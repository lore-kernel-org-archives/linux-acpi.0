From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] ACPI: add _PRT quirks to work around broken firmware
Date: Wed, 12 Mar 2008 11:55:12 -0600
Message-ID: <200803121155.13321.bjorn.helgaas@hp.com>
References: <200803111445.16316.bjorn.helgaas@hp.com> <200803112340.05293.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:16193 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039AbYCLRw1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Mar 2008 13:52:27 -0400
In-Reply-To: <200803112340.05293.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Pierre Ossman <drzeus-bugzilla@drzeus.cx>, Michael Fu <michael.fu@intel.com>, Martin Kirst <martin.kirst@s1998.tu-chemnitz.de>, Hadmut Danisch <hadmut@danisch.de>, Johann-Nikolaus Andreae <johann-nikolaus.andreae@nacs.de>, Dominik =?iso-8859-1?q?Sch=E4fer?= <schaedpq2@gmx.de>, Alex Williamson <alex.williamson@hp.com>, Aron Griffis <aron@hp.com>

On Tuesday 11 March 2008 09:40:04 pm Len Brown wrote:
> Is it true that simply enabling pci=routeirq on these boxes
> is an insufficient workaround?

I'm told that pci=routeirq is a sufficient workaround for the
first two issues, but I verified that it is not sufficient on
the t5710.

On the t5710, even with pci=routeirq, as soon as we turn on the
radeon interrupt, it starts generating interrupts on LNK3.  Since
the radeon driver isn't listening there, we eventually turn off
that IRQ, killing other other devices sharing it as a side-effect.

I don't know why pci=routeirq works on the other two boxes.  Maybe
because of your guess below.

> I suspect the answer is yes, because when pci=routeirq works
> we may just be lucky -- eg. we happen to assign the real
> and the fake link to the same IRQ and thus the driver
> actually registers for the correct IRQ, but by accident.
> 
> I'll put this patch into the acpi test tree.

Thanks.

