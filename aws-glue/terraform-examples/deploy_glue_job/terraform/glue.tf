resource "aws_s3_object" "deploy_script_s3" {
  bucket = var.s3_bucket
  key = "glue/scripts/script.py"
  source = "${local.glue_src_path}script.py"
  etag = filemd5("${local.glue_src_path}script.py")
}

resource "aws_glue_job" "deploy_script" {
    glue_version = "4.0" 
    max_retries = 0 
    name = "script" 
    description = "Deployment of an AWS Glue job with terraform" 
    role_arn = aws_iam_role.glue_service_role.arn 
    number_of_workers = 2 
    worker_type = "G.1X" # https://docs.aws.amazon.com/glue/latest/dg/add-job.html
    timeout = "60" 
    execution_class = "FLEX" 
    tags = {
    project = var.project 
  }

  command {
    name="glueetl" 
    script_location = "s3://${var.s3_bucket}/glue/scripts/script.py"
  }
  default_arguments = {
    "--class"                   = "GlueApp"
    "--enable-job-insights"     = "true"
    "--enable-auto-scaling"     = "false"
    "--enable-glue-datacatalog" = "true"
    "--job-language"            = "python"
    "--job-bookmark-option"     = "job-bookmark-disable"
    "--datalake-formats"        = "iceberg"
    "--conf"                    = "spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions  --conf spark.sql.catalog.glue_catalog=org.apache.iceberg.spark.SparkCatalog  --conf spark.sql.catalog.glue_catalog.warehouse=s3://tnt-erp-sql/ --conf spark.sql.catalog.glue_catalog.catalog-impl=org.apache.iceberg.aws.glue.GlueCatalog  --conf spark.sql.catalog.glue_catalog.io-impl=org.apache.iceberg.aws.s3.S3FileIO"

  }
}