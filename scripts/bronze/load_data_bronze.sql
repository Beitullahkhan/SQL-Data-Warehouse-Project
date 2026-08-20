/*

=============================================================================== 
Create Stored Procedure For Bronze Layer 
=============================================================================== 
Script Purpose: This stored procedure automates the loading of raw CRM and ERP source data into the Bronze Layer of the data warehouse. 

The procedure is responsible for: 

CRM Data Loading — customer information, product information, and sales details. 
ERP Data Loading — customer information, location information, and product category information.

For each Bronze table, the procedure first truncates the existing data and then loads the latest 
records from the corresponding CSV source file using BULK INSERT. This ensures that the Bronze layer
contains a fresh and complete copy of the source data during each execution.

The procedure also records the start and end time of each table load and calculates the load duration. Progress messages
are printed during execution to provide visibility into the ETL process and help monitor loading performance.

The procedure uses a TRY...CATCH block to provide an error-handling framework for the Bronze loading process.

The procedure can be executed using: 
EXEC bronze.load_bronze;

The primary purpose of this Bronze loading procedure is to provide a centralized, repeatable, and automated process for
ingesting raw CRM and ERP data into the data warehouse.

Key Objectives 
Load raw CRM and ERP source data into Bronze tables. 
Refresh Bronze tables using a full-load strategy. 
Automate the raw data ingestion process. 
Measure and display the loading duration for each table. 
Provide execution progress messages for monitoring. 
Support a consistent and repeatable ETL/ELT workflow.
Provide a raw data foundation for downstream Silver and Gold layer transformations.

*/

EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT '===============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===============================================';

		PRINT '-----------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '-----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>Inserting data into: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'Seconds';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>Inserting data into: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'Seconds';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>Inserting data into: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'Seconds';

		PRINT '-----------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '-----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>Inserting data into: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_erp\cust_az12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'Seconds';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>Inserting data into: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_erp\loc_a101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'Seconds';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>Inserting data into: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Enclair.tech\Desktop\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + 'Seconds';
	END TRY
	BEGIN CATCH
	END CATCH
END
