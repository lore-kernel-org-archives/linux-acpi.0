From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: xHCI Express Card failure -- ACPI related?
Date: Wed, 23 Feb 2011 06:57:47 -0800
Message-ID: <20110223145747.GA4627@xanatos>
References: <20110223005513.GA2503@xanatos>
 <20110223015445.GA27481@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110223015445.GA27481-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 23, 2011 at 01:54:45AM +0000, Matthew Garrett wrote:
> On Tue, Feb 22, 2011 at 04:55:13PM -0800, Sarah Sharp wrote:
> > I'm having an issue with an xHCI (USB 3.0 host controller) Express Card.
> > This card works fine on 2.6.37, but on 2.6.38-rc5, when I plug in the
> > card, I get this output in dmesg:
> 
> Is the controller associated with irq 23?

I think it is, before the xHCI driver switches to MSI/MSIX.  I'd have to
disable MSI in 2.6.37 to confirm.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
