From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Wed, 7 May 2008 11:45:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org>
References: <200805071422.56147.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34134 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755752AbYEGPpI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2008 11:45:08 -0400
In-Reply-To: <200805071422.56147.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Wed, 7 May 2008, Rafael J. Wysocki wrote:

> On Wednesday, 7 of May 2008, Pavel Machek wrote:
> > Hi!
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > The new suspend and hibernation callbacks introduced with
> > > 'struct pm_ops' and 'struct pm_ext_ops' do not take a
> > > pm_message_t argument, so the drivers using them will not be able
> > > to use pci_choose_state() in its present form.  For this reason,
> > > introduce the new function pci_preferred_state() playing the role
> > > of pci_choose_state(), but taking only a pointer to the device
> > > object.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  drivers/pci/pci.c   |   33 ++++++++++++++++++++++++++++++++-
> > >  include/linux/pci.h |    1 +
> > >  include/linux/pm.h  |   10 ++++++++++
> > >  3 files changed, 43 insertions(+), 1 deletion(-)
> > > 
> > > Index: linux-2.6/drivers/pci/pci.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/pci/pci.c
> > > +++ linux-2.6/drivers/pci/pci.c
> > > @@ -509,7 +509,38 @@ pci_set_power_state(struct pci_dev *dev,
> > >  }
> > >  
> > >  pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
> > > - 
> > > +
> > > +/**
> > > + * pci_preferred_state - Choose the preferred power state of a PCI device
> > > + * @dev: PCI device to be put into the low power state
> > > + * @sp: Information aboutabout what the driver would prefer to do with
> > > + *	the device if there were no platform-implemeted policy.
> > > + *
> > > + * Returns PCI power state suitable for given device and given suspend policy.
> > > + * The policy, however, is only used if platform_pci_choose_state() fails or is
> > > + * not present.  Otherwise, it is assumed that platform_pci_choose_state()
> > > + * implements the right policy.
> > > + */
> > > +
> > > +pci_power_t pci_preferred_state(struct pci_dev *dev, enum suspend_policy sp)
> > > +{
> > > +	pci_power_t ret;
> > > +
> > > +	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> > > +		return PCI_D0;
> > > +
> > > +	ret = (sp == SP_TURN_OFF) ? PCI_D3hot : PCI_D0;
> > > +	if (platform_pci_choose_state) {
> > > +		pci_power_t platform_ret = platform_pci_choose_state(dev);
> > > +
> > > +		if (platform_ret != PCI_POWER_ERROR)
> > > +			ret = platform_ret;
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > > +EXPORT_SYMBOL(pci_preferred_state);
> > 
> > I don't get it. How is driver supposed to use this? How does the
> > driver decide between SP_TURN_OFF and SP_TURN_ON?
> > 
> > ...and it seems to be clearer to just inline this in the driver... or
> > pass  PCI_D3hot/PCI_D0 to it, instead of inventing yet another
> > define...
> 
> I thought about that too.  I'd like to know what the other people think,
> though.

The point of this isn't at all clear.

Is this routine meant to be called during a hibernation 
transition?  Or is it just for suspend?

And why would the return value ever be anything other than D3_hot?  (Or 
why would the driver ever want to put a device in a different state?)
AFAICS, the only reason would be because platform_pci_choose_state() 
suggested something else.  In which case there's no need for the 
"policy" argument.

Alan Stern

