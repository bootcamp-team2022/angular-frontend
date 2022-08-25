Script wrapper to automate creation of Terraform Upper Environment

This template will create a stack that creates the following resources:

- Terraform State S3 Bucket
- Replication bucket to backup
- DynamoDB table for Terraform state locking

The script needs three variables:
- replicationbucket (backup of Terraform state files )
- statebucket: (Terraform state bucket)
- dynamotable: (DynamoDB Table for Statelocking)

Windows Powershell SYNTAX:
.\makefile.ps1 -region <REGION> -replicationbucket <REPLICATION_BUCKET_NAME> -statebucket <STATE_BUCKET_NAME> -dynamotable <DYNAMODB_TABLE_NAME>

( templates are located in /cf_templates/ )