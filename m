From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Sat, 12 May 2012 22:50:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205122231230.17724-100000@netrider.rowland.org>
References: <4FAEA23B.1010009@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:49078 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752137Ab2EMCuG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 May 2012 22:50:06 -0400
In-Reply-To: <4FAEA23B.1010009@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Sun, 13 May 2012, Lan Tianyu wrote:

> >> I think we can not power off ports on the hubs that the user plugs in.
> > You are wrong.  Some hubs do allow ports to be powered off.  Most
> > don't, but some do.
> Ok. Thanks for correct. So how to control ports' power on those
> hub? via set or clear PORT_POWER?

That's the only way.  :-)

> Sorry. I may misunderstand your statement. I try to make it clear. :)
> 
> >All you have to do is turn off the connect-change status bit.  In fact,
> >the debounce routine does this already.  Just leave the port state set
> >to "off" until the connection is debounced.
> 
> I have checked hub_port_debounce(). The routine only clear
> port feature USB_PORT_FEAT_C_CONNECTION when connect-change event
> is detected.

Forget about hub_port_debounce().  You shouldn't be using it anyway; 
ports need to be debounced only when a cable is physically plugged in 
or unplugged.  Electrical switching doesn't need debouncing.

Instead, what you should do after turning on the port power is wait for
up to one second (say) for the connect status to turn on.  Then make
sure the port's connect-change and enable-change status bits are off
(*), set the port's status back to "on", and call finish_port_resume().

> "turn off the connect-change status bit". you mean unmask the
> connect and enable change status bit.
> just like:
> portchange&= ~(USB_PORT_STAT_C_CONNECTION |
> 		USB_PORT_STAT_C_ENABLE);
> right?

No, I mean send Clear-Port-Feature requests for
USB_PORT_FEAT_C_CONNECTION and USB_PORT_FEAT_C_ENABLE.  It might be
necessary to do the same for USB_PORT_FEAT_C_SUSPEND,
USB_PORT_FEAT_C_PORT_LINK_STATE, and maybe even
USB_PORT_FEAT_C_BH_PORT_RESET.  There's already some code in
hub_activate() that does something like this; you might be able to
reuse it.

> > Why is hub_port_connect_change() going to get called?  hub_event()
> > doesn't call hub_port_connect_change() when it doesn't need to.
> > In this case it won't need to, because debouncing turns off the
> > connect-change status.
> in the hub_event(), the routine will get port's status and
> port change status every time. How does hub_port_debounce()
> turn off the the value of port change status in the hub_event?
> 
> hub_event() {
> 	...
> 	connect_change = test_bit(i, hub->change_bits);
> 	if (!test_and_clear_bit(i, hub->event_bits)&&
> 					!connect_change)
> 				continue;
> 
> 	ret = hub_port_status(hub, i,
> 		&portstatus,&portchange);
> 	if (ret<  0)
> 		continue;
> 
> 	/*
> 	 * if we unmask the portchange here,
> 	 * the hub_port_connect_change() will not be
> 	 * invoked.
> 	 * portchange&= ~(USB_PORT_STAT_C_CONNECTION |
> 	 * USB_PORT_STAT_C_ENABLE);
> 	 */

Not needed.

> 	if (portchange&  USB_PORT_STAT_C_CONNECTION) {
> 		clear_port_feature(hdev, i,
> 			USB_PORT_FEAT_C_CONNECTION);
> 		connect_change = 1;
> 	}

Right.  But portchange & USB_PORT_STAT_C_CONNECTION will be 0 because 
at (*) we sent the Clear-Port-Feature request.

> 	...
> }
> 
> Is there a way to forbid connect-change or enable-change bits
> to be on when these events take place?

You don't need to forbid them.

> > Do you know what a "reset-resume" is? See Documentation/usb/persist.txt.
> I know reset-resume. But if hub_port_connect_change() is invoked.
> It just like unplug and plug device.

It won't be invoked.

> My main question is that how does usb_port_debounce() prevent the
> connect-change and enable-change bits to be off.

Forget about hub_port_debounce().  See above.

Alan Stern

