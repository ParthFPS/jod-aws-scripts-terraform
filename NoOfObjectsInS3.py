import boto3
s3 = boto3.client('s3')

def list_buckets():
    response = s3.list_buckets()
    print("List of Buckets:")
    for bucket in response['Buckets']:
        print(bucket['Name'])
def count_objects_in_bucket(bucket_name):
    response = s3.list_objects_v2(Bucket=bucket_name)
    if 'Contents' in response:
        object_count = len(response['Contents'])
        print(f"Total objects in {bucket_name}: {object_count}")
    else:
        print(f"No objects found in {bucket_name}")
if __name__ == '__main__':
    list_buckets()
    count_objects_in_bucket('parth-static-website-bucket')
