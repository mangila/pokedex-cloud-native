import os
import subprocess
import sys
import zipfile


def main():
    """
    build binaries and .zip golang source code for aws lambda deployment
    """
    os.chdir("lambda")
    lambdas = [
        {"name": "hello"},
    ]
    output_dir = "../build"
    for lambda_info in lambdas:
        lambda_name = lambda_info["name"]
        go_binary = build_go_binaries(lambda_name=lambda_name,
                                      output_dir=output_dir)
        zip_go_binaries(lambda_name=lambda_name,
                        go_binary=go_binary,
                        output_dir=output_dir)
        clean_up_go_binaries(go_binary=go_binary)


def build_go_binaries(lambda_name, output_dir):
    try:
        os.chdir("./" + lambda_name)
        env = os.environ.copy()
        env["GOOS"] = "linux"
        env["GOARCH"] = "arm64"
        env["CGO_ENABLED "] = "0"
        go_binary = os.path.join(output_dir, lambda_name) + ".bin"
        go_build_command = "go build -o {} main.go".format(go_binary)
        subprocess.run(go_build_command,
                       env=env,
                       check=True)
        print(f"Built golang binary: {go_binary}")
        return go_binary
    except Exception as e:
        print(f"Error while building -- {lambda_name}: {e}")
        sys.exit(1)


def zip_go_binaries(lambda_name, go_binary, output_dir):
    zip_file = os.path.join(output_dir, lambda_name + ".zip")
    try:
        with zipfile.ZipFile(file=str(zip_file), mode='w') as zipf:
            zipf.write(go_binary,
                       arcname="bootstrap",
                       compress_type=zipfile.ZIP_DEFLATED)
        print(f"Created ZIP file: {zip_file}")
        return zip_file
    except Exception as e:
        os.remove(zip_file)
        print(f"Error while compressing -- {lambda_name}: {e}")
        sys.exit(1)


def clean_up_go_binaries(go_binary):
    try:
        os.remove(go_binary)
        print(f"Deleted golang binary: {go_binary}")
    except Exception as e:
        print(f"Error while cleaning up go binary file: {e}")


if __name__ == "__main__":
    main()
