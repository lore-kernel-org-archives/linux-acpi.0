From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: mpparse.c APIC/ACPI support
Date: Tue, 15 Apr 2003 14:53:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10476C27D@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C30388.BA068BF6"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "Zink, Dan" <Dan.Zink-VXdhtT5mjnY@public.gmane.org>, "Mathiasen, Torben" <Torben.Mathiasen-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C30388.BA068BF6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andy,

Attached is a small patch that fixes the problem for dynamic PRT
entries.

We have tested this (with your 2.4 bk kernel) and it works perfectly.
Please consider including this in your next update to Marcelo & Linus
for 2.4 and 2.5.

Credit goes to Dan Zink for this patch.

Thanks,
John

> -----Original Message-----
> From: Cagle, John (ISS-Houston)=20
> Sent: Tuesday, April 15, 2003 2:41 AM
> To: Grover, Andrew; info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org; acpi-devel@lists.sourceforge.net
> Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; Zink, Dan; Mathiasen, Torben
> Subject: RE: [ACPI] mpparse.c APIC/ACPI support
>=20
>=20
> Andy,
>=20
> I couldn't easily test that code snippet, since it requires a=20
> lot of kernel changes to export mp_find_ioapic() and=20
> mp_ioapic_routing[]. Also, mp_find_ioapic() has the __init=20
> attribute, and that would have to change too.
>=20
> Wouldn't this be better fixed when parsing the PRT in=20
> mpparse.c -- handle the dynamic irqs along with the static irqs?
>=20
> Thanks,
> John
>=20
> > -----Original Message-----
> > From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > Sent: Monday, April 14, 2003 7:32 PM
> > To: Cagle, John (ISS-Houston); info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org;=20
> > acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; Zink, Dan; Mathiasen, Torben
> > Subject: RE: [ACPI] mpparse.c APIC/ACPI support
> >=20
> > John,
> >=20
> > Take a look at pci_irq.c acpi_pci_irq_enable(). We should be
> > calling this for all PCI devices, when they are enabled. We=20
> > appear to be doing the right thing in the PIC case (calling=20
> > eisa_set_level_irq) but not in the IO APIC case. I would=20
> > think something like:
> >=20
> > 	/*=20
> > 	 * Make sure all (legacy) PCI IRQs are set as level-triggered.
> > 	 */
> > 	if (acpi_ioapic)
> > 	{
> > 		int ioapic =3D mp_find_ioapic(irq);
> > 		int ioapic_pin =3D irq -
> > mp_ioapic_routing[ioapic].irq_start;
> > 		io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
> > 	}
> > #ifdef CONFIG_X86
> > 	else if ((dev->irq < 16) &&  !((1 << dev->irq) & irq_mask)) {
> > 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Setting IRQ %d
> > as level-triggered\n", dev->irq));
> > 		irq_mask |=3D (1 << dev->irq);
> > 		eisa_set_level_irq(dev->irq);
> > 	}
> > #endif
> >=20
> > Totally untested. Thoughts? Do you have a system that we can
> > verify a fix on?
> >=20
> > Regards -- Andy
> >=20
> >=20
> > > From: Cagle, John (ISS-Houston)=20
> [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org] What we=20
> > > have found is that the Linux ACPI code (from
> > > bitkeeper) is not properly configuring all PCI interrupts:
> > >=20
> > > In particular, mp_parse_prt() only calls
> > > io_apic_set_pci_routing() for *static* entries in the PRT.
> > > It doesn't do anything for dynamic entries in the PRT.  To be=20
> > > correct, mp_parse_prt() needs to call=20
> > > io_apic_set_pci_routing() for dynamic entries as well.
> > >=20
> > > For example, a PCI-USB interrupt which is routed to IRQ 7 by the=20
> > > BIOS, and which has a dynamic entry in the PRT would be left as=20
> > > edge-triggered by default (since IRQ 7 is one of the "legacy"=20
> > > interrupts).  This breaks USB interrupt handling (since=20
> it needs to=20
> > > be level triggered).
> > >=20
> > > ACPI Gurus -- Does this make sense, and is there some reason that=20
> > > dynamic PRT entries aren't being handled?
> > >=20
> > > Thanks,
> > > John
> > > --------------------------------
> > > John Cagle     john.cagle-VXdhtT5mjnY@public.gmane.org
> > > Principal Member Technical Staff
> > >    Industry Standard Servers
> > >     Hewlett-Packard Company
> > >     http://www.hp.com/linux
> > >=20
> > > > -----Original Message-----
> > > > From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > > > Sent: Tuesday, March 04, 2003 12:21 PM
> > > > To: Cagle, John (ISS-Houston); info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org;=20
> > > > acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > > Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > > > Subject: RE: [ACPI] mpparse.c APIC/ACPI support
> > > >=20
> > > >=20
> > > > > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]
> > > > > > In theory, ACPI comes through later and changes the
> > > irqs < 15 with
> > > > > > possible PCI devices by calling io_apic_set_pci_routing.
> > > > > >
> > > > > > So *in theory* it should work ok. Obviously something is
> > > > not right.
> > > > >=20
> > > > > How does ACPI, when it comes through later, know which
> > > > irq's < 15 are
> > > > > for PCI devices?
> > > >=20
> > > > The device's driver calls pci_enable_device, which calls:
> > > > pci_enable_device_bars, which calls:=20
> pcibios_enable_device, which=20
> > > > calls: pcibios_enable_irq, which is a function pointer=20
> we set to=20
> > > > acpi_pci_irq_enable, which does an eisa_set_level_irq(), thus=20
> > > > setting the interrupt (if less than 16) to level-triggered.
> > > >=20
> > > > So why isn't it working? Hmm.
> > > >=20
> > > > Regards -- Andy

