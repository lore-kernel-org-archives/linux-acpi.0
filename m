From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: C2 and C3 processor states cause mouse desynchronization
Date: Tue, 24 Apr 2007 01:50:43 +0100
Message-ID: <1177375843.3689.15.camel@monteirov>
References: <Pine.LNX.4.64.0704222237480.25154@lexneva.name>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-5cETh5aWm03XN6ocvTej"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3.netcabo.pt ([212.113.174.30]:33503 "EHLO
	exch01smtp10.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031000AbXDXAvX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Apr 2007 20:51:23 -0400
In-Reply-To: <Pine.LNX.4.64.0704222237480.25154@lexneva.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lex Neva <acpi@lexneva.name>
Cc: linux-acpi@vger.kernel.org


--=-5cETh5aWm03XN6ocvTej
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-04-22 at 22:57 -0400, Lex Neva wrote:
> So, the questions I have:
>=20
> Is this a problem anyone's seen before?
>=20
> Is this a bug?  If so, is it in linux-ACPI or psmouse (or something
> else)?
>=20
> Is there anything I can do to get my power savings and still make the
> mouse=20
> driver happy?
>=20
> Is there any chance that I can work with the linux-ACPI developers to
> get a=20
> fix produced?
>=20

Well I am not a kernel hacker either but=20
what give you ?=20
cat /sys/devices/system/clocksource/clocksource0/available_clocksource
cat /sys/devices/system/clocksource/clocksource0/current_clocksource

and boot with parameter: report_lost_ticks

and boot with parameter: notsc ( try first report_lost_ticks if you got
lost ticket than boot with both notsc and report_lost_ticks )

cat /proc/interrupts=20
At MNI got any value, different than zero ?

I got all my ansync computer problems resolved at 2.6.21-rc5, but I had
more problems that just a mouse desynchronization=20
=20

Best regards ,=20
--=20
S=E9rgio M.B.

--=-5cETh5aWm03XN6ocvTej
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGVjCCAw8w
ggJ4oAMCAQICEGne8YrzxxgYAeyxZxmiO+owDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA2MTAxMTEwMjAzOVoXDTA3MTAxMTEwMjAz
OVowSzEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEoMCYGCSqGSIb3DQEJARYZc2Vy
Z2lvQHNlcmdpb21iLm5vLWlwLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAN9R
ix9koyWSNQDmAHxcSeWXdFO1osqg2yeNgBBl+fz8FLYyROsDGpZMcnOd/Df6tWwMZpMSYDNIksiZ
5VkCWaWIzIBccHX3wIkqrkcq3v1OcPGW9adXClXSbSZ0Hb4V4+bQ9LMAOjaMlH/dKLVkln6qmbko
NOxgPotdVxCGcUy1Pqa4dT1zFo5+nIv1NAUNqKpq63X/+3nILNG4JGAvLIL8wcYs0cETGS6vISgd
YFN/JlIqekWUGGUmc+SJcyyTWjXGN+2G0SDS8K3a9NFCo7a1Y0FyHQxikQRtB9sCcpQCoXiqaWsT
npSrNJ0Od4w1sHZz09uEdhWKqXEmJsKKwi8CAwEAAaNZMFcwDgYDVR0PAQH/BAQDAgSQMBEGCWCG
SAGG+EIBAQQEAwIFoDAkBgNVHREEHTAbgRlzZXJnaW9Ac2VyZ2lvbWIubm8taXAub3JnMAwGA1Ud
EwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAwVE8/kY82qYG7I2+gW0NhSyn+DR0uAWYbSxB2NgP
16QOrzXt2HazlXkl2Bc+NKQEqEGKOu5fPPg2GoJ3zDO1Y8GUNGtJH0sX+63RGoUNOAv+bAK1Nxhb
illDUUCjW3OqA/hRyBwjU9kHJPYhl1EbAUGpAhfENHjkS/S7b1REBLMwggM/MIICqKADAgECAgEN
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
IEZyZWVtYWlsIElzc3VpbmcgQ0ECEGne8YrzxxgYAeyxZxmiO+owCQYFKw4DAhoFAKBdMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA3MDQyNDAwNTAzOFowIwYJKoZI
hvcNAQkEMRYEFN0K9ROnreG0YJXXpVY8CB8Sd1tjMA0GCSqGSIb3DQEBAQUABIIBAC5jsAhcHPZa
bL7NlKserpx0M1M/DZQJGcA8QI4b8FKRrmKT5VAcpgxKZzCDxlM/OT6Ta7yrUus9P9mkWFe23Mu5
phuL2JsZ05DFcO2vkJVRGxDe+3yIq71Tv2mp9ym+ybw/mVP7uSWthsI7sgswSoIemX9F1oODAj/z
LLgXgtTq10tis2JyzBIYprMBCygg+JYId0X+K0OpivA3qMGCAl0oyQNAX8dpDvNQEq0wkAlPptyW
ncGNnGIojLSyLDv8eD7mHzpGl7+freY/wmLR+m/B3mY8WL1jEtig9KVnkZpXGrFnNRx1Ons8c6JG
7kYooUMApHGDAGllfr/NvpdIyj4AAAAAAAA=


--=-5cETh5aWm03XN6ocvTej--
