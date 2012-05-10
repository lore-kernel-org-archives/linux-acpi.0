From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Thu, 10 May 2012 14:11:56 -0700
Message-ID: <20120510211156.GA18754@xanatos>
References: <Pine.LNX.4.44L0.1205101136470.1831-100000@iolanthe.rowland.org>
 <1336677578.6463.5.camel@dcbw.foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336677578.6463.5.camel-wKZy7rqYPVb5EHUCmHmTqw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, May 10, 2012 at 02:19:38PM -0500, Dan Williams wrote:
> On Thu, 2012-05-10 at 11:54 -0400, Alan Stern wrote:
> > On Thu, 10 May 2012, Lan Tianyu wrote:
> > 
> > > hi all:
> > > 	Currently, we are working on usb port power off mechanism. Our developing
> > > machine provides usb port power control (a vbus switch)via ACPI power resource.
> > > When the power resource turns off, usb port powers off and usb device loses
> > > power. From usb hub side, just like the device being unplugged.
> > > 
> > > 	Since usb port power off will affect hot-plug and devices remote wakeup
> > > function, it should be careful to do that.
> > > 	We conclude three different situations for power off mechanism.
> > > 	(1) hard-wired port with device
> > > 	(2) hot-pluggable port without device
> > > 	(3) hot-pluggable port with device
> > > 
> > > For hard-wired port, the device will not be removed physically. So we can
> > > power off it when device is suspended and remote wakeup is disabled without
> > > concerning with hot-plug. This patch is dedicated to this siutation.
> > > 
> > > This patch is to provide usb acpi power control method and call them in the
> > > usb_port_suspend() and usb_port_resume() when port can be power off. When the
> > > usb port is in the power off state, usb core doesn't remove device which is
> > > attached to the port. The device is still on the system and user can access
> > > the device.
> > 
> > Can you provide any examples where this would be useful?  It won't end 
> > up saving very much power (although on a laptop even a little bit might 
> > help).
> 
> I'd love to do this with ModemManager to shoot a modem in the head if
> it's crashed.  Right now there's simply no way to reset a device that's
> misbehaving or crashed.  Powering off the port would be a last resort,
> but not all devices actually disconnect from the bus when they crash and
> reconnect after the firmware reboots.

I'm not sure if the policy we set up would allow that, if the device was
still connected and not suspended.  Maybe we need an "off" setting that
forces the port off?

Also, setting the port power off via ACPI may not actually cut power,
because port power might be ganged.  Once we signal via ACPI that all
the ports that are ganged together can be powered off, they will.  So
there's no guarantees that you can power off the buggy modem unless you
power off the other ganged ports as well.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
