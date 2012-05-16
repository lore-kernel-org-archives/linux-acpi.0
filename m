From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Wed, 16 May 2012 08:57:23 -0700
Message-ID: <20120516155723.GC20507@xanatos>
References: <4FB348AB.5050308@intel.com>
 <Pine.LNX.4.44L0.1205161033340.1852-100000@iolanthe.rowland.org>
 <20120516143958.GA612@kroah.com>
 <4FB3BF95.50600@intel.com>
 <20120516150846.GB3293@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120516150846.GB3293-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, May 16, 2012 at 08:08:46AM -0700, Greg KH wrote:
> On Wed, May 16, 2012 at 10:54:13PM +0800, Lan Tianyu wrote:
> > On 2012/5/16 22:39, Greg KH wrote:
> > >On Wed, May 16, 2012 at 10:36:02AM -0400, Alan Stern wrote:
> > >>On Wed, 16 May 2012, Lan Tianyu wrote:
> > >>
> > >>>Ok. Let me reconfirm the meaning of these opinions.
> > >>>
> > >>>"auto"
> > >>>	if port without device, turn off power directly.
> > >>>	if port with device, turn off power when the device is suspended.
> > >>>
> > >>>"on"	the port's power must be on.
> > >>>
> > >>>"off"	the port's power must be off.
> > >>>
> > >>>Right?
> > >>Maybe the "auto" setting should be renamed "active".  Then "auto" can
> > >>be used for:
> > >>
> > >>	If the port has a device, turn the power on.
> > >>	If the port doesn't have a device, turn the power off.
> > >And plugging a new device into a port that was powered off is going to
> > >cause the power to come back on, right?
> > When the port was powered off, the connect-change event will not be
> > detected and
> > we don't know a device was plugged in. :(
> 
> Then that doesn't seem like a very good thing to ever do, right?

When the port is powered off, VBUS is removed.  That means we don't get
connect, disconnect, or remote wakeup events.  The most useful case for
this is if we know there's a USB port that's internal (say inside a
laptop) that either is empty, or has a USB device that's suspended
without remote wakeup enabled.  Then we know we can safely power off the
port, because we shouldn't ever see a connect, disconnect, or remote
wakeup.

We can use ACPI tables to figure out whether a USB port is physically
connectable (e.g. internal) or not.  Of course, the ACPI tables may well
lie to us, so we need to export the sysfs interface so that userspace
can override any kernel defaults WRT powering off internal ports.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
