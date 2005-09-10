From: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Subject: Re: C states on AMD SMP
Date: Sat, 10 Sep 2005 10:08:53 +0200
Message-ID: <1126339733.22979.2.camel@localhost.localdomain>
References: <1126178956.24699.42.camel@localhost.localdomain>
	 <43202621.9080600@tzi.de> <1126182374.4397.8.camel@localhost.localdomain>
	 <43215F09.7030909@tzi.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-3Yp0gNr7FxG9xqJ4ixyS"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43215F09.7030909-cGBD8117FJM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-3Yp0gNr7FxG9xqJ4ixyS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-09-09 at 12:08 +0200, Janosch Machowinski wrote:

> The P_BLK is actually defined int the FADT...
> And you do not have a _CST object, cause it would habe been decalared her=
e :
>      Scope (\_PR)
>      {
>          Processor (CPU0, 0x00, 0x00008010, 0x06) {}
>          Processor (CPU1, 0x01, 0x00000000, 0x00) {}
>      }
>=20
>=20
> The little 0x06 after CPU0 tells us that there is an P_BLK,
> but like pavel told us, I think the OEM of the Mainboard disabled C2 and=20
>   C3, but you are free to verify it ;-)

Indeed:

Signature:        FACP
Length:           244
Revision:         0x01
Checksum:         0xf7
OEMID:            AMD
OEM Table ID:     TECATE
OEM Revision:     0x06040000
Creator ID:       PTL
Creator Revision: 0x000f4240
FIRMWARE_CTRL:    0x3fefffc0
DSDT:             0x3fefcf54
INT_MODEL:        0x00
SCI_INT:          9
SMI_CMD:          0x0000802f
ACPI_ENABLE:      0xf0
ACPI_DISABLE:     0xf1
S4BIOS_REQ:       0x00
PM1a_EVT_BLK:     0x00008000
PM1b_EVT_BLK:     0x00000000
PM1a_CNT_BLK:     0x00008004
PM1b_CNT_BLK:     0x00000000
PM2_CNT_BLK:      0x00000000
PM_TMR_BLK:       0x00008008
GPE0_BLK:         0x00008020
GPE1_BLK:         0x00000000
PM1_EVT_LEN:      4
PM1_CNT_LEN:      2
PM2_CNT_LEN:      0
PM_TM_LEN:        4
GPE0_BLK_LEN:     4
GPE1_BLK_LEN:     0
GPE1_BASE:        0
P_LVL2_LAT:       101
P_LVL3_LAT:       1001
FLUSH_SIZE:       0
FLUSH_STRIDE:     0
DUTY_OFFSET:      1
DUTY_WIDTH:       0
DAY_ALRM:         0x0d
MON_ALRM:         0x00
CENTURY:          0x32
Flags:            0x00000005

Is there a way to patch the FADT or to fool linux-acpi into it does
actually work (to at least be able to test the thing)?

--=-3Yp0gNr7FxG9xqJ4ixyS
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGFjCCAs8w
ggI4oAMCAQICAw9TczANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUwODE4MTE1NDA1WhcNMDYwODE4MTE1NDA1WjBDMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSAwHgYJKoZIhvcNAQkBFhFlcmlrQHNsYWd0ZXIubmFt
ZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANAMKW15OgreNb+Wd++Xcw6uNJUXXIfX
56u1rtTObMmbbDY2wNc4Iqwbuwaysvox3z+YElXBibE8BAyV1iMjhee4mOfAy38dGHtWDxhOGke8
VpkyY8DSWgMN5p4egTiT6YNdHW75iiQ+Vh5zMHju1UXnIqgf5zkUGkNuxYp15jLZvRDbfA5H+Sil
jbZGB2fiPOJHpyI61ZidcMgdow31qm70/oe6vXxhSZLzo7OLvExE+mQHwbCSIJMN/hPTK1z0lmQ1
kkaEjHrefqIgoF9Dk/WfOtulzvR3xBzDL50GZ32BxT/OhXYe1SHEJpSM1S/aq8TBQJYwjzREWyDh
0OYsmr0CAwEAAaMuMCwwHAYDVR0RBBUwE4ERZXJpa0BzbGFndGVyLm5hbWUwDAYDVR0TAQH/BAIw
ADANBgkqhkiG9w0BAQQFAAOBgQCCpzoneRQIKsUO8zSnwQ7yhJTrS/EaDibiIVrkkCbzXwCiHFAi
7nmTRF0DlLVF3Ssf97ITWT/RSdkj9Xke0OHH7724PJdfpA6OglMnx2i7IcJLzPgPjB+fOmfR0nYX
UYKuzGxTOXmshLmPcwKdpFuRLLk7n+vrTAwJYJI++crhJzCCAz8wggKooAMCAQICAQ0wDQYJKoZI
hvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcT
CUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmlj
YXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3
MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUg
Q29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRw
nd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+R
NiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEA
AaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwu
dGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEA
SIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6E
sZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILc
IRk13iSx0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQQIDD1NzMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0wNTA5MTAwODA4NTBaMCMGCSqGSIb3DQEJBDEWBBTKmQuUUr08PwNf
H69L5g27gJVw2zANBgkqhkiG9w0BAQEFAASCAQC9yUAmY5E/MehfBcCJK7EWlODXc9AhHnwGHjof
qn97TJBkjYnSyARWtSoR0sZAhfFVmPaur8EUHumgCh648tDghI9YnBsPowo9LwVSVNXRpQkkTpqB
RTZ+OJrO1cVnSLE4x/Wgu7O2UMzcNcbJJj4LxeIpaTp6IGihy8KBPqTo5cHd+JBUJs9DRietl/kA
DHecWvdrE/PQXBFCneNYGgVLtyCYSJ6qJPZHMLKk5HNuX37NYGZX9ZDGh3GLV9/qAXP8gwH86EEy
LgLxWrnn7LRXUkXV4f+yZHLXLZ4DWUuPSYItyKdtmpAkBj2cxCoKJs5mvkm28Zfs68DNDuWwRFZA
AAAAAAAA


--=-3Yp0gNr7FxG9xqJ4ixyS--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
