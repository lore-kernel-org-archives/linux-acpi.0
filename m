From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 4/5] usb/acpi: add the support of usb hub ports' acpi
 binding without attached devices.
Date: Wed, 28 Mar 2012 15:31:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203281516451.1599-100000@iolanthe.rowland.org>
References: <1332917353-28123-5-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34492 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758027Ab2C1TbH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Mar 2012 15:31:07 -0400
In-Reply-To: <1332917353-28123-5-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@intel.com, mjg@redhat.com

On Wed, 28 Mar 2012, Lan Tianyu wrote:

> The usb port is a device in the acpi table but it's not in the linux
> usb subsystem. USB hub port doesn't have struct device. So the acpi
> glue framework only can cover the usb port connected with usb device
> and store the acpi handle to struct device.archdata.acpi_handle. This
> patch gets the hub port's acpi_handle and store it in the port's platform_data
> to resolve no attached device no binding problem. The acpi method "_UPC"
> and "_PLD" can be accessed without attached device.

You can merge this patch with the previous one.  As it stands now, the 
previous patch adds new routines but no callers.

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index ac7bd89..97b8993 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -1239,6 +1239,7 @@ static int hub_configure(struct usb_hub *hub,
>  		hub->indicator [0] = INDICATOR_CYCLE;
>  
>  	hub_activate(hub, HUB_INIT);
> +	usb_acpi_bind_hub_ports(hdev);
>  	return 0;

You probably should put usb_acpi_bind_hub_ports before hub_activate 
instead of after.  The hub can start to operate as soon as hub_activate 
runs.

> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -82,7 +82,16 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
>  	if (!parent_handle)
>  		return -ENODEV;
>  
> -	*handle = acpi_get_child(parent_handle, udev->portnum);
> +	/**
> +	 * The root hub's acpi handle is got from acpi method.
> +	 * Other device's acpi handle can be got from the usb hub
> +	 * port's platform_data.
> +	 */
> +	if (!udev->parent)
> +		*handle = acpi_get_child(parent_handle, udev->portnum);
> +	else
> +		usb_get_hub_port_platform_data(udev->parent, udev->portnum,
> +			(unsigned long *)handle);
>  
>  	if (!*handle)

What happens if usb_get_hub_port_platform_data returns an error?  You 
don't check the error code, and then handle never gets assigned any 
value.  So the test "if (!*handle)" won't work right.

Instead of returning an error code, make usb_get_hub_port_platform_data 
return the data directly.

>  		return -ENODEV;
> @@ -105,6 +114,33 @@ static struct acpi_bus_type usb_acpi_bus = {
>  	.find_device = usb_acpi_find_device,
>  };
>  
> +int usb_acpi_bind_hub_ports(struct usb_device *hdev)
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
> +	 * in the acpi table. Store its acpi handle in the platform data of usb
> +	 * hub port.
> +	 */
> +	for (i = 1; i <= hdev->maxchild; i++) {
> +		port_handle = acpi_get_child(hub_handle, i);
> +		if (!port_handle)
> +			continue;
> +		if (usb_set_hub_port_platform_data(hdev, i,
> +				(unsigned long)port_handle) < 0)
> +			return -ENODEV;

Similarly, make usb_set_hub_port_platform_data return void.  There's no 
reason to check for errors here; they can never happen.

Alan Stern

