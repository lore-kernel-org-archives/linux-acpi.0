From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 16043] New: Resume w/USB remote working in
 2.6.33.2, no longer in 2.6.33.10
Date: Thu, 27 May 2010 18:01:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005271755500.1595-100000@iolanthe.rowland.org>
References: <20100527130117.ca479487.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100527130117.ca479487.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: scott-ILTxhEaIe5LR7s880joybQ@public.gmane.org
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 27 May 2010, Andrew Morton wrote:

> > https://bugzilla.kernel.org/show_bug.cgi?id=16043
> > 
> >            Summary: Resume w/USB remote working in 2.6.33.2, no longer in
> >                     2.6.33.10

> > Using the latest Arch Linux kernel (2.6.33.10-1), the contents of
> > /proc/acpi/wakeup are:

/proc/acpi/wakeup doesn't matter.  What matters are the power/wakeup 
files under /sys.

> > The machine will suspend to RAM correctly, but will no longer be resumed by a
> > USB remote power-on event.  Instead, the power button on the machine must be
> > pressed.  It then resumes correctly.

By default, wakeup is disabled for USB host controllers.  This is so 
that people don't cause their suspended laptops to wake up by 
unplugging a USB mouse, for example.

If you want to enable wakeup, you have to do it manually or from a 
boot-time script like /etc/rc.d/rc.local.  For example, you might need 
to do:

	echo enabled >/sys/bus/pci/devices/0000:00:04.0/power/wakeup

The system has been this way a long time, but up until just now it
didn't work correctly.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
