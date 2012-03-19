From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 2/4] usb: add platform_data in the struct usb_hub_port
Date: Mon, 19 Mar 2012 12:07:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203191204500.1641-100000@iolanthe.rowland.org>
References: <1332167626-5806-2-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38052 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030530Ab2CSQHC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2012 12:07:02 -0400
In-Reply-To: <1332167626-5806-2-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, mjg@redhat.com, linux-usb@vger.kernel.org, sarah.a.sharp@intel.com

On Mon, 19 Mar 2012, Lan Tianyu wrote:

> Add the member platform_data in the usb_hub_port to store port's
> platform related data. Provide usb_set_hub_port_platform_data() and
> usb_get_hub_port_platform_data() to access the member.

> +int usb_set_hub_port_platform_data(struct usb_device *udev, int port,
> +	unsigned long data)

The argument is a 1-based port number, so it should be called "port1" 
instead of "port".

The same change needs to be made in other places in your patch series.

> +{
> +	struct usb_hub *hub = hdev_to_hub(udev);
> +
> +	if (port > hub->descriptor->bNbrPorts || port < 1)

Use udev->maxchild instead of hub->descriptor->bNbrPorts.  Same thing 
in usb_get_hub_port_platform_data().

> +		return -EINVAL;
> +	hub->port_data[port - 1].platform_data = data;
> +	return 0;
> +}

Alan Stern

