pkg update -y && pkg upgrade -y
pkg install python nano -y

mkdir -p ~/SH-BASE
cd ~/SH-BASE

cat > sh.py <<'PY'
import os
import sys
import time
import platform
import subprocess

BLUE = "\033[96m"
GREEN = "\033[92m"
RED = "\033[91m"
WHITE = "\033[97m"
RESET = "\033[0m"

def clear():
    os.system("clear")

def wait():
    input(f"\n{BLUE}Enter दबाओ वापस जाने के लिए...{RESET}")

def banner():
    print(BLUE + r"""
  ____  _   _   ____    _    ____  _____
 / ___|| | | | | __ )  / \  / ___|| ____|
 \___ \| |_| | |  _ \ / _ \ \___ \|  _|
  ___) |  _  | | |_) / ___ \ ___) | |___
 |____/|_| |_| |____/_/   \_\____/|_____|

         S H   B A S E   T O O L
             Version 1.0
""" + RESET)

def device_info():
    clear()
    banner()
    print(GREEN + "DEVICE INFORMATION" + RESET)
    print("System :", platform.system())
    print("Release:", platform.release())
    print("Machine:", platform.machine())
    print("Python :", sys.version.split()[0])
    print("Platform:", platform.platform())
    wait()

def terminal():
    clear()
    print(BLUE + "SH BASE - SAFE COMMAND MODE" + RESET)
    print("Exit लिखकर वापस आओ।")
    allowed = {
        "pwd": ["pwd"],
        "date": ["date"],
        "whoami": ["whoami"],
        "python --version": ["python", "--version"],
        "df -h": ["df", "-h"],
        "free -h": ["free", "-h"],
        "ls": ["ls", "-la"],
        "uname -a": ["uname", "-a"]
    }

    while True:
        cmd = input("\nSH> ").strip()
        if cmd.lower() in ("exit", "back"):
            break
        if cmd in allowed:
            subprocess.run(allowed[cmd])
        elif cmd == "":
            continue
        else:
            print(RED + "यह कमांड उपलब्ध नहीं है।" + RESET)
            print("Available:", ", ".join(allowed.keys()))

def about():
    clear()
    banner()
    print("SH BASE TOOL")
    print("A personal Termux utility project.")
    print("Built with Python.")
    print("Mode: Non-root")
    print("Use: Device info, safe terminal commands.")
    wait()

def main():
    while True:
        clear()
        banner()
        print(WHITE + """
 [1] Device Information
 [2] Safe Command Terminal
 [3] About SH BASE
 [0] Exit
""" + RESET)

        choice = input("SH-BASE > ").strip()

        if choice == "1":
            device_info()
        elif choice == "2":
            terminal()
        elif choice == "3":
            about()
        elif choice == "0":
            print(GREEN + "SH BASE बंद हो गया।" + RESET)
            break
        else:
            print(RED + "गलत विकल्प!" + RESET)
            time.sleep(1)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nSH BASE बंद किया गया।")
PY

python sh.py
