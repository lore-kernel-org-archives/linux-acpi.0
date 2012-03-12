From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH 3/4] usb: Bind devices to ACPI devices when possible
Date: Mon, 12 Mar 2012 21:12:45 +0000
Message-ID: <20120312211245.GA23202@srcf.ucam.org>
References: <20120312205616.GB22929@srcf.ucam.org>
 <Pine.LNX.4.44L0.1203121702000.1216-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1203121702000.1216-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 12, 2012 at 05:03:54PM -0400, Alan Stern wrote:
> On Mon, 12 Mar 2012, Matthew Garrett wrote:
> > Ugh. Is there any clean way to distinguish from the device structure? If 
> > not, the easiest would seem to be to just add another bus type 
> > structure, even if the members are identical.
> 
> Easy; just call is_usb_device() (defined in core/usb.h).

Ah, thanks - I'll add that and repost.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
