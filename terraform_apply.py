import os
import subprocess
import sys


def main():
    """
    run terraform `apply` command with vars
    """
    os.chdir("infrastructure")
    tf_vars = {
        "env": "vars/dev.tfvars.tf",
        "secret": "vars/secret.tfvars.tf",
    }
    terraform_apply(tf_vars)


def terraform_apply(tf_vars: dict[str, str]):
    env = tf_vars["env"]
    secret = tf_vars["secret"]
    tf_command = ("terraform apply -var-file={} -var-file={}"
                  .format(env, secret))
    print(tf_command)
    out = subprocess.run(tf_command)
    if out.returncode != 0:
        sys.exit(out.returncode)


if __name__ == "__main__":
    main()
