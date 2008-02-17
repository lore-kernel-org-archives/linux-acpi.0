From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: Proc Lid
Date: Sun, 17 Feb 2008 15:56:03 +0000
Message-ID: <1203263763.30364.16.camel@localhost.localdomain>
References: <fa6232b60802162104s7025d47ajbb857cfd75d0bd9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-1UYIbDBmvMpIj4+0j7Cl"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:50660 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751001AbYBQP4I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Feb 2008 10:56:08 -0500
In-Reply-To: <fa6232b60802162104s7025d47ajbb857cfd75d0bd9d@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: N J <njspam@gmail.com>
Cc: linux-acpi@vger.kernel.org


--=-1UYIbDBmvMpIj4+0j7Cl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2008-02-17 at 15:04 +1000, N J wrote:
> Quick question. My laptop lid is always detected as closed. How do I forc=
e
> the state in /proc/acpi/buttons/lid/LID/state (might not be exact path
> because i had to disable acpi on kernel boot to get xorg working) to open=
?

hi , I am looking for someone that had same troubles than me,
 http://bugzilla.kernel.org/show_bug.cgi?id=3D9642

could you try the proposed patch there and report if you had success or
not.

--- a/drivers/acpi/video.c	2008-02-08 00:08:36.000000000 +0000
+++ b/drivers/acpi/video.c	2008-02-07 22:32:37.000000000 +0000
@@ -1764,7 +1765,7 @@ static int acpi_video_bus_put_devices(st
=20
 static int acpi_video_bus_start_devices(struct acpi_video_bus *video)
 {
-	return acpi_video_bus_DOS(video, 0, 0);
+	return acpi_video_bus_DOS(video, 1, 0);
 }
=20
 static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)


>=20
> Thanks in advance,
>=20
> NJ
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
S=C3=A9rgio M. B.

--=-1UYIbDBmvMpIj4+0j7Cl
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGVjCCAw8w
ggJ4oAMCAQICECv58J8+j9G8Y7r6tize4dAwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MTAxMzIyMjE1NFoXDTA4MTAxMjIyMjE1
NFowSzEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEoMCYGCSqGSIb3DQEJARYZc2Vy
Z2lvQHNlcmdpb21iLm5vLWlwLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALmR
do8nLKka6p0NNur5o8znYir80AaybL3nuKDDeY2CNjm8JdpJPea9KmXurRU9Q/jnsmgtn2UH9blF
1qUDxzUvFrZ8fEFkMBht+DJMPShJIa885JyggTvRg+ZUEPdjvb7pHrvpEhxlDcJ9vpYnB4M06D2p
lefGl9TVq9srUCUMc/4/G/OLaLz0f6Nhc0Gb7YcUDIRINHR0pWuCpxl8wxOU8YSx43KbNgPOo3Kn
jtdcgGRoy7kAKN2rQmU4tgLDh8F+f9a3mMc3YRs0CfkPq7RSGMWcNagkEWCcoh0f5tDYjq1iQEWD
5fK1esWmiR5onZ+QyUd+kU7IycY68iMD5BMCAwEAAaNZMFcwDgYDVR0PAQH/BAQDAgSQMBEGCWCG
SAGG+EIBAQQEAwIFoDAkBgNVHREEHTAbgRlzZXJnaW9Ac2VyZ2lvbWIubm8taXAub3JnMAwGA1Ud
EwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAetiCq+dKlfTpFybx+lLoL7A/ep10fER7eHDGB6MQ
9n8HDqz2eOXMZrw0WSYfWXhG+fnrpUE85DseFXQFJDf6gBdD/KlYqnmaDY0nK9LdFHA3hapRARvB
el9wYF60z+1yI69bFzyoZpCnY3+1oFQGews7kwT6u77QVdj6Y8v+Ai0wggM/MIICqKADAgECAgEN
MA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIw
EAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9D
ZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwg
RnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20w
HhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZ
Wh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuv
PAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBly
YLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRw
Oi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMC
AQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFh
YsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVN
d+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIB/DCCAfgCAQEwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECECv58J8+j9G8Y7r6tize4dAwCQYFKw4DAhoFAKBdMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDIxNzE1NTU1N1owIwYJKoZI
hvcNAQkEMRYEFDpWFQ9kXUMWouYb5sWXFEwKP+dOMA0GCSqGSIb3DQEBAQUABIIBAJmbIjdAUfU0
gUr3iUA3GZj1sNp7VBHM4HxcZISVifYHn2RR5ctPb5DqkeXx2hhF8+bB+0TrqyFgENOYMlvwBwS8
xesmijIumLzQX/WQKySk6Aij6P6lCZFtA6Xuahbc0gXuWK2M8uiEgqTxoUVxyC5/mVTauaonXpXJ
qZXYQEQWePRFACjPdULGeaAK5MKRT9oaw9d+vCgCVUumE2Z36VFH2MciRpBmIsyTmh9PvDWUmdj7
b2FPtB2BMa1g641f4QDPiZWT/8b3Q07egc3reqM5aI2LlYg0eGdiaSAXNUjkBxWiZourPW3GWxmQ
9f0Rfwk28G1vp6GFtMB2zC2SrF4AAAAAAAA=


--=-1UYIbDBmvMpIj4+0j7Cl--

