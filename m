From: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Subject: Re: (1) ACPI messes up Parallel support in kernels >2.6.9
Date: Thu, 5 Jan 2006 03:55:59 -0500
Message-ID: <20060105085559.GA1357@neo.rr.com>
References: <200601042203.12377.dmutters@gmail.com> <20060104225209.56e35802.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060104225209.56e35802.akpm-3NddpPZAyC0@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dane Mutters <dmutters-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 04, 2006 at 10:52:09PM -0800, Andrew Morton wrote:
> Dane Mutters <dmutters-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > 	I've been attempting to figure out this problem for a long time, and have 
> >  come to the conclusion that it must be a kernel bug (that or perhaps I'm a 
> >  bit dense).  Whenever I have the option, "Device Drivers > Plug and Play > 
> >  ACPI Support" enabled, I become unable to print using my parallel port.
> 
> hm, regressions are bad and the fact that it _used_ to work meand that we
> should be able to make it work again.
> 
> Could you please raise a bug reports against acpi at bugzilla.kernel.org? 
> It might help if that report includes the output of `dmesg -s 1000000' for
> both working and non-working kernels.
> 
> Thanks.

This may be a PnP bug.  If you can provide further information, I'll
look into it.

Thanks,
Adam

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
