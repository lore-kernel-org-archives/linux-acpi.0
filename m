From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [Resend PATCH V3 7/8] usb/acpi: add the support of usb hub
 ports' acpi binding without attached devices.
Date: Fri, 11 May 2012 17:15:48 -0700
Message-ID: <20120512001548.GA31948@kroah.com>
References: <1336723712-7686-1-git-send-email-tianyu.lan@intel.com>
 <1336723712-7686-8-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336723712-7686-8-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 11, 2012 at 04:08:31PM +0800, Lan Tianyu wrote:
> The usb port is a device in the acpi table but it's not in the linux
> usb subsystem. USB hub port doesn't have struct device. So the acpi
> glue framework only can cover the usb port connected with usb device
> and store the acpi handle to struct device.archdata.acpi_handle. This
> patch adds the member platform_data in the struct usb_hub_port and
> gets the hub port's acpi_handle and store it in the port's platform_data
> to resolve no attached device no binding problem. The acpi method "_UPC"
> and "_PLD" can be accessed without attached device.

No, that's a hack.  Please do this correctly and use the real structures
here, not an unsigned long.

Why not make the hub a real struct device?  That would solve this
problem, right?

>  struct usb_hub_port {
>  	void			*port_owner;
>  	struct usb_device	*child;
> +	unsigned long		platform_data;

Yeah, no, that's not ok, sorry.  We use real pointers because we can,
don't use opaque types here, where you are really putting a pointer in
here.  Be specific.

I'm not going to accept this patch, sorry.  Please rework it, and I'm
guessing, the one after this.

I'll go test the other patches in this series now...

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
