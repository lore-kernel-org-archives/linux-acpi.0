From: Ron Arts <ron.arts-aH2ABhMBJl7z+pZb47iToQ@public.gmane.org>
Subject: Fixing my DSDT. Do I have to learn another language?
Date: Sun, 11 Dec 2005 10:22:57 +0100
Message-ID: <439BEFF1.1040607@netland.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050904040402030902050903"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050904040402030902050903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I own a Uniwill 255II3, and occasionally my system thinks the battery is almost empty
(XP has the same problem on this laptop BTW).

Looking at the syslog I get about every minute:

Dec 11 09:51:05 raarts-ttec kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Dec 11 09:51:05 raarts-ttec kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.BAT0._BST] (Node c145c9e0), AE_TIME

I found out about DSDT's, and determined that mine must contain errors, I need
to fix it, and boot my system with the fixed table.

I dumped my current DSDT, decompiled mine using iasl and looked at it.

This is where I am now. I have looked at the ACPI spec, and this spec is 631 pages.
Do I have to learn this language to fix the fact that my system occasionally
thinks it has an empty battery? Maybe someone can give me a hint on how to
handle it? I made it available here: http://www.netland.nl/download/dsdt.dsl
(temporary link).

Another question (sorry): I also own some Apple iBooks. When I close the lid, they
go into a state where the laptop only preserves its RAM image, and when I open the lid
the system is back within 3 seconds. An iBook can stay this way for a week, before
the battery wears out.

Can I get this to work on this Uniwill laptop with Intel Pentium M processor
and 82852/82855 GM/GME/PM/GMV chipset? Will it last just as long as the iBook?

I am disappointed by the fact that these Intel laptops continuously spin up
their cooling fan, this is very annoying. People I talk to seem to take this
for granted, but The iBooks I have used to far were totally quiet, and the
fan almost never needed to kick in. So I am trying every trick in the book
to let it run cooler.

Thanks,
Ron Arts

--------------ms050904040402030902050903
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJIzCC
AuwwggJVoAMCAQICAw6ZsTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwNDI5MTIxNTU1WhcNMDYwNDI5MTIxNTU1
WjBeMQ0wCwYDVQQEEwRBcnRzMREwDwYDVQQqEwhSb24gUi5BLjEWMBQGA1UEAxMNUm9uIFIu
QS4gQXJ0czEiMCAGCSqGSIb3DQEJARYTcm9uLmFydHNAbmV0bGFuZC5ubDCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBANlu9xu6kwAzUNDpwfNK8HreV4GeZIWBzpWh2h7u6yHi
4rCXA4v4DLiTIIb/5O8CGJurYE2ih9Hdr0Nc3WSB56bCwd6cMjPhlvCwQTRyB7jDRL9qn1Ql
I1sgHEDaFv+9D36QCTL6Q2QHDGLLMjt+gKsVcJUEpAPvPUD1BcPVOQlSMk3NpqRiS0FzvDzO
G73EFWOWQlArQ+yRHJNB2BlYrSUR2expANR4ngZ5rqdbrjiiVP6KbzCxdMXtfARz4mqObQVk
f4zfBKBCXRCoQ5IlLCMrFs1cu4OPy/0jOhuQ7TAEUG4FeZsKA+ukc1MY/s4mhlvzqS98ax5l
XyFy7LQ7Ef8CAwEAAaMwMC4wHgYDVR0RBBcwFYETcm9uLmFydHNAbmV0bGFuZC5ubDAMBgNV
HRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GBACwiE6sFXA6j/hwjTmWbwQvi2q7Hg+eabk7+
Zs2ZxuEkhfPTV/VonGw7AKqq+dCE+n24s8O/I7e2VTnkTX4Qzys7Cftgsgk1EHUHEnhbIamN
3IWgUWLmAwAXwFzYW1GkhngprCXY8PNa5zch3y41JqlTMPd0HTqZEfa5IFTlICK9MIIC7DCC
AlWgAwIBAgIDDpmxMA0GCSqGSIb3DQEBBAUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxU
aGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwg
RnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNTA0MjkxMjE1NTVaFw0wNjA0MjkxMjE1NTVaMF4x
DTALBgNVBAQTBEFydHMxETAPBgNVBCoTCFJvbiBSLkEuMRYwFAYDVQQDEw1Sb24gUi5BLiBB
cnRzMSIwIAYJKoZIhvcNAQkBFhNyb24uYXJ0c0BuZXRsYW5kLm5sMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEA2W73G7qTADNQ0OnB80rwet5XgZ5khYHOlaHaHu7rIeLisJcD
i/gMuJMghv/k7wIYm6tgTaKH0d2vQ1zdZIHnpsLB3pwyM+GW8LBBNHIHuMNEv2qfVCUjWyAc
QNoW/70PfpAJMvpDZAcMYssyO36AqxVwlQSkA+89QPUFw9U5CVIyTc2mpGJLQXO8PM4bvcQV
Y5ZCUCtD7JEck0HYGVitJRHZ7GkA1HieBnmup1uuOKJU/opvMLF0xe18BHPiao5tBWR/jN8E
oEJdEKhDkiUsIysWzVy7g4/L/SM6G5DtMARQbgV5mwoD66RzUxj+ziaGW/OpL3xrHmVfIXLs
tDsR/wIDAQABozAwLjAeBgNVHREEFzAVgRNyb24uYXJ0c0BuZXRsYW5kLm5sMAwGA1UdEwEB
/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEALCITqwVcDqP+HCNOZZvBC+LarseD55puTv5mzZnG
4SSF89NX9WicbDsAqqr50IT6fbizw78jt7ZVOeRNfhDPKzsJ+2CyCTUQdQcSeFshqY3chaBR
YuYDABfAXNhbUaSGeCmsJdjw81rnNyHfLjUmqVMw93QdOpkR9rkgVOUgIr0wggM/MIICqKAD
AgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5n
MSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZy
ZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHy
v1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsY
Pge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0T
AQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20v
VGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQe
MBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD
6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZ
GwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC
3CEZNd4ksdMdRv9dX2VPMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECAw6ZsTAJBgUrDgMCGgUAoIIBpzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNTEyMTEwOTIyNTdaMCMGCSqGSIb3DQEJ
BDEWBBTLR3gC2Ntt3TbZXySsfxcN8qCs6zBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDDpmxMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw6ZsTANBgkqhkiG9w0BAQEFAASCAQDF1R/h
HJ0c6F3FseOttenyKbgZs2jq4CMA/saneDSSHdKxfa8eEVyTTOee0v/94sC30s9Mnkzn6mQ3
7gC6smswzv4xIAkKrRhhBi0RlFs6mJcctezvYHmyfLRhVaSUb8RdGW5vAQcGr1rwZWSP+5lD
oG61A29u6fRvU0wsHEh94pab0KZm5Tez4DfLKvXOVTdsu4RB3N/7QwryuONCZvbGg/alF4i0
m42JbuoJtxwmKFxqXPKHe5ZZ7y9Xudnmcg5tFl/+HU4wLL2morKcTiGNQtS6vb8lV4psjz9V
km9u586TM3K/Rr6/ZHpr/7OCTScG4jZOoGldCUw466+09oVeAAAAAAAA
--------------ms050904040402030902050903--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
