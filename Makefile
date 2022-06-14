project_name = $(shell grep -oP "name: '\K[\w.]+" dbt_project.yml)
region := us-east-1
version := $(shell grep -oP "version: '\K[\d.]+" dbt_project.yml)
account_id := 812219721165

export TF_VAR_project_version=$(version)

.ONESHELL:
ecr_login:
	aws ecr get-login-password | docker login --username AWS --password-stdin $(account_id).dkr.ecr.$(region).amazonaws.com

build_image:
	docker build -t $(account_id).dkr.ecr.$(region).amazonaws.com/$(project_name):$(version) .

push_image: ecr_login
	docker push $(account_id).dkr.ecr.$(region).amazonaws.com/$(project_name):$(version)

terraform_plan:
	cd infra/
	terraform init
	terraform plan

terraform_apply:
	cd infra/
	terraform apply

terraform_destroy:
	cd infra/
	terraform destroy