import subprocess

from shared_vars import TF_VARS_FILE, SECRET_TF_VARS_FILE


def terraform_destroy():
    tf_command = f"terraform destroy -var-file={TF_VARS_FILE} -var-file={SECRET_TF_VARS_FILE} -auto-approve"
    print(tf_command)
    subprocess.run(tf_command,
                   cwd="app",
                   check=True,
                   shell=True)


if __name__ == "__main__":
    terraform_destroy()
