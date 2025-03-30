import os
import subprocess
import sys


def main():
    """
    run terraform `destroy` command with vars
    """
    os.chdir("infrastructure")
    tf_vars = {
        "env": "vars/dev.tfvars.tf",
        "secret": "vars/secret.tfvars.tf",
    }
    tf_command = f"terraform destroy -var-file={tf_vars["env"]} -var-file={tf_vars["secret"]} -auto-approve"
    print(tf_command)
    out = subprocess.run(tf_command)
    if out.returncode != 0:
        sys.exit(out.returncode)


if __name__ == "__main__":
    main()
