From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 5/7] usb: move struct usb_device->children to struct
 usb_hub_port->child
Date: Tue, 17 Apr 2012 10:02:25 -0700
Message-ID: <20120417170225.GA4670@xanatos>
References: <1334642522-22021-1-git-send-email-tianyu.lan@intel.com>
 <1334642522-22021-6-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334642522-22021-6-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 17, 2012 at 02:02:00PM +0800, Lan Tianyu wrote:
> Move child's pointer to the struct usb_hub_port since the child device
> is directly associated with the port. Provide usb_get_hub_child_device()
> to get child's pointer.

It looks like you deleted the documentation for the children pointer
from usb_hub_port, but didn't actually remove the pointer from the
structure.  Did you mean to do that?

> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 73b68d1..1ea01a5 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -428,7 +428,6 @@ enum usb_device_removable {
>   *	access from userspace
>   * @usbfs_dentry: usbfs dentry entry for the device
>   * @maxchild: number of ports if hub
> - * @children: child devices - USB devices that are attached to this hub
>   * @quirks: quirks of the whole device
>   * @urbnum: number of URBs submitted for the whole device
>   * @active_duration: total time device is not suspended
> @@ -527,6 +526,8 @@ static inline struct usb_device *interface_to_usbdev(struct usb_interface *intf)
>  
>  extern struct usb_device *usb_get_dev(struct usb_device *dev);
>  extern void usb_put_dev(struct usb_device *dev);
> +extern struct usb_device *usb_get_hub_child_device(struct usb_device *hdev,
> +	int port1);
>  
>  /* USB device locking */
>  #define usb_lock_device(udev)		device_lock(&(udev)->dev)
> -- 
> 1.7.6.rc2.8.g28eb
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
