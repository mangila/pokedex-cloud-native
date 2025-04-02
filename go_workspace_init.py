import os
import subprocess


def main():
    lambda_src = "app/lambda_src"
    go_work_init_command = "go work init"
    print(go_work_init_command)
    subprocess.run(go_work_init_command,
                   cwd=lambda_src,
                   check=True,
                   shell=True)
    go_dirs = get_go_directories(lambda_src)
    for go_dir in go_dirs:
        go_test_command = f"go work use ./{go_dir}"
        print(go_test_command)
        subprocess.run(go_test_command,
                       cwd=lambda_src,
                       check=True,
                       shell=True)


def get_go_directories(folder_path):
    for d in os.listdir(folder_path):
        if os.path.isdir(os.path.join(folder_path, d)):
            yield d


if __name__ == "__main__":
    main()
