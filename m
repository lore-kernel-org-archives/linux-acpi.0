From: Ron Arts <ron.arts-aH2ABhMBJl7z+pZb47iToQ@public.gmane.org>
Subject: Re: Fixing my DSDT. Do I have to learn another language?
Date: Thu, 15 Dec 2005 01:09:41 +0100
Message-ID: <43A0B445.70006@netland.nl>
References: <439BEFF1.1040607@netland.nl> <20051213190207.GA16715@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080209020805090202080607"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051213190207.GA16715-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080209020805090202080607
Content-Type: multipart/mixed;
 boundary="------------030502090409020503040404"

This is a multi-part message in MIME format.
--------------030502090409020503040404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bruno Ducrot wrote:
> On Sun, Dec 11, 2005 at 10:22:57AM +0100, Ron Arts wrote:
> 
>>Hi,
>>
>>I own a Uniwill 255II3, and occasionally my system thinks the battery is 
>>almost empty
>>(XP has the same problem on this laptop BTW).
>>

[ snip ]

> 
>>Maybe someone can give me a hint on how to
>>handle it? I made it available here: http://www.netland.nl/download/dsdt.dsl
>>(temporary link).
> 
> 
> The problem is here:
> 
>    2358                     Name (BFB0, Package (0x04)
>    2359                     {
>    2360                         0x00,
>    2361                         0xFFFFFFFF,
>    2362                         0x1034,
>    2363                         0x2A30
>    2364                     })
>    2365                     Method (_BST, 0, NotSerialized)
>    2366                     {
>    2367                         Store ("BST Start", Debug)
>    2368                         Store (\_SB.PCI0.SBRG.EC0.XST0, Index (BFB0, 0x00))
>    2369                         Store (\_SB.PCI0.SBRG.EC0.XST2, Index (BFB0, 0x02))
>    2370                         Store (\_SB.PCI0.SBRG.EC0.XST3, Index (BFB0, 0x03))
>    2371                         Store ("BST End", Debug)
>    2372                         Return (BFB0)
>    2373                     }
> 
> and a timeout happens on one of those lines: 2368, 2369 or 2370.
> The \_SB.PCI0.SBRG.EC0.XST0 (XST1...) are defined under an Embedded
> Controller region.
> The fault come therefore from the EC.  I don't know however if this
> is due to a bug under Linux, or under the EC's firmware.  It may be
> possible that a bios upgrade (including an upgrade to the EC firmware)
> may fix this problem.  Another quick an dirty hack that you may want
> to try is to increase the timeout things into
> 
> drivers/acpi/ec.c
> 
> for example, try to set 100 instead of 50 for ACPI_EC_DELAY
> #define ACPI_EC_DELAY           50      /* Wait 50ms max. during EC ops */
> 
> and so on...
> 

Thanks a lot for this knowledgale answer, I will definitely try this.

>>I am disappointed by the fact that these Intel laptops continuously spin up
>>their cooling fan, this is very annoying. People I talk to seem to take this
>>for granted, but The iBooks I have used to far were totally quiet, and the
>>fan almost never needed to kick in. So I am trying every trick in the book
>>to let it run cooler.
> 
> 
> It's not true.  I saw the fan of my iBook going on, erm, when I wrote a
> driver to control that functionality...
> 

:-)

Ron

--------------030502090409020503040404
Content-Type: text/x-vcard; charset=utf-8;
 name="ron.arts.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ron.arts.vcf"

begin:vcard
fn:Ron Arts
n:Arts;Ron
org:Netland Internet Services BV
adr:;;Kruislaan 419;Amsterdam;;1098VA;The Netherlands
email;internet:ron.arts-aH2ABhMBJl7z+pZb47iToQ@public.gmane.org
tel;work:+31205628282
tel;fax:+31205628281
x-mozilla-html:FALSE
url:http://www.netland.nl
version:2.1
end:vcard


--------------030502090409020503040404--

--------------ms080209020805090202080607
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNTEyMTUwMDA5NDFaMCMGCSqGSIb3DQEJ
BDEWBBSbSLHJSCswDb3AvHpj5kegG4IEGTBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDDpmxMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw6ZsTANBgkqhkiG9w0BAQEFAASCAQCvOZeQ
UMqkkv9iW3XHmk7oPkElhG64RZBVYk1HBbU9hYKLsUYn7naeC+uMxqBRBine5zbuvlS29qOX
iDjN6UDrCQz6xo+r94Ka4QnmrDtPDsEsvS9V6rRmgtj4o/k+DBejFYobqFnWis4X/u2xJgu3
VOw68OIEB/Pt9Ud6Fmjv/ugYbifMk2T3WzwKzfzHKRYPMhnhFqoCXpYoA1KZdQygW7fhJNIk
Hz9ooXFWT4CVGvNCn1WiP2V2QRB4IEbpYjlS8V6twnC8m9O+YKDn/kdheuyhnTMZFSO/6HNE
41596fcDXTkHWtYD7P9hNWVEIN2L/BfFSC6q7Sxd4pdWmHWXAAAAAAAA
--------------ms080209020805090202080607--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
