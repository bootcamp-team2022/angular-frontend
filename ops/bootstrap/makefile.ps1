param($region, $replicationbucket, $statebucket, $dynamodbtbl)

$validAWSRegions =@('us-east-2','us-east-1','us-west-1','us-west-2','af-south-1','ap-east-1','ap-southeast-3','ap-south-1','ap-northeast-3','ap-northeast-2','ap-southeast-1','ap-southeast-2','ap-northeast-1','ca-central-1','eu-central-1','eu-west-1','eu-west-2','eu-south-1','eu-west-3','eu-north-1','me-south-1','sa-east-1')

if ( !($validAWSRegions -contains $region) )
{
    throw "Makefile failed. Please rerun the script and pass a valid AWS Region as a parameter."
}

aws cloudformation create-stack --region $region --stack-name terraform-state-backend --template-body file://cf_templates/state-backend-s3.yml --capabilities CAPABILITY_IAM --parameters ParameterKey=ReplicationS3BucketName,ParameterValue=$replicationbucket ParameterKey=StateS3BucketName,ParameterValue=$statebucket ParameterKey=DynamoDBTableName,ParameterValue=$dynamodbtbl