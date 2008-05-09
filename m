From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Fri, 9 May 2008 19:34:40 +0200
Message-ID: <200805091934.41341.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org> <200805091913.40197.rjw@sisk.pl> <200805091024.53027.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51250 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbYEIRe7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 May 2008 13:34:59 -0400
In-Reply-To: <200805091024.53027.jbarnes@virtuousgeek.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Friday, 9 of May 2008, Jesse Barnes wrote:
> On Friday, May 09, 2008 10:13 am Rafael J. Wysocki wrote:
> > > So why not make platform_pci_choose_state do:
> > > + pci_power_t noacpi_pci_choose_state(struct pci_dev *dev, pci_message_t
> > > state)
> > > + {
> > > +       if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> > > +               return state;
> > > + }
> > >
> > > instead?  Then in the PCI core we would assign either
> > > platform_pci_choose_state to acpi_pci_choose_state or
> > > noacpi_pci_choose_state
> >
> > Good idea.
> >
> > > (though that's a bad name).
> >
> > Does generic_pci_choose_state() sound better?
> 
> Yeah, that's better.
> 
> > > But really, since drivers should probably know what power state to put
> > > their devices in for suspend & hibernate, maybe on non-ACPI systems the
> > > function should just return an error and the driver can choose...
> >
> > That's one possibility too, but in that case many drivers will do
> >
> > state = pci_preferred_state(dev);
> > if (state == PCI_POWER_ERROR)
> > 	state = something;
> >
> > It's just shorter to write
> >
> > state = pci_preferred_state(dev, something);
> 
> But really that's the idea, since if the core doesn't know what state your 
> device should be in (and in many non-ACPI cases I'd argue that to be true) 
> your driver should be picking something sensible.  After all, states other 
> than D0 and D3 are really device dependent, right?
> 
> One way to avoid some ugliness like you show above would be:
> 
> device_suspend(...)
> {
>   ...
>   state = PCI_D3hot;
>   pci_choose_state(dev, pm_state, &state);
>   pci_set_power_state(dev, state);
>   ...
> }
> 
> So in this case pci_choose_state would either change state or leave it 
> untouched if it didn't have a better idea about things.  But now that I look 
> at it I'm not sure it's an improvement. :)

Well, in principle we could go farther and introduce a wrapper around
pci_set_power_state() that will call platform_pci_choose_state() to obtain the
new state or use the driver-provided one if that fails.

What do you think?

Rafael
