From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] USB/ACPI: Add usb port's acpi power control in the
 xhci PORT_POWER feature request process.
Date: Wed, 13 Jun 2012 12:30:38 -0700
Message-ID: <20120613193038.GA6312@kroah.com>
References: <1339381474-17413-1-git-send-email-tianyu.lan@intel.com>
 <1339381474-17413-3-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62917 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab2FMTa7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jun 2012 15:30:59 -0400
Received: by dady13 with SMTP id y13so1470656dad.19
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jun 2012 12:30:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339381474-17413-3-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, sarah.a.sharp@linux.intel.com, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu

On Mon, Jun 11, 2012 at 10:24:33AM +0800, Lan Tianyu wrote:
> On our developping machine, bios can provide usb port's  power control via
> acpi. This patch is to provide usb port's power control way through setting
> or clearing PORT_POWER feature requests. Add two functions usb_acpi_power_manageable()
> and usb_acpi_set_power_state(). The first one is used to find whether the
> usb port has acpi power resource and the second is to set the power state.
> They are invoked in the xhci_hub_control() where clearing or setting PORT_POWER
> feature requests are processed.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/usb/core/usb-acpi.c |   28 ++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-hub.c |   10 ++++++++++
>  include/linux/usb.h         |   10 ++++++++++
>  3 files changed, 48 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
> index 82c90d0..e95f26f 100644
> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -19,6 +19,34 @@
>  
>  #include "usb.h"
>  
> +bool usb_acpi_power_manageable(struct usb_device *hdev, int port1)
> +{
> +	acpi_handle port_handle;
> +
> +	port_handle = usb_get_hub_port_acpi_handle(hdev,
> +		port1);
> +	return port_handle ? acpi_bus_power_manageable(port_handle) : false;

Ick, I _really_ hate the ? : usage in C, please use real if statements
so that everyone can read and understand them easier.  You do that a lot
here, please fix them all.

> +}
> +EXPORT_SYMBOL_GPL(usb_acpi_power_manageable);
> +
> +int usb_acpi_set_power_state(struct usb_device *hdev, int port1, bool enable)
> +{
> +	acpi_handle port_handle;
> +	unsigned char state;
> +	int error = -EINVAL;
> +
> +	port_handle = (acpi_handle)usb_get_hub_port_acpi_handle(hdev,
> +		port1);
> +	state = enable ? ACPI_STATE_D0 : ACPI_STATE_D3_COLD;
> +	error = acpi_bus_set_power(port_handle, state);

You forgot to check port_handle here.

Why not call usb_acpi_power_manageable() to ensure that you can do this?

> +	if (!error)
> +		dev_dbg(&hdev->dev, "The power of hub port %d was set to %s\n",
> +			port1, enable ? "enable" : "disabe");

Why not report the error if debugging as well?


> +
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
> +
>  static int usb_acpi_check_port_connect_type(struct usb_device *hdev,
>  	acpi_handle handle, int port1)
>  {
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 2c55fcf..0ce48b3 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -728,6 +728,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  
>  			temp = xhci_readl(xhci, port_array[wIndex]);
>  			xhci_dbg(xhci, "set port power, actual port %d status  = 0x%x\n", wIndex, temp);
> +
> +			if (usb_acpi_power_manageable(hcd->self.root_hub,
> +					wIndex + 1))

Why +1?  If you have to do this everywhere, then do it only in the
function, so you can be 0 based properly.

Also, minor coding style nit, please rewrite as:
			if (usb_acpi_power_manageable(hcd->self.root_hub,
						      wIndex + 1))
Or even better yet, use a temp variable for the value returned and then
check that, it's clearer and easier to read, right?

> +				usb_acpi_set_power_state(hcd->self.root_hub,
> +					wIndex + 1, true);

Same question about +1 here.

>  			break;
>  		case USB_PORT_FEAT_RESET:
>  			temp = (temp | PORT_RESET);
> @@ -830,6 +835,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  		case USB_PORT_FEAT_POWER:
>  			xhci_writel(xhci, temp & ~PORT_POWER,
>  				port_array[wIndex]);
> +
> +			if (usb_acpi_power_manageable(hcd->self.root_hub,
> +					wIndex + 1))
> +				usb_acpi_set_power_state(hcd->self.root_hub,
> +					wIndex + 1, false);
>  			break;
>  		default:
>  			goto error;
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index feb0a04..92f8898 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -599,6 +599,16 @@ extern int usb_lock_device_for_reset(struct usb_device *udev,
>  extern int usb_reset_device(struct usb_device *dev);
>  extern void usb_queue_reset_device(struct usb_interface *dev);
>  
> +#ifdef CONFIG_ACPI
> +extern int usb_acpi_set_power_state(struct usb_device *hdev, int port,
> +	bool enable);
> +extern bool usb_acpi_power_manageable(struct usb_device *hdev, int port);
> +#else
> +static inline int usb_acpi_set_power_state(struct usb_device *hdev, int port,
> +	bool enable) { return 0; }
> +static inline bool usb_acpi_power_manageable(struct usb_device *hdev, int port)
> +	{ return 0; }

is 0 a bool?  :)

Please get the types right.

greg k-h
