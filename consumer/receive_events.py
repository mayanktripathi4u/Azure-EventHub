import asyncio
from azure.eventhub.aio import EventHubConsumerClient
from azure.eventhub.extensions.checkpointstoreblobaio import BlobCheckpointStore
import os

CONNECTION_STR = os.getenv("EVENTHUB_CONNECTION_STRING")
EVENTHUB_NAME = "app-logs"
CONSUMER_GROUP = "$Default"

# STORAGE_CONN = "<BLOB_STORAGE_CONNECTION>"
# CONTAINER = "checkpoints"


# checkpoint_store = BlobCheckpointStore.from_connection_string(
#     STORAGE_CONN,
#     CONTAINER
# )


async def on_event(partition_context, event):

    print(
        f"Partition: {partition_context.partition_id}, "
        f"Data: {event.body_as_str()}"
    )

    await partition_context.update_checkpoint(event)


async def main():

    client = EventHubConsumerClient.from_connection_string(
        conn_str=CONNECTION_STR,
        consumer_group=CONSUMER_GROUP,
        eventhub_name=EVENTHUB_NAME,
        # checkpoint_store=checkpoint_store
    )

    async with client:
        await client.receive(
            on_event=on_event,
            starting_position="-1"
        )


asyncio.run(main())
