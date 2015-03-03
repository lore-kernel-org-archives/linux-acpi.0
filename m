From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: PCIe 32-bit MMIO exhaustion
Date: Tue, 3 Mar 2015 16:38:16 -0600
Message-ID: <20150303223816.GB22299@google.com>
References: <54C8A10B.3070207@numascale.com>
 <CAErSpo4t94BXYhhE+bh5-3_PsdKTSa113beqqz14W+_emdCGMQ@mail.gmail.com>
 <54EC0013.7000100@numascale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:38121 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbbCCWil (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Mar 2015 17:38:41 -0500
Received: by obcwo20 with SMTP id wo20so3064869obc.5
        for <linux-acpi@vger.kernel.org>; Tue, 03 Mar 2015 14:38:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54EC0013.7000100@numascale.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel J Blueman <daniel@numascale.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Steffen Persvold <sp@numascale.com>, "x86@kernel.org" <x86@kernel.org>, Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

[+cc linux-pci, linux-acpi]

On Tue, Feb 24, 2015 at 12:37:39PM +0800, Daniel J Blueman wrote:
> Hi Bjorn, Jiang,
>=20
> On 29/01/2015 23:23, Bjorn Helgaas wrote:
> >Hi Daniel,
> >
> >On Wed, Jan 28, 2015 at 2:42 AM, Daniel J Blueman <daniel@numascale.=
com> wrote:
> >>With systems with a large number of PCI devices, we're seeing lack =
of 32-bit
> >>MMIO space, eg one quad-port NetXtreme-2 adapter takes 128MB of spa=
ce [1].
> >>
> >>An errata to the PCIe 2.1 spec provides guidance on limitations wit=
h 64-bit
> >>non-prefetchable BARs (since bridges have only 32-bit non-prefetcha=
ble
> >>ranges) stating that vendors can enable the prefetchable bit in BAR=
s under
> >>certain circumstances to allow 64-bit allocation [2].
> >>
> >>The problem with that, is that vendors can't know apriori what host=
s their
> >>products will be in, so can't just advertise prefetchable 64-bit BA=
Rs. What
> >>can be done, is system firmware can use the 64-bit prefetchable BAR=
 in
> >>bridges, and assign a 64-bit non-prefetchable device BAR into that =
area,
> >>where it is safe to do so (following the guidance).
> >>
> >>At present, linux denies such allocations [3] and disables the BARs=
=2E It
> >>seems a practical solution to allow them if the firmware believes i=
t is
> >>safe.
> >
> >This particular message ([3]):
> >
> >>pci 0002:01:00.0: BAR 0: [mem size 0x00002000 64bit] conflicts with=
 PCI Bus
> >>0002:00 [mem 0x10020000000-0x10027ffffff pref]
> >
> >is misleading at best and likely a symptom of a bug.  We printed the
> >*size* of BAR 0, not an address, which means we haven't assigned spa=
ce
> >for the BAR.  That means it should not conflict with anything.
> >
> >We already do revert to firmware assignments in some situations when
> >Linux can't figure out how to assign things itself.  But apparently
> >not in *this* situation.
> >
> >Without seeing the whole picture, it's hard for me to figure out
> >what's going on here.  Could you open a bug report at
> >http://bugzilla.kernel.org (category drivers/PCI) and attach a
> >complete dmesg and "lspci -vv" output?  Then we can look at what
> >firmware did and what Linux thought was wrong with it.
>=20
> Done a while back:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D92671
>=20
> An interesting question popped up: I find the kernel doesn't accept
> IO BARs and bridge windows after address 0xffff, though the PCI spec
> and modern hardware allows 32-bit decode.
>=20
> Thus for practical reasons, our NumaConnect firmware doesn't setup
> IO BARs/windows beyond the first PCI domain (which is the only one
> with legacy support, and no drivers seem to require IO their BARs
> anyway), ...

If we don't handle IO ports above 0xffff, I think that's broken.  I'm
pretty sure we do handle that on ia64 (it's done by assigning 64K of IO
space to each host bridge, and I think it's typically translated by the
bridge so each root bus sees a 0-64K space on PCI).  We should be able =
to
do something similar on x86, but it may not be implemented there yet.

> and we get conflicts and warnings [1]:
>=20
> pnp 00:00: disabling [io  0x0061] because it overlaps 0001:05:00.0
> BAR 0 [io  0x0000-0x00ff]
> pci 0001:03:00.0: BAR 13: no space for [io  size 0x1000]
> pci 0001:03:00.0: BAR 13: failed to assign [io  size 0x1000]
>=20
> Is there a cleaner way of dealing with this, in our firmware and/or
> the kernel? Eg, I guess if IO BARs aren't assigned (value 0) on PCI
> domains without IO bridge windows in the ACPI AML, no need to
> conflict/attempt assignment?

Yes, we should be able to deal with this better.

The complaint about disabling the pnp 00:00 resource is bogus because t=
he
PCI 0001:05:00.0 BAR is not assigned and should never be enabled, so th=
is
is not a real conflict. =A0My intent is that the PCI resource correspon=
ding
to this BAR should have the IORESOURCE_UNSET bit set. =A0That will prev=
ent
pci_enable_resources() from setting the PCI_COMMAND_IO bit, which is wh=
at
would enable the BAR.

Can you try the patch below?  I don't think it will work right off the =
bat
because I think the fact that we print "[io  0x0000-0x00ff]" instead of
"[io  size 0x0100]" means we don't have IORESOURCE_UNSET set in the PCI
resource.  But maybe you can figure out where it *should* be getting
set?

Bjorn


commit fd4888cf942a2ae9cdefc46d1fba86b2c7ec2dbf
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Mar 3 16:13:56 2015 -0600

    PNP: Don't check for overlaps with unassigned PCI BARs
   =20
    After 0509ad5e1a7d ("PNP: disable PNP motherboard resources that ov=
erlap
    PCI BARs"), we disable and warn about PNP resources that overlap PC=
I BARs.
    But we assume that all PCI BARs are valid, which is incorrect, beca=
use a
    BAR may not have any space assigned to it.  In that case, we will n=
ot
    enable the BAR, so no other resource can conflict with it.
   =20
    Ignore PCI BARs that are unassigned, as indicated by IORESOURCE_UNS=
ET.
   =20
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index ebf0d6710b5a..943c1cb9566c 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -246,13 +246,16 @@ static void quirk_system_pci_resources(struct pnp=
_dev *dev)
 	 */
 	for_each_pci_dev(pdev) {
 		for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++) {
-			unsigned long type;
+			unsigned long flags, type;
=20
-			type =3D pci_resource_flags(pdev, i) &
-					(IORESOURCE_IO | IORESOURCE_MEM);
+			flags =3D pci_resource_flags(pdev, i);
+			type =3D flags & (IORESOURCE_IO | IORESOURCE_MEM);
 			if (!type || pci_resource_len(pdev, i) =3D=3D 0)
 				continue;
=20
+			if (flags & IORESOURCE_UNSET)
+				continue;
+
 			pci_start =3D pci_resource_start(pdev, i);
 			pci_end =3D pci_resource_end(pdev, i);
 			for (j =3D 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
