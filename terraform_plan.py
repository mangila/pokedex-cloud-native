import os
import subprocess

from terraform_vars import ENV_TF_VARS_FILE, SECRET_TF_VARS_FILE, TF_PLAN_FILE


def terraform_plan():
    os.chdir("app")
    tf_command = f"terraform plan -var-file={ENV_TF_VARS_FILE} -out={TF_PLAN_FILE}"
    if os.path.exists(SECRET_TF_VARS_FILE):
        print(f"Including {SECRET_TF_VARS_FILE} in the command.")
        tf_command += f" -var-file={SECRET_TF_VARS_FILE}"
    else:
        print(f"Warning: {SECRET_TF_VARS_FILE} not found. Running without it.")
    print(tf_command)
    subprocess.run(tf_command,
                   check=True,
                   shell=True)


if __name__ == "__main__":
    terraform_plan()
