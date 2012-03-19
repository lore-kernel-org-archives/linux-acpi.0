From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 3/4] usb/acpi: add the support of usb hub ports' acpi
 binding without attached devices.
Date: Mon, 19 Mar 2012 12:10:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203191207120.1641-100000@iolanthe.rowland.org>
References: <1332167626-5806-3-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38062 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030655Ab2CSQKY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2012 12:10:24 -0400
In-Reply-To: <1332167626-5806-3-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, mjg@redhat.com, linux-usb@vger.kernel.org, sarah.a.sharp@intel.com

On Mon, 19 Mar 2012, Lan Tianyu wrote:

> The usb port is a device in the acpi table but it's not in the linux
> usb subsystem. USB hub port doesn't have struct device. So the acpi
> glue framework only can cover the usb port connected with usb device
> and store the acpi handle to struct device.archdata.acpi_handle. This
> patch gets the hub port's acpi_handle and store it in the port's platform_data
> to resolve no attached device no binding problem. The acpi method "_UPC"
> and "_PLD" can be accessed without attached device.

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -1238,6 +1238,7 @@ static int hub_configure(struct usb_hub *hub,
>  		hub->indicator [0] = INDICATOR_CYCLE;
>  
>  	hub_activate(hub, HUB_INIT);
> +	usb_acpi_bind_hub_ports(hdev, hub->descriptor->bNbrPorts);

Use hdev->maxchild instead of hub->descriptor->bNbrPorts.

> @@ -105,6 +114,33 @@ static struct acpi_bus_type usb_acpi_bus = {
>  	.find_device = usb_acpi_find_device,
>  };
>  
> +int usb_acpi_bind_hub_ports(struct usb_device *hdev, int portnum)

Don't pass portnum as an argument; use hdev->maxchild instead.

> +{
> +	acpi_handle hub_handle = NULL;
> +	acpi_handle port_handle = NULL;
> +	struct device *dev = &hdev->dev;
> +	int i;
> +
> +	hub_handle = DEVICE_ACPI_HANDLE(dev);
> +	if (!hub_handle)
> +		return -ENODEV;
> +
> +	/**
> +	 * The usb hub port is not a device in the usb subsystem but it is a device
> +	 * in the acpi table. Store it's acpi handle in the platform data of usb

s/it's/its/

"its" is a possessive pronoun, but "it's" is a contraction of "it is" 
or "it has".

Alan Stern

