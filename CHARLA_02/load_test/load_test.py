import asyncio
import secrets
import time
import aiohttp

#!/usr/bin/env python3

URL = "http://localhost:8080/mensaje"
TIEMPO_TOTAL = 10   # segundos
RATE =2000    # requests por segundo

async def enviar_request(session, stats):
    name = secrets.token_hex(4)
    lastname = secrets.token_hex(4)
    phone = secrets.token_hex(3)
    params = {"name": name, "lastname": lastname, "phoneNumber": phone}
    try:
        async with session.post(URL, params=params) as resp:
            await resp.read()
            if resp.status < 500:
                stats['ok'] += 1
            else:
                stats['fail'] += 1
    except Exception:
        stats['fail'] += 1

async def main():
    print(f"Iniciando: {RATE} req/s durante {TIEMPO_TOTAL}s hacia {URL}")
    stats = {'ok': 0, 'fail': 0}
    end_time = time.time() + TIEMPO_TOTAL
    tasks = []

    timeout = aiohttp.ClientTimeout(total=500)
    async with aiohttp.ClientSession(timeout=timeout) as session:
        # Logger en segundo plano
        async def logger():
            while time.time() < end_time:
                await asyncio.sleep(1)
                total = stats['ok'] + stats['fail']
                print(f"Progreso: {total} reqs (OK: {stats['ok']} | Fail: {stats['fail']})")
        log_task = asyncio.create_task(logger())

        # Envío en ráfagas de 1 segundo con RATE requests cada segundo
        while time.time() < end_time:
            for _ in range(RATE):
                tasks.append(asyncio.create_task(enviar_request(session, stats)))
            # Espera 1 segundo antes de la siguiente ráfaga
            await asyncio.sleep(1)
            # Limpiar tareas terminadas para no acumular referencias
            tasks = [t for t in tasks if not t.done()]

        # Esperar a que terminen las tareas pendientes
        if tasks:
            await asyncio.gather(*tasks, return_exceptions=True)

        log_task.cancel()

    print("----- RESUMEN -----")
    total = stats['ok'] + stats['fail']
    print(f"Total enviados: {total}")
    print(f"Exitosas: {stats['ok']}")
    print(f"Fallidas: {stats['fail']}")

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\nInterrumpido por el usuario")
