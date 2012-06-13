From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Resend PATCH V3 4/4] usb/acpi: add usb check for the connect
 type of usb port
Date: Wed, 13 Jun 2012 11:40:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206131138420.1401-100000@iolanthe.rowland.org>
References: <1339556840-2663-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57495 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754338Ab2FMPkC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jun 2012 11:40:02 -0400
In-Reply-To: <1339556840-2663-4-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Wed, 13 Jun 2012, Lan Tianyu wrote:

> Check the connect type of usb port when getting the usb port's
> acpi_handle and store result into connect_type in the struct
> usb_hub_port.
> 
> Accoding to ACPI Spec 9.13. PLD indicates whether usb port is
> user visible and _UPC indicates whether it is connectable. If
> the port was visible and connectable, it could be freely connected
> and disconnected with USB devices. If no visible and connectable,
> a usb device is directly hard-wired to the port. If no visible and
> no connectable, the port would be not used.
> 
> When a device was found on the port, if the connect_type was hot-plug,
> then the device would be removable. If the connect_type was hard-wired,
> the device would be non-removable.

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

> @@ -4941,6 +4942,49 @@ struct usb_device *usb_get_hub_child(struct usb_device *hdev,
>  }
>  EXPORT_SYMBOL_GPL(usb_get_hub_child);
>  
> +/**
> + * usb_set_hub_port_connect_type - set hub port connect type.
> + * @hdev: USB device belonging to the usb hub
> + * @port1: port num of the port
> + * @type: connect type of the port
> + *		USB_PORT_CONNECT_TYPE_UNKNOWN
> + *		USB_PORT_CONNECT_TYPE_HOT_PLUG
> + *		USB_PORT_CONNECT_TYPE_HARD_WIRED
> + *		USB_PORT_NOT_USED
> + */
> +void usb_set_hub_port_connect_type(struct usb_device *hdev, int port1,
> +	enum usb_port_connect_type type)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +
> +	if (port1 < 1 || port1 > hdev->maxchild)
> +		return;

You can remove this test.

> +	hub->port_data[port1 - 1].connect_type = type;
> +}
> +
> +/**
> + * usb_get_hub_port_connect_type - Get the port's connect
> + * type
> + * @hdev: USB device belonging to the usb hub
> + * @port1: port num of the port
> + *
> + * Return connect type of the port annd if input params are
> + *	invalid, return USB_PORT_CONNECT_TYPE_UNKNOWN.
> + *		USB_PORT_CONNECT_TYPE_UNKNOWN
> + *		USB_PORT_CONNECT_TYPE_HOT_PLUG
> + *		USB_PORT_CONNECT_TYPE_HARD_WIRED
> + *		USB_PORT_NOT_USED
> + */
> +enum usb_port_connect_type
> +usb_get_hub_port_connect_type(struct usb_device *hdev,	int port1)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +
> +	if (port1 < 1 || port1 > hdev->maxchild)
> +		return USB_PORT_CONNECT_TYPE_UNKNOWN;

And this test.

Alan Stern

