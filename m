From: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH V2 1/4] ACPI: Fix up _PLD methods
Date: Tue, 10 Apr 2012 07:56:40 +0000
Message-ID: <4CFBC02C07DA244CA19D6815A05BE6EE05C77B@SHSMSX101.ccr.corp.intel.com>
References: <1331588747-1247-1-git-send-email-mjg@redhat.com>
 <20120313213207.GA23216@kroah.com> <20120313213850.GB22956@srcf.ucam.org>
 <20120313214941.GA4534@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120313214941.GA4534-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The new version of the patch has been merged in 3.4
	http://marc.info/?l=linux-acpi&m=133311010407354&w=2

Best Regards 
Tianyu Lan 

-----Original Message-----
From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Greg KH
Sent: Wednesday, March 14, 2012 5:50 AM
To: Matthew Garrett
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Subject: Re: [PATCH V2 1/4] ACPI: Fix up _PLD methods

On Tue, Mar 13, 2012 at 09:38:50PM +0000, Matthew Garrett wrote:
> On Tue, Mar 13, 2012 at 02:32:07PM -0700, Greg KH wrote:
> > On Mon, Mar 12, 2012 at 05:45:44PM -0400, Matthew Garrett wrote:
> > > _PLD is defined as returning a package of buffers, but many 
> > > implementations simply return a buffer. Fix this up.
> > > 
> > > (Original patch by Bob Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>)
> > 
> > Does that mean the "From:" line should be set to Bob?
> > 
> > Any objection from the ACPI developers for me to apply this series?
> 
> Bob's asked me to hold off on this - he has a better patch for acpica 
> that he'll post later this month.

Ok, so I'll drop the whole series, I guess this will miss 3.4 then :(

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
