From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/4] usb: Bind devices to ACPI devices when possible
Date: Mon, 12 Mar 2012 16:38:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203121631230.1216-100000@iolanthe.rowland.org>
References: <1331596735-3690-3-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58158 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756383Ab2CLUi6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Mar 2012 16:38:58 -0400
In-Reply-To: <1331596735-3690-3-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org

On Mon, 12 Mar 2012, Matthew Garrett wrote:

> Built-in USB devices will typically have a representation in the system
> ACPI tables. Add support for binding the two together so the USB code can
> make use of the associated methods.

> +static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
> +{
> +	struct usb_device *udev = to_usb_device(dev);
> +	struct device *parent = dev->parent;
> +	acpi_handle *parent_handle = DEVICE_ACPI_HANDLE(parent);
> +
> +	if (!parent_handle)
> +		return -ENODEV;
> +
> +	*handle = acpi_get_child(parent_handle, udev->portnum);
> +
> +	if (!*handle)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static struct acpi_bus_type usb_acpi_bus = {
> +	.bus = &usb_bus_type,
> +	.find_bridge = NULL,
> +	.find_device = usb_acpi_find_device,
> +};

I don't understand exactly how this is supposed to work.  Does this 
mean that the ACPI core will call usb_acpi_find_device() for every ACPI 
device whose underlying real device is registered on the usb_bus_type?  
If so, when does this call take place?

Or does it work some other way?

Bear in mind that USB devices aren't the only things registered with 
usb_bus_type.  We also register device structures representing USB 
interfaces and endpoints.  Hence the to_usb_device() call above might 
not always do what you want.

Alan Stern

