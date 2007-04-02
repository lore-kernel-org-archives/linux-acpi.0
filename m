From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Power Mangement Interfaces
Date: Mon, 02 Apr 2007 18:23:42 +0800
Message-ID: <1175509422.5321.37.camel@localhost.localdomain>
References: <20070330235759.GC4252@cosmic.amd.com>
	 <200703311157.03975.david-b@pacbell.net>
	 <20070401010155.GA10151@cosmic.amd.com>
	 <200703312001.55231.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20321 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965380AbXDBKZC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Apr 2007 06:25:02 -0400
In-Reply-To: <200703312001.55231.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Jordan Crouse <jordan.crouse@amd.com>, devel@laptop.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org

On Sat, 2007-03-31 at 20:01 -0700, David Brownell wrote:
> > This looks very good, and is pretty close to what I was proposing.  
> > Replace the acpi_*_event() calls with a generic pm_ infrastructure, and
> > add hooks to the pm_ops for each individual PM system to handle the wakeups
> > in whatever way they see fit, and we're there.  It would be slightly more
> > complex for AT91 and friends to match this (since they have the advantage
> > of a 1:1 mapping right now), but in the long run, I think everybody would
> > benefit.
> 
> I guess I don't see why this isn't already sufficiently generic ...
> 
> As a rule, all those embedded drivers are platform-specific and have
> no need for more than a few enable_irq_wake() calls, in addition to
> whatever controller setup and clock management they do.  Since they
> can't be very portable, they don't need to generalize such stuff.
> 
> And for PCI based things, pci_enable_wake() encapsulates everything
> that needs doing.  Not that ACPI actually *does* anything yet!  But
> the stuff that writing /proc/acpi/wakeup enables should happen in that
> routine ... and eventually PCI runtime wake events should work too.
> (So:  no drivers would ever call ACPI directly, and they already have
> the generic call that ACPI should hook.)
> 
> That seems to cover most drivers in Linux, without a need for any
> new generic PM infrastructure.  Did I overlook something important?
> 
> 
> > The only other issue then, is how we could define and manage wakeup events
> > for events that aren't associated with specific devices, like power button
> > and lid events.  We'll need some way to control those somewhere in sysfs -
> > if not in /sys/power/wakeup like I had proposed, then somewhere under the
> > platform or system hierarchy .
> 
> I see /sys/devices/acpi_system:00/button_power:00 on this system; and
> /sys/devices/acpi_system:00/device:00/PNP0C0D:00 has path \_SB_.LID_ ...
> such device nodes already exist, even though they're not really hooked
> up to anything much.  Notably, their "wakeup" state is not initialized.
> 
That's right.
This is meaningless now and we don't intend to use it in the future.
If a device is also described in ACPI namespace, it should know its ACPI
device node in sysfs.
Then when we want to enable/disable a deivce's wakeup ability, just goto
the physical device node in sysfs. What we need is a hook offered by
ACPI device driver.
> And while it seems that the three USB controllers on this system show up
> as /sys/devices/acpi_system:00/device:00/PNP0A03:00/device:{01,02,03} I
> have no idea which one is /sys/devices/pci0000:00/0000:00:02.2 versus
> 0000:00:02.1 or 0000:00:02.0 ... I know that USB0 is device:01 and so
> on (by reading "path"), but associating one with a PCI device seems to
> involve pure guesswork.
> 
Sorry to make you confused.
That's what we need to improve in the wish list. :)

Thanks,
Rui
