From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: who I do know if a interrupt is ioapic_edge_type or
 ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
 2.6.17-rc6-mm2 - USB issues]]
Date: Wed, 21 Jun 2006 17:47:54 -0700
Message-ID: <20060621174754.159bb1d0.rdunlap@xenotime.net>
References: <44953B4B.9040108@agotnes.com>
	<4497DA3F.80302@agotnes.com>
	<20060620044003.4287426d.akpm@osdl.org>
	<4499245C.8040207@agotnes.com>
	<1150936606.2855.21.camel@localhost.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:58805 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751539AbWFVApH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 20:45:07 -0400
Received: from midway.site ([71.245.102.105]) by xenotime.net for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 17:45:06 -0700
In-Reply-To: <1150936606.2855.21.camel@localhost.portugal>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sergio@sergiomb.no-ip.org
Cc: kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu, cw@f00f.org, vsu@altlinux.ru

On Thu, 22 Jun 2006 01:36:46 +0100 Sergio Monteiro Basto wrote:

> who I do know if a interrupt is ioapic_edge_type or ioapic_edge_type =
?=20

Do you mean how they are configured in a running kernel?

cat /proc/interrupts ::

           CPU0       CPU1      =20
  0:   12412944   12407808    IO-APIC-edge  timer
  1:     122673     124208    IO-APIC-edge  i8042
  7:          0          0    IO-APIC-edge  parport0
  9:          0          0   IO-APIC-level  acpi
 12:    1141950    1138138    IO-APIC-edge  i8042
 14:    1107749    1109102    IO-APIC-edge  ide0
 58:     451498          0         PCI-MSI  eth0
 66:     530689     495356         PCI-MSI  libata
 74:          0          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb=
6
 82:         31          3   IO-APIC-level  ohci_hcd:usb2, ohci_hcd:usb=
3, ohci_hcd:usb4, ohci_hcd:usb5
 90:        561        492   IO-APIC-level  HDA Intel
169:          3          0   IO-APIC-level  ohci1394
177:          0          0   IO-APIC-level  uhci_hcd:usb8
185:          0          0   IO-APIC-level  uhci_hcd:usb7
193:          0          0   IO-APIC-level  uhci_hcd:usb9


or how they should be configured in case you are not sure?
See a hardware spec. for that.


> On Wed, 2006-06-21 at 20:50 +1000, Johny wrote:
> > Success :)
> >=20
> > I simply made the change=20
> > manually, based on your and others' inputs (it seemed the simpler
> > option).
> >=20
> > Both kernels now boot, and all USB devices are recognised correctly=
=2E
> >=20
>=20
> > I run in XT_PIC mode for interrupts.
> >=20
>=20
> Hi, thanks for your positive test on "my" theory.
>=20
> Here it goes the link that I talked about on last email=20
> http://lkml.org/lkml/2005/8/18/92 (you can read the previous messages=
 on
> this thread)=20
>=20
> The patch of this link doesn't compile (at least for me), but have a
> simple idea, which is just quirk the VIA_PCIs if they are in XT_PIC m=
ode
> and I think that is the way of this quirks should go.
>=20
> So someone help me out and do a patch that recognize if the interrupt=
 is
> in XT-PIC mode or not ?=20
>=20
> Thanks, =20
> --=20
> S=E9rgio M. B.
>=20


---
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
