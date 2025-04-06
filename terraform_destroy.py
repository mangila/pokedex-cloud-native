import subprocess


def terraform_destroy():
    tf_command = f"terraform destroy -auto-approve"
    print(tf_command)
    subprocess.run(tf_command,
                   cwd="app",
                   check=True,
                   shell=True)


if __name__ == "__main__":
    terraform_destroy()
