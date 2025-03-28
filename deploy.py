import os
import subprocess
import sys


def terraform_plan(tf_vars: dict[str, str]):
    env = tf_vars["env"]
    secret = tf_vars["secret"]
    tf_command = ("terraform plan -var-file={} -var-file={}"
                  .format(env, secret))
    print(tf_command)
    out = subprocess.run(tf_command)
    if out.returncode != 0:
        sys.exit(out.returncode)


def terraform_format():
    tf_command = "terraform fmt -check"
    print(tf_command)
    out = subprocess.run(tf_command)
    if out.returncode != 0:
        sys.exit(out.returncode)


def terraform_apply(tf_vars: dict[str, str]):
    env = tf_vars["env"]
    secret = tf_vars["secret"]
    tf_command = ("terraform apply -var-file={} -var-file={}"
                  .format(env, secret))
    print(tf_command)
    out = subprocess.run(tf_command)
    if out.returncode != 0:
        sys.exit(out.returncode)


def main():
    os.chdir("infrastructure")
    tf_vars = {
        "env": "vars/dev.tfvars.tf",
        "secret": "vars/secret.tfvars.tf",
    }
    terraform_format()
    terraform_plan(tf_vars)
    terraform_apply(tf_vars)


if __name__ == "__main__":
    main()
