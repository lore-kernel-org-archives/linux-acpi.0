From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB runtime D3
Date: Thu, 30 Jul 2009 15:15:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907301511030.6087-100000@iolanthe.rowland.org>
References: <20090730190243.GA22016@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090730190243.GA22016-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 30 Jul 2009, Matthew Garrett wrote:

> On Thu, Jul 30, 2009 at 02:58:26PM -0400, Alan Stern wrote:
> > On Thu, 30 Jul 2009, Matthew Garrett wrote:
> > 
> > > Yes, that would basically work for me. I'm still slightly curious as to 
> > > why my hardware's not giving me the correct ACPI notification, though - 
> > > I guess this may be entirely untested under Windows.
> > 
> > To put it mildly...
> 
> Windows doesn't D3 the host?

As far as I know, Windows doesn't even suspend the root hub.  However 
my knowledge of Windows internals is out of date by at least 10 years.  
Thank goodness...  :-)

Alan Stern

P.S.: Besides which, you can't put these Intel UHCI controllers into D3
because they don't support PCI PM.  Controllers from other vendors
(i.e., VIA) do.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
