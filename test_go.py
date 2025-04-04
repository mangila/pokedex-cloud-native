import subprocess

from shared_vars import GO_MODULES


def main():
    lambda_src = "app/lambda_src"
    go_modules = GO_MODULES
    for go_module in go_modules:
        go_module_name = go_module["name"]
        cwd = f"{lambda_src}/{go_module_name}"
        print(go_module_name)
        go_test_command = "go test -v -count=1 ./..."
        subprocess.run(go_test_command,
                       cwd=cwd,
                       check=True,
                       shell=True)


if __name__ == "__main__":
    main()
