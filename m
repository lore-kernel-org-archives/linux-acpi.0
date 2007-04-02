From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Mon, 2 Apr 2007 11:24:21 -0700
Message-ID: <200704021124.21926.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703312001.55231.david-b@pacbell.net>
	<1175509422.5321.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@laptop.org>
In-Reply-To: <1175509422.5321.37.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=unsubscribe>
List-Archive: <http://mailman.laptop.org/pipermail/devel>
List-Post: <mailto:devel@laptop.org>
List-Help: <mailto:devel-request@laptop.org?subject=help>
List-Subscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=subscribe>
Sender: devel-bounces@laptop.org
Errors-To: devel-bounces@laptop.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 02 April 2007 3:23 am, Zhang Rui wrote:

> > > The only other issue then, is how we could define and manage wakeup events
> > > for events that aren't associated with specific devices, like power button
> > > and lid events.  We'll need some way to control those somewhere in sysfs -
> > > if not in /sys/power/wakeup like I had proposed, then somewhere under the
> > > platform or system hierarchy .
> > 
> > I see /sys/devices/acpi_system:00/button_power:00 on this system; and
> > /sys/devices/acpi_system:00/device:00/PNP0C0D:00 has path \_SB_.LID_ ...
> > such device nodes already exist, even though they're not really hooked
> > up to anything much.  Notably, their "wakeup" state is not initialized.
> 
> That's right.
> This is meaningless now and we don't intend to use it in the future.

Why not?  Exactly how do you anticipate ACPI exposing its wakeup
capabilities, if it's not going to use the existing platform-neutral
interface?


> If a device is also described in ACPI namespace, it should know its ACPI
> device node in sysfs.

What about PCI or PNP devices that have "shadow" listings in ACPI?


> Then when we want to enable/disable a deivce's wakeup ability, just goto
> the physical device node in sysfs. What we need is a hook offered by
> ACPI device driver.

I don't follow this at all.  Most of the relevant devices have a PCI
device driver, not an ACPI device driver.  Surely you aren't proposing
that PCI drivers should incorporate lots of ACPI-specific code (which
won't be useful on non-ACPI platforms) before they start to work right?

For a PCI device driver, pci_enable_wake() is all the hook that it should
ever need.  If ACPI magic is needed, it should be called from inside that
routine.


> > And while it seems that the three USB controllers on this system show up
> > as /sys/devices/acpi_system:00/device:00/PNP0A03:00/device:{01,02,03} I
> > have no idea which one is /sys/devices/pci0000:00/0000:00:02.2 versus
> > 0000:00:02.1 or 0000:00:02.0 ... I know that USB0 is device:01 and so
> > on (by reading "path"), but associating one with a PCI device seems to
> > involve pure guesswork.
>
> Sorry to make you confused.
> That's what we need to improve in the wish list. :)

Do you mean the "ACPI 4.0" wishlist?  Or the "Linux ACPI" wishlist?

- Dave
