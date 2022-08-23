export AWS_PROFILE=default

all: bootcamp-dev

bootcamp-dev: 
	terraform -chdir=ops/accounts/${environment}  init
	terraform -chdir=ops/accounts/${environment}  plan -out tfapply --var-file=${environment}.tfvars
	terraform -chdir=ops/accounts/${environment}  apply -auto-approve tfapply