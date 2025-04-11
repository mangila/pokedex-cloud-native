import os
import subprocess

from shared_vars import TF_VARS_FILE, SECRET_TF_VARS_FILE, TF_PLAN_FILE


def terraform_plan():
    os.chdir("app")
    tf_command = f"terraform plan -var-file={TF_VARS_FILE} -var-file={SECRET_TF_VARS_FILE} -out={TF_PLAN_FILE}"
    print(tf_command)
    subprocess.run(tf_command,
                   check=True,
                   shell=True)


if __name__ == "__main__":
    terraform_plan()
