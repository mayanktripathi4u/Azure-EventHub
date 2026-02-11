from azure.eventhub import EventHubProducerClient, EventData
import json
import time
import random
import os

CONNECTION_STR = os.getenv("EVENTHUB_CONNECTION_STRING")
EVENTHUB_NAME = "app-logs"

producer = EventHubProducerClient.from_connection_string(
    conn_str=CONNECTION_STR,
    eventhub_name=EVENTHUB_NAME
)


def generate_log():
    return {
        "app": "order-service",
        "level": random.choice(["INFO", "WARN", "ERROR"]),
        "message": "Order processed",
        "latency_ms": random.randint(50, 500),
        "timestamp": time.time()
    }


with producer:
    batch = producer.create_batch()

    for _ in range(100):
        payload =generate_log()
        print(f"Generated log: {payload}, and sending to Event Hub...")
        event = EventData(json.dumps(payload))
        batch.add(event)

    producer.send_batch(batch)

print("Events sent successfully")