> On Tuesday 11 March 2008, Bjorn Helgaas wrote:
> > This patch works around incorrect _PRT (PCI interrupt routing)
> > information from firmware.  This does not fix any regressions
> > and can wait for the next kernel release.
> > 
> > On the Medion MD9580-F laptop, the BIOS says the builtin RTL8139
> > NIC interrupt at 00:09.0[A] is connected to \_SB.PCI0.ISA.LNKA, but
> > it's really connected to \_SB.PCI0.ISA.LNKB.  Before this patch,
> > the workaround was to use "pci=routeirq".  More details at
> > http://bugzilla.kernel.org/show_bug.cgi?id=4773.
> > 
> > On the Dell OptiPlex GX1, the BIOS says the PCI slot interrupt
> > 00:0d[A] is connected to LNKB, but it's really connected to LNKA.
> > Before this patch, the workaround was to use "pci=routeirq".
> > Pierre Ossman tested a previous version of this patch and confirmed
> > that it fixed the problem.  More details at
> > http://bugzilla.kernel.org/show_bug.cgi?id=5044.
> > 
> > On the HP t5710 thin client, the BIOS says the builtin Radeon
> > video interrupt at 01:00[A] is connected to LNK1, but it's really
> > connected to LNK3.  The previous workaround was to use a custom
> > DSDT.  I tested this patch and verified that it fixes the problem.
> > More details at http://bugzilla.kernel.org/show_bug.cgi?id=10138.  
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> > Index: work7/drivers/acpi/pci_irq.c
> > ===================================================================
> > --- work7.orig/drivers/acpi/pci_irq.c	2008-03-06 09:06:28.000000000 -0700
> > +++ work7/drivers/acpi/pci_irq.c	2008-03-11 14:40:57.000000000 -0600
> > @@ -25,6 +25,7 @@
> >   */
> >  
> >  
> > +#include <linux/dmi.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> > @@ -76,6 +77,101 @@
> >  	return NULL;
> >  }
> >  
> > +/* http://bugzilla.kernel.org/show_bug.cgi?id=4773 */
> > +static struct dmi_system_id medion_md9580[] = {
> > +	{
> > +		.ident = "Medion MD9580-F laptop",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "MEDIONNB"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "A555"),
> > +		},
> > +	},
> > +	{ }
> > +};
> > +
> > +/* http://bugzilla.kernel.org/show_bug.cgi?id=5044 */
> > +static struct dmi_system_id dell_optiplex[] = {
> > +	{
> > +		.ident = "Dell Optiplex GX1",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex GX1 600S+"),
> > +		},
> > +	},
> > +	{ }
> > +};
> > +
> > +/* http://bugzilla.kernel.org/show_bug.cgi?id=10138 */
> > +static struct dmi_system_id hp_t5710[] = {
> > +	{
> > +		.ident = "HP t5710",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "hp t5000 series"),
> > +			DMI_MATCH(DMI_BOARD_NAME, "098Ch"),
> > +		},
> > +	},
> > +	{ }
> > +};
> > +
> > +struct prt_quirk {
> > +	struct dmi_system_id	*system;
> > +	unsigned int		segment;
> > +	unsigned int		bus;
> > +	unsigned int		device;
> > +	unsigned char		pin;
> > +	char			*source;	/* according to BIOS */
> > +	char			*actual_source;
> > +};
> > +
> > +/*
> > + * These systems have incorrect _PRT entries.  The BIOS claims the PCI
> > + * interrupt at the listed segment/bus/device/pin is connected to the first
> > + * link device, but it is actually connected to the second.
> > + */
> > +static struct prt_quirk prt_quirks[] = {
> > +	{ medion_md9580, 0, 0, 9, 'A',
> > +		"\\_SB_.PCI0.ISA.LNKA",
> > +		"\\_SB_.PCI0.ISA.LNKB"},
> > +	{ dell_optiplex, 0, 0, 0xd, 'A',
> > +		"\\_SB_.LNKB",
> > +		"\\_SB_.LNKA"},
> > +	{ hp_t5710, 0, 0, 1, 'A',
> > +		"\\_SB_.PCI0.LNK1",
> > +		"\\_SB_.PCI0.LNK3"},
> > +};
> > +
> > +static void
> > +do_prt_fixups(struct acpi_prt_entry *entry, struct acpi_pci_routing_table *prt)
> > +{
> > +	int i;
> > +	struct prt_quirk *quirk;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(prt_quirks); i++) {
> > +		quirk = &prt_quirks[i];
> > +
> > +		/* All current quirks involve link devices, not GSIs */
> > +		if (!prt->source)
> > +			continue;
> > +
> > +		if (dmi_check_system(quirk->system) &&
> > +		    entry->id.segment == quirk->segment &&
> > +		    entry->id.bus == quirk->bus &&
> > +		    entry->id.device == quirk->device &&
> > +		    entry->pin + 'A' == quirk->pin &&
> > +		    !strcmp(prt->source, quirk->source) &&
> > +		    strlen(prt->source) >= strlen(quirk->actual_source)) {
> > +			printk(KERN_WARNING PREFIX "firmware reports "
> > +				"%04x:%02x:%02x[%c] connected to %s; "
> > +				"changing to %s\n",
> > +				entry->id.segment, entry->id.bus,
> > +				entry->id.device, 'A' + entry->pin,
> > +				prt->source, quirk->actual_source);
> > +			strcpy(prt->source, quirk->actual_source);
> > +		}
> > +	}
> > +}
> > +
> >  static int
> >  acpi_pci_irq_add_entry(acpi_handle handle,
> >  		       int segment, int bus, struct acpi_pci_routing_table *prt)
> > @@ -96,6 +192,8 @@
> >  	entry->id.function = prt->address & 0xFFFF;
> >  	entry->pin = prt->pin;
> >  
> > +	do_prt_fixups(entry, prt);
> > +
> >  	/*
> >  	 * Type 1: Dynamic
> >  	 * ---------------
> > 
> 
> 
> 


