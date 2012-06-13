From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [Resend PATCH V3 3/4] usb/acpi: add the support of usb hub ports'
 acpi binding without attached devices.
Date: Wed, 13 Jun 2012 11:38:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206131136020.1401-100000@iolanthe.rowland.org>
References: <1339556840-2663-3-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339556840-2663-3-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 13 Jun 2012, Lan Tianyu wrote:

> The usb port is a device in the acpi table but it's not in the linux
> usb subsystem. USB hub port doesn't have struct device. So the acpi
> glue framework only can cover the usb port connected with usb device
> and store the acpi handle to struct device.archdata.acpi_handle. This
> patch is to add member port_acpi_handle in the struct usb_hub_port to
> store acpi handle. The acpi method "_UPC" and "_PLD" can be accessed
> without attached device.
> 
> v2
>  replace struct usb_hub_port member platform_data with member port_acpi_handle
> to store acpi_handle

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

> @@ -4933,3 +4941,37 @@ struct usb_device *usb_get_hub_child(struct usb_device *hdev,
>  }
>  EXPORT_SYMBOL_GPL(usb_get_hub_child);
>  
> +#ifdef CONFIG_ACPI
> +/**
> + * usb_set_hub_port_acpi_handle - Set the usb port's acpi handle
> + * @hdev: USB device belonging to the usb hub
> + * @port1: port num of the port
> + * @handle: port's acpi handle
> + */
> +void usb_set_hub_port_acpi_handle(struct usb_device *hdev, int port1,
> +	void *handle)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +
> +	if (port1 < 1 || port1 > hdev->maxchild)
> +		return;

You don't need this test.  The function gets called from only one 
place, so you know that port1 is valid.

> +	hub->port_data[port1 - 1].port_acpi_handle = handle;
> +}
> +
> +/**
> + * usb_get_hub_port_acpi_handle - Get the usb port's acpi handle
> + * @hdev: USB device belonging to the usb hub
> + * @port1: port num of the port
> + *
> + * Return port's acpi handle if successful, NULL if params are
> + * invaild.
> + */
> +acpi_handle usb_get_hub_port_acpi_handle(struct usb_device *hdev, int port1)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +
> +	if (port1 < 1 || port1 > hdev->maxchild)
> +		return NULL;

Same for this test.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
