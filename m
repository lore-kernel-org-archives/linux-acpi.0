From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] usb: add struct usb_hub_port to store port
 related members.
Date: Wed, 21 Mar 2012 10:38:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203211038200.1369-100000@iolanthe.rowland.org>
References: <4F699725.3080404@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F699725.3080404-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sarah.a.sharp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 21 Mar 2012, Lan Tianyu wrote:

> >> hi alan:
> >> 	Great thanks for your review.
> >> 	But I still confuse about "You might as well add the child device pointer
> >> into your new data structure." Could you help me to make it clear? :)
> >> 	Do you mean add struct usb_device pointer toward the device attached to the
> >> port in the
> >> struct usb_hub_port? If yes,Why?
> >
> > Yes, that's what I mean.  It's a natural thing to do; the child device
> > is directly associated with the port.  It's better than allocating a
> > separate array for hdev->children.
> OK. That' mean that I should replace the hdev->children with 
> port_data->child_device.
> In the hub.c, the struct usb_hub_port can be visited and the child_device can be 
> accessed
> directly. Out of hub.c, I should provide function to return child pointer. Is 
> that right?

Right.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
