From: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Subject: Re: C states on AMD SMP
Date: Sun, 11 Sep 2005 12:09:00 +0200
Message-ID: <1126433340.4839.7.camel@localhost.localdomain>
References: <1126178956.24699.42.camel@localhost.localdomain>
	 <43202621.9080600@tzi.de> <1126182374.4397.8.camel@localhost.localdomain>
	 <43215F09.7030909@tzi.de> <1126339733.22979.2.camel@localhost.localdomain>
	 <4322A06D.8050804@tzi.de> <1126343826.4766.29.camel@localhost.localdomain>
	 <20050910100113.GA2582@tangens.sinus.cz>
	 <1126349195.4766.48.camel@localhost.localdomain>
	 <20050910170808.GA683@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-2W5lzGEWvIJrI+M48X3K"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050910170808.GA683-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
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


--=-2W5lzGEWvIJrI+M48X3K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-09-10 at 19:08 +0200, Pavel Troller wrote:

> > a) mostly for the amd760 chipset (as opposed to amd768)

> But which chipset is in my machine, when for example lspci shows:
> 00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] Sy=
stem Controller (rev 11)
> 00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP=
 Bridge
> 00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev =
04)
> 00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (r=
ev 04)
> Is it a compbination of 760/768 ? If the important part is in the first l=
ine,=20
> does it mean that it cannot work that simple as a "pure" 768 ?

That actually is a amd768 chipset. The southbridge (in your case 768) is
what gives the chipset the name (btw I have exactly the same config).
The northbridge is always 760.

> > b) some registers are already set by default or by bios
> But when the bios forbids PM, takes it enough care to put them to the cor=
rect=20
> state ?

I can change it in my bios settings.

> > c) some registers enable some extra savings
> Another reason for a specialized driver.

Ok, I guess you are right ;-) The default acpi driver lets one CPU go to
C3, one only to C1, and it looks like there actually doesn't happen
anything.

So I guess I will try amd76x_pm another try. Advantage is that I don't
use my saa7134 (tv capturing with extensive bus mastering) anymore, so
the busmastering latency isn't much an issue anymore.

Guess I'll have to give up the idea of plain acpi idling on SMP anyway.

> Probably not, but for example the previous version of the driver with C3 =
enabled
> (the current version seems not to contain C3 support) entered C3 in my ca=
se
> regularly (less than C2, but my machine is running a lot of daemons keepi=
ng CPU
> load at 0.2 or more so maybe it didn't had enough time to enter it so oft=
en).

The current version has an "extra" patch to add C3/NTH/POS support. The
latter two are imho actually not useful. I never got throttling working
(also by taking the except steps as described in the chipset docs), so I
guess it's broken; it won't buy you much power savings anyway. POS off
course is totally useless on a server system.

--=-2W5lzGEWvIJrI+M48X3K
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
MBwGCSqGSIb3DQEJBTEPFw0wNTA5MTExMDA4NTdaMCMGCSqGSIb3DQEJBDEWBBT9LqTRFwBUyLxQ
yVIXxVjwB20JSjANBgkqhkiG9w0BAQEFAASCAQBzksauRa5gbsPXpxCe28FgU9hDngDBJU/oqYNm
EvHxn5T+/mli0sylxWHKNkfFKIELIH/QS43nFIpvEiO2uqP2Do3+wgc+81Hcch387lnu04uN/Y5W
Qb3tV7Alm67ijgorVud1js2QcitWqDuJuOC7XVh72L3bUVBufl7ds4vUi/UpsuQpH/N4T2LJ3SqV
g9t7jBhtOKqSTH6g4scVzhxXgTb+tv3Y2Ao2IJlXJ5hu3S7lm8ZbTne4UKknCGpPyFojJzUqzY/s
JBT1IPdZnoLJdxnNHPW1H1SJlGupzj2L44hI/i2hgayTLYT57Vic5WfePKGMqGs9O4/d7tZtGHFJ
AAAAAAAA


--=-2W5lzGEWvIJrI+M48X3K--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
