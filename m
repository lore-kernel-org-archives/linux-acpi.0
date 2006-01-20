From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: wake-on-lan
Date: Fri, 20 Jan 2006 16:56:36 -0500
Message-ID: <20060120215636.GA13188@neo.rr.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CECE@hdsmsx401.amr.corp.intel.com> <20060120051635.GA30662@hell.org.pl> <20060120063637.GC27435@neo.rr.com> <20060120065045.GC30662@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:59850 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1751174AbWATVvZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 16:51:25 -0500
Content-Disposition: inline
In-Reply-To: <20060120065045.GC30662@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: "Brown, Len" <len.brown@intel.com>, Joseph Dunn <jdunn14@hotpop.com>, linux-acpi@vger.kernel.org

On Fri, Jan 20, 2006 at 07:50:45AM +0100, Karol Kozimor wrote:
> Thus wrote Adam Belay:
> > > Note also that there are very few explicit calls to pci_enable_wake() in
> > > the whole tree. Linux doesn't set the PME-Enable bit properly, which
> > > apparently results in WOL either working or not working. My understanding
> > > is that the final outcome depends on what BIOS does to the card during
> > > POST. Please see http://bugme.osdl.org/show_bug.cgi?id=3801 for a weird 
> > > example.
> > I'm in the process of overhauling the PCI layer's power management event
> > support.  Basically, I'd like to catch ACPI GPE events and then walk the
> > device tree in thier corresponding location to see if PME is set.  If so
> 
> Ouch. Registering a notify handler against the device's node is not enough?
> AFAIR, the spec requires devices that triggered wake-up to be notified and
> most DSDTs I've seen do it in one way or another (usually through _WAK).

Sure, there are a lot of requirements on the ACPI end.  We also need to call
_DSW or _PSW (if it's available) when preparing a PCI device for wakeup.
> 
> > a function like ->wake() will be called for the device driver that owns
> > the triggered device.  This should allow for even runtime PME usage.  I'm
> > expecting to have a patch available for the PCI end of these changes soon.
> 
> What point is calling this when we're already up?

I think you're defining a scope that is too narrow for wake events.
Remember that they can be enabled during S0 (and there are many good
reasons to do so).  In this case, a device is not going to turn on by
itself as ->resume will never be called.  Rather, the driver will need
to evaluate the wake event and determine the proper course of action.  

> 
> Obviously, I haven't seen the whole picture, but from what I know we
> already have a .enable_wake callback that is ignored by both the core code
> and the drivers. Perhaps extending this callback with platform hooks to
> enable the corresponding GPE (die, /proc/acpi/wakeup, die!) and making sure
> it actually is called would suffice?

Yes, I'd like to use platform hooks.  The API on the PCI end might look
like this: (in psuedo-code)

pci_arm_wakeup(struct pci_dev *dev,
	       struct power_state *lowest_state_we_might_enter,
	       struct system_state *target_system_suspend_state)
{
	pci_enable_pme();
	enable_platform_wakeup();
}

pci_disarm_wakeup(struct pci_dev *dev)
{
	disable_platform_wakeup();
	pci_disable_pme();
}

pci_enable_wake() would be deprecated.

Regards,
Adam

