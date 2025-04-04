[![CircleCI](https://dl.circleci.com/status-badge/img/gh/mangila/pokedex-cloud-native/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/mangila/pokedex-cloud-native/tree/main)

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Go](https://img.shields.io/badge/go-%2300ADD8.svg?style=for-the-badge&logo=go&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

# pokedex-cloud-native

Consume pokeapi.co as a Cloud Native app.

Cloud infrastructure is created with Terraform together with Python helper scripts.

- compile_lambda.py
- go_workspace_init.py
- shared_vars.py
- terraform_apply.py
- terraform_destroy.py
- terraform_format.py
- terraform_init.py
- terraform_plan.py
- terraform_validate.py
- test_go.py

pre-commit hooks for some automatic quality control

- [pre-commit](https://pre-commit.com/) hooks see `.pre-commit-config.yaml`

CircleCI for some CI deployment and Terraform state management as a Terraform workspace