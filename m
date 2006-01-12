From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt bug]
Date: Thu, 12 Jan 2006 10:53:21 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601121052190.5383-100000@iolanthe.rowland.org>
References: <43C6194C.1070107@reub.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43C6194C.1070107-MwA23MxOyI4@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Reuben Farrelly <reuben-lkml-MwA23MxOyI4@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Neil Brown <neilb-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 12 Jan 2006, Reuben Farrelly wrote:

> >> Initializing USB Mass Storage driver...
> >> irq 193: nobody cared (try booting with the "irqpoll" option)

> >> handlers:
> >> [<c027017e>] (usb_hcd_irq+0x0/0x56)
> >> Disabling IRQ #193
> > 
> > USB lost its interrupt.  Could be USB, more likely ACPI.
> 
> I've seen this one happen nearly every boot since then including bootups that 
> are otherwise OK (no oopses), so it's probably worth more looking into rather 
> than being written off as a 'once off':
> 
> uhci_hcd 0000:00:1d.3: Unlink after no-IRQ?  Controller is probably using the 
> wrong IRQ.

> It's a new regression to -mm3.

Did the same IRQ get assigned to that controller in earlier kernel 
versions?

Alan Stern

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
