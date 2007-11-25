From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: No blacklight Re: [patch] remove debug info in acpi video
Date: Sun, 25 Nov 2007 00:21:50 +0000
Message-ID: <1195950110.813.1.camel@localhost.localdomain>
References: <20071113005047.GA27837@zhen-devel.sh.intel.com>
	 <1194921410.2969.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-DraX8t5k/nMUg0BksZbt"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:39362 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752977AbXKYA2x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Nov 2007 19:28:53 -0500
In-Reply-To: <1194921410.2969.1.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Zhenyu Wang <zhenyu.z.wang@intel.com>, linux-acpi@vger.kernel.org


--=-DraX8t5k/nMUg0BksZbt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Since I begging to see this message on dmesg , when i press lid button ,
I don't have black light =20


On Tue, 2007-11-13 at 10:36 +0800, Zhang Rui wrote:
> On Tue, 2007-11-13 at 08:50 +0800, Zhenyu Wang wrote:
> >=20
> > Remove acpi video debug message.
> >=20
> > Signed-off-by: Zhenyu Wang <zhenyu.z.wang@intel.com>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
>=20
> > ---
> >  drivers/acpi/video.c |    3 ---
> >  1 files changed, 0 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> > index bac956b..9c8c8e6 100644
> > --- a/drivers/acpi/video.c
> > +++ b/drivers/acpi/video.c
> > @@ -1782,9 +1782,6 @@ static void acpi_video_bus_notify(acpi_handle
> > handle, u32 event, void *data)
> >         struct input_dev *input;
> >         int keycode;
> >=20
> > -
> > -       printk("video bus notify\n");
> > -
> >         if (!video)
> >                 return;
> >=20
> > --
> > 1.5.3.3
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
S=C3=A9rgio M. B.

--=-DraX8t5k/nMUg0BksZbt
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA3MTEyNTAwMjE0NFowIwYJKoZI
hvcNAQkEMRYEFG3AuXWHmMIRs851Qhyr9E7YHPwNMA0GCSqGSIb3DQEBAQUABIIBADexeHK9LV0F
yS0YY4ry+bxuz7SPLqNq48yBrHLKEbalcDiFv+bED5tJBeiNrGSAmDKodCx0fhgaLsaMnRSOVLLm
pY/j2Cr1Lg7WLtt/lmTObD+au3ML50ULCsBvjniXet5qRxwNzUe/tJzqW3GaDny6LSxVpbwHfwjy
A7k/J78OrHQqyEu7BHzH8VIIlg5V5XirEPAlS4pybEJVs2cS5dFAYu++G2NL4eHSYKdWppaypqto
OB6nOibMx54JxBb+EDSqUFzZyYlt28utfiZy6k19YW78qYR9zMBNUrJV+ED/99Jw4sBcUKU4+H78
5jC6DguBeWqb2Srdlf9Lu8AQhekAAAAAAAA=


--=-DraX8t5k/nMUg0BksZbt--

