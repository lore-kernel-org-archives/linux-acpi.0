From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Tue, 15 May 2012 08:18:00 -0700
Message-ID: <20120515151800.GC23916@kroah.com>
References: <20120511202113.GH18754@xanatos>
 <Pine.LNX.4.44L0.1205111629150.1865-100000@iolanthe.rowland.org>
 <20120511235922.GJ18754@xanatos>
 <20120512001722.GA28011@kroah.com>
 <20120514232123.GK18754@xanatos>
 <4FB268CA.9060304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FB268CA.9060304-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, May 15, 2012 at 10:31:38PM +0800, Lan Tianyu wrote:
> Since alan suggested we should start simpler version(power
> down port that have no devices attached) firstly. And we
> also should provide general power off mechanism.
> 
> I have a proposal.
> first:  add portx_power_control sys file.
>      echo "auto" => portx_power_control
>                     check whether there is a device. if no, send the clear
>                     USB_PORT_FEAT_POWER request. (since general way
>                     to control port power is via set or clear PORT_POWER)
> 
>     echo "on" =>  portx_power_control
>                     send the set  USB_PORT_FEAT_POWER request.

No "off"?

> second:
> In the  xhci driver, add acpi hook in the xhci_hub_control()
>                 where USB_PORT_FEAT_POWER request is dealt with.

Do you have a patch showing that this works?

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
