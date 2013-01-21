From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v6 2/8] usb: Register usb port's acpi power resources
Date: Mon, 21 Jan 2013 13:20:57 -0800
Message-ID: <20130121212056.GA14908@kroah.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
 <1358777887-2656-3-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1358777887-2656-3-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, oneukum-l3A5Bk7waGM@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 21, 2013 at 10:18:01PM +0800, Lan Tianyu wrote:
> This patch is to register usb port's acpi power resources. Create
> link between usb port device and its acpi power resource.
> 
> Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/core/port.c     |    3 +++
>  drivers/usb/core/usb-acpi.c |   20 ++++++++++++++++++++
>  drivers/usb/core/usb.h      |    6 ++++++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index fe5959f..4dfa254 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -66,6 +66,7 @@ static void usb_port_device_release(struct device *dev)
>  {
>  	struct usb_port *port_dev = to_usb_port(dev);
>  
> +	usb_acpi_unregister_power_resources(dev);
>  	kfree(port_dev);
>  }
>  
> @@ -95,6 +96,8 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>  	if (retval)
>  		goto error_register;
>  
> +	usb_acpi_register_power_resources(&port_dev->dev);
> +
>  	return 0;
>  
>  error_register:
> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
> index cef4252..558ab01 100644
> --- a/drivers/usb/core/usb-acpi.c
> +++ b/drivers/usb/core/usb-acpi.c
> @@ -216,6 +216,26 @@ static struct acpi_bus_type usb_acpi_bus = {
>  	.find_device = usb_acpi_find_device,
>  };
>  
> +int usb_acpi_register_power_resources(struct device *dev)
> +{
> +	acpi_handle port_handle = DEVICE_ACPI_HANDLE(dev);
> +
> +	if (!port_handle)
> +		return -ENODEV;
> +
> +	if (acpi_power_resource_register_device(dev, port_handle) < 0)
> +		return -ENODEV;
> +	return 0;
> +}

Why return a value if you never check it?  Either properly handle the
error in the place you call this function, or don't have a return value.

I'd prefer you to handle the error properly.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
