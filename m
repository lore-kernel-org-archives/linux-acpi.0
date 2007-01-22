From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 1/5] ACPI: move FADT resource reservations from motherboard driver to osl
Date: Mon, 22 Jan 2007 08:57:38 -0700
Message-ID: <200701220857.38474.bjorn.helgaas@hp.com>
References: <200701181636.45590.bjorn.helgaas@hp.com> <200701191246.59641.bjorn.helgaas@hp.com> <1169429242.12766.4.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:56989 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbXAVP5o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jan 2007 10:57:44 -0500
In-Reply-To: <1169429242.12766.4.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>

On Sunday 21 January 2007 18:27, Shaohua Li wrote:
> On Fri, 2007-01-19 at 12:46 -0700, Bjorn Helgaas wrote:
> > On Thursday 18 January 2007 18:12, Shaohua Li wrote:
> > > > +device_initcall(acpi_reserve_resources);
> > > Will this be called before PCI assigned resources to PCI devices? We use
> > > fs_initcall in motherboard to avoid PCI devices use motherboard's
> > > resources before.
> > 
> > I think we're OK.  Here's the current order:
> > 
> >   pnp_system_init            fs_initcall       drivers/pnp/system.c
> >   pcibios_assign_resources   fs_initcall       arch/i386/pci/i386.c
> >   acpi_reserve_resources     device_initcall   drivers/acpi/osl.c
> > 
> > So pnp_system_init() will reserve all the motherboard resources before
> > the PCI resources are assigned.  What do you think?
>
> In this way, we could just remove acpi_reserve_resources as pci already
> assigns resources to pci devices. The concern is motherboard might not
> list all acpi resources in its _CRS, but I don't know if there are such
> BIOS. Microsoft seems to reserve motherboard resources in the same way.
> Maybe we could just remove acpi_reserve_resources and give it a spin in
> -mm to see if anybody complains.

I agree that in theory we should be able to remove acpi_reserve_resources()
and just depend on pnp_system_init() reserving all the motherboard
resources.  But your concern is very valid: it looks like both HP DL360
(x86) and rx2600 (ia64) firmware list things in the FADT that aren't
included in _CRS for motherboard devices.  I think these are BIOS bugs,
but for now, it seems safest to keep acpi_reserve_resources() to work
around the bugs.

Bjorn
