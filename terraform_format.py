import subprocess


def terraform_format():
    tf_command = "terraform fmt -check"
    print(tf_command)
    subprocess.run(tf_command,
                   cwd="infrastructure",
                   check=True,
                   shell=True)


if __name__ == "__main__":
    terraform_format()
