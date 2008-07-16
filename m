From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: [PATCH 02/11] Check for ACPI backlight support otherwise use
	vendor ACPI drivers
Date: Wed, 16 Jul 2008 14:01:27 +0100
Message-ID: <1216213287.5678.17.camel@segulix.localdomain>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
	 <1216205553-8486-3-git-send-email-trenn@suse.de>
	 <20080716111611.GA27442@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-RF3yZuBBdZEMNw6G6JYx"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:48354 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754840AbYGPNIM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 09:08:12 -0400
In-Reply-To: <20080716111611.GA27442@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it


--=-RF3yZuBBdZEMNw6G6JYx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, this patches are the a solution on i915 with backlight problems and
others ?

like=20

https://bugzilla.redhat.com/show_bug.cgi?id=3D351661

https://bugzilla.redhat.com/show_bug.cgi?id=3D389541

https://bugzilla.redhat.com/show_bug.cgi?id=3D201472

https://bugzilla.redhat.com/show_bug.cgi?id=3D423931

https://bugs.freedesktop.org/show_bug.cgi?id=3D13709

https://bugs.freedesktop.org/show_bug.cgi?id=3D12852

http://bugzilla.kernel.org/show_bug.cgi?id=3D10985

http://bugzilla.kernel.org/show_bug.cgi?id=3D9642

http://bugzilla.kernel.org/show_bug.cgi?id=3D9827


On Wed, 2008-07-16 at 12:16 +0100, Matthew Garrett wrote:
> There's no need to do the IGD flagging (the drm driver probes it=20
> properly), but the rest looks good.
>=20
--=20
S=C3=A9rgio M. B.

--=-RF3yZuBBdZEMNw6G6JYx
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDcxNjEzMDEyMlowIwYJKoZI
hvcNAQkEMRYEFEo/8dunq1Kd5GvszRpo2S2omH45MA0GCSqGSIb3DQEBAQUABIIBAGQqsrJjkyCo
OxiNvl/7QsQjdRp2Sg7Ih3WGsMGaLfg4OlAM12dQGG2OLJVip7r5vYRAlRvXstvNsT8L1QokER3X
UM+CyxMEh6TOcLmq/lgsok96AhwjP67mT5An3oQ8F4LJpYZnkK5Rv26n92T6bZhDaMr7WtNDQMZb
2tdZr7ef6mcHjLIEUerT8RGK2nURcPpQzn/QQMVNBlMDuYAghcef4h55JlqDwH/REMDSUq6vZ1cc
GpKkuctS7KsEaIYDNfnr24QtQ/KuxdaI4RHl7uAEUP3moml1sfTxxfR9XQYORglhKyv+T+q3HKay
73Bpgp4s1yamogyXsvnka7y5cNkAAAAAAAA=


--=-RF3yZuBBdZEMNw6G6JYx--

