From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [Resend PATCH V2 2/7] usb: Bind devices to ACPI devices when
 possible
Date: Fri, 4 May 2012 17:21:55 -0700
Message-ID: <20120505002155.GA12282@kroah.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
 <1336100803-28353-3-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336100803-28353-3-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 04, 2012 at 11:06:38AM +0800, Lan Tianyu wrote:
> From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Built-in USB devices will typically have a representation in the system
> ACPI tables. Add support for binding the two together so the USB code can
> make use of the associated methods.
> 
> Signed-off-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/usb/core/Makefile   |    1 +
>  drivers/usb/core/usb-acpi.c |   60 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/usb.c      |    6 ++++
>  drivers/usb/core/usb.h      |    7 +++++
>  4 files changed, 74 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/core/usb-acpi.c

This patch breaks the build with:
	ERROR: "unregister_acpi_bus_type" [drivers/usb/core/usbcore.ko] undefined!
	ERROR: "register_acpi_bus_type" [drivers/usb/core/usbcore.ko] undefined!

{sigh}

Care to resend them after fixing this?

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
