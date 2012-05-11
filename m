From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 16:20:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205111605560.1865-100000@iolanthe.rowland.org>
References: <4CFBC02C07DA244CA19D6815A05BE6EE0A6910@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47620 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754242Ab2EKUUs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 May 2012 16:20:48 -0400
In-Reply-To: <4CFBC02C07DA244CA19D6815A05BE6EE0A6910@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lan, Tianyu" <tianyu.lan@intel.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Fri, 11 May 2012, Lan, Tianyu wrote:

> On 2012/5/12 1:44, Alan Stern wrote:
> > On Sat, 12 May 2012, Lan Tianyu wrote:
> >>  From my opinion, ACPI will tell us whether the port is connectable or not.
> > ACPI will tell you about some ports, not others (for example, ACPI
> > knows nothing about the ports on hubs that the user plugs in).  On
> > other systems, a Device Tree database might provide the same
> > information.
> I think we can not power off ports on the hubs that the user plugs in.

You are wrong.  Some hubs do allow ports to be powered off.  Most 
don't, but some do.

> Power off needs platform support.

No, it doesn't.

>  So those port that can be power
> off must be on the motherboard and platform knows these ports.

> > The problem is that the kernel doesn't know whether a port can be
> > powered off.  For some ports, you may be able to rely on platform
> > information like ACPI.  But for other ports, you simply can't tell.
>   The same as previous. Platform should know all the port that
> Can be power off. These port must be on the motherboard.

See above.

> > This doesn't matter.  Disconnections will be handled by 
> > usb_reset_and_verify_device(), when it is called by 
> > finish_port_resume().
> This will cause the device to be re-enumerated. Just like
> unplugged and plugged a device. I think this is not what
> we want.

It is exactly what you want if the device really has been unplugged and 
was never plugged back in again.

>  Disconnect and create the same device. device
> num is also change.

Do you know what a "reset-resume" is?  See 
Documentation/usb/persist.txt.

> > I still don't see what the problem is.  They don't have to be
> > synchronized; all you need to do is make sure that the port's state
> > remains set to "off" until the debouncing is finished and you have
> > turned off the connect-change and enable-change features.
>     Do you mean during debouncing, the USB_PORT_FEAT_CONNECTION

USB_PORT_STAT_C_CONNECTION, not USB_PORT_FEAT_CONNECTION.

> will be clear. So the hub_irq() will not receive connect-change event?

No, hub_irq() definitely will receive events.  But so long as the
port's state remains set to "off", those events will be ignored.  You
should know, since you added code in the patch to do this!  :-)

And after the port's power state is changed to "on", the events won't 
do anything because the connect-change status will have been turned 
off.

> What I see is that during the deboucing, the connect-change event also
> will received. So there are two paths.  The usb_port_resume will set
> port state to "on". hub_port_connect_change() needs port state to
> determine whether disconnect device. If "on", disconnect device.
> If "off", return directly. They are in two threads. So how to make
> sure to set port state to "on" after hub_port_connect_change()
> make decision whether to disconnect device or not.
> 
>  usb_port_resume()
>         ||
>  power on the port
>         ||                                                          
>     deboucing                      connect change (connect status => on)
>         ||                                       ||
>    set port state "on"               hub_irq() kick_khub() (connect-change event received)
>                                                  ||
>                                           hub_thread() hub_event()
>                                            hub_port_connect_change()

Why is hub_port_connect_change() going to get called?  hub_event() 
doesn't call hub_port_connect_change() when it doesn't need to.
In this case it won't need to, because debouncing turns off the 
connect-change status.

Alan Stern

