From: Florian Manschwetus <florianmanschwetus@gmx.de>
Subject: Re: T60 UltraBay location [PATCH]
Date: Wed, 16 Aug 2006 12:31:23 +0200
Message-ID: <44E2F3FB.90809@gmx.de>
References: <44DD82A5.2050403@gmx.de> <44DD9BFA.2090606@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms090509020507080107040503"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:49116 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750914AbWHPKb0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Aug 2006 06:31:26 -0400
In-Reply-To: <44DD9BFA.2090606@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090509020507080107040503
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Florian Manschwetus wrote:
> Florian Manschwetus wrote:
>> Is IBMAcpi for 2.6.18 now patched with the new path to the UltraBay 
>> for T60 and similar?
>> florian
> ok, this is the Patch for 2.6.16 and 2.6.17 (works on both):
> -------------------------------------------------------------------------
> --- a/drivers/acpi/ibm_acpi.c.orig      2006-06-09 13:00:13.000000000 +0200
> +++ b/drivers/acpi/ibm_acpi.c   2006-06-09 13:02:16.000000000 +0200
> @@ -170,6 +170,7 @@
>   IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",       /* 570 */
>             "\\_SB.PCI0.IDE0.IDES.IDSM", /* 600e/x, 770e, 770x */
>             "\\_SB.PCI0.IDE0.SCND.MSTR", /* all others */
> +          "\\_SB.PCI0.SATA.SCND.MSTR", /* T60 and similar */
>       );                         /* A21e, R30, R31 */
> 
>   IBM_HANDLE(bay_ej, bay, "_EJ3",        /* 600e/x, A2xm/p, A3x */
> -------------------------------------------------------------------------
> yes, it is just adding this line.
> florian
has someone checked it?
Is it on list for include?
florian

--------------ms090509020507080107040503
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKDDCC
BQIwggLqoAMCAQICAwJsyDANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wNjA3
MDQwODM3MDNaFw0wNzA3MDQwODM3MDNaMEgxHDAaBgNVBAMTE0Zsb3JpYW4gTWFuc2Nod2V0
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
KoZIhvcNAQEFBQADggIBAEWB3PGEGRaPY1owD28EJCte+WuYsF+fIGslM6+XJI8aN8i2WkCL
p04pKgrBiNBUe71WXYqbgOgQAAQ36s6Z4HwlCKmn4hyRKAtFDwRa3qGtpSSeyX6jE4BUewXV
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
ZXJ0Lm9yZwIDAmzIMAkGBSsOAwIaBQCgggHbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTA2MDgxNjEwMzEyM1owIwYJKoZIhvcNAQkEMRYEFG58Szl/3kVr
Bv1bpJWvYHlGJq24MFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwIC
AgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3
EAQxgYMwgYAweTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNl
cnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcN
AQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAwJsyDCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQ
MA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYD
VQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0
QGNhY2VydC5vcmcCAwJsyDANBgkqhkiG9w0BAQEFAASCAQABgKp01ijl3PnRATW+etzfsJYu
e1LYP8OJHTxQmVxKQA128tztqdyRNSYl2CBaW0uupaaKowcsXXKUDrUYatb7on3fC9kvuppJ
B6Z2jAGEsQ5HLpgy4zOFuzEpU8hVA4EB3wQ1EhJxdtCELHteXrQm4DPC1D0FtTALLR4bejlw
qy8lmStqWu9/2LsCczH0CAg0pJgL8UZXZclE3XPIRybUJMgBO1y93trtXMdMnXjD5ZPbmC8j
2Uio2mL6dqJ9qeo8K8B8UjDHTJ0mdqZWF0O6e3PIOljiQy7apGigEhKk3DL5pOgqoBivW8Hr
Q7Qq4wUv0g1IEgoBvWa9BgIYBOq5AAAAAAAA
--------------ms090509020507080107040503--
