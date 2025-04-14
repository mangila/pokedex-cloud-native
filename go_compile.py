import os
import subprocess

from shared_vars import GO_LAMBDAS


def main():
    for lambda_name in GO_LAMBDAS:
        print(lambda_name)
        build_go_binaries(lambda_name=lambda_name)


def build_go_binaries(lambda_name):
    env = os.environ.copy()
    env["GOOS"] = "linux"
    env["GOARCH"] = "amd64"
    env["CGO_ENABLED "] = "0"
    go_build_command = "go build -o bootstrap main.go"
    cwd = f"app/lambda/{lambda_name}"
    subprocess.run(go_build_command,
                   cwd=cwd,
                   env=env,
                   check=True,
                   shell=True)


if __name__ == "__main__":
    main()
