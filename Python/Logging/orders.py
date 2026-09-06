import logging

logger = logging.getLogger(__name__)


def import_orders():

    logger.info("Starting order import")

    orders = ["ORD-1001", "ORD-1002"]

    logger.info(
        "Imported %d orders",
        len(orders)
    )

    return orders