from cassandra.cluster import Cluster
from cassandra import OperationTimedOut
from script import CONTACTS, KEYSPACE

def flush_keyspace(host, port, keyspace):
    cluster = Cluster([host], port=port)
    try:
        session = cluster.connect()
        print(f"Dropping keyspace '{keyspace}' on {host}:{port} ...")
        session.execute(f"DROP KEYSPACE IF EXISTS {keyspace}")
        print(f"  OK: dropped {keyspace} on {host}:{port}")
    except OperationTimedOut as e:
        print(f"  TIMEOUT: {host}:{port} -> {e}")
    except Exception as e:
        print(f"  ERROR: {host}:{port} -> {e}")
    finally:
        cluster.shutdown()

def main():
    for label, (host, port) in CONTACTS.items():
        print(f"[{label}]")
        flush_keyspace(host, port, KEYSPACE)

if __name__ == "__main__":
    main()