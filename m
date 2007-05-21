From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-git] pci_choose_state() works, does ACPI magic
Date: Mon, 21 May 2007 10:55:54 -0700
Message-ID: <200705211055.55090.david-b@pacbell.net>
References: <200705091222.29561.david-b@pacbell.net> <200705211134.36578.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:35246 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756329AbXEUR4S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 May 2007 13:56:18 -0400
In-Reply-To: <200705211134.36578.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Monday 21 May 2007, Bjorn Helgaas wrote:
> On Wednesday 09 May 2007 01:22:29 pm David Brownell wrote:
> >  static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> >  {
> > ...
> > +	switch (state) {
> > +	case PCI_D0:
> > +	case PCI_D1:
> > +	case PCI_D2:
> > +	case PCI_D3hot:
> > +	case PCI_D3cold:
> > +		return acpi_bus_set_power(handle, state_conv[state]);
> > +	}
> > +
> > +	return -EINVAL;

... i.e. a cleaned-up version of the existing code ...

> >  }
> 
> Did you account for the fact that PCI works on a per-function basis,
> but ACPI power management works on a per-slot basis?

This is a per-function method though.  The ACPI code should
be able to keep that straight ... simple refcounting on the
power resources would suffice, assuming it goes the route of
managing power resources rather than just invoking the methods
associated with each device.


> We had a bug[1] a while back where e1000 would suspend a device and
> call pci_power_state(), which used ACPI to turn off the slot.  The
> only problem was that this was a dual-port card and the other port
> was still active when the lights went out.

Sounds like an ACPI bug to me:  not properly tracking the users
of a given PCI power resource.  I can't see that bug without
getting a Novell login -- you might want post the report rather
than its URL.

 
> Maybe you deal with this already; it just wasn't obvious to me from
> a quick glance through your patch.

Didn't touch it ... pre-existing bugs shouldn't have been affected.

The only behavioral change in that particular method should have been
safer handling of an out-of-range parameter.

- Dave
 

> Bjorn
> 
> 
> [1] https://bugzilla.novell.com/show_bug.cgi?id=162320
> 


