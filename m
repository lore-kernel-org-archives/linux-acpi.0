From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: Kernel Version specific vendor override possibilities needed -
	Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 05:31:53 +0000
Message-ID: <1203571913.3764.19.camel@localhost.localdomain>
References: <1203471860.3358.177.camel@linux-2bdv.site>
	 <20080220173248.GA22709@srcf.ucam.org>
	 <20080220182339.GC17648@khazad-dum.debian.net>
	 <20080220184954.GB23679@srcf.ucam.org>
	 <20080221031324.GB6344@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-VILBaKme7m/Shtdx3nLd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:51700 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751448AbYBUFb5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 00:31:57 -0500
In-Reply-To: <20080221031324.GB6344@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@MIT.EDU>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>


--=-VILBaKme7m/Shtdx3nLd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Thu, 2008-02-21 at 00:13 -0300, Henrique de Moraes Holschuh wrote:
> On Wed, 20 Feb 2008, Matthew Garrett wrote:
> > It doesn't punish them. They're the ones who are going to work with us=20
> > to ensure that Linux works on their hardware, and their needs are going=
=20
>=20
> And since when we have to work exactly like Windows (whatever version) do=
es
> in THAT case?
>=20
> Also, why would one thing (proper replacement for OSI(Linux)) cause any s=
ort
> of difference over the other (trying to be bug-to-bug compatible with
> Microsoft crap).
>=20

I agree with Henrique. Since we have, in fact, more Windows cases than
Linux cases and for Linux, just announce that  is recommended,
osi=3Dlinux.=20
Also it is possible put Linuxs bios in a kind of white-list in kernel
code ...

--=20
S=C3=A9rgio M. B.

--=-VILBaKme7m/Shtdx3nLd
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDIyMTA1MzE1M1owIwYJKoZI
hvcNAQkEMRYEFMCFlvsN26L7EC09IF+oSSAElrMdMA0GCSqGSIb3DQEBAQUABIIBAJTqkFQ0QTgh
nan1Ol7qWUnSLaOwp2MsMQq8AGOuYNYjv2ermqJ+J3XR8Llk8bpby8TjKSZyGSwnI2PEd5qXQPr5
YTixK9bBiCkiIke30jokaiu3Gq2CeyslIHlwF3Vvg0NS/OZcEZ4LRbNllbe+Ij/e0c42bY4NItKg
Ebg2W3DOtaSckjRVIltlez6Iq8ENGIDcLOTxXFk4xX7UArDxHWS7QHzdUV+Xe61vhzLw3dwzKopl
a1j2DUnBJagm74XDn5BqTXHd9rsE2YA9sM0H3jzY3Kvu1abgMice6L2Lpu2ilioC0B8ZVqJNtz6g
BGszP+Y80VRoOb/FUIoUbWi83MMAAAAAAAA=


--=-VILBaKme7m/Shtdx3nLd--

