import subprocess

from shared_vars import GO_MODULES


def go_workspace_init():
    lambda_src = "app/lambda_src"
    go_work_init_command = "go work init"
    print(go_work_init_command)
    subprocess.run(go_work_init_command,
                   cwd=lambda_src,
                   check=True,
                   shell=True)
    for go_module in GO_MODULES:
        go_test_command = f"go work use {go_module["name"]}"
        print(go_test_command)
        subprocess.run(go_test_command,
                       cwd=lambda_src,
                       check=True,
                       shell=True)


if __name__ == "__main__":
    go_workspace_init()