------_=_NextPart_001_01C30388.BA068BF6
Content-Type: application/octet-stream;
	name="dynamic_irq.patch"
Content-Transfer-Encoding: base64
Content-Description: dynamic_irq.patch
Content-Disposition: attachment;
	filename="dynamic_irq.patch"

ZGlmZiAtdWFyIGxpbnV4LTIuNC1hY3BpL2FyY2gvaTM4Ni9rZXJuZWwvbXBwYXJzZS5jIGxpbnV4
LTIuNC1hY3BpX2ZpeGVkL2FyY2gvaTM4Ni9rZXJuZWwvbXBwYXJzZS5jCi0tLSBsaW51eC0yLjQt
YWNwaS9hcmNoL2kzODYva2VybmVsL21wcGFyc2UuYwkyMDAzLTA0LTA4IDE0OjI0OjE2LjAwMDAw
MDAwMCAtMDcwMAorKysgbGludXgtMi40LWFjcGlfZml4ZWQvYXJjaC9pMzg2L2tlcm5lbC9tcHBh
cnNlLmMJMjAwMy0wNC0xNSAwODowNzoyNS4wMDAwMDAwMDAgLTA3MDAKQEAgLTEyNzQsMTEgKzEy
NzUsMTQgQEAKIAlsaXN0X2Zvcl9lYWNoKG5vZGUsICZhY3BpX3BydC5lbnRyaWVzKSB7CiAJCWVu
dHJ5ID0gbGlzdF9lbnRyeShub2RlLCBzdHJ1Y3QgYWNwaV9wcnRfZW50cnksIG5vZGUpOwogCi0J
CS8qIFdlJ3JlIG9ubHkgaW50ZXJlc3RlZCBpbiBzdGF0aWMgKG5vbi1saW5rKSBlbnRyaWVzLiAq
LwotCQlpZiAoZW50cnktPmxpbmsuaGFuZGxlKQotCQkJY29udGludWU7CisJCS8qIE5lZWQgdG8g
Z2V0IGlycSBmb3IgZHluYW1pYyBlbnRyeSAqLworCQlpZiAoZW50cnktPmxpbmsuaGFuZGxlKSB7
CisJCQlpcnEgPSBhY3BpX3BjaV9saW5rX2dldF9pcnEoZW50cnktPmxpbmsuaGFuZGxlLCBlbnRy
eS0+bGluay5pbmRleCk7CisJCQlpZiAoIWlycSkKKwkJCQljb250aW51ZTsKKwkJfQorCQllbHNl
IGlycSA9IGVudHJ5LT5saW5rLmluZGV4OwogCi0JCWlycSA9IGVudHJ5LT5saW5rLmluZGV4Owog
CQlpb2FwaWMgPSBtcF9maW5kX2lvYXBpYyhpcnEpOwogCQlpZiAoaW9hcGljIDwgMCkKIAkJCWNv
bnRpbnVlOwo=

------_=_NextPart_001_01C30388.BA068BF6--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
