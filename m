From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 13:44:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
References: <4FAD3A51.4010803@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47548 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756764Ab2EKRo1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 May 2012 13:44:27 -0400
In-Reply-To: <4FAD3A51.4010803@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Sat, 12 May 2012, Lan Tianyu wrote:

>     The power saving depends on devices. I test a usb3.0 ssd. The power saving of
> power off is about 2.2w more than just selective suspend. In theory, power
> off can help to save remaining power after selective suspend.

That's a lot of power!  Suspended USB devices aren't supposed to
consume more than 2.5 mA of bus current, which at 5 V amounts to <=
0.0125 W.  Does the port really use that much?  Or does the SSD have a
separate power supply that it disables when port power is removed?

> > The patch did not address the case of powering down ports that have no
> > devices attached.  That might be a better place to start, because it's
> > simpler, even though it might not yield as much power savings.
> 
> Do you mean internal ports?

Internal or external.

>  From my opinion, ACPI will tell us whether the port is connectable or not.

ACPI will tell you about some ports, not others (for example, ACPI
knows nothing about the ports on hubs that the user plugs in).  On
other systems, a Device Tree database might provide the same
information.

> When the internal port is not connectable, this means the port is not used
> and this patch will power down the port.

...

> For external ports, this should be associated with sys file control. The users
> need to determine when they should be power off.

You don't mean "external", you mean "not described as unconnectable by 
ACPI".

> So I should work on the external ports without devices firstly and
> add the sys file for user to control?

Yes, I think so.  It will be less controversial and probably simpler.  
When that mechanism is ready, you should be able to use it
automatically for unconnectable ports.

One tricky thing: In theory, there should be a separate sysfs file for 
each port.  That seems like a lot of overhead though; is there any way 
to present the information in a single file that won't offend sysfs 
purists?

> > Makes sense.  (But I foresee a lot of confusion among users when this
> > box is checked and the ports don't get powered down -- many of
> > today's laptops are incapable of powering down their USB ports.)
> >
> How about to just provide sys files if the usb port can be power off
> and the checkbox only is selectable when sys files exit.

The problem is that the kernel doesn't know whether a port can be
powered off.  For some ports, you may be able to rely on platform
information like ACPI.  But for other ports, you simply can't tell.

> >> When we turn the power back on, we'll get a connect status change bit
> >> set.  We don't want the USB core to misinterpret that bit and try to
> >> logically disconnect the device attached to the port.
> >
> > All you have to do is turn off the connect-change status bit.  In fact,
> > the debounce routine does this already.  Just leave the port state set
> > to "off" until the connection is debounced.
> This is my original version. :)
> But after testing, I found that after the connection is debounced,
> hub_port_connect_change() may not to be invoked or not reach place
> "disconnect devices".
> 
> hub_port_connect_change() {
> ...
> /* debounce may be completed before here and port's state has becomed
>   * "on". The device also will be removed.
>   */	
> if (hub->port_data[port1 - 1].power_state == USB_PORT_POWER_STATE_OFF) {
> 	clear_bit(port1, hub->change_bits);
> 	return;
> }
> 	
> /* Disconnect any existing devices under this port */
> if (udev)
> 	usb_disconnect(&hub->port_data[port1-1].child);
> clear_bit(port1, hub->change_bits);
> 
> ...
> }

This doesn't matter.  Disconnections will be handled by 
usb_reset_and_verify_device(), when it is called by 
finish_port_resume().

> I spent a lot of time resolving the problem. At last, I found to add
> "waiting for connection" state to resolve the problem.
> 
> After power on the port, hub_irq() invokes kick_khubd() to deal with
> connect or enable change event. Connect debouncing does in the
> usb_port_resume() and  connect-change event is processed in hub_thread().
> It is hard to synchronize them and the port's state should be set to
> "on" after the connect-change event finishing.

I still don't see what the problem is.  They don't have to be
synchronized; all you need to do is make sure that the port's state
remains set to "off" until the debouncing is finished and you have
turned off the connect-change and enable-change features.

(In the future, synchronization may become more of a problem.  For
example, there could be trouble if hub_events() is already running when
a bit in hub->busy_bits gets turned on.  As far as I can tell, though, 
this doesn't affect you.)

> > You may also have to turn off the enable-change status bit.
> >
> You mean clear_port_feature(connect or enable change)?
>  From my opinion, this will be done in the hub_event() since
> hub is active and hub->quiescing should be 0 when the usb_port_resume()
> is invoking. Every portIs that right?

I don't know; it seems more likely that you'll have a problem when the 
power is turned off, not when it is turned on.  That's when the connect 
and enable status changes occur.

Alan Stern

