From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch 1/5] ACPI: move FADT resource reservations from
	motherboard driver to osl
Date: Mon, 22 Jan 2007 09:27:22 +0800
Message-ID: <1169429242.12766.4.camel@sli10-conroe.sh.intel.com>
References: <200701181636.45590.bjorn.helgaas@hp.com>
	 <200701181642.56040.bjorn.helgaas@hp.com>
	 <1169169121.23563.1.camel@sli10-conroe.sh.intel.com>
	 <200701191246.59641.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10992 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbXAVB3K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jan 2007 20:29:10 -0500
In-Reply-To: <200701191246.59641.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>

On Fri, 2007-01-19 at 12:46 -0700, Bjorn Helgaas wrote:
> On Thursday 18 January 2007 18:12, Shaohua Li wrote:
> > > +device_initcall(acpi_reserve_resources);
> > Will this be called before PCI assigned resources to PCI devices? We use
> > fs_initcall in motherboard to avoid PCI devices use motherboard's
> > resources before.
> 
> I think we're OK.  Here's the current order:
> 
>   pnp_system_init            fs_initcall       drivers/pnp/system.c
>   pcibios_assign_resources   fs_initcall       arch/i386/pci/i386.c
>   acpi_reserve_resources     device_initcall   drivers/acpi/osl.c
> 
> So pnp_system_init() will reserve all the motherboard resources before
> the PCI resources are assigned.  What do you think?
In this way, we could just remove acpi_reserve_resources as pci already
assigns resources to pci devices. The concern is motherboard might not
list all acpi resources in its _CRS, but I don't know if there are such
BIOS. Microsoft seems to reserve motherboard resources in the same way.
Maybe we could just remove acpi_reserve_resources and give it a spin in
-mm to see if anybody complains.

Thanks,
Shaohua
