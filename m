From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH V2 1/7] ACPI: Add _PLD support
Date: Mon, 23 Apr 2012 13:20:58 -0700
Message-ID: <20120423202058.GA22717@kroah.com>
References: <1334716601-12266-1-git-send-email-tianyu.lan@intel.com>
 <1334716601-12266-2-git-send-email-tianyu.lan@intel.com>
 <20120418213104.GA15939@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120418213104.GA15939-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 18, 2012 at 02:31:04PM -0700, Greg KH wrote:
> On Wed, Apr 18, 2012 at 10:36:35AM +0800, Lan Tianyu wrote:
> > From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > 
> > Add a simple helper function to allow drivers to obtain the physical
> > device location data.
> > 
> > Signed-off-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/acpi/utils.c    |   29 +++++++++++++++++++++++++++++
> >  include/acpi/acpi_bus.h |   31 +++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+), 0 deletions(-)
> 
> I need an ack from an ACPI maintainer before I can apply this patch.
> And as the rest of the patches in this series depend on this, I need it
> in order to be able to apply them as well.
> 
> Len?

Ok, due to lack of response, I'm flushing these from my queue, sorry.
Lan, please try again after the ACPI developers ack this change, or take
it through their tree.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
