From: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Subject: Re: C states on AMD SMP
Date: Sat, 10 Sep 2005 12:46:35 +0200
Message-ID: <1126349195.4766.48.camel@localhost.localdomain>
References: <1126178956.24699.42.camel@localhost.localdomain>
	 <43202621.9080600@tzi.de> <1126182374.4397.8.camel@localhost.localdomain>
	 <43215F09.7030909@tzi.de> <1126339733.22979.2.camel@localhost.localdomain>
	 <4322A06D.8050804@tzi.de> <1126343826.4766.29.camel@localhost.localdomain>
	 <20050910100113.GA2582@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-SHXK+xNBmNgGxseOMQbO"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050910100113.GA2582-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Cc: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-SHXK+xNBmNgGxseOMQbO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-09-10 at 12:01 +0200, Pavel Troller wrote:

> > > > Is there a way to patch the FADT or to fool linux-acpi into it does
> > > > actually work (to at least be able to test the thing)?
> > > Shure, patch the verify functions in processor_idle.c ...
> > > But actually I think this is no good idea...
> >=20
> > Testing purposes ;-)
> >=20
> > BTW amd76x_pm does work, so you never know... I'd really be happy if I
> > could get something off the 190 Watts the machine now dissipates
> > constantly!

>   AFAIK, the Cx state transition mechanism described in the ACPI spec is
> designed just very simply: CPU accesses the "sleep register" stated in th=
e
> FACP for the particular sleep level, does the dummy operation, and hardwa=
re
> puts CPU to the desired sleep level.

Yeah, that's right. The amd 768 chipset does it exactly this way. I have
the documentation here because I fiddled a lot with amd768 and didn't
manage to do it the right thing (which means: full power when needed
(+bus mastering), minimum power when idle).

I do know C2/C3 works, because if you call it from the idle loop, about
20 times in a row, your computer will become dead slow ;-)

> But, what to do, if the chipset is=20
> designed that it requires more than a single access ? I'm afraid that it =
will
> then require a specialized driver for that purpose.=20

In that case it's not acpi compliant. IMHO it shouldn't be mentioned in
the acpi tables anyway...

>   Did You look at the amd76x_pm sources?

Yes ;-)

> I did, just to see what it
> does. There is a plenty of registers accessed, bits set/cleared from them=
,
> simply something, which is not present in plain processor_idle.c.

a) mostly for the amd760 chipset (as opposed to amd768)
b) some registers are already set by default or by bios
c) some registers enable some extra savings

>  I'm also using amd76x_pm and it's really wonderful, the CPUs cool down t=
o 45C
> from 75C, I can even stop the fans and the temp doesn't go above 60C if t=
he
> CPUs are idling.

See above. It doesn't do the right thing, especially not using bus
mastering (like video capturing cards).


--=-SHXK+xNBmNgGxseOMQbO
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGFjCCAs8w
ggI4oAMCAQICAw9TczANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUwODE4MTE1NDA1WhcNMDYwODE4MTE1NDA1WjBDMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSAwHgYJKoZIhvcNAQkBFhFlcmlrQHNsYWd0ZXIubmFt
ZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANAMKW15OgreNb+Wd++Xcw6uNJUXXIfX
56u1rtTObMmbbDY2wNc4Iqwbuwaysvox3z+YElXBibE8BAyV1iMjhee4mOfAy38dGHtWDxhOGke8
VpkyY8DSWgMN5p4egTiT6YNdHW75iiQ+Vh5zMHju1UXnIqgf5zkUGkNuxYp15jLZvRDbfA5H+Sil
jbZGB2fiPOJHpyI61ZidcMgdow31qm70/oe6vXxhSZLzo7OLvExE+mQHwbCSIJMN/hPTK1z0lmQ1
kkaEjHrefqIgoF9Dk/WfOtulzvR3xBzDL50GZ32BxT/OhXYe1SHEJpSM1S/aq8TBQJYwjzREWyDh
0OYsmr0CAwEAAaMuMCwwHAYDVR0RBBUwE4ERZXJpa0BzbGFndGVyLm5hbWUwDAYDVR0TAQH/BAIw
ADANBgkqhkiG9w0BAQQFAAOBgQCCpzoneRQIKsUO8zSnwQ7yhJTrS/EaDibiIVrkkCbzXwCiHFAi
7nmTRF0DlLVF3Ssf97ITWT/RSdkj9Xke0OHH7724PJdfpA6OglMnx2i7IcJLzPgPjB+fOmfR0nYX
UYKuzGxTOXmshLmPcwKdpFuRLLk7n+vrTAwJYJI++crhJzCCAz8wggKooAMCAQICAQ0wDQYJKoZI
hvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcT
CUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmlj
YXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3
MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUg
Q29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRw
nd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+R
NiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEA
AaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwu
dGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEA
SIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6E
sZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILc
IRk13iSx0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQQIDD1NzMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0wNTA5MTAxMDQ2MzVaMCMGCSqGSIb3DQEJBDEWBBTuA6gKxFahX6JR
FagX1nfeofOskTANBgkqhkiG9w0BAQEFAASCAQBQbeDfg0jhnLkg+6tpbdNsjp54IZ/QM4g1MMO1
NvHGC235+5cdFtLzIL6Dpj/oW0tIiW+SSEyUmlNLeZKBL3tu99E2RpSDN6vdA5oBMi7tJ4ux62Jy
1XCUmYbhQ0Q4FFL9HUXTv532q7HcTnyJZGW7GaCOGvxbhHEh6JkM7wwsoOWIIqbFyksNDy0qpCf1
QLRmNoAR6u9Moug8MDgvnmosrbGW+5nyYIrot71oX1u1ULnGfn9supE/2zspOUkK3HVUy+OlAD55
wTmbz2V927FBy10+zhwoGqx+D7UDBYWSGBCEJrp560Da/KeYEnqQJlYAgrsjqN65fmcROXjP6uzN
AAAAAAAA


--=-SHXK+xNBmNgGxseOMQbO--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
