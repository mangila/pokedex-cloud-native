import subprocess


def terraform_init():
    tf_command = "terraform init"
    print(tf_command)
    subprocess.run(tf_command,
                   cwd="app",
                   check=True,
                   shell=True)


if __name__ == "__main__":
    terraform_init()
