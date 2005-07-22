From: Garry Williams <gtwilliams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: DSDT Error Object does not exist (PDC0)
Date: Fri, 22 Jul 2005 15:08:02 -0400
Message-ID: <1122059282.3010.7.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-qebc4FsOSEfH5lqxs//x"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-qebc4FsOSEfH5lqxs//x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On my Sony VGN-FS640/W I have three errors compiling my DSDT

  (http://www.zvolve.com/~garry/dsdt.dsl)

dsdt.dsl   506:             If (LEqual (And (PDC0, 0x0A), 0x0A))
Error    1022 -           Object does not exist ^  (PDC0)
dsdt.dsl   511:             If (LEqual (And (PDC1, 0x0A), 0x0A))
Error    1022 -           Object does not exist ^  (PDC1)
dsdt.dsl   553:                         If (LNot (LEqual (And (PDC1, 0x0A),=
 0x0A)))
Error    1022 -                             Object does not exist ^  (PDC1)

ASL Input:  dsdt.dsl - 4185 lines, 135677 bytes, 1667 keywords
Compilation complete. 3 Errors, 0 Warnings, 0 Remarks, 1 Optimizations

Does anyone know why this is the case or what to do about it?

--=20
Garry Williams -- +1 (678) 656-4579

--=-qebc4FsOSEfH5lqxs//x
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGHDCCAtUw
ggI+oAMCAQICAw6H9DANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUwNDIwMjI0NDEwWhcNMDYwNDIwMjI0NDEwWjBGMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSMwIQYJKoZIhvcNAQkBFhRndHdpbGxpYW1zQGdtYWls
LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKd35xA6MwQlSqPL6gX/Czhm43hT
8+0h8U6fWOt+pPTWOPTUJxCw12Ec/rqIdpPxQpblB/U+gj8Xgeo5glzIzHXiPKRXXxeew88vH20u
Cs/wcql652xmUQWZWwK4PjkILOx+X9RUYYDet6lnGoraypsCfTdq/I+5ZsjkjasWk9JClR0PlEaj
1hQ70hAXmWwHSv4NGFH0Zfcxqjsjgt7KsgxUK9xpgaMFXLaE9QqteWHSrNDorJX9royRLbpkXGNA
HVc3CJ1j+QXvCqw3qDDzmtgB0s1eiTECcMb2Pmmk4N9/Dfo7BPZPS6J4bydGVfTtbQBHAozFGO3I
dEf5DwPdKDUCAwEAAaMxMC8wHwYDVR0RBBgwFoEUZ3R3aWxsaWFtc0BnbWFpbC5jb20wDAYDVR0T
AQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQBODZ3PrHRH5h/cVjOWdn+3wTXuTkz6OaoXXsgMBzIN
wTWyLbqpJ/diT5+R5Fhq2ac6q1C0Elmw6yXKWXIM33a+185uCj6AhCXx9FVdek/gilcgN37IFCo5
C0k17YNghD0pmoEVSgXN8NtvMa00Wdis6Hrd9LEkfGlt1IwJuQYgQjCCAz8wggKooAMCAQICAQ0w
DQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQ
BgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0Nl
cnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAe
Fw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxU
aGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065ypla
HmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688
Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJg
t/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6
Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIB
BjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEF
BQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU13
41YheILcIRk13iSx0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwg
RnJlZW1haWwgSXNzdWluZyBDQQIDDof0MAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNTA3MjIxOTA3NTZaMCMGCSqGSIb3DQEJBDEWBBRfzRdb
vJyjXTjpi1WhbwrCcwZkvjANBgkqhkiG9w0BAQEFAASCAQAEgZ4IsBzZts2gXMoIz4AM683r/Nod
C8LKYYIacbyuJUm/3M495pzICGV76MfWF9JP+eAdeqdfm2EgoyOPuBWrgMwMZaoBZvlg1rbMHN5K
RyTQ0fwwSQwzPlsKyDQ1Kv8WQMsWD5hrQ+czfCDH+QoUGPvplYxe1lyNkWp8jOrp+stBEbpdqttZ
2baS7X/uygHrI/0cuoBueWjaDSB/3N8DJBWXwpIK0Xqb8pZRuBhiaIawRYvdADVbQQyzothHOwcp
7DhGol2mCDAxO+iouLm5YY5zHkU72deB1wABgw/Y555ZrZtSJzsmDC+u+rv0GxlFCsELHv6heMBi
YeXpnCecAAAAAAAA


--=-qebc4FsOSEfH5lqxs//x--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
