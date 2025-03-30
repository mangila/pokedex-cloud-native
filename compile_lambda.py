import os
import subprocess
import sys


def main():
    """
    build golang binaries for aws lambda deployment
    """
    lambdas = [
        {"name": "hello"},
    ]
    os.chdir("infrastructure/lambda_src")
    for lambda_info in lambdas:
        lambda_name = lambda_info["name"]
        os.chdir(lambda_name)
        build_go_binaries(lambda_name=lambda_name)
        os.chdir("..")


def build_go_binaries(lambda_name):
    try:
        env = os.environ.copy()
        env["GOOS"] = "linux"
        env["GOARCH"] = "amd64"
        env["CGO_ENABLED "] = "0"
        go_build_command = "go build -o bootstrap main.go"
        subprocess.run(go_build_command,
                       env=env,
                       check=True)
        print(f"Built golang binary for lambda_src -- {lambda_name}")
    except Exception as e:
        print(f"Error while building golang binary for lambda_src -- {lambda_name}: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
