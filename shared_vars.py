ENV_TF_VARS_FILE = "vars/dev.tfvars.tf"
SECRET_TF_VARS_FILE = "vars/secret.tfvars.tf"
TF_PLAN_FILE = "pokedex-tfplan"
LAMBDAS = [
    {"name": "enrich_pokemon"},
    {"name": "fetch_generation"},
    {"name": "persist_pokemon"},
]
GO_MODULES = [
    {"name": "enrich_pokemon"},
    {"name": "fetch_generation"},
    {"name": "persist_pokemon"},
    {"name": "shared"},
]
