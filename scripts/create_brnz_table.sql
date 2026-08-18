/*

===============================================================================
Create Table For Bronze Schema
===============================================================================
Script Purpose:
This repository contains SQL scripts for creating and managing the Bronze Layer of a data warehouse.The scripts define the initial database structures
used to store raw data from CRM and ERP source systems before it is cleaned, transformed, and loaded into downstream data warehouse layers.

The Bronze layer includes tables for:

CRM Customer Data — customer IDs, names, marital status, gender, and creation dates.
CRM Product Data — product details, costs, product lines, and effective dates.
CRM Sales Data — sales orders, products, customers, dates, quantities, prices, and sales amounts.
ERP Customer Location Data — customer identifiers and country information.
ERP Customer Demographic Data — birth dates and gender information.
ERP Product Category Data — product categories, subcategories, and maintenance information.

Each script first checks whether the corresponding table already exists and drops it before recreating the table with the required schema.
This ensures a consistent and repeatable environment for loading fresh source data during the ETL/ELT process.

The primary purpose of this Bronze layer is to provide a raw, structured landing zone for source data while preserving the original information.
Subsequent data warehouse layers can then use these tables for data cleansing, standardization, integration, and business transformations.

Key Objectives
Create a structured Bronze layer for raw CRM and ERP data.
Maintain consistent table definitions across development and testing environments.
Support repeatable data loading and ETL/ELT workflows.
Provide a foundation for data quality checks and transformation processes.

*/

IF OBJECT_ID ('bronze.crm_cust_info','U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info
(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);

IF OBJECT_ID ('bronze.crm_prd_info','U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info
(
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME
);

IF OBJECT_ID ('bronze.crm_sales_details','U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details
(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);

IF OBJECT_ID ('bronze.erp_loc_a101','U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101
(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_cust_az12','U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12
(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_px_cat_g1v2','U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2
(	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
);
