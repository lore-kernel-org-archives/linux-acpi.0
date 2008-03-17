From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Mon, 17 Mar 2008 21:39:53 +0000
Message-ID: <1205789993.6918.30.camel@segulix.localdomain>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com>
	 <1205725210.27560.9.camel@segulix.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-pDtN0LivtoFpbk1QvClA"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:34220 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752114AbYCQVkS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Mar 2008 17:40:18 -0400
In-Reply-To: <1205725210.27560.9.camel@segulix.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <gregkh@suse.de>


--=-pDtN0LivtoFpbk1QvClA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Mon, 2008-03-17 at 03:40 +0000, Sergio Monteiro Basto wrote:
> On Fri, 2008-03-14 at 11:49 +0800, Shaohua Li wrote:
> > asus_hides_smbus_lpc_ich6() is called with interrupt disabled in
> > resume
> > time, but ioremap_nocache() and iounmap() can't be called with
> > interrupt
> > disabled. Below is my debug fix. If you have better fix, please
> > speak.=20
>=20
> yap , I have a better fix for my laptop=20
> I have a Compaq nx , and this quirk is applied ,
>=20
> I simply remove the quirk like I had write=20
> http://lkml.org/lkml/2007/3/9/516
>=20
> Especially if we don't an ASUS, which may need the quirk.
>=20
> I have been working almost an year without the quirk on my laptop and
> things seems that work better=20

Btw I am running  2.6.24.3-12 fedora kernel , I recompile from the
src.rpm and apply with 2 patches one:=20
http://bugzilla.kernel.org/show_bug.cgi?id=3D9642
this one seems that I don't need anymore on 2.6.25-rc=20
and remove this quirk.
And enable ACPI_DEBUG.

And I am very happy with it , hibernation, suspend works very well and
don't loose ACPI events after resume, backlight also works always fine,
ACPI events always on, resume from ram don't have to go to console to
have screen .
I just use git Intel drive.=20

Which make me think, will not updates kernels for a very long time :) =20
Regards,=20
--=20
S=C3=A9rgio M. B.

--=-pDtN0LivtoFpbk1QvClA
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDMxNzIxMzk1M1owIwYJKoZI
hvcNAQkEMRYEFGz34Cciobkgwqg+o5ReHCJsmbEoMA0GCSqGSIb3DQEBAQUABIIBAKc0kK+oBRh4
bbvKn4Q93oM33GGSMO0BuggWU6VDPZ60uP/4kpIfdS+GllCfVmRFZaUxnloSiL1FfQ8sAtq2KWnI
Q99XH+yyiGg4B0XjaYKIWb2Ci8OpdHjc+wiWPYplb70m5DueUS0ZVf7NlxsLKKAeTqhaMl/WP5ha
uYOpEbYgwN/DV3stjCnKupLqHrVnULyoCS759dUlo7XvX+ltT1oLliSK66D2ikbcIlc6u3xQRljh
u503zvaks+KqJXA/CKMeJDD1+tWNLzyLJTX1izi1c0eJ62VpnWxOaigwPdXCD2KFs2Tzw0p2YK8T
9QItAykyXYxlVeXUnW9D5j4TlrsAAAAAAAA=


--=-pDtN0LivtoFpbk1QvClA--

