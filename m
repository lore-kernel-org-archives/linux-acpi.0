From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Thu, 10 May 2012 13:44:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205101253280.1831-100000@iolanthe.rowland.org>
References: <20120510163528.GA32651@xanatos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120510163528.GA32651@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 10 May 2012, Sarah Sharp wrote:

> On Thu, May 10, 2012 at 11:54:04AM -0400, Alan Stern wrote:
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
> Every little bit of power savings helps for the particular system that
> implements the USB port power off.  For this particular platform, Intel
> is looking at the system as a whole and trying to eek out power savings
> where ever they can.  A little power savings in one particular subsystem
> may not seem like a big deal, but when you look at the overall picture,
> the long tail adds up.  Just trust me, I'm excited about this system. :)

I'll take your word for it.  :-)

> As for examples of where the port power off would be useful, think about
> a laptop with several internal ports.  The customer can save some money
> by choosing not to purchase an internal USB bluetooth device.  The OEM
> may have just one motherboard for those two choices, so the port that
> would have held the bluetooth device will be empty.  In that case, we'll
> never see a USB device connect on that empty port, so we may as well
> power it down.  If we can further power off the internal webcam port
> when the device is suspended, we can save more power.

The patch did not address the case of powering down ports that have no
devices attached.  That might be a better place to start, because it's
simpler, even though it might not yield as much power savings.

There's one more thing to consider, which was missing from the patch.  
When you power the port back up and resume the device, it will 
necessarily be a reset-resume.  You won't want to do this if any of the 
drivers attached to the device's interfaces doesn't have reset-resume 
support.

> Another example is when a user walks away from their laptop with some
> USB devices plugged in.  If userspace can somehow know when the system
> is idle (e.g. the screen blanks, the bluetooth/NFC radio no longer
> detects the person's phone, etc), we can power off unconnected and
> suspended external ports.  The hypothesis is that some users may not
> care about USB device connects and disconnects when their system is
> idle.  They really will only care that the changes get noticed when
> they start using their system.
> 
> This breaks down for some users, of course.  Arjan has several desktops
> under his desk that are always on, and he starts interacting with them
> by plugging in a USB mouse and keyboard.  So obviously the "port power
> off on screen blank" policy might not work for him.  It also won't work
> for servers, where no one connects a real monitor to the server for
> months, but server folks probably won't care about this mechanism
> because their power budget is so much larger.
> 
> However, someone on an airplane, trying to eek out every mW out of their
> battery, would want to power off any external unconnected or suspended
> USB ports.
> 
> The point is that whether a user wants to allow the ports to be powered
> off should be a userspace policy.  That's why we export the sysfs file,
> so that desktop software can implement whatever their customers want.
> Personally, I would want a checkbox in the Gnome display settings that
> says "Power off USB ports on screen blank".

Makes sense.  (But I foresee a lot of confusion among users when this
box is checked and the ports don't get powered down -- many of
today's laptops are incapable of powering down their USB ports.)

> > > "waiting for connection" state is to avoid device to being removed.
> > 
> > Why would the device be removed?
> 
> When we turn the power back on, we'll get a connect status change bit
> set.  We don't want the USB core to misinterpret that bit and try to
> logically disconnect the device attached to the port.

All you have to do is turn off the connect-change status bit.  In fact,
the debounce routine does this already.  Just leave the port state set
to "off" until the connection is debounced.

You may also have to turn off the enable-change status bit.

> What if the external device was suspended, we power off the port, and
> then the user yanks the device while it was suspended?  A device may
> never connect in that case.

Then the debounce loop in usb_port_wait_for_connected() will time out.  
At that point you'll know the device has been disconnected.

> Let me know if you have any more questions about the mechanisms or
> policy we're trying to set up.  Tianyu has been creating these patches,
> but I've tried to provide some advice to him along the way.

I think I get the picture.  It's a tricky job, because you can easily 
go too far and turn off something that needs to remain on.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
