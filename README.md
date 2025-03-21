# pokedex-cloud-native

## infrastructure

#### Terraform

* AWS provider

create `secret.tfvars.tf` file in `/infrastructure` to set aws secrets

```terraform
aws_access_key = ""
aws_secret_key = ""
```

## lambda

golang lambdas source code

- hello - placeholder (WIP)
- world - placeholder (WIP)

## scripts

python scripts automation

- build and .zip compress golang lambdas
- run terraform commands