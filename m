From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 1/4] usb: add struct usb_hub_port to store port
 related members.
Date: Mon, 19 Mar 2012 12:04:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203191156280.1641-100000@iolanthe.rowland.org>
References: <1332167626-5806-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38042 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030777Ab2CSQEk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2012 12:04:40 -0400
In-Reply-To: <1332167626-5806-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, mjg@redhat.com, linux-usb@vger.kernel.org, sarah.a.sharp@intel.com

On Mon, 19 Mar 2012, Lan Tianyu wrote:

> Add struct usb_hub_port pointer port_data in the struct usb_hub and allocate
> struct usb_hub_port perspectively for each ports to store private data.

You might as well add the child device pointer into your new data 
structure.  This will require changes to at least three other files in 
addition to hub.c:

	devices.c, host/r8a66597-hcd.c,
	drivers/staging/usbip/usbip_common.c

Maybe some others; I didn't look through the entire kernel source.  It 
also means you will have to export a function to get a pointer to the 
child device, given the port number.

> @@ -1451,13 +1456,12 @@ void usb_hub_release_all_ports(struct usb_device *hdev, void *owner)
>  	int n;
>  	void **powner;
>  
> -	n = find_port_owner(hdev, 1, &powner);
> -	if (n == 0) {
> -		for (; n < hdev->maxchild; (++n, ++powner)) {
> -			if (*powner == owner)
> -				*powner = NULL;
> -		}
> +	for (n = 1; n <= hdev->maxchild; n++) {
> +		find_port_owner(hdev, n, &powner);
> +		if (*powner == owner)
> +			*powner = NULL;
>  	}

This is wrong; find_port_owner() doesn't set powner to anything if an 
error occurs.

You can just set the pointer field directly to NULL, instead of looking
it up in find_port_owner().  I don't remember why it was written that
way originally.

Alan Stern

