import os
import subprocess
import sys


def main():
    """run terraform `plan` command with vars"""
    os.chdir("infrastructure")
    tf_vars = {
        "env": "vars/dev.tfvars.tf",
        "secret": "vars/secret.tfvars.tf",
    }
    terraform_plan(tf_vars)


def terraform_plan(tf_vars: dict[str, str]):
    tf_command = f"terraform plan -var-file={tf_vars["env"]} -var-file={tf_vars["secret"]}"
    print(tf_command)
    out = subprocess.run(tf_command)
    if out.returncode != 0:
        sys.exit(out.returncode)


if __name__ == "__main__":
    main()
