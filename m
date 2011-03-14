From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT][PATCH] PCI / ACPI: Do not require MSI support for PCIe native features
Date: Mon, 14 Mar 2011 21:37:41 +0100
Message-ID: <201103142137.41607.rjw@sisk.pl>
References: <201103052254.48515.rjw@sisk.pl> <201103142102.11164.rjw@sisk.pl> <20110314201909.GA4937@xanatos>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59582 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462Ab1CNUhh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Mar 2011 16:37:37 -0400
In-Reply-To: <20110314201909.GA4937@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Monday, March 14, 2011, Sarah Sharp wrote:
> On Mon, Mar 14, 2011 at 09:02:11PM +0100, Rafael J. Wysocki wrote:
> > On Monday, March 14, 2011, Sarah Sharp wrote:
> > > Hi Rafael,
> > > 
> > > I applied this patch, on top of this patch:
> > > PCI/ACPI: Report ASPM support to BIOS if not disabled from command line
> > > 
> > > Unfortunately, the Express Card still doesn't show up.  The trace looks
> > > slightly different, but the irq still gets disabled.  dmesg is attached.
> > 
> > Hmm.  It looks like, for some reason, the check against
> > pcie_aspm_support_enabled() returns false on your system.  Do you have
> > ASPM enabled in .config?
> 
> My .config is attached.  Looks like CONFIG_PCIEASPM=y.

Does it help if you replace "pcie_aspm_support_enabled()" with "true" in
drivers/acpi/pci_root.c:acpi_pci_root_add() ?

Rafael
