From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 1/5] ACPI: move FADT resource reservations from motherboard driver to osl
Date: Fri, 19 Jan 2007 12:46:59 -0700
Message-ID: <200701191246.59641.bjorn.helgaas@hp.com>
References: <200701181636.45590.bjorn.helgaas@hp.com> <200701181642.56040.bjorn.helgaas@hp.com> <1169169121.23563.1.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:38149 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932846AbXASTrI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jan 2007 14:47:08 -0500
In-Reply-To: <1169169121.23563.1.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>

On Thursday 18 January 2007 18:12, Shaohua Li wrote:
> > +device_initcall(acpi_reserve_resources);
> Will this be called before PCI assigned resources to PCI devices? We use
> fs_initcall in motherboard to avoid PCI devices use motherboard's
> resources before.

I think we're OK.  Here's the current order:

  pnp_system_init            fs_initcall       drivers/pnp/system.c
  pcibios_assign_resources   fs_initcall       arch/i386/pci/i386.c
  acpi_reserve_resources     device_initcall   drivers/acpi/osl.c

So pnp_system_init() will reserve all the motherboard resources before
the PCI resources are assigned.  What do you think?

Bjorn
