import subprocess

from terraform_vars import ENV_TF_VARS_FILE, SECRET_TF_VARS_FILE


def terraform_apply():
    tf_command = f"terraform apply -var-file={ENV_TF_VARS_FILE} -var-file={SECRET_TF_VARS_FILE} -auto-approve"
    print(tf_command)
    subprocess.run(tf_command,
                   cwd="app",
                   check=True,
                   shell=True)


if __name__ == "__main__":
    terraform_apply()
