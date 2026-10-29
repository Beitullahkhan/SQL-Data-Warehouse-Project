# Data Catalog — Gold Layer

## Project Overview

The Gold Layer contains business-ready data organized into three tables: customer information, product information, and sales transactions. These tables can be used for reporting, business intelligence, and sales analysis.

## 1. Table: `gold.dim_customers`

**Description:** Stores customer details, including personal information, demographic attributes, and account creation date.

| Column Name | Data Type | Nullable | Description |
|---|---|---|---|
| `customer_key` | BIGINT | Yes | Customer key used to connect customer records with sales transactions. |
| `customer_id` | INT | Yes | Customer identifier from the source system. |
| `customer_number` | NVARCHAR(50) | Yes | Business reference number assigned to the customer. |
| `first_name` | NVARCHAR(50) | Yes | Customer's first name. |
| `last_name` | NVARCHAR(50) | Yes | Customer's last name. |
| `country` | NVARCHAR(50) | Yes | Country associated with the customer. |
| `marital_status` | NVARCHAR(50) | Yes | Customer's marital status. |
| `gender` | NVARCHAR(50) | Yes | Customer's gender as recorded in the source data. |
| `birthdate` | DATE | Yes | Customer's date of birth. |
| `create_date` | DATE | Yes | Date the customer record was created. |

**Primary Key:** Not confirmed from the available schema screenshot.

**Relationship:** `customer_key` is used to join with `gold.fact_sales.customer_key`.

---

## 2. Table: `gold.dim_products`

**Description:** Stores product details, including product identifiers, categories, costs, product lines, and start dates.

| Column Name | Data Type | Nullable | Description |
|---|---|---|---|
| `product_key` | BIGINT | Yes | Product key used to connect product records with sales transactions. |
| `product_id` | INT | Yes | Product identifier from the source system. |
| `product_number` | NVARCHAR(50) | Yes | Business reference number assigned to the product. |
| `product_name` | NVARCHAR(50) | Yes | Name of the product. |
| `category_id` | NVARCHAR(50) | Yes | Identifier of the product's category. |
| `category` | NVARCHAR(50) | Yes | Category to which the product belongs. |
| `subcategory` | NVARCHAR(50) | Yes | Subcategory of the product. |
| `maintenance` | NVARCHAR(50) | Yes | Maintenance-related attribute recorded for the product; exact meaning requires source-data validation. |
| `cost` | INT | Yes | Cost associated with the product. |
| `product_line` | NVARCHAR(50) | Yes | Product line or business segment associated with the product. |
| `start_date` | DATE | Yes | Start date associated with the product record. |

**Primary Key:** Not confirmed from the available schema screenshot.

**Relationship:** `product_key` is used to join with `gold.fact_sales.product_key`.

---

## 3. Table: `gold.fact_sales`

**Description:** Stores sales transaction records, including order information, customer and product references, dates, quantities, and financial measures.

| Column Name | Data Type | Nullable | Description |
|---|---|---|---|
| `order_number` | NVARCHAR(50) | Yes | Reference number identifying the sales order. |
| `product_key` | BIGINT | Yes | Product reference used to connect sales with `gold.dim_products`. |
| `customer_key` | BIGINT | Yes | Customer reference used to connect sales with `gold.dim_customers`. |
| `order_date` | DATE | Yes | Date the order was placed. |
| `shipping_date` | DATE | Yes | Date associated with shipping the order. |
| `due_date` | DATE | Yes | Due date associated with the order. |
| `sales_amount` | INT | Yes | Sales amount recorded for the transaction. |
| `quantity` | INT | Yes | Number of units sold. |
| `price` | INT | Yes | Price recorded for the transaction. |

**Table Type:** Fact Table

**Relationships:**
- `customer_key` → `gold.dim_customers.customer_key`
- `product_key` → `gold.dim_products.product_key`

**Note:** The exact grain of this table—whether each row represents an order, an order line, or another transaction level—should be confirmed from the source data.

---

## 4. Table Relationships

The following relationships represent the joins used in the SQL queries:

| Fact Table Column | Dimension Table Column | Purpose |
|---|---|---|
| `fact_sales.customer_key` | `dim_customers.customer_key` | Connect sales transactions with customer details. |
| `fact_sales.product_key` | `dim_products.product_key` | Connect sales transactions with product details. |

### Logical Data Model

```text
gold.dim_customers
        |
        | customer_key
        |
        v
gold.fact_sales
        ^
        | product_key
        |
gold.dim_products
```

The `fact_sales` table connects the two dimension tables and enables analysis of sales by customer and product.

---

## 5. Data Quality Considerations

The following checks can help maintain reliable data:

1. **Missing customer references:** Identify sales records whose `customer_key` does not match a customer in `gold.dim_customers`.
2. **Missing product references:** Identify sales records whose `product_key` does not match a product in `gold.dim_products`.
3. **Null values:** Check important fields such as customer keys, product keys, order dates, sales amounts, and quantities.
4. **Duplicate records:** Check for duplicate customer, product, or sales records using the appropriate business keys.
5. **Date validation:** Check whether order, shipping, and due dates are consistent with business rules.
6. **Financial validation:** Validate sales amounts and prices against the source system and the business calculation rules.

---

## Conclusion

This catalog documents the three tables in the Gold Layer, their columns, data types, purposes, and logical relationships. It provides a starting point for understanding the warehouse structure and supporting data quality checks and reporting.
