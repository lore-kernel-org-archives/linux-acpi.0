From: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC, PATCH] sysdev suspend/resume order?
Date: Mon, 16 Aug 2004 12:04:43 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <88056F38E9E48644A0F562A38C64FB60029C689B@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C483C3.E3ED3F4D"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C483C3.E3ED3F4D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


=20
Problem:
Most of the sysdev_register calls in various devices
are being done using device_initcalls. This method of=20
initialization has a side-effect, as we loose the=20
ordering requirements for various resume calls.=20
Order in which _resume() functions gets called during=20
a resume, just depends on the order device_initcalls=20
were called on these devices.

Shaohua's mail below describes one issue that is a=20
result of this problem, where in pci link device get=20
initialized before PIC. There can be more issues=20
like this.

One solution to this problem:
Call the sysdev_registers during the actual device=20
initialization. Say, i8259 sysdev_register should be=20
called when i8259 device is getting registered and=20
not with a device_initcall 'sometime' later.

With this, we will be able to save the original=20
device initialization order (bootup order), and call=20
the resume methods in the same order.

Attached are the couple of sample patches that does=20
this in particular files.

Questions:
Is this solution proper?
Is there any better solution to this problem? Say=20
introducing some sort of levels in device_initcall.
If the above soultion is proper, is it=20
practical/feasible to audit all usages of=20
sysdev_register() and try to move it to the=20
device initialization function?

Thanks,
Venki

>-----Original Message-----
>From: Pallipadi, Venkatesh=20
>Sent: Friday, August 13, 2004 11:58 AM
>To: Li, Shaohua; 'Patrick Mochel'
>Cc: 'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'; Brown, Len
>Subject: RE: sysdev suspend/resume order?
>
>
>
>I think, there should be a relation between the order
>in which actual device initialization happens during=20
>the boot time and the order in which device initcalls=20
>are called (at boot time).
>
>In this example, actual PIC initialization happens=20
>before pci_link device initialization. So, device=20
>initcall should have a similar ordering. That will=20
>take care of this after S3 ordering in a natural manner.
>
>Thanks,
>Venki=20
>
>>-----Original Message-----
>>From: Li, Shaohua=20
>>Sent: Friday, August 13, 2004 12:37 AM
>>To: Patrick Mochel
>>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Brown, Len; Pallipadi, Venkatesh
>>Subject: sysdev suspend/resume order?
>>
>>Patrick,
>>My sound card dies after S3 sometimes. Basically, if it dies=20
>>depends on the order of sysdev's resume. If IRQ router resume=20
>>before PIC (I use a tricky method to change order. It's=20
>>changing the initcall level of the sysfs initialization for=20
>>the device), the sound card die. Otherwise, it works. Is it=20
>>possible that we add some levels for sysdev? I'd like some=20
>>sysdevs resume before other sysdevs. Does this make sense?=20
>>
>>Thanks,
>>Shaohua
>>
>

------_=_NextPart_001_01C483C3.E3ED3F4D
Content-Type: application/octet-stream;
	name="sysfsinit_i8259.patch"
Content-Transfer-Encoding: base64
Content-Description: sysfsinit_i8259.patch
Content-Disposition: attachment;
	filename="sysfsinit_i8259.patch"

