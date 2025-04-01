import subprocess

from terraform_vars import TF_PLAN_FILE


def terraform_apply():
    tf_command = f"terraform apply {TF_PLAN_FILE}"
    print(tf_command)
    subprocess.run(tf_command,
                   cwd="app",
                   check=True,
                   shell=True)


if __name__ == "__main__":
    terraform_apply()
