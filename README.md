![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

# pokedex-cloud-native

Consume pokeapi.co as a Cloud Native app.

Cloud infrastructure is created with Terraform together with Python helper scripts.

- shared_vars.py
- terraform_apply.py
- terraform_destroy.py
- terraform_format.py
- terraform_init.py
- terraform_plan.py
- terraform_validate.py

pre-commit hooks for some automatic quality control

- [pre-commit](https://pre-commit.com/) hooks see `.pre-commit-config.yaml`

Terraform state management as a Terraform workspace