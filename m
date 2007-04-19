From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 2.6.21-rc5-git 0/3] x86_pc and ACPI support
	/sys/devices/.../wakeup
Date: Thu, 19 Apr 2007 17:48:32 +0800
Message-ID: <1176976112.9072.54.camel@localhost.localdomain>
References: <200704051248.40745.david-b@pacbell.net>
	 <1176889866.5376.34.camel@localhost.localdomain>
	 <200704180933.07601.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43688 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993220AbXDSJt2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Apr 2007 05:49:28 -0400
In-Reply-To: <200704180933.07601.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Wed, 2007-04-18 at 09:33 -0700, David Brownell wrote:
> On Wednesday 18 April 2007 2:51 am, Zhang Rui wrote:
> > Hi, David,
> > 
> > On Thu, 2007-04-05 at 12:48 -0700, David Brownell wrote:
> > > Following are three patches for basic driver model wakeup flag support on
> > > PCs.  I think the first two are nearly mergable.  The third previously broke
> > > powerpc, so it's likely not yet mergeable ... the issue was arch-specific
> > > differences in PCI initialization, someone else will need to solve them.
> > > 
> > > The patches are:
> > > 
> > >  - Define a platform_enable_wakeup() PM hook and use it with PCI.  (This
> > >    might help OLPC with its non-RTC events...)
> > > 
> > >  - Make ACPI init and use driver model wakeup flags for the (motherboard)
> > >    devices in its table ... and implement that new platform hook.  Now
> > >    /proc/acpi/wakeup is almost purely informative.
> > 
> > Yes.
> > But /proc/acpi/wakeup is exporting the wrong information then.
> 
> I'd say it's always exported the wrong information ... and
> since those /proc files are going away, this there's no
> strong need to continue following that path.
> 
> The literal meaning hasn't changed:  it still reflects the
> value of the acpi_device.wakeup.state.enabled flag.  This
> version of the patch avoided changing that meaning, to make
> the compatibility story simpler.
> 
> > I.e. when a physical device is set to may_wakeup, the corresponding
> > GPE will be enabled before entering a system sleep state.
> 
> The GPE is not always enabled when device_may_wakeup(dev)
> returns true.  When drivers aren't set up to handle wakeups,
> they won't make requests that boil down to enabling GPEs.
> 
> What /proc/acpi/wakeup shows in those cases is the state
> of what I called "manual overrides".  Drivers that aren't
> wakeup-aware will use those settings ... same as always.
> (Unless userspace disables wakeup for that device through
> the driver model.)
> 

> Wakeup-aware drivers will manage their GPEs directly, by
> calling pci_enable_wake() -- or whatever -- according to
> what device_may_wakeup(dev) tells them to do.
> 

That's true.
Now acpi_device.wakeup.state.enabled is handled by
the wakeup-aware drivers of the "real" device.

I love the first two patches which help user space get rid of
this ACPI specific GPE control.

What I meant yesterday is that, as /proc/acpi/wakeup won't be
removed until we are able to map all the ACPI devices shown to
the real device node, if they have one,
it would be better if we either remove this GPE status information
from /proc/acpi/wakeup, or export something that really makes sense.
But now I think it's wrong. Because the other devices that are not
mapped yet still need this I/F to enable/disable GPE, we can not
remove/change this at the current stage.

Then the first two patches are OK with me.:)

Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Thanks,
Rui
