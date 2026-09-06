import logging
from orders import import_orders

logging.basicConfig(
    level = logging.INFO,
    format = "%(asctime)s | %(levelname)s | %(name)s | %(message)s",
    filename = "orders.log"
)
import_orders()
