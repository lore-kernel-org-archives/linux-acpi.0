From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 3/3] usb : Add sysfs files to control usb port's
 power
Date: Mon, 28 May 2012 11:14:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205281109230.31801-100000@netrider.rowland.org>
References: <4FC30EBC.2010607@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:35598 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752411Ab2E1POS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 May 2012 11:14:18 -0400
In-Reply-To: <4FC30EBC.2010607@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Mon, 28 May 2012, Lan Tianyu wrote:

> >> port1_power_control has three options. "auto", "on" and "off"
> >> "auto" - if port without device, power off the port.
> >> "on" - port must be power on.
> >> "off" - port must be power off.
> >
> > Remind me again -- what's the point of the "auto" setting?  It doesn't
> > seem to mean anything as a port power state.
> >
> > That is, if you write "auto" to the sysfs file then the power will
> > remain on if it is already on and a device is plugged in, or it will go
> > off if it is already off or no device is plugged in.  Either way, it
> > won't remain at "auto" because once the power is off, there's no way to
> > tell when a new device gets plugged in.
> >
> > Given this, do the power_control and power_state files need to be
> > separate?
>  From my opinion, power_control determines the work pattern.
> Currently, we just consider port without device. When "auto", power off
> the port directly. For port with device, if the device was not in the suspend
> at that pointer, the power would remain on but it would power off when it was
> suspended. If the the device was in the suspend, "auto" means the device could
> be put into much lower state so the device need to resume and suspend again.

Okay, this is different from what you wrote above.  "auto" means power 
off the port whenever there is no device or the device is suspended 
(and wakeup isn't enabled).

> > No, no, no!  sysfs.c is meant for attributes that apply to all USB
> > devices.  Your new attributes apply only to hubs, so they don't belong
> > here.
> >
> > Furthermore, the attributes defined in sysfs.c go in the device's
> > sysfs directory, but your attributes belong in the hub's interface
> > directory.  That is, the files should go into
> > /sys/bus/usb/devices/1-0:1.0, not /sys/bus/usb/devices/usb1.
> >
> Ok. So I should put these code in the hub.c or create a hub-sysfs.c?

For now, put them into hub.c.  hub.c needs to be broken up into several 
files anyway.

> > And they probably don't belong in the power/ subdirectory either.  In
> > fact, you might want to create a separate subdirectory for each port
> > with one or two files in each subdirectory.
> Do you mean
> ls /sys/bus/usb/devices/1-0:1.0
> bAlternateSetting  bInterfaceClass  bInterfaceNumber  bInterfaceProtocol
> bInterfaceSubClass  bNumEndpoints  driver  ep_81  modalias  power
> subsystem  supports_autosuspend  uevent port1 port2 port3 port4
> 
> ls /sys/bus/usb/devices/1-0:1.0/port1
> power_control power_state
> ?

Yes.  Except that perhaps you can leave out the "power_" prefixes.

Alan Stern

