/*

===============================================================================
Bronze Layer — CRM & ERP Data Load Script
===============================================================================
Script Purpose:
The purpose of this script is to load raw CRM and ERP CSV data into the Bronze layer of the data warehouse.

The script first truncates the existing Bronze tables to remove previously loaded data and then uses SQL Server BULK INSERT to load the latest data from the source CSV files.
The Bronze layer includes tables for:

Responsibilities
Clear existing data from Bronze tables.
Load CRM customer data.
Load CRM product data.
Load CRM sales data.
Load ERP customer data.
Load ERP location data.
Load ERP product category data.
Preserve the raw source data for downstream transformations.

Tables Loaded
bronze.crm_cust_info
bronze.crm_prd_info
bronze.crm_sales_details
bronze.erp_cust_az12
bronze.erp_loc_a101
bronze.erp_px_cat_g1v2
Process
Source CSV Files
       │
       ▼
TRUNCATE Bronze Tables
       │
       ▼
BULK INSERT
       │
       ▼
Bronze Layer
       │
       ▼
Raw Data Available
       │
       ▼
Silver Layer Transformations
Important Note

This script performs a full refresh of the Bronze layer. Existing records are removed before the new CSV files are loaded.

The script is intended for SQL Server and assumes that the CSV files are accessible from the SQL Server environment and that the required Bronze tables already exist.
*/

TRUNCATE TABLE bronze.crm_cust_info;

BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_crm\cust_info.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

TRUNCATE TABLE bronze.crm_cust_info;

BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_crm\prd_info.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

TRUNCATE TABLE bronze.crm_sales_details;

BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_crm\sales_details.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

TRUNCATE TABLE bronze.erp_cust_az12;

BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_erp\cust_az12.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

TRUNCATE TABLE bronze.erp_loc_a101;

BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_erp\loc_a101.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

TRUNCATE TABLE bronze.erp_px_cat_g1v2;

BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_erp\px_cat_g1v2.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
