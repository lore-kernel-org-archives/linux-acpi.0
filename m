From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 4/4] usb/acpi: add usb check for the connect type of
 usb port
Date: Mon, 19 Mar 2012 12:13:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203191210270.1641-100000@iolanthe.rowland.org>
References: <1332167626-5806-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38070 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932261Ab2CSQNL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2012 12:13:11 -0400
In-Reply-To: <1332167626-5806-4-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, mjg@redhat.com, linux-usb@vger.kernel.org, sarah.a.sharp@intel.com

On Mon, 19 Mar 2012, Lan Tianyu wrote:

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

> @@ -132,7 +133,7 @@ MODULE_PARM_DESC(initial_descriptor_timeout,
>   *
>   * For maximum flexibility there are two boolean parameters to control the
>   * hub driver's behavior.  On the first initialization attempt, if the
> - * "old_scheme_first" parameter is set then the old scheme will be used,
> +.iiies * "old_scheme_first" parameter is set then the old scheme will be used,

This is a typo.

>   * otherwise the new scheme is used.  If that fails and "use_both_schemes"
>   * is set, then the driver will make another attempt, using the other scheme.
>   */
> @@ -4174,3 +4175,27 @@ int usb_get_hub_port_platform_data(struct usb_device *udev, int port,
>  	*data = hub->port_data[port - 1].platform_data;
>  	return 0;
>  }
> +
> +int usb_set_hub_port_connect_type(struct usb_device *hdev, int port,
> +	enum usb_port_connect_type type)

The parameter should be called "port1", not "port".

> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +
> +	if (port > hub->descriptor->bNbrPorts || port < 1)

Use hdev->maxchild instead of hub->descriptor->bNbrPorts.  Same in 
usb_get_hub_port_connect_type().

> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -19,58 +19,57 @@
>  
>  #include "usb.h"
>  
> -static int usb_acpi_check_upc(struct usb_device *udev, acpi_handle handle)
> +static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
> +	acpi_handle handle, int port)

port1, not port.

Alan Stern

