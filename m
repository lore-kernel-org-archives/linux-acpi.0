From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: RE: how to back from suspend without shutdown
Date: Sat, 22 Apr 2006 00:06:11 +0100
Message-ID: <1145660771.4129.14.camel@localhost.portugal>
References: <554C5F4C5BA7384EB2B412FD46A3BAD11206C7@pdsmsx411.ccr.corp.intel.com>
Reply-To: sergio@sergiomb.no-ip.orgcpi_during_suspend_resume
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-y66YWXVdAA2N+XCvXbhV"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.netcabo.pt ([212.113.174.29]:19726 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932491AbWDUW0x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 18:26:53 -0400
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD11206C7@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: acpi devel <linux-acpi@vger.kernel.org>


--=-y66YWXVdAA2N+XCvXbhV
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-04-19 at 21:59 +0800, Yu, Luming wrote:
> >Hi everybody,
> >I have a new laptop one HP Compaq NX6110 , that works quite well with
> >suspend and hibernation.
> >
> >But after suspend , how I bring back computer ?, the only key that I
> >know is power button, but after press power button and laptop wake-up,
> >Begins the shutdown process because is triggered the power button
> >shutdown .
> >any ideas ?
>=20
> Maybe you need to write a patch:
>=20
> acpi_button_notify:
> 	if(acpi_during_suspend_resume)
> 		don't generate power button event to confuse user space
> daemon,
I agree 100% , just  more simply  and more specific=20
acpi_button_notify:
	if (acpi_during_suspend_resume && power_button_event)
		don't generate event to confuse user space daemon=20

>=20
> for acpi_during_suspend_ruesme definition please search title=20
> "Power-button event after resume from S3" in acpi ML archive.
>=20
so the patch is this
http://marc.theaimsgroup.com/?l=3Dlinux-acpi&m=3D114472292910442&w=3D2

I don't agree with not sending other events than power_button_event.=20

On my point of view, the perfect way, is have user space daemon
receiving all events after suspend less the power_button_event, because
this one was used to make machine wake up, simply like that.


Thanks,

> Thanks,
> Luming
--=20
S=E9rgio M. B.

--=-y66YWXVdAA2N+XCvXbhV
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
SIb3DQEJBTEPFw0wNjA0MjEyMzA2MDdaMCMGCSqGSIb3DQEJBDEWBBQJOzBB2iY8D6ztJvSPBSzO
p8tL4DANBgkqhkiG9w0BAQEFAASCAQAmxGmqNcl1IZXidXDzYueGKR99PvVBJqsYHhSW9zGYZIWk
qYkopTExal2Ip7F8snWTj8a9L2FrXbdBan1W3xYYJM4Gsi8WhayRsbkpdReI/MnWjPpxuOhDL+t2
qBqCBPqliqGUd5cTsnyk8bS9o5cyOIPxX+SKt4AxgDawbnSugfDXauc2GxDn5iBA9y3L8iIWbU+8
DvYyXeXzU/8EGOTxrEGu7pdkdvdoq0rOAHXSDB3jphNUNRdBChfm2AQzDKnEMubId3H2KQcEm99T
PtytRjVBTzeqAfC+p+I0GNXI9HOPryAJQ1Tmh0TF73bUZWSSUPKMm1iK94hvW3zANbhmAAAAAAAA



--=-y66YWXVdAA2N+XCvXbhV--

