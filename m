From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git] make /proc/acpi/wakeup more useful
Date: Tue, 17 Apr 2007 20:25:52 -0700
Message-ID: <200704172025.52862.david-b@pacbell.net>
References: <200704031741.42273.david-b@pacbell.net> <200704171457.50416.david-b@pacbell.net> <20070418030343.GB12756@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:48714 "HELO
	smtp104.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1031025AbXDRDZ4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2007 23:25:56 -0400
In-Reply-To: <20070418030343.GB12756@kroah.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>, Zhang Rui <rui.zhang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tuesday 17 April 2007 8:03 pm, Greg KH wrote:
> On Tue, Apr 17, 2007 at 02:57:49PM -0700, David Brownell wrote:

> > Looks like the i8042 serial nodes will be bizarre too:
> > 
> > 	/sys/devices/pnp0/00:09
> > 		... touchpad's PNP node
> > 	/sys/devices/acpi_system:00/device:00/PNP0A03:00/device:15/PNP0F13:00
> > 		... its ACPI node
> > 	/sys/devices/platform/i8042/serio4
> > 		... its serio node
> > 
> > That seems like two nodes too many, but without me trying to twist
> > my mind around i8042 issues, I can't quite speculate why struct
> > serio "is-a" device rather than "has-a" device (the PNP node) as
> > would be the case with a more normal driver structure.
> > 
> > But the existence of that device_add() in serio.c sure explains why
> > the PNP node doesn't get associated with the input class device one
> > would expect from knowing that 00:09 is the touchpad.
> 
> Ick, how can we fix this up?

You're asking the wrong penguin for that answer ... :)

But I'd suggest that someone who knows ACPI -- and PNPACPI --- work
on merging those ACPI and PNP nodes.  (Same thing would need doing
with ACPI and PCI ...)

That ACPI subtree is quite new, at least in terms of being public.
So I'd think its details must be very flexible right now.


> > And hmm, just this morning I saw email from Greg re-affirming that
> > drivers should not device_add().  Converting such legacy drivers is
> > simple though, right?  :)
> 
> Heh, yeah right, they can remain platform drivers :)

Most platform drivers aren't legacy drivers.  Just the x86 ones!
And a lot of those wouldn't be headaches if PNPACPI were used better...

In this case, making the i8042 stuff use PNP more naturally would
seem like the most natural way to resolve the problem for all but
pre-ACPI legacy x86 hardware.  Now that ACPI implies PNPACPI by
default, various corner cases have vanished.

That said, I know less about i8042 wierdness -- and I know there's
a lot of it! -- than about ACPI, so I'll stay out of that.  Beyond
pointing out these curious little corner cases I've uncovered while
trying to make sure wakeup annotations get assigned to the right
sysfs device nodes.  :)

- Dave


> 
> thanks,
> 
> greg k-h
> 
