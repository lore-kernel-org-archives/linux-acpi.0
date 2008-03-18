From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Tue, 18 Mar 2008 23:47:07 +0000
Message-ID: <1205884027.3096.15.camel@monteirov>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com>
	 <1205725210.27560.9.camel@segulix.localdomain>
	 <1205789993.6918.30.camel@segulix.localdomain>
	 <1205810090.11199.1.camel@sli10-desk.sh.intel.com>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-iT9BlflTz+t2ZfUbCZsx"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3.netcabo.pt ([212.113.174.30]:36587 "EHLO
	exch01smtp12.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756062AbYCSTtW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Mar 2008 15:49:22 -0400
In-Reply-To: <1205810090.11199.1.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <gregkh@suse.de>


--=-iT9BlflTz+t2ZfUbCZsx
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable


On Tue, 2008-03-18 at 11:14 +0800, Shaohua Li wrote:
> On Mon, 2008-03-17 at 21:39 +0000, Sergio Monteiro Basto wrote:
> > On Mon, 2008-03-17 at 03:40 +0000, Sergio Monteiro Basto wrote:
> > > On Fri, 2008-03-14 at 11:49 +0800, Shaohua Li wrote:
> > > > asus_hides_smbus_lpc_ich6() is called with interrupt disabled in
> > > > resume
> > > > time, but ioremap_nocache() and iounmap() can't be called with
> > > > interrupt
> > > > disabled. Below is my debug fix. If you have better fix, please
> > > > speak.=20
> > >=20
> > > yap , I have a better fix for my laptop=20
> > > I have a Compaq nx , and this quirk is applied ,
> > >=20
> > > I simply remove the quirk like I had write=20
> > > http://lkml.org/lkml/2007/3/9/516
> > >=20
> > > Especially if we don't an ASUS, which may need the quirk.
> > >=20
> > > I have been working almost an year without the quirk on my laptop and
> > > things seems that work better=20
> >=20
> > Btw I am running  2.6.24.3-12 fedora kernel , I recompile from the
> > src.rpm and apply with 2 patches one:=20
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D9642
> > this one seems that I don't need anymore on 2.6.25-rc=20
> > and remove this quirk.
> > And enable ACPI_DEBUG.
> >=20
> > And I am very happy with it , hibernation, suspend works very well and
> > don't loose ACPI events after resume, backlight also works always fine,
> > ACPI events always on, resume from ram don't have to go to console to
> > have screen .
> > I just use git Intel drive.=20
> >=20
> > Which make me think, will not updates kernels for a very long time :) =20
> > Regards,=20

> Sure, you can remove the quirk without any problem if you don't want to
> use the smbus device.

smbus came with lm_sensors ? isn't it ?=20

I will see, If I can have smbus working or not but just in next month, I
am very busy right now.

But at least name of quirk is wrong, says that if for an ASUS, which I
though that not should be applied on HP Compaqs .

Thanks,=20

--=20
S=E9rgio M.B.

--=-iT9BlflTz+t2ZfUbCZsx
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDMxODIzNDcwMlowIwYJKoZI
hvcNAQkEMRYEFKZhWiqceaIpuxOYQQkt4lksiFDzMA0GCSqGSIb3DQEBAQUABIIBABe7WahB27kO
r/WoeHeg9Y/lVGJLHMfmJFCoR+LEzS7TmtfXrZ0IoSXLyr/Miz5DRmVq54DSyK9Ifd1Kh7cvW0US
66no5TFM/ITo/fE+mFlvQvYT126edTpws+/dqsJj+T2faJMI9uzKTKA4xTyqa55s/+FPM7YxTuxw
roO35Q9Awx5Te+8P5ns3nPvUzImNaDHrlWlEEJyVo4jO4FAVIfoRjDHX1G3ATKZJLZy62PccKc1+
Kgr8LrAsGyspbk1vNrq4xG33BbXLvGUfGWx63EyLGODaw/6eaMw7IFvzSsW9Y2rEl2bjrbsKoktt
cY+tc80RThoPqyhM0hg6K/tcgz4AAAAAAAA=


--=-iT9BlflTz+t2ZfUbCZsx--

