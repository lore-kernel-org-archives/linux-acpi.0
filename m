From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 3/3] usb : Add sysfs files to control usb port's
 power
Date: Fri, 25 May 2012 11:41:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205251127180.1907-100000@iolanthe.rowland.org>
References: <1337924882-17332-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57888 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751305Ab2EYPly (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 May 2012 11:41:54 -0400
In-Reply-To: <1337924882-17332-4-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Fri, 25 May 2012, Lan Tianyu wrote:

> This patch is to add two sys files for each usb hub ports to control port's power,
> e.g port1_power_control and port1_power_state both for port one. Control port's
> power through setting or clearing PORT_POWER feature.
> 
> port1_power_control has three options. "auto", "on" and "off"
> "auto" - if port without device, power off the port.
> "on" - port must be power on.
> "off" - port must be power off.

Remind me again -- what's the point of the "auto" setting?  It doesn't 
seem to mean anything as a port power state.

That is, if you write "auto" to the sysfs file then the power will
remain on if it is already on and a device is plugged in, or it will go
off if it is already off or no device is plugged in.  Either way, it
won't remain at "auto" because once the power is off, there's no way to
tell when a new device gets plugged in.

Given this, do the power_control and power_state files need to be
separate?

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

> @@ -4985,6 +4992,37 @@ usb_get_hub_port_connect_type(struct usb_device *hdev,	int port1)
>  	return hub->port_data[port1 - 1].connect_type;
>  }
>  
> +enum port_power_policy
> +usb_get_hub_port_power_policy(struct usb_device *hdev, int port1)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +	return hub->port_data[port1 - 1].port_power_policy;
> +}
> +
> +void usb_set_hub_port_power_policy(struct usb_device *hdev, int port1,
> +	enum port_power_policy value)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +	hub->port_data[port1 - 1].port_power_policy = value;
> +}

I suspect these routines aren't needed at all.

> +void usb_set_hub_port_power(struct usb_device *hdev, int port1, bool enabled)
> +{
> +	if (enabled)
> +		set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
> +	else
> +		clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
> +}
> +
> +int usb_get_hub_port_power_state(struct usb_device *hdev, int port1)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +	u16 portstatus, portchange;
> +
> +	hub_port_status(hub, port1, &portstatus, &portchange);

Use get_port_status(), not hub_port_status().

> +	return port_is_power_on(hub, portstatus);
> +}

These routines don't belong here at the end of the file.  They belong
near the start, close to set_port_feature() and get_port_status().


> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c

No, no, no!  sysfs.c is meant for attributes that apply to all USB
devices.  Your new attributes apply only to hubs, so they don't belong
here.

Furthermore, the attributes defined in sysfs.c go in the device's
sysfs directory, but your attributes belong in the hub's interface
directory.  That is, the files should go into
/sys/bus/usb/devices/1-0:1.0, not /sys/bus/usb/devices/usb1.

And they probably don't belong in the power/ subdirectory either.  In
fact, you might want to create a separate subdirectory for each port
with one or two files in each subdirectory.

Alan Stern

