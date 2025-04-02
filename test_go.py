import os
import subprocess


def main():
    lambda_src = "app/lambda_src"
    go_dirs = get_go_directories(lambda_src)
    for go_dir in go_dirs:
        print(go_dir)
        go_test_command = "go test -v -count=1 ./..."
        subprocess.run(go_test_command,
                       cwd=go_dir,
                       check=True,
                       shell=True)


def get_go_directories(folder_path):
    for d in os.listdir(folder_path):
        if os.path.isdir(os.path.join(folder_path, d)):
            yield os.path.join(folder_path, d)


if __name__ == "__main__":
    main()
