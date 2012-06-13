From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 2/3] USB/ACPI: Add usb port's acpi power control in the
 xhci PORT_POWER feature request process.
Date: Wed, 13 Jun 2012 14:00:58 -0700
Message-ID: <20120613210058.GA8827@kroah.com>
References: <1339381474-17413-1-git-send-email-tianyu.lan@intel.com>
 <1339381474-17413-3-git-send-email-tianyu.lan@intel.com>
 <20120613193038.GA6312@kroah.com>
 <20120613205329.GA5597@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120613205329.GA5597@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 13, 2012 at 01:53:29PM -0700, Sarah Sharp wrote:
> On Wed, Jun 13, 2012 at 12:30:38PM -0700, Greg KH wrote:
> > On Mon, Jun 11, 2012 at 10:24:33AM +0800, Lan Tianyu wrote:
> > > +
> > > +			if (usb_acpi_power_manageable(hcd->self.root_hub,
> > > +					wIndex + 1))
> > 
> > Why +1?  If you have to do this everywhere, then do it only in the
> > function, so you can be 0 based properly.
> > 
> > Also, minor coding style nit, please rewrite as:
> > 			if (usb_acpi_power_manageable(hcd->self.root_hub,
> > 						      wIndex + 1))
> 
> This is an arbitrarily applied rule, and I don't follow it in the xHCI
> driver.  The code indentation should be left at the default indentation
> in the xHCI driver.  Let's keep the code style in the driver consistent,
> please.

Ok, fair enough, I didn't notice.

> I don't understand why people want to move the trailing arguments to
> align with the function parenthesis.  I can see that it might add to
> readability for some people, but it's just more work on both the
> developer's and maintainer's side.
> 
> Checkpatch will complain about mixed tabs and spaces, so that's more
> work for me to edit my git pre-commit hook when the checkpatch error
> stops git-am.  Plus the developer has to actually pause and think about
> indentation, rather than letting their editor take care of it.

No, checkpatch should not complain about the above line, as it's tabs
and then spaces.  Well, it better not, as I use it all the time :)

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
