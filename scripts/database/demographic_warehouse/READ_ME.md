# Demographic Warehouse Database
# Del Esposo, Data Dude 01/17/2019

This document is to guide the user on how to re-create the demographic_warehouse database from scratch given the data source is from existing data.

Github Directory: https://github.com/SANDAG/ABM/tree/master/sql/data_structure/demographic_datawarehouse
Branch: demographic_datawarehouse
SQL Type: On-premise
SQL Source Instance: sql2014a8
SQL Destination Instance: socioeca8
SQL Server Script Version: SQL Server 2016

# SQL Instance Prerequisites

	1. Database named demographic_warehouse should not exist on the destination instance for this script.
	2. Directory F:\SQLDATA\ needs to exist on the server with at least 300GB of free space
	3. Source data from demographic_warehouse database will need to be restored as demographic_warehouse_origin 
		on the destination instance for data pull.
	4. SQL Agent needs to be up and running for the automated scripts to run.

    There are two main directories: Advanced & Diagnostic

    - Diagnostic directory contains miscellaneous scripts to help with prerequisites such as instance evaluation, database restore, and query performance post installation.

        * demographic_warehouse_origin_restore.sql -- a restore script that will help satisfy prerequisite number 3
        * demographic_warehouse_query_sampl.sql -- a sample script to test query performance after database installation or recovery
        * glennb_diagnostics_2016sp1.sql -- an open source script from Glenn Berry to scan a SQL Server 2016 instance. Ref. https://www.sqlskills.com/blogs/glenn/category/dmv-queries/

    - Advanced directory contains all the necessary scripts to deploy the data migration or recovery of demographic_warehouse.

        * 0_demographic_warehouse_advanced_auto_data_load.sql -- is an automated script that will build the demographic_warehouse database, schemas, reclaim space, and job.
        * Scripts 1 to 5.x are the same SQL scripts on 0_demographic_warehouse_advanced_auto_data_load.sql except broken down into segments for manual deployment and troubleshooting.
        * For a simpler database structure, 5.3_demographic_warehouse_manual_enable_constraints.sql can be skipped to not enforce constraints in a datawarehouse
        * For advanced database structure, 0_demographic_warehouse_advanced_auto_data_load.sql uses a new enhancement in SQL Server 2016 where a constraints are enforceable on
            a a table with clustered columnstore index.

# References
    Clustered versus Non-Clustered: https://blogs.msdn.microsoft.com/sqlserverstorageengine/2016/07/18/columnstore-index-differences-between-clusterednonclustered-columnstore-index/
    Combining nonclustered and columnstore indexes: https://docs.microsoft.com/en-us/sql/relational-databases/indexes/columnstore-indexes-data-warehouseview=sql-server-2017#example-use-a-nonclustered-index-to-enforce-a-primary-key-constraint-on-a-columnstore-table
