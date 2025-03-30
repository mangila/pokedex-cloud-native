import os
import subprocess
import sys


def main():
    lambdas = [
        {"name": "hello"},
    ]
    for lambda_info in lambdas:
        lambda_name = lambda_info["name"]
        build_go_binaries(lambda_name=lambda_name)


def build_go_binaries(lambda_name):
    try:
        env = os.environ.copy()
        env["GOOS"] = "linux"
        env["GOARCH"] = "amd64"
        env["CGO_ENABLED "] = "0"
        go_build_command = "go build -o bootstrap main.go"
        cwd = f"infrastructure/lambda_src/{lambda_name}"
        subprocess.run(go_build_command,
                       cwd=cwd,
                       env=env,
                       check=True,
                       shell=True)
        print(f"Built golang binary for lambda_src -- {lambda_name}")
    except Exception as e:
        print(f"Error while building golang binary for lambda_src -- {lambda_name}: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