LS0tIGxpbnV4LTIuNi44LjEvYXJjaC9pMzg2L2tlcm5lbC9pODI1OS5jLm9yZwkyMDA0LTA4LTE2
IDEzOjQ0OjA4LjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjguMS9hcmNoL2kzODYva2Vy
bmVsL2k4MjU5LmMJMjAwNC0wOC0xNiAxMzo1NDo0My4wMDAwMDAwMDAgLTA3MDAKQEAgLTI2Miw4
ICsyNjIsNiBAQCBzdGF0aWMgaW50IF9faW5pdCBpODI1OUFfaW5pdF9zeXNmcyh2b2lkCiAJcmV0
dXJuIGVycm9yOwogfQogCi1kZXZpY2VfaW5pdGNhbGwoaTgyNTlBX2luaXRfc3lzZnMpOwotCiB2
b2lkIGluaXRfODI1OUEoaW50IGF1dG9fZW9pKQogewogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CkBA
IC0zMDMsNiArMzAxLDggQEAgdm9pZCBpbml0XzgyNTlBKGludCBhdXRvX2VvaSkKIAlvdXRiKGNh
Y2hlZF9zbGF2ZV9tYXNrLCBQSUNfU0xBVkVfSU1SKTsJICAvKiByZXN0b3JlIHNsYXZlIElSUSBt
YXNrICovCiAKIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZpODI1OUFfbG9jaywgZmxhZ3MpOwor
CWk4MjU5QV9pbml0X3N5c2ZzKCk7CisKIH0KIAogLyoKQEAgLTQwMCw4ICs0MDAsNiBAQCBzdGF0
aWMgaW50IF9faW5pdCBpbml0X3RpbWVyX3N5c2ZzKHZvaWQpCiAJcmV0dXJuIGVycm9yOwogfQog
Ci1kZXZpY2VfaW5pdGNhbGwoaW5pdF90aW1lcl9zeXNmcyk7Ci0KIHZvaWQgX19pbml0IGluaXRf
SVJRKHZvaWQpCiB7CiAJaW50IGk7CkBAIC00MzIsNiArNDMwLDcgQEAgdm9pZCBfX2luaXQgaW5p
dF9JUlEodm9pZCkKIAkgKiB2ZWN0b3Igbm93OgogCSAqLwogCXNldHVwX3RpbWVyKCk7CisJaW5p
dF90aW1lcl9zeXNmcygpOwogCiAJLyoKIAkgKiBFeHRlcm5hbCBGUFU/IFNldCB1cCBpcnExMyBp
ZiBzbywgZm9yCg==

------_=_NextPart_001_01C483C3.E3ED3F4D
Content-Type: application/octet-stream;
	name="sysfsinit_apic.patch"
Content-Transfer-Encoding: base64
Content-Description: sysfsinit_apic.patch
Content-Disposition: attachment;
	filename="sysfsinit_apic.patch"

LS0tIGxpbnV4LTIuNi44LjEvYXJjaC9pMzg2L2tlcm5lbC9hcGljLmMub3JnCTIwMDQtMDgtMTYg
MTM6NDM6MjAuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuOC4xL2FyY2gvaTM4Ni9rZXJu
ZWwvYXBpYy5jCTIwMDQtMDgtMTYgMTQ6MTI6MDEuMDAwMDAwMDAwIC0wNzAwCkBAIC00MCw2ICs0
MCw3IEBACiAjaW5jbHVkZSAiaW9fcG9ydHMuaCIKIAogc3RhdGljIHZvaWQgYXBpY19wbV9hY3Rp
dmF0ZSh2b2lkKTsKK3N0YXRpYyBpbnQgaW5pdF9sYXBpY19zeXNmcyh2b2lkKTsKIAogdm9pZCBf
X2luaXQgYXBpY19pbnRyX2luaXQodm9pZCkKIHsKQEAgLTQ3Nyw2ICs0NzgsNyBAQCB2b2lkIF9f
aW5pdCBzZXR1cF9sb2NhbF9BUElDICh2b2lkKQogCWlmIChubWlfd2F0Y2hkb2cgPT0gTk1JX0xP
Q0FMX0FQSUMpCiAJCXNldHVwX2FwaWNfbm1pX3dhdGNoZG9nKCk7CiAJYXBpY19wbV9hY3RpdmF0
ZSgpOworCWluaXRfbGFwaWNfc3lzZnMoKTsKIH0KIAogI2lmZGVmIENPTkZJR19QTQpAQCAtNjAy
LDExICs2MDQsMTEgQEAgc3RhdGljIGludCBfX2luaXQgaW5pdF9sYXBpY19zeXNmcyh2b2lkKQog
CQllcnJvciA9IHN5c2Rldl9yZWdpc3RlcigmZGV2aWNlX2xhcGljKTsKIAlyZXR1cm4gZXJyb3I7
CiB9Ci1kZXZpY2VfaW5pdGNhbGwoaW5pdF9sYXBpY19zeXNmcyk7CiAKICNlbHNlCS8qIENPTkZJ
R19QTSAqLwogCiBzdGF0aWMgdm9pZCBhcGljX3BtX2FjdGl2YXRlKHZvaWQpIHsgfQorc3RhdGlj
IGludCBpbml0X2xhcGljX3N5c2ZzKHZvaWQpIHsgfQogCiAjZW5kaWYJLyogQ09ORklHX1BNICov
CiAK

------_=_NextPart_001_01C483C3.E3ED3F4D--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
