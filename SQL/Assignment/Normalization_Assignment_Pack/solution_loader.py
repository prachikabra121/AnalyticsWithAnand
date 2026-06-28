"""
SOLUTION reference loader for the Normalization assignment.

Reads orders_raw.csv (denormalized), then:
  1. Explodes the multi-valued ORDER_ITEMS field   -> 1NF
  2. Splits into normalized tables                  -> 2NF / 3NF
  3. Writes each normalized table to /normalized/*.csv
  4. Computes the Data-Quality KPIs and Business KPIs

Pure standard library (csv) so it runs anywhere. Pandas version is shown
in the assignment doc as an alternative.
"""
import csv, os
from collections import defaultdict

SRC = "orders_raw.csv"
OUT = "normalized"
os.makedirs(OUT, exist_ok=True)

with open(SRC, newline="") as f:
    raw = list(csv.DictReader(f))

# ---------------------------------------------------------------- 1NF -----
# Explode ORDER_ITEMS -> one row per (order, product)
flat = []                       # the 1NF "wide" line-item table
for r in raw:
    for item in r["ORDER_ITEMS"].split(" || "):
        name, cat, price, qty = item.split("~")
        flat.append({
            "ORDER_ID": r["ORDER_ID"],
            "ORDER_DATE": r["ORDER_DATE"],
            "CUSTOMER_NAME": r["CUSTOMER_NAME"],
            "CUSTOMER_EMAIL": r["CUSTOMER_EMAIL"],
            "CUSTOMER_CITY": r["CUSTOMER_CITY"],
            "CUSTOMER_STATE": r["CUSTOMER_STATE"],
            "CUSTOMER_SEGMENT": r["CUSTOMER_SEGMENT"],
            "SALES_REP_NAME": r["SALES_REP_NAME"],
            "SALES_REP_REGION": r["SALES_REP_REGION"],
            "SALES_REP_EMAIL": r["SALES_REP_EMAIL"],
            "PAYMENT_METHOD": r["PAYMENT_METHOD"],
            "SHIPPING_COST": int(r["SHIPPING_COST"]),
            "PRODUCT_NAME": name,
            "CATEGORY": cat,
            "UNIT_PRICE": int(price),
            "QUANTITY": int(qty),
        })

# ------------------------------------------------------- 2NF / 3NF -------
# Surrogate-key dimensions
def keyed(values, prefix, width=3):
    """Stable id assignment in first-seen order."""
    out, seen = {}, []
    for v in values:
        if v not in out:
            out[v] = f"{prefix}{len(seen)+1:0{width}d}"
            seen.append(v)
    return out

cat_desc = {
    "Electronics": "Consumer electronic devices and accessories",
    "Stationery":  "Office and writing supplies",
    "Furniture":   "Home and office furniture",
    "Appliances":  "Household electrical appliances",
    "Books":       "Printed and reference books",
}

cat_id  = keyed([r["CATEGORY"] for r in flat], "CAT")
cust_id = keyed([r["CUSTOMER_NAME"] for r in flat], "CUST")
rep_id  = keyed([r["SALES_REP_NAME"] for r in flat], "REP")
prod_id = keyed([r["PRODUCT_NAME"] for r in flat], "PROD")

# DIM_CATEGORY
dim_category = [{"CATEGORY_ID": cat_id[c], "CATEGORY_NAME": c,
                 "CATEGORY_DESCRIPTION": cat_desc[c]} for c in cat_id]

# DIM_PRODUCT  (price lives with product)
prod_price = {}
for r in flat:
    prod_price[r["PRODUCT_NAME"]] = (r["CATEGORY"], r["UNIT_PRICE"])
dim_product = [{"PRODUCT_ID": prod_id[p], "PRODUCT_NAME": p,
                "CATEGORY_ID": cat_id[prod_price[p][0]],
                "UNIT_PRICE": prod_price[p][1]} for p in prod_id]

# DIM_CUSTOMER
cust_attr = {}
for r in flat:
    cust_attr[r["CUSTOMER_NAME"]] = (r["CUSTOMER_EMAIL"], r["CUSTOMER_CITY"],
                                     r["CUSTOMER_STATE"], r["CUSTOMER_SEGMENT"])
dim_customer = [{"CUSTOMER_ID": cust_id[c], "CUSTOMER_NAME": c,
                 "CUSTOMER_EMAIL": cust_attr[c][0], "CUSTOMER_CITY": cust_attr[c][1],
                 "CUSTOMER_STATE": cust_attr[c][2], "CUSTOMER_SEGMENT": cust_attr[c][3]}
                for c in cust_id]

# DIM_SALES_REP
rep_attr = {}
for r in flat:
    rep_attr[r["SALES_REP_NAME"]] = (r["SALES_REP_REGION"], r["SALES_REP_EMAIL"])
dim_sales_rep = [{"SALES_REP_ID": rep_id[s], "SALES_REP_NAME": s,
                  "REGION": rep_attr[s][0], "EMAIL": rep_attr[s][1]} for s in rep_id]

# FACT_ORDERS  (order header)  -- attributes dependent only on ORDER_ID
order_hdr = {}
for r in flat:
    order_hdr[r["ORDER_ID"]] = {
        "ORDER_ID": r["ORDER_ID"], "ORDER_DATE": r["ORDER_DATE"],
        "CUSTOMER_ID": cust_id[r["CUSTOMER_NAME"]],
        "SALES_REP_ID": rep_id[r["SALES_REP_NAME"]],
        "PAYMENT_METHOD": r["PAYMENT_METHOD"], "SHIPPING_COST": r["SHIPPING_COST"]}
