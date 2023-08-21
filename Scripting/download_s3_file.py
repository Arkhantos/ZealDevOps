import boto3
def main():
    # Set up connection to S3
	s3_client = boto3.client('s3')

	# Download file from S3, the variables can be passing by variables using args but depends on the implementation required
	s3_client.download_file('my-bucket', 's3_location/file.txt', '/path/to/local/file.txt')

if __name__ == "__main__":
    main()