From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup and fixes
Date: Fri, 21 Mar 2008 01:22:43 +0100
Message-ID: <200803210122.44188.rjw@sisk.pl>
References: <200803201408.33466.david-b@pacbell.net> <200803202337.07465.rjw@sisk.pl> <20080320230301.8EFB235F4AF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38111 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbYCUAXL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Mar 2008 20:23:11 -0400
In-Reply-To: <20080320230301.8EFB235F4AF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: lenb@kernel.org, trenn@suse.de, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Friday, 21 of March 2008, David Brownell wrote:
> > > +	switch (mesg.event) {
> > >  	case PM_EVENT_SUSPEND:
> > > +		/* NOTE:  platform_pci_choose_state() should only return
> > > +		 * states where wakeup won't work if
> > > +		 *   - !device_may_wakeup(&dev->dev), or
> > > +		 *   - dev can't wake from the target system state
> > > +		 */
> > > +		if (platform_pci_choose_state) {
> > > +			ret = platform_pci_choose_state(dev, mesg);
> > > +			if (ret == PCI_POWER_ERROR)
> > > +				ret = PCI_D3hot;
> > > +			else if ((ret == PCI_D1 || ret == PCI_D2)
> > > +					&& pci_no_d1d2(dev))
> > > +				ret = PCI_D3hot;
> > > +			break;
> > > +		}
> > > +		/* FALLTHROUGH ... D3hot works, but may be suboptimal */
> > >  	case PM_EVENT_HIBERNATE:
> > > -		return PCI_D3hot;
> > > +		ret = PCI_D3hot;
> >
> > This is clearly wrong.  It should do the same as for suspend here (_S4D may be
> > defined and we should take it into account if it is).
> 
> So you're saying the original code was wrong, and this patch should
> change that behavior too?

The original code executed platform_pci_choose_state() first, if defined, and
if that succeeded, it just returned the result.  You put
platform_pci_choose_state() under the switch(). :-)

In fact the entire switch() in pci_choose_state() is just confusing.  I'd make
it return PCI_D3hot if platform_pci_choose_state() is undefined or fails (I
wonder if pci_choose_state() is ever called with PMSG_ON).  That at least
would be consistent with the behavior of acpi_pm_device_sleep_state().

Consequently, the 'state' argument would simply be unnecessary (and in fact
it's ignored if platform_pci_choose_state() is defined).

> > > +		break;
> > >  	default:
> > > -		printk("Unrecognized suspend event %d\n", state.event);
> > > -		BUG();
> > > +		ret = PCI_D0;
> > > +		break;
> > >  	}
> > > -	return PCI_D0;
> > > +	return ret;
> > >  }
> > >  
> > >  EXPORT_SYMBOL(pci_choose_state);
> >
> > I really don't think pci_choose_state() should take the state argument at all.
> 
> There is no "state" argument.  It's a pm_message_t, which does
> not package the target state.

Correct, but the pm_message_t argument is called 'state', confusingly so.

> A patch to change the calling syntax for this would necessarily
> be a different patch... and would need to change the callers too.

Agreed.

Thanks,
Rafael
