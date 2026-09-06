import logging

#Logger1

logger = logging.getLogger("logging.orders")
logger.setLevel(logging.INFO)


#2Handler

handler = logging.StreamHandler()
handler.setLevel(logging.INFO)

#3Formater

formatter = logging.Formatter("%(asctime)s | %(name)s | %(levelname)s | %(message)s")

handler.setFormatter(formatter)

#connect handler to logger

logger.addHandler(handler)
logger.info("Order import started")
logger.warning("Order ORD-1002 has missing city")
logger.error("Order ORD-1005 failed")
