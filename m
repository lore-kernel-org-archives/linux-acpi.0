From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V4 8/8] usb : Add usb port's power control attributes
Date: Thu, 28 Jun 2012 10:58:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206281048110.1752-100000@iolanthe.rowland.org>
References: <1340868702-1894-9-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50165 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751642Ab2F1O6u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2012 10:58:50 -0400
In-Reply-To: <1340868702-1894-9-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Thu, 28 Jun 2012, Lan Tianyu wrote:

> This patch is to add two attributes for each usb hub ports to control port's power.
> Control port's power through setting or clearing PORT_POWER feature.
> 
> control has two options. "auto", "on" and "off"
> "on" - port power must be on.
> "off" - port power must be off.
> 
> state reports usb port's power state
> "on" - power on
> "off" - power off
> "error" - can't get power state
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

> @@ -848,7 +858,9 @@ static unsigned hub_power_on(struct usb_hub *hub, bool do_delay)
>  		dev_dbg(hub->intfdev, "trying to enable port power on "
>  				"non-switchable hub\n");
>  	for (port1 = 1; port1 <= hub->descriptor->bNbrPorts; port1++)
> -		set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
> +		if (hub->ports[port1 - 1]->port_power_policy
> +				== USB_PORT_POWER_ON)
> +			set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);

Since the last patch version, I realized that sometimes host controller
drivers will turn on port power by themselves.  To be safe, you should add

		else
			clear_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);


> +static ssize_t
> +store_port_power_control(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)

Since you have to break the line anyway, you ought to put the function's
name on the first line.

> +{
> +	struct usb_device *hdev = to_usb_device(dev->parent->parent);
> +	struct usb_port *hub_port = to_usb_port(dev);
> +	int port1, len = count;
> +	char *cp;
> +
> +	sscanf(dev_name(dev), "port%d", &port1);
> +	cp = memchr(buf, '\n', count);
> +	if (cp)
> +		len = cp - buf;
> +	if (len == sizeof on_string - 1
> +		&& strncmp(buf, on_string, len) == 0) {
> +		hub_port->port_power_policy = USB_PORT_POWER_ON;
> +		set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
> +	} else if (len == sizeof off_string - 1
> +		&& strncmp(buf, off_string, len) == 0) {
> +		hub_port->port_power_policy = USB_PORT_POWER_OFF;
> +		clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);

You should return -EIO if set_port_feature or clear_port_feature fails.

Alan Stern

