From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/5]PCIe native PME support
Date: Fri, 21 Aug 2009 18:47:11 +0200
Message-ID: <200908211847.11347.rjw@sisk.pl>
References: <1250666659.23178.119.camel@sli10-desk.sh.intel.com> <200908202322.02588.rjw@sisk.pl> <20090821070112.GC16694@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43119 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932328AbZHUQqQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Aug 2009 12:46:16 -0400
In-Reply-To: <20090821070112.GC16694@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Friday 21 August 2009, Shaohua Li wrote:
> On Fri, Aug 21, 2009 at 05:22:02AM +0800, Rafael J. Wysocki wrote:
> > On Wednesday 19 August 2009, Shaohua Li wrote:
> > > 
> > > PCIe defines a native PME detection mechanism. When a PCIe endpoint
> > > invokes PME, PCIe root port has a set of regisets to detect the
> > > endpoint's bus/device/function number and root port will send out
> > > interrupt when PME is received. After getting interrupt, OS can identify
> > > which device invokes PME according to such information. See PCIe
> > > spec for detail. This patch implements this feature.
> > > 
> > > ---
> > >  drivers/pci/pcie/Kconfig  |    7 +
> > >  drivers/pci/pcie/Makefile |    2 
> > >  drivers/pci/pcie/npme.c   |  300 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/pci_regs.h  |    1 
> > >  4 files changed, 310 insertions(+)
> > > 
> > > Index: linux/drivers/pci/pcie/Kconfig
> > > ===================================================================
> > > --- linux.orig/drivers/pci/pcie/Kconfig	2009-08-19 13:43:18.000000000 +0800
> > > +++ linux/drivers/pci/pcie/Kconfig	2009-08-19 14:34:00.000000000 +0800
> > > @@ -46,3 +46,10 @@ config PCIEASPM_DEBUG
> > >  	help
> > >  	  This enables PCI Express ASPM debug support. It will add per-device
> > >  	  interface to control ASPM.
> > > +
> > > +config PCIENPME
> > > +	bool "PCIE Native PME support(Experimental)"
> > > +	depends on PCIEPORTBUS && EXPERIMENTAL
> > > +	help
> > > +	  This enables PCI Express Native PME Reporting.
> > 
> > I don't really think we need that.  Or maybe.  But I'd prefer to call it
> > PCIE_PME.
> It definitely is required if you ever looked at PCIe spec.
> In my test machine, the e1000 card can send such event, and the root port can
> collect it.

I meant the CONFIG switch, not the feature. :-)

Thanks,
Rafael
