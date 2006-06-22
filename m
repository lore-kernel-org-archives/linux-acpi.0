From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: how I know if a interrupt is ioapic_edge_type or
 ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
 2.6.17-rc6-mm2 - USB issues]]
Date: Wed, 21 Jun 2006 21:08:17 -0700
Message-ID: <20060621210817.74b6b2bc.rdunlap@xenotime.net>
References: <44953B4B.9040108@agotnes.com>
	<4497DA3F.80302@agotnes.com>
	<20060620044003.4287426d.akpm@osdl.org>
	<4499245C.8040207@agotnes.com>
	<1150936606.2855.21.camel@localhost.portugal>
	<20060621174754.159bb1d0.rdunlap@xenotime.net>
	<1150938288.3221.2.camel@localhost.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:7843 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932764AbWFVEFa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 00:05:30 -0400
Received: from midway.site ([71.245.102.105]) by xenotime.net for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 21:05:29 -0700
In-Reply-To: <1150938288.3221.2.camel@localhost.portugal>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sergio@sergiomb.no-ip.org
Cc: kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu, cw@f00f.org, vsu@altlinux.ru

On Thu, 22 Jun 2006 02:04:48 +0100 Sergio Monteiro Basto wrote:

> who no, how sorry! I am a little tired=20
>=20

> On Wed, 2006-06-21 at 17:47 -0700, Randy.Dunlap wrote:=20
> > On Thu, 22 Jun 2006 01:36:46 +0100 Sergio Monteiro Basto wrote:
> >=20
> > > who I do know if a interrupt is ioapic_edge_type or ioapic_edge_t=
ype ?=20
> >=20
> > Do you mean how they are configured in a running kernel?
>=20
> yes, I want to know in=20
> linux-2.6.13/drivers/pci/quirks.c
> when I am going quirk the PCI_VIA irq, if this irq is in
> IO-APIC-something or is in XT-PIC , to decide if I quirk the interrup=
t
> or not

You have to look all over the place. :(
And I've probably missed some of them.

But if the system if using PICs, they will be XT-PIC.
Edge or level triggered is then determined by the bus type:
ISA is mostly edge-triggered (OK, I can't remember that far back)
and PCI is defined as level-triggered.  However, there are
exceptions.  IIRC, legacy IDE is edge-triggered even if it is
on a PCI bus (see listing below for ide0).  And some legacy
devices are edge-triggered (timer, keyboard controller/8042,
parallel port).

You can find info about specifics in places like Intel
chipset specs (ICH5, ICH6, ICH7, etc.), the (large) ACPI
spec from www.acpi.info, the Multiprocessor (MP) spec.
from developer.intel.com, probably some AMD chipset specs,
some PCI bus specs, and in some Linux kernel source code.
Like I said, I probably missed a few places.

If you have a specific issue/problem, it would probably be
better just to focus on that.


> > cat /proc/interrupts ::
> >=20
> >            CPU0       CPU1      =20
> >   0:   12412944   12407808    IO-APIC-edge  timer
> >   1:     122673     124208    IO-APIC-edge  i8042
> >   7:          0          0    IO-APIC-edge  parport0
> >   9:          0          0   IO-APIC-level  acpi
> >  12:    1141950    1138138    IO-APIC-edge  i8042
> >  14:    1107749    1109102    IO-APIC-edge  ide0
> >  58:     451498          0         PCI-MSI  eth0
> >  66:     530689     495356         PCI-MSI  libata
> >  74:          0          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd=
:usb6
> >  82:         31          3   IO-APIC-level  ohci_hcd:usb2, ohci_hcd=
:usb3, ohci_hcd:usb4, ohci_hcd:usb5
> >  90:        561        492   IO-APIC-level  HDA Intel
> > 169:          3          0   IO-APIC-level  ohci1394
> > 177:          0          0   IO-APIC-level  uhci_hcd:usb8
> > 185:          0          0   IO-APIC-level  uhci_hcd:usb7
> > 193:          0          0   IO-APIC-level  uhci_hcd:usb9
> >=20
> >=20
> > or how they should be configured in case you are not sure?
> > See a hardware spec. for that.
> >=20
> >=20
> > > On Wed, 2006-06-21 at 20:50 +1000, Johny wrote:
> > > > Success :)
> > > >=20
> > > > I simply made the change=20
> > > > manually, based on your and others' inputs (it seemed the simpl=
er
> > > > option).
> > > >=20
> > > > Both kernels now boot, and all USB devices are recognised corre=
ctly.
> > > >=20
> > >=20
> > > > I run in XT_PIC mode for interrupts.
> > > >=20
> > >=20
> > > Hi, thanks for your positive test on "my" theory.
> > >=20
> > > Here it goes the link that I talked about on last email=20
> > > http://lkml.org/lkml/2005/8/18/92 (you can read the previous mess=
ages on
> > > this thread)=20
> > >=20
> > > The patch of this link doesn't compile (at least for me), but hav=
e a
> > > simple idea, which is just quirk the VIA_PCIs if they are in XT_P=
IC mode
> > > and I think that is the way of this quirks should go.
> > >=20
> > > So someone help me out and do a patch that recognize if the inter=
rupt is
> > > in XT-PIC mode or not ?=20
> > >=20
> > > Thanks, =20
> > > --=20
> > > S=E9rgio M. B.

---
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
