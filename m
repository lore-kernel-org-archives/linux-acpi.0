From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v6 4/8] usb: add runtime pm support for usb port device
Date: Mon, 21 Jan 2013 13:24:59 -0800
Message-ID: <20130121212459.GA20083@kroah.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
 <1358777887-2656-5-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1358777887-2656-5-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, oneukum-l3A5Bk7waGM@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 21, 2013 at 10:18:03PM +0800, Lan Tianyu wrote:
> This patch is to add runtime pm callback for usb port device.
> Set/clear PORT_POWER feature in the resume/suspend callbak.
> Add portnum for struct usb_port to record port number. Do
> pm_rumtime_get_sync/put(portdev) when a device is plugged/unplugged
> to prevent it from being powered off when it is active.
> 
> Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/core/hub.c  |   18 ++++++++++++++++++
>  drivers/usb/core/hub.h  |    4 ++++
>  drivers/usb/core/port.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 29ca6ed..8c1f9a5 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -714,6 +714,18 @@ static void hub_tt_work(struct work_struct *work)
>  	spin_unlock_irqrestore (&hub->tt.lock, flags);
>  }
>  
> +int usb_hub_set_port_power(struct usb_device *hdev, int port1,
> +		bool set)

As this is a new global USB function, please provide the proper
kerneldoc comments describing what it does.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
