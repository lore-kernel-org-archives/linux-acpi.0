From: "Moritz Naumann" <securemail@zertificon.com>
Subject: Re: Dell OptiPlex 755 ACPI: DMI
Date: Thu, 14 Feb 2008 10:59:10 +0100
Message-ID: <TBoneMsgId%zertificon.com%47B410EE.5060303%zertificon.com%m.naumann@zertificon.com>
References: <47B17562.7010107@zertificon.com> <200802121446.15971.lenb@kernel.org> <TBoneMsgId%zertificon.com%47B2B702.1030305%zertificon.com%m.naumann@zertificon.com> <200802132249.05631.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="----463677A913E6C8AFE49CC0E6B0C19F2C"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smgw2.zertificon.com ([213.23.92.6]:35225 "EHLO
	smgw2.zertificon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbYBNJ7o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 04:59:44 -0500
In-Reply-To: <200802132249.05631.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This is an S/MIME signed message

------463677A913E6C8AFE49CC0E6B0C19F2C
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=utf-8; format=flowed

Len Brown wrote:
> Linux appears to be a special case in this BIOS.
> ISLI returns 1 for OSI(Linux), which causes GUSB to do nothing.
> (otherwise GUSB appears to touch SMM).  GUSB is called at init time,
> and also at wakup time.

I will need to read up a little on these terms (ISLI, GUSB, SMM), as I 
know neither of them so far.

> Do you notice any difference in USB operation with acpi_osi=Linux?
> How about after resume from suspend?

I assume you are referring to suspend to disk? I don't use this on this 
system.

I don't know whether it is related, but on this kernel (recent Debian 
testing backport to stable)...

Linux version 2.6.22-3-amd64 (Debian 2.6.22-6~bpo40+1) 
(nobse@backports.org) (gcc version 4.1.2 20061115 (prerelease) (Debian 
4.1.1-21)) #1 SMP Mon Nov 12 17:53:18 UTC 2007

...this got written to syslog when I switched on my monitor, a DELL 
2007WFPb, which contains a USB hub (yes this is silly) which is 
connected to a rear USB connector of the PC:

Feb 14 09:42:54 pcnau kernel: usb 7-5: new high speed USB device using 
ehci_hcd and address 5
Feb 14 09:42:54 pcnau kernel: usb 7-5: configuration #1 chosen from 1 choice
Feb 14 09:42:54 pcnau kernel: hub 7-5:1.0: USB hub found
Feb 14 09:42:54 pcnau kernel: hub 7-5:1.0: 4 ports detected
Feb 14 09:46:14 pcnau kernel: rtc: lost some interrupts at 2048Hz.
Feb 14 09:46:28 pcnau last message repeated 11 times
Feb 14 09:46:31 pcnau kernel: printk: 8 messages suppressed.
Feb 14 09:46:31 pcnau kernel: rtc: lost some interrupts at 2048Hz.
Feb 14 09:46:40 pcnau kernel: printk: 20 messages suppressed.
Feb 14 09:46:40 pcnau kernel: rtc: lost some interrupts at 2048Hz.
Feb 14 09:47:03 pcnau kernel: printk: 1 messages suppressed.
Feb 14 09:47:03 pcnau kernel: rtc: lost some interrupts at 2048Hz.
Feb 14 09:47:04 pcnau last message repeated 4 times
Feb 14 09:47:11 pcnau kernel: printk: 13 messages suppressed.
Feb 14 09:47:11 pcnau kernel: rtc: lost some interrupts at 2048Hz.
Feb 14 09:47:11 pcnau kernel: printk: 6 messages suppressed.
Feb 14 09:47:11 pcnau kernel: rtc: lost some interrupts at 2048Hz.
Feb 14 09:47:30 pcnau kernel: printk: 13 messages suppressed.
Feb 14 09:47:30 pcnau kernel: rtc: lost some interrupts at 2048Hz.
Feb 14 09:47:32 pcnau last message repeated 3 times
Feb 14 09:47:43 pcnau kernel: printk: 18 messages suppressed.
Feb 14 09:47:43 pcnau kernel: rtc: lost some interrupts at 2048Hz.
Feb 14 09:49:16 pcnau kernel: rtc: lost some interrupts at 2048Hz.
Feb 14 09:49:16 pcnau kernel: rtc: lost some interrupts at 2048Hz.

I can try the same thing with acpi_osi=Linux if it would help. I could 
also run a speed test for writing to USB flash disks with and without 
acpi_osi=Linux if this would be of help. Other than that, I don't know 
what exactly to look for (and I have not run in acpi_osi=Linux mode, 
yet). Can you recommend a specific test to run?

Moritz

