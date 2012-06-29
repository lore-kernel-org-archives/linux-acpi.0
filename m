From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH V5 5/8] usb/acpi: add check for the connect type of usb
 port
Date: Fri, 29 Jun 2012 10:06:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206291004060.1638-100000@iolanthe.rowland.org>
References: <1340950799-3321-5-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340950799-3321-5-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 29 Jun 2012, Lan Tianyu wrote:

> Change since v4: Remove some redundant kerneldocs and fix typo.
> 
> Change since v3: Rebase on the patch "make usb port a real device"
> 
> Check the connect type of usb port when getting the usb port's
> acpi_handle and store result into connect_type in the struct
> usb_port.
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
> 
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> +/**
> + * usb_get_hub_port_connect_type - Get the port's connect
> + * type

Don't break the line like that.

> + * @hdev: USB device belonging to the usb hub
> + * @port1: port num of the port
> + *
> + * Return connect type of the port and if input params are
> + *	invalid, return USB_PORT_CONNECT_TYPE_UNKNOWN.
> + */
> +enum usb_port_connect_type
> +usb_get_hub_port_connect_type(struct usb_device *hdev,	int port1)

Tab instead of a space.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
