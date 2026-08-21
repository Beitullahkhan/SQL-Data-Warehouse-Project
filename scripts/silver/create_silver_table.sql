/*

===============================================================================
Create Table For Bronze Schema
===============================================================================

Script Purpose:
This repository contains SQL scripts for creating and managing the Silver Layer of a data warehouse. The scripts define the database
structures used to store cleaned, standardized, and transformed data from CRM and ERP source systems.

The Silver layer includes tables for:

CRM Customer Data — standardized customer IDs, keys, names, marital status, gender, and creation dates.
CRM Product Data — standardized product IDs, keys, names, costs, product lines, and effective dates.
CRM Sales Data — cleaned sales orders, products, customers, order dates, shipping dates, due dates, quantities, prices, and sales amounts.
ERP Customer Location Data — standardized customer identifiers and country information.
ERP Customer Demographic Data — cleaned customer birth dates and gender information.
ERP Product Category Data — standardized product categories, subcategories, and maintenance information.

Each script first checks whether the corresponding table already exists and drops it before recreating the table with the required schema.
This ensures a consistent and repeatable environment for loading refreshed and transformed data during the ETL/ELT process.

The Silver layer serves as an intermediate layer between the raw Bronze layer and the business-ready Gold layer.
The tables are designed to support data cleansing, standardization, validation, integration, and preparation for downstream analytical transformations.

Each Silver table also includes a "dwh_create_date" column with a default value of GETDATE().
This audit column records the date and time when each record is created in the data warehouse, providing basic data lineage and load-tracking capabilities.

Key Objectives
Create a structured Silver layer for cleaned and standardized CRM and ERP data.
Maintain consistent table definitions across development and testing environments.
Support repeatable ETL/ELT workflows and data transformation processes.
Provide a reliable foundation for integrating CRM and ERP source data.
Track record creation timestamps using the dwh_create_date audit column.
Prepare standardized data for the creation of business-ready Gold layer tables.

===============================================================================
*/

IF OBJECT_ID ('silver.crm_cust_info','U') IS NOT NULL
	DROP TABLE silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info
(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.crm_prd_info','U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info
(
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.crm_sales_details','U') IS NOT NULL
	DROP TABLE silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details
(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.erp_loc_a101','U') IS NOT NULL
	DROP TABLE silver.erp_loc_a101;
CREATE TABLE silver.erp_loc_a101
(
	cid NVARCHAR(50),
	cntry NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.erp_cust_az12','U') IS NOT NULL
	DROP TABLE silver.erp_cust_az12;
CREATE TABLE silver.erp_cust_az12
(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.erp_px_cat_g1v2','U') IS NOT NULL
	DROP TABLE silver.erp_px_cat_g1v2;
CREATE TABLE silver.erp_px_cat_g1v2
(	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