------463677A913E6C8AFE49CC0E6B0C19F2C
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIHwwYJKoZIhvcNAQcCoIIHtDCCB7ACAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCBW0wggVpMIIEUaADAgECAhBKw+cO0GuaKjxH3KiV3ynWMA0GCSqGSIb3
DQEBBQUAMIGuMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNVBAcTDlNh
bHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxITAf
BgNVBAsTGGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTE2MDQGA1UEAxMtVVROLVVT
RVJGaXJzdC1DbGllbnQgQXV0aGVudGljYXRpb24gYW5kIEVtYWlsMB4XDTA4MDEw
NzAwMDAwMFoXDTA5MDEwNjIzNTk1OVowga8xCzAJBgNVBAYTAkRFMQ8wDQYDVQQI
EwZCZXJsaW4xDzANBgNVBAcTBkJlcmxpbjEXMBUGA1UEChMOemVydGlmaWNvbi5j
b20xFzAVBgNVBAsTDnplcnRpZmljb24uY29tMSIwIAYDVQQDExlaZXJ0aWZpY29u
IFNvbHV0aW9ucyBHbWJIMSgwJgYJKoZIhvcNAQkBFhlzZWN1cmVtYWlsQHplcnRp
Zmljb24uY29tMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDWbvyp6OQVEce3
/AMJIgKlu+HPWpPRR5DDpC1TmFbESiqVVM5F1TESAIta/UFbGvQOxI2fbfxTpMh0
nTqMJT2WYorjHNXZPd+Nm65GspSVFh38/Fd4I3PoU2zpxOJOdMu0+JsHLX3Ro8rF
YA+5rVYLFAq7zd08uJqundLvX0/vOwIDAQABo4ICAjCCAf4wHwYDVR0jBBgwFoAU
iYJnfcSdJnAAS7RQSHzePa4Ebn0wHQYDVR0OBBYEFOzOVdJDQCDovJKR2Sk72AAF
dZ6vMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsG
AQUFBwMEBggrBgEFBQcDAjARBglghkgBhvhCAQEEBAMCBaAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29t
b2RvLm5ldC9DUFMwgaUGA1UdHwSBnTCBmjBMoEqgSIZGaHR0cDovL2NybC5jb21v
ZG9jYS5jb20vVVROLVVTRVJGaXJzdC1DbGllbnRBdXRoZW50aWNhdGlvbmFuZEVt
YWlsLmNybDBKoEigRoZEaHR0cDovL2NybC5jb21vZG8ubmV0L1VUTi1VU0VSRmly
c3QtQ2xpZW50QXV0aGVudGljYXRpb25hbmRFbWFpbC5jcmwwfAYIKwYBBQUHAQEE
cDBuMDYGCCsGAQUFBzAChipodHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9VVE5BQUFD
bGllbnRDQS5jcnQwNAYIKwYBBQUHMAKGKGh0dHA6Ly9jcnQuY29tb2RvLm5ldC9V
VE5BQUFDbGllbnRDQS5jcnQwDQYJKoZIhvcNAQEFBQADggEBACA7zGmtTeY6s594
DgZks7f7UO8C5yK1AN+xukp0xWrzU/50YFeQ6j8KO+1htq/yBjTA7aV+0jFAcNcl
Qc644+MovHYNYmn69WXOIruU8QRp9dWez4UFSzyob1g90gY3WDOcuRkoOWS6ibQ0
p1VALOXJew51gYqYUY20UGE0RmhVp+hFqIoFYloQfVUeHoAzeGMD3exuPxvczBT6
4rFZiAqTQoJneJlhqqSYgKPby4ITyNjaRoJMtLxUguZjqb7nSsGPyuZtJRcg6KOO
p/a3+SA0n3fHsWJlhmZIehuiQvRMgwMrS2qI5rw/szEdARLqUQLAqtWaknvhVe5R
v4GbmKIxggIeMIICGgIBATCBwzCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVU
MRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVT
VCBOZXR3b3JrMSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0
BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBF
bWFpbAIQSsPnDtBrmio8R9yold8p1jAJBgUrDgMCGgUAoIGxMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDIxNDA5NTkzMVowIwYJ
KoZIhvcNAQkEMRYEFOR2jSiaMPk3tJ9SObOt34IYEthtMFIGCSqGSIb3DQEJDzFF
MEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIGAsg7i0V1Wnq1s
++ktMZfCjHRPJ5xmOMWygsq1vK+wivPwMG1JmSeYMzlvU66VCH4dXa+5/bm0EDfy
ijIlWiYL8wDVyG7ECXJq36UZYXh/ans57626cRc9bZ7Kv2FIuT5Fpis81MB9BYaD
l1Papbas54KsGsFUENqWyk5XrUA2nNA=

------463677A913E6C8AFE49CC0E6B0C19F2C--


