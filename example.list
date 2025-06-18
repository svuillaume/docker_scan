#cmd 
http://3.96.209.91:5000/cmd?exec=cat%20/etc/passwd
http://3.96.209.91:5000/cmd?exec=ls+-la

#greeting
http://3.96.209.91:5000/greet

#client-ip
http://3.96.209.91:5000/client-ip

From anywhere
curl -H "X-Forwarded-For: 1.2.3.4" http://3.96.209.91:5000/client-ip

| **IP Address**   | **Reason / Source**                           |
| ---------------- | --------------------------------------------- |
| `45.227.253.55`  | Associated with malware C2 (AbuseIPDB)        |
| `185.220.101.1`  | Tor exit node (commonly flagged as malicious) |
| `1.3.3.7`        | Meme/red team testing IP                      |
| `222.186.30.50`  | Frequent brute-force attacker (honeypots)     |
| `89.248.167.131` | Blacklisted scanning IP (abuse reports)       |
| `23.129.64.50`   | Known Tor exit node, flagged in threat feeds  |
