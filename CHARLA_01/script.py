import random, time, statistics
from datetime import datetime, timedelta, date
from cassandra.cluster import Cluster
from cassandra.io.asyncioreactor import AsyncioConnection
from cassandra.query import SimpleStatement, ConsistencyLevel

CONTACTS = {
    "cassandra": ("127.0.0.1", 9042),
    "scylla":    ("127.0.0.1", 9043),
}

KEYSPACE = "demo"

def setup_session(host, port):
    cluster = Cluster([host], port=port)
    session = cluster.connect()
    session.execute(f"""
        CREATE KEYSPACE IF NOT EXISTS {KEYSPACE}
        WITH replication = {{'class':'SimpleStrategy','replication_factor':1}};
    """)
    session.set_keyspace(KEYSPACE)
    session.execute("""
        CREATE TABLE IF NOT EXISTS events_by_device (
          device_id text,
          day_bucket date,
          ts timestamp,
          value double,
          PRIMARY KEY ((device_id, day_bucket), ts)
        ) WITH CLUSTERING ORDER BY (ts DESC);
    """)
    return cluster, session

def bench(session, label, n_insert=15000, n_read=7500):
    # Datos sintéticos
    devices = [f"dev-{i:03d}" for i in range(75)]
    today = date.today()

    insert_lat = []
    read_lat = []

    insert_stmt = session.prepare("""
        INSERT INTO events_by_device (device_id, day_bucket, ts, value)
        VALUES (?, ?, ?, ?)
    """)
    insert_stmt.consistency_level = ConsistencyLevel.ONE

    # Inserciones
    for i in range(n_insert):
        d = random.choice(devices)
        ts = datetime.now() - timedelta(seconds=random.randint(0, 3600))
        val = random.random() * 100.0
        t0 = time.perf_counter()
        session.execute(insert_stmt, (d, today, ts, val))
        insert_lat.append((time.perf_counter() - t0) * 1000.0)  # ms

    # Lecturas (últimos N por un device aleatorio)
    for i in range(n_read):
        d = random.choice(devices)
        stmt = SimpleStatement(
            "SELECT * FROM events_by_device WHERE device_id=%s AND day_bucket=%s LIMIT 20",
            consistency_level=ConsistencyLevel.ONE
        )
        t0 = time.perf_counter()
        rows = list(session.execute(stmt, (d, today)))
        read_lat.append((time.perf_counter() - t0) * 1000.0)

    def stats(arr):
        avg = sum(arr)/len(arr)
        p95 = statistics.quantiles(arr, n=100)[94]
        return avg, p95

    ai, pi = stats(insert_lat)
    ar, pr = stats(read_lat)

    print(f"\n[{label}] results:")
    print(f"  inserts: avg={ai:.2f} ms  p95={pi:.2f} ms  (n={len(insert_lat)})")
    print(f"  reads:   avg={ar:.2f} ms  p95={pr:.2f} ms (n={len(read_lat)})")

    # Return structured stats for later comparison
    return {
        "label": label,
        "inserts": {"avg_ms": ai, "p95_ms": pi, "n": len(insert_lat)},
        "reads": {"avg_ms": ar, "p95_ms": pr, "n": len(read_lat)},
    }

def main():
    conns = {}
    try:
        for label, (host, port) in CONTACTS.items():
            print(f"Connecting to {label} at {host}:{port} ...")
            cluster, session = setup_session(host, port)
            conns[label] = (cluster, session)

        # Benchmark sencillo en cada base and collect results
        results = {}
        for label, (_, session) in conns.items():
            stats = bench(session, label)
            if stats is not None:
                results[label] = stats
        # If we have results from at least two backends, compute fastness
        if len(results) >= 2:
            labels = list(results.keys())
            a_label = labels[0]
            b_label = labels[1]
            a = results[a_label]
            b = results[b_label]

            def pct_faster(a_ms, b_ms):
                # return how much faster A is than B in percent (positive means A faster)
                if b_ms == 0:
                    return float('inf') if a_ms != 0 else 0.0
                return (1.0 - (a_ms / b_ms)) * 100.0

            ins_pct = pct_faster(a['inserts']['avg_ms'], b['inserts']['avg_ms'])
            rd_pct = pct_faster(a['reads']['avg_ms'], b['reads']['avg_ms'])
            ins_pct_winning_label = a_label if ins_pct > 0 else b_label
            ins_pct_winning = abs(ins_pct)
            rd_pct_winning_label = a_label if rd_pct > 0 else b_label
            rd_pct_winning = abs(rd_pct)
            print('\nComparison summary:')
            print(f"  {a_label} vs {b_label}")
            print(f"  Inserts: {a_label} avg={a['inserts']['avg_ms']:.2f} ms, {b_label} avg={b['inserts']['avg_ms']:.2f} ms -> {ins_pct_winning_label} is {ins_pct_winning:.2f}% faster")
            print(f"  Reads:   {a_label} avg={a['reads']['avg_ms']:.2f} ms, {b_label} avg={b['reads']['avg_ms']:.2f} ms -> {rd_pct_winning_label} is {rd_pct_winning:.2f}% faster")
        else:
            print('\nNot enough results to compare fastness (need at least two backends).')

    finally:
        for _, (cluster, _) in conns.items():
            cluster.shutdown()

if __name__ == "__main__":
    main()
