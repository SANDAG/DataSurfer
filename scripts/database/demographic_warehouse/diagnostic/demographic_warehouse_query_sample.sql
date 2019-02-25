SELECT
    jurisdiction
    ,age_group.age_group_id
    ,age_group.name
    ,sex_id
    ,ethnicity.ethnicity_id
    ,ethnicity.long_name
    ,SUM(population) as pop
FROM fact.age_sex_ethnicity
    INNER JOIN dim.mgra_denormalize
    ON mgra_denormalize.mgra_id = age_sex_ethnicity.mgra_id
        INNER JOIN dim.age_group
        ON age_group.age_group_id = age_sex_ethnicity.age_group_id
            INNER JOIN dim.ethnicity
            ON ethnicity.ethnicity_id = age_sex_ethnicity.ethnicity_id
WHERE datasource_id = 17
GROUP BY 
    jurisdiction
    ,age_group.age_group_id
    ,age_group.name
    ,sex_id
    ,ethnicity.ethnicity_id
    ,ethnicity.long_name
ORDER BY 1,2,4,5

/* 
***Original***

SQL Server parse and compile time: 
   CPU time = 78 ms, elapsed time = 653 ms.

(6080 rows affected)
Table 'age_group'. Scan count 1, logical reads 2, physical reads 1, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'ethnicity'. Scan count 1, logical reads 2, physical reads 1, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'age_sex_ethnicity'. Scan count 41, logical reads 151, physical reads 1, read-ahead reads 156, lob logical reads 60399, lob physical reads 180, lob read-ahead reads 189912.
Table 'age_sex_ethnicity'. Segment reads 76, segment skipped 331.
Table 'mgra_denormalize'. Scan count 41, logical reads 3386, physical reads 3, read-ahead reads 3213, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 6642 ms,  elapsed time = 6378 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

*** CCIX & NCIX ***

SQL Server parse and compile time: 
   CPU time = 93 ms, elapsed time = 117 ms.

(6080 rows affected)
Table 'age_sex_ethnicity'. Scan count 40, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 182336, lob physical reads 392, lob read-ahead reads 599896.
Table 'age_sex_ethnicity'. Segment reads 237, segment skipped 626.
Table 'mgra_denormalize'. Scan count 40, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 121, lob physical reads 0, lob read-ahead reads 260.
Table 'mgra_denormalize'. Segment reads 1, segment skipped 0.
Table 'ethnicity'. Scan count 40, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 12, lob physical reads 1, lob read-ahead reads 0.
Table 'ethnicity'. Segment reads 1, segment skipped 0.
Table 'age_group'. Scan count 40, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 13, lob physical reads 1, lob read-ahead reads 0.
Table 'age_group'. Segment reads 1, segment skipped 0.
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 6875 ms,  elapsed time = 12194 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

 *** CCIX ***

 SELECT
    jurisdiction
    ,age_group.age_group_id
    ,age_group.name
    ,sex_id
    ,ethnicity.ethnicity_id
    ,ethnicity.long_name
    ,SUM(population) as pop
FROM fact.age_sex_ethnicity
    INNER JOIN dim.mgra_denormalize
    ON mgra_denormalize.mgra_id = age_sex_ethnicity.mgra_id
        INNER JOIN dim.age_group
        ON age_group.age_group_id = age_sex_ethnicity.age_group_id
            INNER JOIN dim.ethnicity
            ON ethnicity.ethnicity_id = age_sex_ethnicity.ethnicity_id
WHERE datasource_id = 17
GROUP BY 
    jurisdiction
    ,age_group.age_group_id
    ,age_group.name
    ,sex_id
    ,ethnicity.ethnicity_id
    ,ethnicity.long_name
ORDER BY 1,2,4,5
*/