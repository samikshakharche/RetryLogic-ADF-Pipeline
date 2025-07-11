Retry Logic Pipeline using Azure Data Factory

This mini-project showcases how to implement retry logic in Azure Data Factory (ADF) to gracefully handle transient data retrieval failures when copying data from Azure SQL Database to Azure Blob Storage.

________________________________________

What This Project Does:

The pipeline implements a retry mechanism that waits briefly before reattempting the copy operation if it fails.

•  Uses an `Until` loop to continue retrying until success or max retries reached

•  Inside the loop, checks if the previous `Copy` activity failed

•  Waits 5 seconds before retrying using `Wait` activity

•  Increments a retry count using pipeline variables

•  Exits on success or after 3 retries

________________________________________

Tools and Services Used:

•  Azure Data Factory (V2) – pipeline, expressions, triggers  

•  Azure SQL Database – source data (Products table)  

•  Azure Blob Storage – sink for output CSV file  

•  Dataset and Linked Services – configured with proper retry settings  

•  Variables – to track retry count and success status  

________________________________________

How the Pipeline Works:

The pipeline named `Retry_Copy_Pipeline` follows this logic:

1. Initializes 3 variables: `RetryCount`, `Success`, and `RetryTemp`

2. Inside the `Until` loop, it evaluates:

```
@or(variables('Success'), greaterOrEquals(variables('RetryCount'), 3))
```

3. Executes a `Copy_SQL_to_Blob` activity (copy data from SQL to Blob)

4. If it fails → runs the True branch:

   - Waits 5 seconds

   - Increments retry count using a temp variable

5. If it succeeds → sets `Success = true` and exits loop

________________________________________

Expression Logic Explained:

•  `RetryCount` ensures retry stops after 3 attempts  

•  `Success` ensures loop exits immediately after success  

•  `@not(equals(activity('Copy_SQL_to_Blob').Status,'Succeeded'))` is used to detect failure  

•  Uses only supported ADF functions for compatibility

________________________________________

How the Pipeline Runs:

•  Triggered manually using "Debug" with SQL DB populated

•  If the Copy fails (e.g., transient error), the loop waits and retries  

•  If the Copy succeeds on first try, loop exits immediately  

•  Final result appears as CSV in Blob container: `/output/products.csv`

________________________________________

Note on Credit Usage (Student Subscription):

Due to limited Azure credits under my student subscription, I tested and captured output/screenshots with minimal runs.

SQL Server, Blob Storage, and ADF resources were deleted after export to save credits.

________________________________________

Author

Samiksha Kharche

This project helped me understand retry patterns in ADF using loops, conditions, expressions, and variables. It is useful for building resilient pipelines that handle intermittent failures.


