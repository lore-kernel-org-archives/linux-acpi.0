From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] usb: add struct usb_hub_port to store port related
 members.
Date: Wed, 28 Mar 2012 14:54:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203281452010.1599-100000@iolanthe.rowland.org>
References: <1332917353-28123-2-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34455 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754199Ab2C1Syw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Mar 2012 14:54:52 -0400
In-Reply-To: <1332917353-28123-2-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@intel.com, mjg@redhat.com

On Wed, 28 Mar 2012, Lan Tianyu wrote:

> Add struct usb_hub_port pointer port_data in the struct usb_hub and allocate
> struct usb_hub_port perspectively for each ports to store private data.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/usb/core/hub.c |   29 +++++++++++++++--------------
>  1 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index aeefbab..1ee130d 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c

>  void usb_hub_release_all_ports(struct usb_device *hdev, void *owner)
>  {
> +	struct usb_hub *hub = hdev_to_hub(hdev);
>  	int n;
> -	void **powner;
>  
> -	n = find_port_owner(hdev, 1, &powner);
> -	if (n == 0) {
> -		for (; n < hdev->maxchild; (++n, ++powner)) {
> -			if (*powner == owner)
> -				*powner = NULL;
> -		}
> -	}
> +	for (n = 0; n < hdev->maxchild; n++)
> +		hub->port_data[n].port_owner = NULL;

This is not quite right.  It should be:

	for (n = 0; n < hdev->maxchild; n++) {
		if (hub->port_data[n].port_owner == owner)
			hub->port_data[n].port_owner = NULL;
	}

Otherwise the patch is okay.

Alan Stern

