import subprocess

from terraform_vars import ENV_TF_VARS_FILE, SECRET_TF_VARS_FILE


def terraform_destroy():
    tf_command = f"terraform destroy -var-file={ENV_TF_VARS_FILE} -var-file={SECRET_TF_VARS_FILE}"
    print(tf_command)
    subprocess.run(tf_command,
                   cwd="infrastructure",
                   check=True,
                   shell=True)


if __name__ == "__main__":
    terraform_destroy()
