# EternalBlue - TryHackMe Lab

## 🧾 Overview
This lab demonstrates the exploitation of the **EternalBlue (MS17-010)** vulnerability, a critical SMB bug that affects older versions of Microsoft Windows. This exploit was famously used in the **WannaCry** ransomware attack and was originally developed by the NSA.

## 🎯 Objectives
- Understand the basics of the SMB protocol.
- Identify and verify a system vulnerable to MS17-010.
- Use Metasploit to exploit EternalBlue and gain a remote shell.
- Perform basic post-exploitation activities.

 🛠 Tools Used
- `nmap`
- `msfconsole` (Metasploit Framework)
- `smbclient`
- `whoami`, `systeminfo` (for enumeration)
- `mimikatz` (optional, for credential harvesting)
- 'hashdump' ( for dum the hashes )
- 'john the ripper '
🔍 Reconnaissance

### Step 1: Scan for open SMB ports
```bash
nmap -p 445 --script smb-vuln-ms17-010 <TARGET_IP>
