From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.1 - IRQ routing regression on Abit VP6
Date: Wed, 14 Jan 2004 13:09:49 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8D5FEB8@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3DA5C.A26B26BB"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ian Pilcher <i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3DA5C.A26B26BB
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Did you open CONFIG_PCI_USE_VECTOR? Please try close it or try the =
attached patch.

thanks,
-David

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Ian Pilcher
> Sent: 2004=C4=EA1=D4=C214=C8=D5 12:42
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; acpi-devel@lists.sourceforge.net
> Subject: [ACPI] 2.6.1 - IRQ routing regression on Abit VP6
>=20
> 2.6.0 works fine on this hardware, including the twitchy built-in USB
> controllers.
>=20
> Loading the uhci-hcd module on 2.6.1 gives me the following:
>=20
> drivers/usb/core/usb.c: registered new driver usbfs
> drivers/usb/core/usb.c: registered new driver hub
> drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
> driver v2.1
> uhci_hcd 0000:00:07.2: UHCI Host Controller
> uhci_hcd 0000:00:07.2: irq 225, io base 00009400
> uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> uhci_hcd 0000:00:07.3: UHCI Host Controller
> uhci_hcd 0000:00:07.3: irq 225, io base 00009800
> uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> hub 1-0:1.0: new USB device on port 1, assigned address 2
> APIC error on CPU1: 00(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU0: 00(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU1: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU1: 40(40)
> irq 177: nobody cared!
> Call Trace:
>   [<c010d74a>] __report_bad_irq+0x2a/0x90
>   [<c010d840>] note_interrupt+0x70/0xb0
>   [<c010dc35>] do_IRQ+0x195/0x220
>   [<c011b7ed>] smp_apic_timer_interrupt+0xdd/0x150
>   [<c0105000>] rest_init+0x0/0x80
>   [<c010bc24>] common_interrupt+0x18/0x20
>   [<c0108ac0>] default_idle+0x0/0xc0
>   [<c0105000>] rest_init+0x0/0x80
>   [<c0108a19>] hlt_idle+0x29/0x40
>   [<c0108bbb>] cpu_idle+0x3b/0x50
>   [<c03aa4a0>] unknown_bootoption+0x0/0x120
>   [<c03aa940>] start_kernel+0x1b0/0x200
>   [<c03aa4a0>] unknown_bootoption+0x0/0x120
>=20
> handlers:
> [<c0263d00>] (ide_intr+0x0/0x2c0)
> [<c0263d00>] (ide_intr+0x0/0x2c0)
> Disabling IRQ #177
> usb 1-1: control timeout on ep0out
> uhci_hcd 0000:00:07.2: Unlink after no-IRQ?  Different ACPI or APIC
> settings may help.
>=20
> And so on, until I shut down the system.
>=20
> The 20031203 ACPI patch fixes the problem.
>=20
> --
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Ian Pilcher                                        =
i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: Perforce Software.
> Perforce is the Fast Software Configuration Management System offering
> advanced branching capabilities and atomic changes on 50+ platforms.
> Free Eval! http://www.perforce.com/perforce/loadprog.html
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

------_=_NextPart_001_01C3DA5C.A26B26BB
Content-Type: application/octet-stream;
	name="sci_vector-2.6.1"
Content-Transfer-Encoding: base64
Content-Description: sci_vector-2.6.1
Content-Disposition: attachment;
	filename="sci_vector-2.6.1"

ZGlmZiAtTnVyIGxpbnV4LTIuNi4xLm9yaWcvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL2Jvb3QuYyBs
aW51eC0yLjYuMS9hcmNoL2kzODYva2VybmVsL2FjcGkvYm9vdC5jCi0tLSBsaW51eC0yLjYuMS5v
cmlnL2FyY2gvaTM4Ni9rZXJuZWwvYWNwaS9ib290LmMJMjAwNC0wMS0wOCAyMjo1OTo1Ni4wMDAw
MDAwMDAgLTA4MDAKKysrIGxpbnV4LTIuNi4xL2FyY2gvaTM4Ni9rZXJuZWwvYWNwaS9ib290LmMJ
MjAwNC0wMS0xMyAxNDoxNTo1Ny4wMDAwMDAwMDAgLTA4MDAKQEAgLTMyLDYgKzMyLDcgQEAKICNp
bmNsdWRlIDxhc20vYXBpYy5oPgogI2luY2x1ZGUgPGFzbS9pby5oPgogI2luY2x1ZGUgPGFzbS9t
cHNwZWMuaD4KKyNpbmNsdWRlIDxsaW51eC9pcnEuaD4KIAogI2lmIGRlZmluZWQgKENPTkZJR19Y
ODZfTE9DQUxfQVBJQykKICNpbmNsdWRlIDxtYWNoX2FwaWMuaD4KQEAgLTI3NSw3ICsyNzYsMTUg
QEAKIH0KICNlbmRpZiAvKiBDT05GSUdfQUNQSV9CVVMgKi8KIAotCisjaWZkZWYgQ09ORklHX1g4
Nl9JT19BUElDCitpbnQKK2FjcGlfaXJxX3RvX3ZlY3RvciAodTMyIGlycSkKK3sKKwlpZiAodXNl
X3BjaV92ZWN0b3IoKSAmJiAhcGxhdGZvcm1fbGVnYWN5X2lycShpcnEpKQorIAkJaXJxID0gSU9f
QVBJQ19WRUNUT1IoaXJxKTsKKwlyZXR1cm4gaXJxOworfQorI2VuZGlmCiAKIHN0YXRpYyB1bnNp
Z25lZCBsb25nIF9faW5pdAogYWNwaV9zY2FuX3JzZHAgKApkaWZmIC1OdXIgbGludXgtMi42LjEu
b3JpZy9hcmNoL2kzODYva2VybmVsL21wcGFyc2UuYyBsaW51eC0yLjYuMS9hcmNoL2kzODYva2Vy
bmVsL21wcGFyc2UuYwotLS0gbGludXgtMi42LjEub3JpZy9hcmNoL2kzODYva2VybmVsL21wcGFy
c2UuYwkyMDA0LTAxLTA4IDIyOjU5OjE5LjAwMDAwMDAwMCAtMDgwMAorKysgbGludXgtMi42LjEv
YXJjaC9pMzg2L2tlcm5lbC9tcHBhcnNlLmMJMjAwNC0wMS0xMyAxNDoxNTo1Ny4wMDAwMDAwMDAg
LTA4MDAKQEAgLTExMjAsNyArMTEyMCw4IEBACiAKIAkJLyogRG9uJ3Qgc2V0IHVwIHRoZSBBQ1BJ
IFNDSSBiZWNhdXNlIGl0J3MgYWxyZWFkeSBzZXQgdXAgKi8KICAgICAgICAgICAgICAgICBpZiAo
YWNwaV9mYWR0LnNjaV9pbnQgPT0gaXJxKSB7Ci0gICAgICAgICAgICAgICAgICAgICAgICBlbnRy
eS0+aXJxID0gaXJxOyAvKndlIHN0aWxsIG5lZWQgdG8gc2V0IGVudHJ5J3MgaXJxKi8KKwkJCWly
cSA9IGFjcGlfaXJxX3RvX3ZlY3RvcihpcnEpOworCQkJZW50cnktPmlycSA9IGlycTsgLyogd2Ug
c3RpbGwgbmVlZCB0byBzZXQgZW50cnkncyBpcnEgKi8KIAkJCWNvbnRpbnVlOwogICAgICAgICAg
ICAgICAgIH0KIAkKQEAgLTExNDcsMTggKzExNDgsMTQgQEAKIAkJaWYgKCgxPDxiaXQpICYgbXBf
aW9hcGljX3JvdXRpbmdbaW9hcGljXS5waW5fcHJvZ3JhbW1lZFtpZHhdKSB7CiAJCQlwcmludGso
S0VSTl9ERUJVRyAiUGluICVkLSVkIGFscmVhZHkgcHJvZ3JhbW1lZFxuIiwKIAkJCQltcF9pb2Fw
aWNfcm91dGluZ1tpb2FwaWNdLmFwaWNfaWQsIGlvYXBpY19waW4pOwotIAkJCWlmICh1c2VfcGNp
X3ZlY3RvcigpICYmICFwbGF0Zm9ybV9sZWdhY3lfaXJxKGlycSkpCi0gCQkJCWlycSA9IElPX0FQ
SUNfVkVDVE9SKGlycSk7Ci0gCQkJZW50cnktPmlycSA9IGlycTsKKyAJCQllbnRyeS0+aXJxID0g
YWNwaV9pcnFfdG9fdmVjdG9yKGlycSk7CiAJCQljb250aW51ZTsKIAkJfQogCiAJCW1wX2lvYXBp
Y19yb3V0aW5nW2lvYXBpY10ucGluX3Byb2dyYW1tZWRbaWR4XSB8PSAoMTw8Yml0KTsKIAogCQlp
ZiAoIWlvX2FwaWNfc2V0X3BjaV9yb3V0aW5nKGlvYXBpYywgaW9hcGljX3BpbiwgaXJxLCBlZGdl
X2xldmVsLCBhY3RpdmVfaGlnaF9sb3cpKSB7Ci0gCQkJaWYgKHVzZV9wY2lfdmVjdG9yKCkgJiYg
IXBsYXRmb3JtX2xlZ2FjeV9pcnEoaXJxKSkKLSAJCQkJaXJxID0gSU9fQVBJQ19WRUNUT1IoaXJx
KTsKLSAJCQllbnRyeS0+aXJxID0gaXJxOworIAkJCWVudHJ5LT5pcnEgPSBhY3BpX2lycV90b192
ZWN0b3IoaXJxKTsKICAJCX0KIAkJcHJpbnRrKEtFUk5fREVCVUcgIiUwMng6JTAyeDolMDJ4WyVj
XSAtPiAlZC0lZCAtPiBJUlEgJWRcbiIsCiAJCQllbnRyeS0+aWQuc2VnbWVudCwgZW50cnktPmlk
LmJ1cywgCmRpZmYgLU51ciBsaW51eC0yLjYuMS5vcmlnL2RyaXZlcnMvYWNwaS9vc2wuYyBsaW51
eC0yLjYuMS9kcml2ZXJzL2FjcGkvb3NsLmMKLS0tIGxpbnV4LTIuNi4xLm9yaWcvZHJpdmVycy9h
Y3BpL29zbC5jCTIwMDQtMDEtMDggMjI6NTk6NTYuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0y
LjYuMS9kcml2ZXJzL2FjcGkvb3NsLmMJMjAwNC0wMS0xMyAxNjowNzozNS4wMDAwMDAwMDAgLTA4
MDAKQEAgLTI0OSw3ICsyNDksNyBAQAogCSAqLwogCWlycSA9IGFjcGlfZmFkdC5zY2lfaW50Owog
Ci0jaWZkZWYgQ09ORklHX0lBNjQKKyNpZiBkZWZpbmVkKENPTkZJR19JQTY0KSB8fCBkZWZpbmVk
KENPTkZJR19QQ0lfVVNFX1ZFQ1RPUikKIAlpcnEgPSBhY3BpX2lycV90b192ZWN0b3IoaXJxKTsK
IAlpZiAoaXJxIDwgMCkgewogCQlwcmludGsoS0VSTl9FUlIgUFJFRklYICJTQ0kgKEFDUEkgaW50
ZXJydXB0ICVkKSBub3QgcmVnaXN0ZXJlZFxuIiwKQEAgLTI3Miw3ICsyNzIsNyBAQAogYWNwaV9v
c19yZW1vdmVfaW50ZXJydXB0X2hhbmRsZXIodTMyIGlycSwgT1NEX0hBTkRMRVIgaGFuZGxlcikK
IHsKIAlpZiAoYWNwaV9pcnFfaGFuZGxlcikgewotI2lmZGVmIENPTkZJR19JQTY0CisjaWYgZGVm
aW5lZChDT05GSUdfSUE2NCkgfHwgZGVmaW5lZChDT05GSUdfUENJX1VTRV9WRUNUT1IpCiAJCWly
cSA9IGFjcGlfaXJxX3RvX3ZlY3RvcihpcnEpOwogI2VuZGlmCiAJCWZyZWVfaXJxKGlycSwgYWNw
aV9pcnEpOwpkaWZmIC1OdXIgbGludXgtMi42LjEub3JpZy9pbmNsdWRlL2FzbS1pMzg2L2FjcGku
aCBsaW51eC0yLjYuMS9pbmNsdWRlL2FzbS1pMzg2L2FjcGkuaAotLS0gbGludXgtMi42LjEub3Jp
Zy9pbmNsdWRlL2FzbS1pMzg2L2FjcGkuaAkyMDA0LTAxLTA4IDIzOjAwOjAyLjAwMDAwMDAwMCAt
MDgwMAorKysgbGludXgtMi42LjEvaW5jbHVkZS9hc20taTM4Ni9hY3BpLmgJMjAwNC0wMS0xMyAx
NDoxNTo1Ny4wMDAwMDAwMDAgLTA4MDAKQEAgLTExNiw2ICsxMTYsNyBAQAogCiAjaWZkZWYgQ09O
RklHX1g4Nl9JT19BUElDCiBleHRlcm4gaW50IHNraXBfaW9hcGljX3NldHVwOworZXh0ZXJuIGlu
dCBhY3BpX2lycV90b192ZWN0b3IgKHUzMiBpcnEpOwogCiBzdGF0aWMgaW5saW5lIHZvaWQgZGlz
YWJsZV9pb2FwaWNfc2V0dXAodm9pZCkKIHsK

------_=_NextPart_001_01C3DA5C.A26B26BB--


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
