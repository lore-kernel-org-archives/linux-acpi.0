From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 10:08:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205111005370.1865-100000@iolanthe.rowland.org>
References: <20120510211156.GA18754@xanatos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120510211156.GA18754@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Dan Williams <dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 10 May 2012, Sarah Sharp wrote:

> Also, setting the port power off via ACPI may not actually cut power,
> because port power might be ganged.  Once we signal via ACPI that all
> the ports that are ganged together can be powered off, they will.  So
> there's no guarantees that you can power off the buggy modem unless you
> power off the other ganged ports as well.

That reminds me...  I think this should not be so closely linked with
ACPI.  There's a perfectly good USB Clear-Feature request for turning
off port power; that's what we should use.  If hooks are required for
interfacing with platform-specific code (such as ACPI), they can be
added at the appropriate places.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
