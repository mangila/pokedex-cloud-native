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

## deploy.py

run terraform commands and create resources

- fmt -check
- plan
- apply

## package.py

build binaries and .zip golang source code

## destroy.py

run terraform destroy command