From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: ACPI Exception (acpi_thermal-0412)
Date: Wed, 20 Sep 2006 02:22:40 +0100
Message-ID: <1158715360.3098.22.camel@localhost.portugal>
References: <200609141951_MC3-1-CB3C-3653@compuserve.com>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-y7aU9qcT1+ezNs9Cw9N6"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from a83-132-128-147.cpe.netcabo.pt ([83.132.128.147]:39571 "EHLO
	localhost.portugal") by vger.kernel.org with ESMTP id S1750842AbWITBWp
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Sep 2006 21:22:45 -0400
In-Reply-To: <200609141951_MC3-1-CB3C-3653@compuserve.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: acpi devel <linux-acpi@vger.kernel.org>


--=-y7aU9qcT1+ezNs9Cw9N6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi, I think this should be reported on=20
ACPI mailing list , so I am Forwarding to this list=20

On Thu, 2006-09-14 at 19:47 -0400, Chuck Ebbert wrote:
> I get this message at boot on 2.6.18-rc6:
>=20
>  ACPI Exception (acpi_thermal-0412): AE_NOT_FOUND, Invalid active thresho=
ld [0] [20060707]
>=20
> Followed by:
>=20
>  ACPI: Thermal Zone [THRM] (47 C)
>=20
> And looking in /proc/acpi/thermal_zone/THRM/cooling_mode, I see:
>=20
> <setting not supported>
> cooling mode:   passive
>=20
> The fan seems to run at low speed even when CPU temp is stable at 37C,
> and speeds up when it gets warmer, so there seems to be no overheating
> problem (highest temp seen under full load is 60C.)
>=20
> Is this normal?
>=20
--=20
S=E9rgio M.B.

--=-y7aU9qcT1+ezNs9Cw9N6
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
SIb3DQEJBTEPFw0wNjA5MjAwMTIyNDBaMCMGCSqGSIb3DQEJBDEWBBTkVnom4xt420dVw8G1SHtZ
XH6LADANBgkqhkiG9w0BAQEFAASCAQAIw4A1e40Rvkj4f1oNLJBZ+Dg+iTu1tlgMUY8ecqpmwnSz
bOyoKhZZOLhxXn3zTFJHG6PtYuvjvaaGE8MgrPZEjgCArFxS/NYghkQVuq04c11lr99kT2Una/w1
UCDt1knW8HKTSo48Tsye9S4VEJ0u64Qf27hLBW0xoI2gm2wWF3dWF1/vtV9u7XPxtf1q2br/TT/g
+xfMaw8VzzzWrsd96ENJzWnH6+Mbxaj5pIo85gzKIcTn7E+GOlEZisiD27mkGse0pkTg3n0HyhHe
a8v5iW19M26OAZRuHJI5dUErt737SKOP+pNO///YzmDVg91DCL7B3v9w21C0uaYK7Y5QAAAAAAAA



--=-y7aU9qcT1+ezNs9Cw9N6--

