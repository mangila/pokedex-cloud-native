import os
import subprocess
import sys


def main():
    """run terraform `fmt`"""
    os.chdir("infrastructure")
    terraform_format()


def terraform_format():
    tf_command = "terraform fmt -check"
    print(tf_command)
    out = subprocess.run(tf_command, check=True, shell=True)
    if out.returncode != 0:
        sys.exit(out.returncode)


if __name__ == "__main__":
    main()
