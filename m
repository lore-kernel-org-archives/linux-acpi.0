From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: ACPI screwing up USB ehci_hcd with kernel 2.6.16.18
Date: Wed, 31 May 2006 00:57:08 +0100
Message-ID: <1149033428.2881.24.camel@localhost.portugal>
References: <200605282150.24428.surgpub@telkomsa.net>
	 <1148904708.2916.1.camel@localhost.localdomain>
	 <200605302226.52705.surgpub@telkomsa.net>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-F0nTi/kpToY2z8Aq+rbK"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.netcabo.pt ([212.113.174.28]:8757 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932537AbWE3X5U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 May 2006 19:57:20 -0400
In-Reply-To: <200605302226.52705.surgpub@telkomsa.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Surgeon <surgpub@telkomsa.net>
Cc: linux-acpi@vger.kernel.org


--=-F0nTi/kpToY2z8Aq+rbK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,
Some of yours hardware have same IDs than mine=20

you have as relevant ;
cat /usr/include/linux/pci_ids.h  |  grep 3189
#define PCI_DEVICE_ID_VIA_8377_0        0x3189
#define PCI_DEVICE_ID_VIA_82C586_1      0x0571
#define PCI_DEVICE_ID_VIA_82C586_2      0x3038
#define PCI_DEVICE_ID_VIA_8237          0x3227
#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4800_8X    0x0281

I have=20
PCI_DEVICE_ID_VIA_82C586_1=20
PCI_DEVICE_ID_VIA_82C586_2
PCI_DEVICE_ID_VIA_8237_SATA=20

On kernel 2.6.16.17 enter this patch which, if you don't use kernel-rc
version doesn't change nothing :D
http://www.kernel.org/diff/diffview.cgi?file=3D%2Fpub%2Flinux%2Fkernel%
2Fv2.6%2Fincr%2Fpatch-2.6.16.16-17.bz2;z=3D12

if you compile your kernel, you could try remove this 2 lines,=20
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
quirk_via_irq);=20
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2,
quirk_via_irq);=20
to see if ACPI IRQ routing works better:=20

Well, this can be done like this=20
cd drives/pci
edit and delete the lines on quirks.c
cd ../..
make bzImage
(backup mv /boot/vmlinuz-2.6.16.18 /boot/vmlinuz-2.6.16.18.orig)
mv arch/x86_64/boot/bzImage /boot/vmlinuz-2.6.16.18)
and reboot=20

My question which is not meaningfully, because I made a little
confusion, but is if you has used other version of kernel before ? =20

Maybe the best is open o bug in bugzilla with a complete dmesg and one
lspci -n , etc.

I am little curious, why your interrupts are XT-PIC and not IO-APIC

Thanks for the report ,
On Tue, 2006-05-30 at 22:26 +0200, Paul Surgeon wrote:
> On Monday 29 May 2006 14:11, Sergio Monteiro Basto wrote:
> > and before ?
> > can you send lspci -n ?
>=20
> I can send you a lot more than that.  :)
> I attached a zip file containing 10 log files which hopefully won't be an=
=20
> issue with the mailing list. (a single uncompressed dmesg log is 15KB so=20
> hopefully an 18KB zip file won't be a problem)
>=20
> There are two versions of each log file. One before I added acpi=3Dnoirq =
to the=20
> boot options and one after I added acpi=3Dnoirq to the boot options.
>=20
> logs :
> dmesg (dmesg after bootup - USB storage device not plugged in)
> dmesg-usb-plugin  (dmesg output after plugging in USB storage device)
> interrupts
> lspci
> lspci-n
>=20
> Hope that helps a bit
> Paul

--=-F0nTi/kpToY2z8Aq+rbK
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
SIb3DQEJBTEPFw0wNjA1MzAyMzU3MDRaMCMGCSqGSIb3DQEJBDEWBBSRlSiITh3apnT9AD94w1lP
VBr3bzANBgkqhkiG9w0BAQEFAASCAQCJik63WLWUXHDuQRh8QmmUW3rTWyk5HKukwEs8wKakHuQ4
1b3QHwdZz4xdi2u6uvG99H5ZkMEO6f7vbNrRVwo+xSNvrQIJFKKWu1novL99bVE0FLHu2uEyg8cr
CLTe/yOEbHcktSfGbsZh3B/sUm+imN0Zp6udUgfBXPyqOjCtxozIAJd1fATPU7Ir+xaG+XpqSq+N
/k+jLjjZxcKMtjwZxJxCXETtxZFeZuENAcCRf91Y/xQkenPIk36fp1HfnnIe3W3QHRehXPOW18yQ
53Sf9KNo/Ctj/hI23IIu7riSVP0Thrg7h3CB29i6L8/IqHNEWHOqDESaWiEznwfvaVmYAAAAAAAA



--=-F0nTi/kpToY2z8Aq+rbK--
