import boto3

# Initialize the S3 client pointed at Archive.org
s3 = boto3.client(
    's3',
    endpoint_url='https://s3.us.archive.org',
    aws_access_key_id='YOUR_IA_ACCESS_KEY',
    aws_secret_access_key='YOUR_IA_SECRET_KEY'
)

bucket_name = 'my-unique-item-identifier'

# 1. Upload a file
s3.upload_file('local_file.txt', bucket_name, 'remote_file.txt')
print("Upload complete!")

# 2. List objects in the item
response = s3.list_objects_v2(Bucket=bucket_name)
for obj in response.get('Contents', []):
    print(f"File: {obj['Key']}, Size: {obj['Size']} bytes")

# 3. Download a file
s3.download_file(bucket_name, 'remote_file.txt', 'downloaded_file.txt')
