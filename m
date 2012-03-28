From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/5] usb: move struct usb_device->children to struct
 usb_hub_port->child
Date: Wed, 28 Mar 2012 15:13:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203281502450.1599-100000@iolanthe.rowland.org>
References: <1332917353-28123-3-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34469 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753077Ab2C1TNr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Mar 2012 15:13:47 -0400
In-Reply-To: <1332917353-28123-3-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@intel.com, mjg@redhat.com

On Wed, 28 Mar 2012, Lan Tianyu wrote:

> Move child's pointer to the struct usb_hub_port since the child device
> is directly associated with the port. Provide usb_get_hub_child_device()
> to get child's pointer.

> --- a/drivers/usb/core/devices.c
> +++ b/drivers/usb/core/devices.c
> @@ -590,7 +590,9 @@ static ssize_t usb_device_dump(char __user **buffer, size_t *nbytes,
>  
>  	/* Now look at all of this device's children. */
>  	for (chix = 0; chix < usbdev->maxchild; chix++) {
> -		struct usb_device *childdev = usbdev->children[chix];
> +		struct usb_device *childdev;
> +		if (usb_get_hub_child_device(usbdev, chix + 1, &childdev) < 0)
> +			continue;
>  

Whitespace issue: The blank line should come before the new executable 
statement, not after it.

> @@ -1475,11 +1477,12 @@ bool usb_device_is_owned(struct usb_device *udev)
>  
>  static void recursively_mark_NOTATTACHED(struct usb_device *udev)
>  {
> +	struct usb_hub	*hub = hdev_to_hub(udev);

I'm not sure this is good.  You are calling hdev_to_hub without knowing
beforehand that udev really is a hub -- in fact, most of the time udev
won't be a hub.  The routine wasn't meant to be used that way.  Have
you checked that hdev_to_hub won't crash when the argument isn't a hub?  
What happens if the active configuration has no interfaces?

> @@ -4147,3 +4151,15 @@ void usb_queue_reset_device(struct usb_interface *iface)
>  	schedule_work(&iface->reset_ws);
>  }
>  EXPORT_SYMBOL_GPL(usb_queue_reset_device);
> +
> +int usb_get_hub_child_device(struct usb_device *hdev, int port1,
> +	struct usb_device **child)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +
> +	if (port1 > hdev->maxchild || port1 < 1)
> +		return -EINVAL;
> +	*child = hub->port_data[port1 - 1].child;
> +	return 0;
> +}

This new routine is more complicated that it needs to be.  You don't
have to return an error code; none of the callers make use of it.
Just return the child pointer, and return NULL if there's an error.

Alan Stern

