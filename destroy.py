import os
import subprocess
import sys


def main():
    os.chdir("infrastructure")
    tf_vars = {
        "env": "vars/dev.tfvars.tf",
        "secret": "vars/secret.tfvars.tf",
    }
    tf_command = ("terraform destroy -var-file={} -var-file={}"
                  .format(tf_vars["env"],
                          tf_vars["secret"]))
    print(tf_command)
    out = subprocess.run(tf_command)
    if out.returncode != 0:
        sys.exit(out.returncode)


if __name__ == "__main__":
    main()
