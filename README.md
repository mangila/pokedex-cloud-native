# pokedex-cloud-native

## infrastructure

#### Terraform

* AWS provider

create secrets file with AWS for secret key authentication.

`./infrastructure/vars/secret.tfvars.tf`

```terraform
aws_access_key = ""
aws_secret_key = ""
```

## lambda

lambdas source code - golang workspace project

`go work init <module1> <module2>`

- hello - placeholder (WIP)

- shared - structs, utils etc.

## package_lambda.py

build binaries and .zip golang source code for aws lambda deployment

## terraform_apply.py

run terraform `apply` command with vars

## terraform_destroy.py

run terraform `destroy` command with vars

## terraform_format_plan.py

run terraform `fmt` and `plan` command with vars