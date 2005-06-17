From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 03/04] PCI: use the MCFG table to properly access pci devices (x86-64)
Date: Thu, 16 Jun 2005 18:15:39 -0700
Message-ID: <20050616181535.A10031@unix-os.sc.intel.com>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615053214.GD23394@kroah.com> <20050616153404.B5337@unix-os.sc.intel.com> <20050616224223.GA13619@suse.de> <20050616230020.GM7048@bragg.suse.de>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261873AbVFQBQD@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050616230020.GM7048@bragg.suse.de>; from ak@suse.de on Fri, Jun 17, 2005 at 01:00:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <gregkh@suse.de>, Rajesh Shah <rajesh.shah@intel.com>, len.brown@intel.com, acpi-devel@lists.sourceforge.net, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 17, 2005 at 01:00:20AM +0200, Andi Kleen wrote:
> On Thu, Jun 16, 2005 at 03:42:23PM -0700, Greg KH wrote:
> > On Thu, Jun 16, 2005 at 03:34:06PM -0700, Rajesh Shah wrote:
> > > On Tue, Jun 14, 2005 at 10:32:14PM -0700, Greg KH wrote:
> > > > 
> > > > +	for (i = 0; i < pci_mmcfg_config_num; ++i) {
> > > > +		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
> > > > +		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
> > > 
> > > This will map 256MB for each mmcfg aperture, probably better
> > > to restrict it based on bus number range for this aperture.
> > 
> > It should be 1MB per bus number, right?

Yes.

> 
> It shouldn't make much difference anyways - we have plenty of vmalloc
> space on x86-64
> 
Depends on how much you trust firmware :-). In the worst case, it
could create one such entry for each bus.

I noticed this because I worked on picking up resources for root
bridges from firmware recently, and noticed more than one system
in which firmware created ~10 entries for resources that were
adjacent to each other and could be coalesced into a single
resource range. Not illegal, just not optimal.

Rajesh
