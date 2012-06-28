From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V4 3/8] usb: move children to struct usb_port
Date: Thu, 28 Jun 2012 10:42:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206281030590.1752-100000@iolanthe.rowland.org>
References: <1340868702-1894-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50147 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753980Ab2F1Om5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2012 10:42:57 -0400
In-Reply-To: <1340868702-1894-4-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Thu, 28 Jun 2012, Lan Tianyu wrote:

> Move child's pointer to the struct usb_port since the child device
> is directly associated with the port. Provide usb_get_hub_child()
> to get child's pointer and macrio macro usb_get_hub_each_child to
> iterate all child devices on the hub.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>


> --- a/drivers/usb/core/devices.c
> +++ b/drivers/usb/core/devices.c

> @@ -589,14 +590,12 @@ static ssize_t usb_device_dump(char __user **buffer, size_t *nbytes,
>  	free_pages((unsigned long)pages_start, 1);
>  
>  	/* Now look at all of this device's children. */
> -	for (chix = 0; chix < usbdev->maxchild; chix++) {
> -		struct usb_device *childdev = usbdev->children[chix];
> -
> +	usb_get_hub_each_child(usbdev, chix, childdev) {
>  		if (childdev) {
>  			usb_lock_device(childdev);
>  			ret = usb_device_dump(buffer, nbytes, skip_bytes,
>  					      file_offset, childdev, bus,
> -					      level + 1, chix, ++cnt);
> +					      level + 1, chix - 1, ++cnt);
>  			usb_unlock_device(childdev);

You forget to add usb_put_dev(childdev).

>  			if (ret == -EFAULT)
>  				return total_written;

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

> @@ -1784,11 +1783,12 @@ bool usb_device_is_owned(struct usb_device *udev)
>  
>  static void recursively_mark_NOTATTACHED(struct usb_device *udev)
>  {
> +	struct usb_hub *hub = hdev_to_hub(udev);

This is dangerous, because at this point you don't know whether udev is
a hub -- it might not be -- and hdev_to_hub can crash if its argument
isn't a hub.  Instead you should do:

	struct usb_hub *hub;

	if (udev->maxchild > 0)
		hub = hdev_to_hub(udev);

Or if you prefer, add the "hdev->maxchild > 0" test into hdev_to_hub 
itself.

> @@ -1952,6 +1952,7 @@ static void hub_free_dev(struct usb_device *udev)
>  void usb_disconnect(struct usb_device **pdev)
>  {
>  	struct usb_device	*udev = *pdev;
> +	struct usb_hub		*hub = hdev_to_hub(udev);

Same here.

> @@ -4965,3 +4966,27 @@ void usb_queue_reset_device(struct usb_interface *iface)
>  	schedule_work(&iface->reset_ws);
>  }
>  EXPORT_SYMBOL_GPL(usb_queue_reset_device);
> +
> +/**
> + * usb_get_hub_child - Get the pointer of child device
> + * attached to the port which is specified by @port1.
> + * @hdev: USB device belonging to the usb hub
> + * @port1: port num to indicate which port the child device
> + *	is attached to.
> + *
> + * USB drivers call this function to get hub's child device
> + * pointer.
> + *
> + * Return NULL if input param is invalid and
> + * child's usb_device pointer if non-NULL.

The kerneldoc should mention that this routine increments the child's
reference count and the caller must call usb_put_dev() when it
is finished using the child.

Also, I think it would be better if the function were named
"usb_hub_get_child".

> + */
> +struct usb_device *usb_get_hub_child(struct usb_device *hdev,
> +		int port1)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +
> +	if (port1 < 1 || port1 > hdev->maxchild)
> +		return NULL;
> +	return usb_get_dev(hub->ports[port1 - 1]->child);
> +}

> --- a/drivers/usb/host/r8a66597-hcd.c
> +++ b/drivers/usb/host/r8a66597-hcd.c
> @@ -2033,17 +2033,18 @@ static int r8a66597_get_frame(struct usb_hcd *hcd)
>  static void collect_usb_address_map(struct usb_device *udev, unsigned long *map)
>  {
>  	int chix;
> +	struct usb_device *childdev;
>  
>  	if (udev->state == USB_STATE_CONFIGURED &&
>  	    udev->parent && udev->parent->devnum > 1 &&
>  	    udev->parent->descriptor.bDeviceClass == USB_CLASS_HUB)
>  		map[udev->devnum/32] |= (1 << (udev->devnum % 32));
>  
> -	for (chix = 0; chix < udev->maxchild; chix++) {
> -		struct usb_device *childdev = udev->children[chix];
> -
> -		if (childdev)
> +	usb_get_hub_each_child(udev, chix, childdev) {
> +		if (childdev) {
> +			usb_put_dev(childdev);
>  			collect_usb_address_map(childdev, map);

The usb_put_dev should come _after_ the collect_usb_address_map call.
Otherwise you're passing a stale pointer.

> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h

> @@ -567,6 +565,20 @@ static inline struct usb_device *interface_to_usbdev(struct usb_interface *intf)
>  
>  extern struct usb_device *usb_get_dev(struct usb_device *dev);
>  extern void usb_put_dev(struct usb_device *dev);
> +extern struct usb_device *usb_get_hub_child(struct usb_device *hdev,
> +	int port1);
> +
> +/**
> + * usb_get_hub_each_child - iterate over all child devices on the hub
> + * @hdev:  USB device belonging to the usb hub
> + * @port1: portnum associated with child device
> + * @child: child device pointer
> + *

Mention that the caller must call usb_put_dev() when it is finished
using the child.

And change the name to "usb_hub_get_each_child".

Alan Stern

