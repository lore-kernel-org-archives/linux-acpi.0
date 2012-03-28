From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 5/5] usb/acpi: add usb check for the connect type of usb
 port
Date: Wed, 28 Mar 2012 15:40:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203281534430.1599-100000@iolanthe.rowland.org>
References: <1332917353-28123-6-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1332917353-28123-6-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sarah.a.sharp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 28 Mar 2012, Lan Tianyu wrote:

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

> @@ -4186,3 +4187,27 @@ int usb_get_hub_port_platform_data(struct usb_device *hdev, int port1,
>  	*data = hub->port_data[port1 - 1].platform_data;
>  	return 0;
>  }
> +
> +int usb_set_hub_port_connect_type(struct usb_device *hdev, int port1,
> +	enum usb_port_connect_type type)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +
> +	if (port1 > hdev->maxchild || port1 < 1)
> +		return -EINVAL;
> +
> +	hub->port_data[port1 - 1].connect_type = type;
> +	return 0;
> +}
> +
> +int usb_get_hub_port_connect_type(struct usb_device *hdev, int port1,
> +	enum usb_port_connect_type *type)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +
> +	if (port1 > hdev->maxchild || port1 < 1)
> +		return -EINVAL;
> +
> +	*type = hub->port_data[port1 - 1].connect_type;
> +	return 0;
> +}

Once again, you should return void or the data value, not an error
code.

> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c

> +	if (upc->package.elements[0].integer.value && pld.user_visible)
> +		usb_set_hub_port_connect_type(hdev, port1,
> +			USB_PORT_CONNECT_TYPE_HOT_PLUG);
> +	else if (upc->package.elements[0].integer.value && !pld.user_visible)
> +		usb_set_hub_port_connect_type(hdev, port1,
> +			USB_PORT_CONNECT_TYPE_HARD_WIRED);
> +	else if (!upc->package.elements[0].integer.value && !pld.user_visible)
> +		usb_set_hub_port_connect_type(hdev, port1, USB_PORT_NOT_USED);

The logic here could be improved:

	if (upc->package.elements[0].integer.value)
		usb_set_hub_port_connect_type(hdev, port1,
				pld.user_visible ?
					USB_PORT_CONNECT_TYPE_HOT_PLUG :
					USB_PORT_CONNECT_TYPE_HARD_WIRED);
	else if (!pld.user_visible)
		usb_set_hub_port_connect_type(hdev, port1, USB_PORT_NOT_USED);


> +	usb_get_hub_port_connect_type(udev->parent, udev->portnum, &type);
> +
> +	if (type == USB_PORT_CONNECT_TYPE_HOT_PLUG)
> +		udev->removable = USB_DEVICE_REMOVABLE;
> +	else if (type == USB_PORT_CONNECT_TYPE_HARD_WIRED)
> +		udev->removable = USB_DEVICE_FIXED;

This should be a switch statement, and it should handle the other
possible values of type.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
