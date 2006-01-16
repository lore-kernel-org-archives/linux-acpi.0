From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt bug]
Date: Sun, 15 Jan 2006 22:46:28 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601152243330.1929-100000@netrider.rowland.org>
References: <43CB12EA.3040309@reub.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43CB12EA.3040309-MwA23MxOyI4@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Reuben Farrelly <reuben-lkml-MwA23MxOyI4@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Neil Brown <neilb-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 16 Jan 2006, Reuben Farrelly wrote:

> > From the information presented here, it looks like -mm1 correctly routes
> > the 1d.1 controller to IRQ 193 and the 1d.3 controller to IRQ 169, whereas
> > -mm3 incorrectly routes the 1d.3 controller to IRQ 193.  That would make 
> > it an ACPI problem.
> 
> Is this likely to be the same or similar issue to the IRQ 0 problem I see quite 
> frequently on the SATA ports on later -mm releases?
> (see http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/1851.html)

I doubt they are at all related.  In the USB problem the resource is there 
but ACPI is routing it wrongly.  In the SATA problem the resource isn't 
there to begin with.

But then I know almost nothing about ACPI, so I could be wrong...

Alan Stern

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
