From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/3] usb/acpi: add the support of usb hub ports' acpi
 binding without attached devices.
Date: Mon, 14 May 2012 09:58:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205140957230.1699-100000@iolanthe.rowland.org>
References: <1337001268-3100-2-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49159 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756770Ab2ENN6y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 May 2012 09:58:54 -0400
In-Reply-To: <1337001268-3100-2-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Mon, 14 May 2012, Lan Tianyu wrote:

> The usb port is a device in the acpi table but it's not in the linux
> usb subsystem. USB hub port doesn't have struct device. So the acpi
> glue framework only can cover the usb port connected with usb device
> and store the acpi handle to struct device.archdata.acpi_handle. This
> patch is to add member port_acpi_handle in the struct usb_hub_port to
> store acpi handle. The acpi method "_UPC" and "_PLD" can be accessed
> without attached device.

> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -83,7 +83,16 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
>  	if (!parent_handle)
>  		return -ENODEV;
>  
> -	*handle = acpi_get_child(parent_handle, udev->portnum);
> +	/**
> +	 * The root hub's acpi handle is got from acpi method.
> +	 * Other device's acpi handle can be got from the usb hub
> +	 * port's platform_data.
> +	 */

The /** pattern is reserved for kerneldoc comments, which appear only 
at the start of a function.  Within a function you should use the 
normal /* comment pattern.

Alan Stern

