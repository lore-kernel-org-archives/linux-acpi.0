From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: [patch 16/16] acpi: suppress power button event on S3 resume
Date: Sun, 14 May 2006 01:33:30 +0100
Message-ID: <1147566810.4544.8.camel@localhost.portugal>
References: <200604270926.k3R9QiaN025117@shell0.pdx.osdl.net>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-UK5l6TZ8/MaIuZT8pCoL"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.netcabo.pt ([212.113.174.29]:11567 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750973AbWENAdl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 May 2006 20:33:41 -0400
In-Reply-To: <200604270926.k3R9QiaN025117@shell0.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, apatard@mandriva.com, luming.yu@intel.com


--=-UK5l6TZ8/MaIuZT8pCoL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

ok here it goes the state of applying this 16 patches against 2.6.17-rc4

Patches=20
1 2 out of date (n out of m hunks FAILED)
3 4 ok
5 out of date
6 ok
7 8 9 10 out of date=20
11 12 13 ok
14 out of date=20
15 16 ok



On Thu, 2006-04-27 at 02:25 -0700, akpm@osdl.org wrote:
> From: "Arnaud Patard" <apatard@mandriva.com>
>=20
> Suppress POWER_BUTTON event on S3 resume.
>=20
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>
> Acked-by: "Yu, Luming" <luming.yu@intel.com>
> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>=20
>  drivers/acpi/sleep/main.c |    8 ++++++++
>  1 files changed, 8 insertions(+)
>=20
> diff -puN drivers/acpi/sleep/main.c~acpi-suppress-power-button-event-on-s=
3-resume drivers/acpi/sleep/main.c
> --- 25/drivers/acpi/sleep/main.c~acpi-suppress-power-button-event-on-s3-r=
esume	Wed Apr 26 14:15:19 2006
> +++ 25-akpm/drivers/acpi/sleep/main.c	Wed Apr 26 14:15:19 2006
> @@ -105,6 +105,14 @@ static int acpi_pm_enter(suspend_state_t
>  	default:
>  		return -EINVAL;
>  	}
> +
> +	/* ACPI 3.0 specs (P62) says that it's the responsabilty
> +	 * of the OSPM to clear the status bit [ implying that the
> +	 * POWER_BUTTON event should not reach userspace ]
> +	 */
> +	if (ACPI_SUCCESS(status) && (acpi_state =3D=3D ACPI_STATE_S3))
> +		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
> +
>  	local_irq_restore(flags);
>  	printk(KERN_DEBUG "Back to C!\n");
> =20
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-UK5l6TZ8/MaIuZT8pCoL
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjA1MTQwMDMzMjVaMCMGCSqGSIb3DQEJBDEWBBQCRg8U2SSsLQqDRI8QCJru
AfoMoDANBgkqhkiG9w0BAQEFAASCAQCFtvDRGsf7fRFziWmImNasycedeTdtMdQ5wfCL7tmInc8M
ht2astGdCJq2/yIUn1c5yz0v6A9FlKePAg0x7MPH0sCUx3yDmHurnUVR7NSble57rxRX0We5irOI
dtdw8afdqhcNyjdrHYukId0RRx6b8wfPI0eP1aBSzykZQOBRFRLEu2yzqbpQzGA+t/QARm6bGO5c
NtAMwpTODb14+2pAE+3jStfd+qECgNmprZovcN8Hjkblt5t3db55meSQGYuY4nW7AnAnNt7acuo8
WA9W5b7b1nx6N/7+V9EX2S6uRK0JpaUqlQhsKCkkH2s/TYsopnf46gz6myaFNExeDP6vAAAAAAAA



--=-UK5l6TZ8/MaIuZT8pCoL--
