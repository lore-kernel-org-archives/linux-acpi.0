From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Thu, 10 May 2012 11:54:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205101136470.1831-100000@iolanthe.rowland.org>
References: <1336638838-6157-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57437 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755931Ab2EJPyG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 May 2012 11:54:06 -0400
In-Reply-To: <1336638838-6157-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Thu, 10 May 2012, Lan Tianyu wrote:

> hi all:
> 	Currently, we are working on usb port power off mechanism. Our developing
> machine provides usb port power control (a vbus switch)via ACPI power resource.
> When the power resource turns off, usb port powers off and usb device loses
> power. From usb hub side, just like the device being unplugged.
> 
> 	Since usb port power off will affect hot-plug and devices remote wakeup
> function, it should be careful to do that.
> 	We conclude three different situations for power off mechanism.
> 	(1) hard-wired port with device
> 	(2) hot-pluggable port without device
> 	(3) hot-pluggable port with device
> 
> For hard-wired port, the device will not be removed physically. So we can
> power off it when device is suspended and remote wakeup is disabled without
> concerning with hot-plug. This patch is dedicated to this siutation.
> 
> This patch is to provide usb acpi power control method and call them in the
> usb_port_suspend() and usb_port_resume() when port can be power off. When the
> usb port is in the power off state, usb core doesn't remove device which is
> attached to the port. The device is still on the system and user can access
> the device.

Can you provide any examples where this would be useful?  It won't end 
up saving very much power (although on a laptop even a little bit might 
help).

> introduce three port's states.
> 
> USB_PORT_POWER_STATE_ON
> USB_PORT_WAITING_FOR_CONNECTION
> USB_PORT_POWER_STATE_OFF
> 
> "on"
> 	port power on
> 
> "waiting for connection"
> 	port power on but hub port has not detected the device or detect event has
> not been processed.

This state is not needed.

> "off"
> 	port power off
> 
> At first, port's state is "on". When the device is suspended, power off the port and
> set port's state to "off". After the port powering off, the usb hub will detect a
> connection change event. Normally, the device will be removed with regarding as being
> unplugged. But in the power off mechanism, the device is still on the port and user
> can still access the device. So ignore the event.
> 
> When the device is resumed, turn on the power resource and set port's state to
> "waiting for connection". After the port powering on, the usb hub will detect a
> connection change event which originally means a device plugged in and previous
> device will be removed. But in the power offmechanism, the device is not changed
> and so ignore the event. When port's state is "waiting for connection", receive
> an event "connection" and the port's connection state is on. This means the usb
> the device is detected by usb hub again after powering on port. Set port's state
> to "on".
> 
>  "on"
>   |
>  "off"
>   |
>  "waiting for connection"
>   |
>  "on"
> 
> "waiting for connection" state is to avoid device to being removed.

Why would the device be removed?

> If set to "on" after powering on, the connection event may not be processed at that
> time. When it is processed, the port's state has been "on" and the device will be
> removed. So introduce "waiting for connection" state.

Instead you should simply delay setting the state back to "on" until
the device has connected.

> We also have a proposal to add sys file for each port to control port power off
> under usb hub sys directory. If the port's power off is supported by platform,
> create a sys file e.g "port1_power"  for port one. Echo "on" to "port1_power" is
> to not allow port to be power off. Echo "auto" to "port1_power" is to power off
> port if possible.
> 
> Different type ports have different default values.
> (1) hard-wired port with device				"auto"
> (2) hot-pluggable port without device		"on"
> (3) hot-pluggable port with device			"on"
> 
> Add member port_power_control, can_power_off  to struct usb_hub_port. port_power_control
> records user choice. Can_power_off means the platform and device support to power off.
> When a device is attached, check whether port can be power off if yes set can_power_off
> to true. When device driver is load, the driver also can set value to can_power_off. When

That's no good.  What happens if the driver sets the value to false and 
then the driver is unloaded?

> try to power off port, can_power_off and port_power_control should be taken into account.
> Only when these two members  are set to true, the port could be power off.
> 
> sys file operation
> port with device
>  port1_power "auto" => "on" or "on" => "auto" implement
> 	pm_runtime_get_syn(udev)
> 	port_power_control = "auto" or "on"
> 	pm_runtime_put_syn(udev)
> 
> port without device
> 	port can power on or power power off directly.

We have no code for powering off ports that don't have a device.  If 
you did power off such a port, it would not be able to detect when a 
device was plugged in.

> Suggestion and comments more welcome.

Your code style for continuation lines is wrong.  Continuation lines 
should be indented more than one tab stop -- otherwise they look like 
regular lines in an inner block.

Alan Stern

