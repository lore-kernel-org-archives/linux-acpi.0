From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: Strange things on 2.6.19/20 for a dual-core CPU
Date: Tue, 06 Feb 2007 00:04:02 +0000
Message-ID: <1170720242.4926.17.camel@monteirov>
References: <20070205060404.GA23121@tangens.sinus.cz>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-fRIXoLYw4x0bovzY+ZgK"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.netcabo.pt ([212.113.174.28]:6173 "EHLO
	exch01smtp10.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965220AbXBFANR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2007 19:13:17 -0500
In-Reply-To: <20070205060404.GA23121@tangens.sinus.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>
Cc: linux-acpi@vger.kernel.org


--=-fRIXoLYw4x0bovzY+ZgK
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 07:04 +0100, Pavel Troller wrote:
> Hi!
>   I posted the following question, when 2.6.19 was freshly out. However, =
nobody
> has answered. OK, I told myself, let's get things to stabilize, and I wai=
ted
> patiently for 2.6.20. Now, the things are absolutely the same, and IMHO w=
rong.
> Could anybody look at this and decide, whether it is a real bug, which ha=
s to
> be fixed, or not ?

Hi , I also have a Pentium D with a very strange things=20
http://bugzilla.kernel.org/show_bug.cgi?id=3D6419

have you test yours in older kernels?=20


>       With regards, Pavel Troller
>      =20
> ----- Forwarded message from Pavel Troller <patrol@sinus.cz> -----
>=20
> From: Pavel Troller <patrol@sinus.cz>
> To: linux-acpi@vger.kernel.org
> Subject: Strange things on 2.6.19 for a dual-core CPU
> Mail-Followup-To: Pavel Troller <patrol@sinus.cz>,
> 	linux-acpi@vger.kernel.org
> Content-Disposition: inline
> User-Agent: Mutt/1.5.9i
>=20
> Hi!
>   I've updated to vanilla 2.6.19 on my Pentium-D (dual-core x86_64) box.
> Now I can't see even C1 in the /proc/acpi/processor/*/power output:
> patrol@arcus:~$ cat /proc/acpi/processor/CPU1/power
> active state:            C0
> max_cstate:              C8
> bus master activity:     00000000
> maximum allowed latency: 2000 usec
> states:
> patrol@arcus:~$ cat /proc/acpi/processor/CPU2/power
> active state:            C0
> max_cstate:              C8
> bus master activity:     00000000
> maximum allowed latency: 2000 usec
> states:
>=20
>   Another interesting thing is shown here:
> patrol@arcus:~$ cat /proc/acpi/processor/CPU1/info
> processor id:            0
> acpi id:                 1
> bus mastering control:   no
> power management:        no
> throttling control:      yes
> limit interface:         yes
> patrol@arcus:~$ cat /proc/acpi/processor/CPU2/info
> processor id:            1
> acpi id:                 2
> bus mastering control:   no
> power management:        no
> throttling control:      no
> limit interface:         no
>=20
>   As I remember, both cores were showing the same things formerly.
>   The only line referring to CPUs during boot is
> ACPI: Processor [CPU1] (supports 8 throttling states)
>   and CPU2 is not mentioned at all.
>=20
>   The last (but maybe not acpi-related) strange thing is that in /proc/cp=
uinfo,
> CPU1 reports 6403.56 bogomips (as always, approximately twice the clock) =
and CPU2
> 8314.32 ones (too much). It's also very suspicious. Formerly the differen=
ce was
> very small.
>=20
>   Should I provide more info to debug these things, or is it OK ?
>          With regards, Pavel Troller
>=20
> ----- End forwarded message -----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
S=E9rgio M.B.

--=-fRIXoLYw4x0bovzY+ZgK
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
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA3MDIwNjAwMDM1OFowIwYJKoZI
hvcNAQkEMRYEFKq77EqToIZkQ3I2TBGoLOO/q2+yMA0GCSqGSIb3DQEBAQUABIIBALzKnSTplcm7
pWzOR7w1Ik1difyNAXMu2LmAjIXjmCEXXLpFVxm4tHLPzpKAFziaFxOQjbJNCjQdtXR3t9+AT0xK
SnCpBu/SWSbueRrcHYtR9LwH2VE6wR7Jl05TikjBkemeWQATy6JQxBmFXX1DFr/RJ/RSDwIkE2WD
+tPl72BaP35y7I7ayZKFyZ1c4/qdn6fb9BPNJYc/XShwB5Zt0s6+IHXOelmU2XORDQ8BqgpUykCW
h4nWh4Bfu8gmFbvtWpSoyw2RbCgBdxV/rjAn4mhRKqUPff4zms/vS22MbKlMj25WFHEQ326VusiG
yLM1EfkKyTluwDamlYM+1y69tb4AAAAAAAA=


--=-fRIXoLYw4x0bovzY+ZgK--
