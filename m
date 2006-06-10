From: Florian Manschwetus <florianmanschwetus@gmx.de>
Subject: conservative govenour problems on coreduo ibm t60
Date: Sat, 10 Jun 2006 16:25:03 +0200
Message-ID: <448AD63F.4060703@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060000090805020907010105"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39879 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030364AbWFJOZK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Jun 2006 10:25:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060000090805020907010105
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

after echo conservative > 
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
is as far as i can see no scaling is active
and i got this (last time without lookup):

Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: ibm_acpi ipw3945 ieee80211 ieee80211_crypt
CPU:    1
EIP:    0060:[<c039ff65>]    Not tainted VLI
EFLAGS: 00010293   (2.6.16-thinkpad-r3 #1)
EIP is at do_dbs_timer+0x3d5/0x4f0
eax: 00000000   ebx: c05eb254   ecx: 00000000   edx: c05eb254
esi: 0000000a   edi: c194b240   ebp: 00000000   esp: c19cff08
ds: 007b   es: 007b   ss: 0068
Process events/1 (pid: 7, threadinfo=c19ce000 task=c19b0540)
Stack: <0>c05ac43c 0000000a 00000001 c05e9a20 00000001 c1977540 c1977540 
f7c5e880
        4ae79880 c05539e0 c05539e4 c194b240 00000000 c01377dc 00000000 
c19cff54
        c01312d5 c194b268 c194b250 00000202 c039fb90 c19ce000 c194b250 
c194b258
Call Trace:
  [<c01377dc>] run_workqueue+0x7c/0x100
  [<c01312d5>] do_sigaction+0x1d5/0x220
  [<c039fb90>] do_dbs_timer+0x0/0x4f0
  [<c0138459>] worker_thread+0x169/0x190
  [<c011f9e0>] default_wake_function+0x0/0x20
  [<c01382f0>] worker_thread+0x0/0x190
  [<c013b9e2>] kthread+0xe2/0x120
  [<c013b900>] kthread+0x0/0x120
  [<c0101005>] kernel_thread_helper+0x5/0x10
Code: 00 00 00 e9 fa fd ff ff 0f bc c0 b9 0a 00 00 00 83 f8 0a 0f 4e c8 
83 f9 09 0f 87 c5 fd ff ff 89 d3 8b 04 8d 20 e0 5e c0 8b 04 03 <8b> 40 
1c c7 04 24 3c c4 5a c0 89 04 8d e0 98 62 c0 8d 41 01 89

best regards
Florian Manschwetus

--------------ms060000090805020907010105
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKDDCC
BQIwggLqoAMCAQICAwFAHTANBgkqhkiG9w0BAQQFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wNTA2
MjgxMTU3NDFaFw0wNjA2MjgxMTU3NDFaMEgxHDAaBgNVBAMTE0Zsb3JpYW4gTWFuc2Nod2V0
dXMxKDAmBgkqhkiG9w0BCQEWGUZsb3JpYW5NYW5zY2h3ZXR1c0BnbXguZGUwggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC2GnTI54ujEGPHu7/5L3UePHT6bydUQAWsck9f44wc
hURmyPxNMb228wpkIEaWOpsnxCYbKfxW7nIi0zP7eSAhGhXiI9jyLPgJ4NpG1OFT2Eyzjkkf
25CtC1NO9ZbMacVieXjDw4ezPkuJvSyhsDcFAUERCWG9DT74tMdP9ADdMzI8h/eXjv6j4flz
TD2WAsDe1hfdSTkzB7G3SMBtBu6J46CY6p93epais/x1CzFkzDJsh0r7dh0tHGhVCGkR1bN1
5SB2QhIdCR3+Ji1F1W8/7ugak6utREUz4LxYPw/wfiIRaVHTVPjo5YwfD0gjcWSXx25gWf2J
SEVBx+VDr3o1AgMBAAGjgcMwgcAwDAYDVR0TAQH/BAIwADBWBglghkgBhvhCAQ0ESRZHVG8g
Z2V0IHlvdXIgb3duIGNlcnRpZmljYXRlIGZvciBGUkVFIGhlYWQgb3ZlciB0byBodHRwOi8v
d3d3LkNBY2VydC5vcmcwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8vb2Nz
cC5jYWNlcnQub3JnMCQGA1UdEQQdMBuBGUZsb3JpYW5NYW5zY2h3ZXR1c0BnbXguZGUwDQYJ
KoZIhvcNAQEEBQADggIBAHBO9tQ4oojmELHscRqzA96tYHC6YXC7a5pKanbAfVaGZaB7MmoY
NWAjkfn7mznd7Q3+pfCJIE8cb472Llfs9lfOspHXs4Jztet01msXqnh8zt6bCiYZnOIF09hD
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
ZXJ0Lm9yZwIDAUAdMAkGBSsOAwIaBQCgggHbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTA2MDYxMDE0MjUwM1owIwYJKoZIhvcNAQkEMRYEFJGmuzsyWqXS
QNmXKu0rL7iOUbcEMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwIC
AgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3
EAQxgYMwgYAweTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNl
cnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcN
AQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAwFAHTCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQ
MA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYD
VQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0
QGNhY2VydC5vcmcCAwFAHTANBgkqhkiG9w0BAQEFAASCAQAL/RcWVY0Y/OvfCycsBomSLE8n
m9Eq+wl5/xJQOm3h5aEqroBRraHK06wmEEwdJ/pr4rGZ2lVM0ohdExO4gfG+L1u/Y0Iw6CSz
MO04f8h3vJsSKa2XwNHx3JBjcfLaupbk8JmOCoGQolpgdqnngxRFLQUrHWiMdEj2aoRsGHdT
wOHM9sETeKOL/4JH3oNpkmSJE5ag2nzyqWOHvczGVrG8t45IApi+PITBYcCRemZBAJtCcjLI
tbwkMILWdVFszNeugy8kuSpOaTYiRUl90DjwCHNFxHQ7xjVPWYEb6kk6dF3GxYw3OU57hUUy
Ukbht5zXeZWf1+kd2Q2iu24vtyeWAAAAAAAA
--------------ms060000090805020907010105--
