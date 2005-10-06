From: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Subject: Re: Save power at idle onTyan S2466N-MPX, athcool, etc.
Date: Thu, 06 Oct 2005 10:09:44 +0200
Message-ID: <1128586184.5964.22.camel@localhost.localdomain>
References: <E1ENCCr-0005rD-00@mendel.bio.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-hzqWL4s1FVuwMG7aANey"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1ENCCr-0005rD-00-Mlb+9xX7RBA8OKIjkCRLjtKIQNXEaThN@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Mathog <mathog-Mlb+9xX7RBA8OKIjkCRLjtKIQNXEaThN@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-hzqWL4s1FVuwMG7aANey
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-10-05 at 09:33 -0700, David Mathog wrote:

> > We had a discussion about exactly this a few weeks ago.
> >=20
> > It boils down to: the AMD768 chipset can do C1/C2/C3 but not out of the
> > box using ACPI. First because ACPI processor support did not support
> > multiprocessor, now it does, but the ACPI parameters of this motherboar=
d
> > prevent C2/C3 from being used by ACPI processor support.
> >=20
> > So, out of the box you have C1, using the amd76x_pm you also have C2 an=
d
> > optionally C3 support (although that completely screws up my sata
> > controller).
>=20
> Got it, there are problems with ACPI and the S2466.  No big surprise
> there since this board has all sorts of oddball problems.  (No WOL
> etc.)
>=20
> However, it sounded like you and others managed in the end
> obtain some power savings at idle.  Correct?  If so,
> could you or some other poster please explain how you accomplished
> that, stating in particular:
>=20
> 1. relevant BIOS settings
> 2. minimum kernel required
> 3. any extra kernel patches required
> 4. any extra software (like athcool) required
>=20
> The machines in question are single CPU beowulf nodes - they do
> have an S3 video card but it is used only when there are
> hardware problems and/or to change the BIOS.  So maybe
> once every two years.  There's no sound, TV card, video streams,
> or anything else like that.  These just sit around until a
> compute job comes through, then they grind like crazy for a while.
> It would be nice if they used less power while they were waiting.

Please search the mailing list archives for something like amd760,
amd768, amd76x_pm, smp, or simply my name. This has all been covered.

BTW I have had several stability issues with the board, so I am not
going to buy another Tyan board. My previous MSI board always worked
without any problem.

--=-hzqWL4s1FVuwMG7aANey
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
MBwGCSqGSIb3DQEJBTEPFw0wNTEwMDYwODA5NDRaMCMGCSqGSIb3DQEJBDEWBBQSB8ePy2GE/kaY
fjjMgjMEXw07djANBgkqhkiG9w0BAQEFAASCAQC4eUh3NQ9yGaE6OkSbKTDVQk0iA3qwIOvYpTcX
GsYJe7oC9DlNF/grR37XdgXiKLJuL0vPnLk0WZD+XYqlR8ECsk7LTuOWkPPefCB6ylTGhHfTTZxW
LammppiKteeDXIAXj3nlzVUsqB9SdXbf9rP29MTL9sw7By4PcpI1nh1r+P33CqRMYxUs7UczH+9G
1qjl6YPh976yF6l8FtPYektbaM5WXrDnbVaKlBmO2SridYRlbvjXrkHNJBvCWdc03zZ6zUZscVw4
k2ocBQAVRkHFPD2IaANrVFP1uVDwoq78PT9haPDKr2mYvqeoy04daIUEPf3G94U8tLIY1dOzMBDW
AAAAAAAA


--=-hzqWL4s1FVuwMG7aANey--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
