From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Resend PATCH V2 3/7] usb: Set device removable state based on
 ACPI USB data
Date: Tue, 8 May 2012 03:58:17 +0100
Message-ID: <20120508025817.GB23448@srcf.ucam.org>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
 <1336100803-28353-4-git-send-email-tianyu.lan@intel.com>
 <201205040824.17010.oneukum@suse.de>
 <4FA72787.5000106@intel.com>
 <20120507165744.GA28045@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120507165744.GA28045-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, May 07, 2012 at 09:57:44AM -0700, Greg KH wrote:
> On Mon, May 07, 2012 at 09:38:15AM +0800, Lan Tianyu wrote:
> > This depends on the bios. From my opinion, the bluetooth is device on the
> > motherboard so it belongs to hard-wired type.
> 
> That's nice, but it's not what is happening in lots of different laptops
> out there today.
> 
> Oliver is right, how does this handle bluetooth USB controllers that are
> turned on/off from magic function-key presses?

I /believe/ that such devices will be indicated as fixed rather than 
removable. The variable indicates the physical state rather than the 
logical one - fixed doesn't mean that a device will never go away, it 
means that a user can't physically unplug it.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
