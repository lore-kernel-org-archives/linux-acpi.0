From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v6 7/8] usb: add usb_device_allow_power_off() and
 usb_device_prevent_power_off() function.
Date: Mon, 21 Jan 2013 13:33:17 -0800
Message-ID: <20130121213317.GD20083@kroah.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
 <1358777887-2656-8-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1358777887-2656-8-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, oneukum-l3A5Bk7waGM@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 21, 2013 at 10:18:06PM +0800, Lan Tianyu wrote:
> Some usb devices can't be resumed correctly after power off. This
> patch is to add usb_device_allow_power_off() and usb_device_prevent_power_off()
> for device's driver. Call pm_runtime_get_sync(portdev) to increase port's usage
> count and then port will not be suspended. The device will not be powered off.

Please linewrap comments at the proper level (git likes 72).

> 
> Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/core/port.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 0c51d24..0334d91 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -18,11 +18,39 @@
>  
>  #include <linux/slab.h>
>  #include <linux/pm_qos.h>
> +#include <linux/module.h>
>  
>  #include "hub.h"
>  
>  static const struct attribute_group *port_dev_group[];
>  
> +/**
> + * usb_device_control_power_off - Allow or prohibit power off device.
> + * @udev: target usb device
> + * @allow: choice of allow or prohibit
> + *
> + * Call pm_runtime_get/put_sync(portdev) to allow or prohibit target
> + * usb device to be powered off in the kernel. The operations of setting
> + * true and false should be couple. The default status is allowed.
> + */
> +int usb_device_control_power_off(struct usb_device *udev, bool allow)

Ick, again with the boolean variables.  Please don't do this, just make
two different functions:
	usb_device_allow_power_off()
	usb_device_forbid_power_off()
that makes it much easier to understand when you see the function being
called, right?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
