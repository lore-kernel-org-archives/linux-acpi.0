From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2 2/4] usb: move struct usb_device->children to struct
 usb_hub_port->child
Date: Fri, 30 Mar 2012 12:08:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203301201250.1280-100000@iolanthe.rowland.org>
References: <1333099617-11019-3-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51111 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751832Ab2C3QIk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2012 12:08:40 -0400
In-Reply-To: <1333099617-11019-3-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com, mjg@redhat.com

On Fri, 30 Mar 2012, Lan Tianyu wrote:

> Move child's pointer to the struct usb_hub_port since the child device
> is directly associated with the port. Provide usb_get_hub_child_device()
> to get child's pointer.

> --- a/drivers/staging/usbip/usbip_common.c
> +++ b/drivers/staging/usbip/usbip_common.c
> @@ -158,7 +158,7 @@ static void usbip_dump_usb_device(struct usb_device *udev)
>  		udev->have_langid, udev->string_langid);
>  
>  	dev_dbg(dev, "maxchild %d, children %p\n",
> -		udev->maxchild, udev->children);
> +		udev->maxchild, usb_get_hub_child_device(udev, udev->devnum));

This changes the meaning of the statement; it will print the address of 
the first child rather than the address of the array of children.  You 
might as well get rid of the whole "children %p" part.

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

> @@ -1477,12 +1479,15 @@ bool usb_device_is_owned(struct usb_device *udev)
>  
>  static void recursively_mark_NOTATTACHED(struct usb_device *udev)
>  {
> +	struct usb_hub	*hub = hdev_to_hub(udev);
>  	int i;
>  
> -	for (i = 0; i < udev->maxchild; ++i) {
> -		if (udev->children[i])
> -			recursively_mark_NOTATTACHED(udev->children[i]);
> -	}
> +	if (hub)

You don't need this test.  If hub is NULL then udev->maxchild will be
0, so the following loop will be skipped.

> +		for (i = 0; i < udev->maxchild; ++i) {
> +			if (hub->port_data[i].child)
> +				recursively_mark_NOTATTACHED(
> +					hub->port_data[i].child);
> +		}
>  	if (udev->state == USB_STATE_SUSPENDED)
>  		udev->active_duration -= jiffies;
>  	udev->state = USB_STATE_NOTATTACHED;

> @@ -1659,10 +1665,11 @@ void usb_disconnect(struct usb_device **pdev)
>  	usb_lock_device(udev);
>  
>  	/* Free up all the children before we remove this device */
> -	for (i = 0; i < USB_MAXCHILDREN; i++) {
> -		if (udev->children[i])
> -			usb_disconnect(&udev->children[i]);
> -	}
> +	if (hub)

The same is true here.

> +		for (i = 0; i < udev->maxchild; i++) {
> +			if (hub->port_data[i].child)
> +				usb_disconnect(&hub->port_data[i].child);
> +		}

Alan Stern