fact_orders = list(order_hdr.values())

# FACT_ORDER_ITEMS  (line items)  -- depends on full key (ORDER_ID, PRODUCT_ID)
fact_items = [{"ORDER_ID": r["ORDER_ID"], "PRODUCT_ID": prod_id[r["PRODUCT_NAME"]],
               "QUANTITY": r["QUANTITY"], "UNIT_PRICE": r["UNIT_PRICE"]} for r in flat]

def write(name, rows_):
    with open(os.path.join(OUT, name), "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows_[0].keys()))
        w.writeheader(); w.writerows(rows_)

write("dim_category.csv", dim_category)
write("dim_product.csv", dim_product)
write("dim_customer.csv", dim_customer)
write("dim_sales_rep.csv", dim_sales_rep)
write("fact_orders.csv", fact_orders)
write("fact_order_items.csv", fact_items)

# ====================================================================== KPIs
print("="*60)
print("DATA-QUALITY / NORMALIZATION-IMPACT KPIs")
print("="*60)
# Fair baseline = the fully-exploded "One Big Table" (1NF flat), because that
# is what normalization actually replaces. Comparing to the compressed raw
# file would be apples-to-oranges.
flat_cells = len(flat) * len(flat[0])
norm_cells = sum(len(t) * len(t[0]) for t in
                 [dim_category, dim_product, dim_customer, dim_sales_rep,
                  fact_orders, fact_items])
# redundancy: most-repeated customer email in the flat table
from collections import Counter
email_counts = Counter(r["CUSTOMER_EMAIL"] for r in flat)
worst_email, worst_n = email_counts.most_common(1)[0]
print(f"Raw order rows ................... {len(raw)}")
print(f"1NF line-item rows (explode) .... {len(flat)}")
print(f"Distinct customers .............. {len(dim_customer)}")
print(f"Distinct products ............... {len(dim_product)}")
print(f"Distinct categories ............. {len(dim_category)}")
print(f"Distinct sales reps ............. {len(dim_sales_rep)}")
print(f"Most-repeated customer email .... {worst_email} x{worst_n}")
print(f"1NF flat-table cell count ....... {flat_cells}")
print(f"Normalized total cell count ..... {norm_cells}")
print(f"Cell / storage reduction ........ {100*(flat_cells-norm_cells)/flat_cells:.1f}%")

print()
print("="*60)
print("BUSINESS KPIs (from the normalized model)")
print("="*60)
# build lookups
price_of = {p["PRODUCT_ID"]: p["UNIT_PRICE"] for p in dim_product}
catname  = {c["CATEGORY_ID"]: c["CATEGORY_NAME"] for c in dim_category}
prodcat  = {p["PRODUCT_ID"]: catname[p["CATEGORY_ID"]] for p in dim_product}
custname = {c["CUSTOMER_ID"]: c["CUSTOMER_NAME"] for c in dim_customer}
custstate= {c["CUSTOMER_ID"]: c["CUSTOMER_STATE"] for c in dim_customer}
repname  = {r["SALES_REP_ID"]: r["SALES_REP_NAME"] for r in dim_sales_rep}
order_cust= {o["ORDER_ID"]: o["CUSTOMER_ID"] for o in fact_orders}
order_rep = {o["ORDER_ID"]: o["SALES_REP_ID"] for o in fact_orders}

line_rev = [(it["ORDER_ID"], it["PRODUCT_ID"], it["QUANTITY"]*it["UNIT_PRICE"])
            for it in fact_items]
total_rev = sum(x[2] for x in line_rev)
n_orders = len(fact_orders)
aov = total_rev / n_orders

rev_by_cat = defaultdict(int)
for oid, pid, rev in line_rev:
    rev_by_cat[prodcat[pid]] += rev
rev_by_rep = defaultdict(int)
for oid, pid, rev in line_rev:
    rev_by_rep[repname[order_rep[oid]]] += rev
rev_by_state = defaultdict(int)
for oid, pid, rev in line_rev:
    rev_by_state[custstate[order_cust[oid]]] += rev
units_by_prod = defaultdict(int)
for it in fact_items:
    units_by_prod[it["PRODUCT_ID"]] += it["QUANTITY"]

orders_per_cust = defaultdict(set)
for o in fact_orders:
    orders_per_cust[o["CUSTOMER_ID"]].add(o["ORDER_ID"])
repeat = sum(1 for c, s in orders_per_cust.items() if len(s) > 1)
repeat_rate = 100*repeat/len(orders_per_cust)

prodname = {p["PRODUCT_ID"]: p["PRODUCT_NAME"] for p in dim_product}
top_prod = max(units_by_prod, key=units_by_prod.get)

print(f"Total revenue .................... INR {total_rev:,}")
print(f"Number of orders ................. {n_orders}")
print(f"Average order value (AOV) ........ INR {aov:,.0f}")
print(f"Repeat-customer rate ............. {repeat_rate:.1f}%")
print(f"Top product by units ............. {prodname[top_prod]} ({units_by_prod[top_prod]} units)")
print("Revenue by category:")
for c, v in sorted(rev_by_cat.items(), key=lambda x:-x[1]):
    print(f"   {c:<12} INR {v:,}")
print("Top 3 sales reps by revenue:")
for s, v in sorted(rev_by_rep.items(), key=lambda x:-x[1])[:3]:
    print(f"   {s:<14} INR {v:,}")
print("Top 3 states by revenue:")
for s, v in sorted(rev_by_state.items(), key=lambda x:-x[1])[:3]:
    print(f"   {s:<14} INR {v:,}")
