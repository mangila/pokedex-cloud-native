[![CircleCI](https://dl.circleci.com/status-badge/img/gh/mangila/pokedex-cloud-native/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/mangila/pokedex-cloud-native/tree/main)

# pokedex-cloud-native

## app

#### Terraform

* AWS provider

create secrets file with AWS for secret key authentication.

`app/vars/secret.tfvars.tf`

```terraform
aws_access_key = ""
aws_secret_key = ""
```

## app/lambda_src

lambdas source code - golang workspace project

`go work init <module1> <module2>`

- hello - placeholder (WIP)

- shared - structs, utils etc.

## compile_lambda.py

build golang binaries for aws lambda deployment

- `go build -o bootstrap main.go`

## terraform_apply.py

run `terraform apply -auto-approve` with vars

## terraform_destroy.py

run `terraform destroy -auto-approve` with vars

## terraform_format.py

run `terraform fmt -check` with vars

## terraform_init.py

run `terraform init`

## terraform_plan.py

run `terraform plan`

## terraform_vars.py

terraform tf.vars files location shared variables