From: Kristoffer Sjoberg <kristoffer.sjoberg-lzmg0B5VUhvLoDKTGw+V6w@public.gmane.org>
Subject: Re: HP/Compaq NC6120 ACPI problems
Date: Thu, 17 Mar 2005 22:13:05 +0100
Message-ID: <1111093985.4814.3.camel@localhost.localdomain>
References: <20050317200052.686d683f.andrej.prsa@guest.arnes.si>
	 <1111088904.11380.36.camel@eeyore>
	 <20050317215635.1c788c09.andrej.prsa@guest.arnes.si>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-V+g09+HBuY5aISLeAWEC"
In-Reply-To: <20050317215635.1c788c09.andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrej Prsa <andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, ACPI Support <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-V+g09+HBuY5aISLeAWEC
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


On tor, 2005-03-17 at 21:56 +0100, Andrej Prsa wrote:
> Hi,
>=20
> > > The symptoms are as follows: computer starts fine, but within 20-30
> > > seconds it gradually slows down to the point where it can no longer
> > > be used - it takes 5 minutes to start the terminal. The fan doesn't
> > > work, so the machine overheats. Using 'top' shows that 55% of CPU
> > > power is consumed by kacpid.
> >=20
> > Take a look at /proc/interrupts a couple times, and see if there's
> > a device that's spewing interrupts.
>=20
> Observational update: it does *NOT* gradually slow down, it slows down
> *instantly* after 2-3 minutes of running; the time of kacpid blowup is
> somewhat arbitrary, it sometimes happens even before the boot-up is
> complete. If I was to make another wild guess, it might be connected
> with the fan - when the computer is cool, the blowup occurs later, if it
> is warm, it occurs sooner. Is it possible that the call to turn the fan
> on is triggering this kacpid blowup? How does one go about to test this?
>=20
> For the first time I was now running 'top' from the moment a computer
> came up to the moment kacpid boosted CPU consumption. Another erratum:
> it is not 55% of CPU power for kacpid, it is 98%-99% of CPU power
> reported in 'top'.

Hi,

I have a very similar problem on my NC6000, but only after resume from
S4 (swsusp2 2.1.8.2). It simply won't turn on the fan, and after a while
running 'yes' in a terminal, everything comes to a halt until I abort
the scrolling. Running 2.6.11.2 - I think that 2.6.11-rc1 worked fine
though (although it had a few other problems).


BR

Kristoffer Sj=F6berg

--=-V+g09+HBuY5aISLeAWEC
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJGTCCAucw
ggJQoAMCAQICAw3iRTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUwMTI1MTIzMTQ2WhcNMDYwMTI1MTIzMTQ2WjBPMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSwwKgYJKoZIhvcNAQkBFh1rcmlzdG9mZmVyLnNqb2Jl
cmdAbmV0c3Rhci5zZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANzM1JKzLvxOJf9r
hD4j+a70rxJUJU4QlM37aJgTKBF84DkGqfH4VVMO/6Jo9oUmLzmcS4CMHZrnMQBPdjet33nf80vw
2rSbmolXGG0EcyaJ8PwVjkq0+RZOLpX7CUUiMOUwyda2sgGzKK1iGjZwBNUcsZER6A3rXLCi0O9d
9tBeBOSISnS4axxrxzCVaMslC1BwYXwZUoeQ4++dMi/ZhEfGBDy0UmRch7+qV2tZ6eAO9xR3rrQM
23JxOJ6PoQ3wrRvrYtoIt/dpmevRv3l5/4YZqHLcAQKDVuTb2Ka7HLVGOfUSzO+h++92u1NWwylZ
DcX7S4rd+TX8XliqgFhHRNsCAwEAAaM6MDgwKAYDVR0RBCEwH4Eda3Jpc3RvZmZlci5zam9iZXJn
QG5ldHN0YXIuc2UwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQAJTeR8wW2OVZCSddz5
D+wO0kN06EC8Ay4uqYleJhKiKbzLkvnh0qeZq764N060QCvfQJg9aUKXFV2suAtxoCVK1auFN/m0
UbqQBHQBc04BxmS/3q1fn4TrNPVhIDPKeVSCQ/0eJ/AhVKp6B05UN2263rlXIuqLXArQm74Wn4Bq
DjCCAucwggJQoAMCAQICAw3iRTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwMTI1MTIzMTQ2WhcNMDYwMTI1MTIzMTQ2WjBPMR8w
HQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSwwKgYJKoZIhvcNAQkBFh1rcmlzdG9mZmVy
LnNqb2JlcmdAbmV0c3Rhci5zZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANzM1JKz
LvxOJf9rhD4j+a70rxJUJU4QlM37aJgTKBF84DkGqfH4VVMO/6Jo9oUmLzmcS4CMHZrnMQBPdjet
33nf80vw2rSbmolXGG0EcyaJ8PwVjkq0+RZOLpX7CUUiMOUwyda2sgGzKK1iGjZwBNUcsZER6A3r
XLCi0O9d9tBeBOSISnS4axxrxzCVaMslC1BwYXwZUoeQ4++dMi/ZhEfGBDy0UmRch7+qV2tZ6eAO
9xR3rrQM23JxOJ6PoQ3wrRvrYtoIt/dpmevRv3l5/4YZqHLcAQKDVuTb2Ka7HLVGOfUSzO+h++92
u1NWwylZDcX7S4rd+TX8XliqgFhHRNsCAwEAAaM6MDgwKAYDVR0RBCEwH4Eda3Jpc3RvZmZlci5z
am9iZXJnQG5ldHN0YXIuc2UwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQAJTeR8wW2O
VZCSddz5D+wO0kN06EC8Ay4uqYleJhKiKbzLkvnh0qeZq764N060QCvfQJg9aUKXFV2suAtxoCVK
1auFN/m0UbqQBHQBc04BxmS/3q1fn4TrNPVhIDPKeVSCQ/0eJ/AhVKp6B05UN2263rlXIuqLXArQ
m74Wn4BqDjCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUw
EwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3Rl
IENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29u
YWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIx
CzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYD
VQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEF
AAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQ
CjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16em
u59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEA
MEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZy
ZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0
ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/
TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6M
IE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggLnMIIC4wIBATBp
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSww
KgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDeJFMAkGBSsOAwIa
BQCgggFTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MDMxNzIx
MTMwM1owIwYJKoZIhvcNAQkEMRYEFN6TAP+CCLBHU9XUTjDnsmqCljr5MHgGCSsGAQQBgjcQBDFr
MGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4x
LDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMN4kUwegYLKoZI
hvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAo
UHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQID
DeJFMA0GCSqGSIb3DQEBAQUABIIBAHMclAsgD7xqoZH4YR3iuoJpwI8PVHNTF3SxSjF4WoeZvQi/
7Cvquax0K4/JQoJJHh/QjnJRIl7gzQUlaEx4RkvvgdzlR7bts5ZVJYoTHPTUGpl+Tq1aXR4iw2Ge
a16n+973glEbf+AV/AyoaKJsrLLncjCxteacRpiWXGPva1NTONxgsIz7U79KRt02RRcY+NwSDhiu
iFjjq2y7H+w3+Ktm55EwSSAem99NYpWOTD3pS2SPWDRVo+Qq8+1pXvWBU+6UaaDjjC3JOCQhr5Tu
+eDbAa4lZtoB3ws67KE7sHmPJDMWs9nWuoMjpUJgPStPYZ0N4Yn2beYWovMbZl7bsHcAAAAAAAA=


--=-V+g09+HBuY5aISLeAWEC--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
