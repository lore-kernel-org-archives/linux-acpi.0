From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: wake-on-lan
Date: Fri, 20 Jan 2006 01:36:37 -0500
Message-ID: <20060120063637.GC27435@neo.rr.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CECE@hdsmsx401.amr.corp.intel.com> <20060120051635.GA30662@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:59849 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1030438AbWATGbe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 01:31:34 -0500
Content-Disposition: inline
In-Reply-To: <20060120051635.GA30662@hell.org.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: "Brown, Len" <len.brown@intel.com>, Joseph Dunn <jdunn14@hotpop.com>, linux-acpi@vger.kernel.org

On Fri, Jan 20, 2006 at 06:16:35AM +0100, Karol Kozimor wrote:
> Thus wrote Brown, Len:
> > >When I halt the machine (shutdown -h) I cannot
> > >wake it.  However, if the machine is unplugged, then plugged back in,
> > >*then* I can wake it. 
> > 
> > WOL can be done a couple of ways.
> > 
> > If it is implemented using ACPI GPE's, then
> > you need to find a string (unfortunately, they're arbitrary)
> > in /proc/acpi/wakeup that looks like your device and echo that
> > string into the file to toggle between enabled and disabled.
> > 
> > Only Power/Sleep/LID buttons are enabled for wakeup by default.
> > 
> > Note that this I/F is temporary -- the ability of
> > a device to wake the system should really be a property
> > of that device in the /sys tree.
> 
> Note also that there are very few explicit calls to pci_enable_wake() in
> the whole tree. Linux doesn't set the PME-Enable bit properly, which
> apparently results in WOL either working or not working. My understanding
> is that the final outcome depends on what BIOS does to the card during
> POST. Please see http://bugme.osdl.org/show_bug.cgi?id=3801 for a weird 
> example.

I'm in the process of overhauling the PCI layer's power management event
support.  Basically, I'd like to catch ACPI GPE events and then walk the
device tree in thier corresponding location to see if PME is set.  If so
a function like ->wake() will be called for the device driver that owns
the triggered device.  This should allow for even runtime PME usage.  I'm
expecting to have a patch available for the PCI end of these changes soon.

Thanks,
Adam
