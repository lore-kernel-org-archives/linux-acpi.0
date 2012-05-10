From: Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Thu, 10 May 2012 14:19:38 -0500
Message-ID: <1336677578.6463.5.camel@dcbw.foobar.com>
References: <Pine.LNX.4.44L0.1205101136470.1831-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1205101136470.1831-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2012-05-10 at 11:54 -0400, Alan Stern wrote:
> On Thu, 10 May 2012, Lan Tianyu wrote:
> 
> > hi all:
> > 	Currently, we are working on usb port power off mechanism. Our developing
> > machine provides usb port power control (a vbus switch)via ACPI power resource.
> > When the power resource turns off, usb port powers off and usb device loses
> > power. From usb hub side, just like the device being unplugged.
> > 
> > 	Since usb port power off will affect hot-plug and devices remote wakeup
> > function, it should be careful to do that.
> > 	We conclude three different situations for power off mechanism.
> > 	(1) hard-wired port with device
> > 	(2) hot-pluggable port without device
> > 	(3) hot-pluggable port with device
> > 
> > For hard-wired port, the device will not be removed physically. So we can
> > power off it when device is suspended and remote wakeup is disabled without
> > concerning with hot-plug. This patch is dedicated to this siutation.
> > 
> > This patch is to provide usb acpi power control method and call them in the
> > usb_port_suspend() and usb_port_resume() when port can be power off. When the
> > usb port is in the power off state, usb core doesn't remove device which is
> > attached to the port. The device is still on the system and user can access
> > the device.
> 
> Can you provide any examples where this would be useful?  It won't end 
> up saving very much power (although on a laptop even a little bit might 
> help).

I'd love to do this with ModemManager to shoot a modem in the head if
it's crashed.  Right now there's simply no way to reset a device that's
misbehaving or crashed.  Powering off the port would be a last resort,
but not all devices actually disconnect from the bus when they crash and
reconnect after the firmware reboots.

Dan

> > introduce three port's states.
> > 
> > USB_PORT_POWER_STATE_ON
> > USB_PORT_WAITING_FOR_CONNECTION
> > USB_PORT_POWER_STATE_OFF
> > 
> > "on"
> > 	port power on
> > 
> > "waiting for connection"
> > 	port power on but hub port has not detected the device or detect event has
> > not been processed.
> 
> This state is not needed.
> 
> > "off"
> > 	port power off
> > 
> > At first, port's state is "on". When the device is suspended, power off the port and
> > set port's state to "off". After the port powering off, the usb hub will detect a
> > connection change event. Normally, the device will be removed with regarding as being
> > unplugged. But in the power off mechanism, the device is still on the port and user
> > can still access the device. So ignore the event.
> > 
> > When the device is resumed, turn on the power resource and set port's state to
> > "waiting for connection". After the port powering on, the usb hub will detect a
> > connection change event which originally means a device plugged in and previous
> > device will be removed. But in the power offmechanism, the device is not changed
> > and so ignore the event. When port's state is "waiting for connection", receive
> > an event "connection" and the port's connection state is on. This means the usb
> > the device is detected by usb hub again after powering on port. Set port's state
> > to "on".
> > 
> >  "on"
> >   |
> >  "off"
> >   |
> >  "waiting for connection"
> >   |
> >  "on"
> > 
> > "waiting for connection" state is to avoid device to being removed.
> 
> Why would the device be removed?
> 
> > If set to "on" after powering on, the connection event may not be processed at that
> > time. When it is processed, the port's state has been "on" and the device will be
> > removed. So introduce "waiting for connection" state.
> 
> Instead you should simply delay setting the state back to "on" until
> the device has connected.
> 
> > We also have a proposal to add sys file for each port to control port power off
> > under usb hub sys directory. If the port's power off is supported by platform,
> > create a sys file e.g "port1_power"  for port one. Echo "on" to "port1_power" is
> > to not allow port to be power off. Echo "auto" to "port1_power" is to power off
> > port if possible.
> > 
> > Different type ports have different default values.
> > (1) hard-wired port with device				"auto"
> > (2) hot-pluggable port without device		"on"
> > (3) hot-pluggable port with device			"on"
> > 
> > Add member port_power_control, can_power_off  to struct usb_hub_port. port_power_control
> > records user choice. Can_power_off means the platform and device support to power off.
> > When a device is attached, check whether port can be power off if yes set can_power_off
> > to true. When device driver is load, the driver also can set value to can_power_off. When
> 
> That's no good.  What happens if the driver sets the value to false and 
> then the driver is unloaded?
> 
> > try to power off port, can_power_off and port_power_control should be taken into account.
> > Only when these two members  are set to true, the port could be power off.
> > 
> > sys file operation
> > port with device
> >  port1_power "auto" => "on" or "on" => "auto" implement
> > 	pm_runtime_get_syn(udev)
> > 	port_power_control = "auto" or "on"
> > 	pm_runtime_put_syn(udev)
> > 
> > port without device
> > 	port can power on or power power off directly.
> 
> We have no code for powering off ports that don't have a device.  If 
> you did power off such a port, it would not be able to detect when a 
> device was plugged in.
> 
> > Suggestion and comments more welcome.
> 
> Your code style for continuation lines is wrong.  Continuation lines 
> should be indented more than one tab stop -- otherwise they look like 
> regular lines in an inner block.
> 
> Alan Stern
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
