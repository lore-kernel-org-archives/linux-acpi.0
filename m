From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 11:35:43 -0700
Message-ID: <20120511183543.GF7920@kroah.com>
References: <4FAD3A51.4010803@intel.com>
 <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1205111302080.1865-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 11, 2012 at 01:44:26PM -0400, Alan Stern wrote:
> On Sat, 12 May 2012, Lan Tianyu wrote:
> 
> >     The power saving depends on devices. I test a usb3.0 ssd. The power saving of
> > power off is about 2.2w more than just selective suspend. In theory, power
> > off can help to save remaining power after selective suspend.
> 
> That's a lot of power!  Suspended USB devices aren't supposed to
> consume more than 2.5 mA of bus current, which at 5 V amounts to <=
> 0.0125 W.  Does the port really use that much?  Or does the SSD have a
> separate power supply that it disables when port power is removed?
> 
> > > The patch did not address the case of powering down ports that have no
> > > devices attached.  That might be a better place to start, because it's
> > > simpler, even though it might not yield as much power savings.
> > 
> > Do you mean internal ports?
> 
> Internal or external.
> 
> >  From my opinion, ACPI will tell us whether the port is connectable or not.
> 
> ACPI will tell you about some ports, not others (for example, ACPI
> knows nothing about the ports on hubs that the user plugs in).  On
> other systems, a Device Tree database might provide the same
> information.
> 
> > When the internal port is not connectable, this means the port is not used
> > and this patch will power down the port.
> 
> ...
> 
> > For external ports, this should be associated with sys file control. The users
> > need to determine when they should be power off.
> 
> You don't mean "external", you mean "not described as unconnectable by 
> ACPI".
> 
> > So I should work on the external ports without devices firstly and
> > add the sys file for user to control?
> 
> Yes, I think so.  It will be less controversial and probably simpler.  
> When that mechanism is ready, you should be able to use it
> automatically for unconnectable ports.
> 
> One tricky thing: In theory, there should be a separate sysfs file for 
> each port.  That seems like a lot of overhead though; is there any way 
> to present the information in a single file that won't offend sysfs 
> purists?

Why is that a lot of "overhead"?  It's what, 7-9 files max?  As Sarah
points out, one file for all ports is racy and can get to be a mess.

But then again, I'm a "sysfs purist" :)

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
