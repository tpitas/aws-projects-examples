import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
input_df = glueContext.create_dynamic_frame_from_options(connection_type="s3",
           connection_options = {"paths": ["s3://<++++++++>/raw/ecommerce.csv"]}, format = "csv")
input_df.show(10)

# Convert to a pandas DataFrame
df = input_df.toDF()
df_pd = df.toPandas()
print('The script has successfully ran')