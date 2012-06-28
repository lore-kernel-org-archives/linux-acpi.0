From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH V4 2/8] usb: make usb port a real device
Date: Thu, 28 Jun 2012 10:16:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206281012360.1752-100000@iolanthe.rowland.org>
References: <1340868702-1894-3-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340868702-1894-3-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 28 Jun 2012, Lan Tianyu wrote:

> This patch is to make usb port a real device under usb hub interface.
> Move port_owner to struct usb_port.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/core/hub.c |   93 +++++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 77 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 4cc8dc9..c19e088 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -37,6 +37,12 @@
>  #endif
>  #endif
>  
> +struct usb_port {
> +	struct usb_device *udev;

Why is this field present?  It never gets used anywhere.

If you really want to keep it, please rename it to "hdev", because it 
is a pointer to a hub device, not to a general USB device.  However I 
think it isn't needed, because the hub device is always accessible via 
usb_port->parent->parent.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
