From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 8/8] PCI: Simplify PCI device PM code (rev. 4)
Date: Fri, 11 Jul 2008 22:49:33 +0200
Message-ID: <20080711204933.GG6843@elf.ucw.cz>
References: <200807012356.26669.rjw@sisk.pl> <200807070336.25004.rjw@sisk.pl> <20080711203730.GD6843@elf.ucw.cz> <200807112245.29148.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41070 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbYGKUsp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jul 2008 16:48:45 -0400
Content-Disposition: inline
In-Reply-To: <200807112245.29148.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

On Fri 2008-07-11 22:45:28, Rafael J. Wysocki wrote:
> On Friday, 11 of July 2008, Pavel Machek wrote:
> > Hi!
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > PCI: Simplify PCI device PM code (rev. 4)
> > > 
> > > If the offset of PCI device's PM capability in its configuration
> > > space, the mask of states that the device supports PME# from and the
> > > D1 and D2 support bits are cached in the corresponding
> > > struct pci_dev, the PCI device PM code can be simplified quite a bit.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  drivers/pci/pci.c        |  118 ++++++++++++++++++++---------------------------
> > >  include/linux/pci.h      |    8 ++-
> > >  include/linux/pci_regs.h |    1 
> > >  3 files changed, 60 insertions(+), 67 deletions(-)
> > > 
> > > Index: linux-pci/include/linux/pci.h
> > > ===================================================================
> > > --- linux-pci.orig/include/linux/pci.h
> > > +++ linux-pci/include/linux/pci.h
> > > @@ -177,6 +177,13 @@ struct pci_dev {
> > >  	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
> > >  					   this is D0-D3, D0 being fully functional,
> > >  					   and D3 being off. */
> > > +	int		pm_cap;		/* PM capability offset in the
> > > +					   configuration space */
> > > +	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
> > > +					   can be generated */
> > > +	unsigned int	d1_support:1;	/* Low power state D1 is supported */
> > > +	unsigned int	d2_support:1;	/* Low power state D2 is supported */
> > > +	unsigned int	no_d1d2:1;	/* Only allow D0 and D3 */
> > 
> > Uh, "D1", "D2", then "no D1D2" ?
> 
> Yes.  They are used for different things.

Maybe add one line of explanation?

> > >  	}
> > >  
> > > -	if (pmc & PCI_PM_CAP_PME_MASK) {
> > > +	dev->pm_cap = pm;
> > > +
> > > +	dev->d1_support = false;
> > > +	dev->d2_support = false;
> > 
> > I thought d1_support is unsigned int, not bool?
> 
> They are always used as bools, though.

So make them bools? I'm not sure if this is correct C... or were you
trying to save some bits?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
