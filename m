From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)
Date: Wed, 11 Jan 2006 11:00:16 +0100
Message-ID: <20060111100016.GC2574@elf.ucw.cz>
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060110170037.4a614245.akpm-3NddpPZAyC0@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-dev-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Thanks for testing and reporting - it really helps.
> 
> > 1- reiser3 oopsed[1] twice while suspending to ram. It seems
> >    reproducible (have some activity on the fs and suspend)
> 
> No significant reiser3 changes in there, so I'd be suspecting something
> else has gone haywire.

Suspend to *RAM*? That really does not do anything that should kill
the filesystems. Has it ever worked before? When? Any SATA?

> > The reiser oops seems reproducible by suspending with some dirty cache
> > (I've been able to suspend/resume cycle 3 times without reiser crashing
> > but I also didn't have big activities on that partition).
> > If really necessary I can try to reproduce it (oh, poor filesystem).
> > Other than that are ther suggestions/patches to start with?
> 
> Pavel, have you heard of anything like this??

No, never seen this before. With suspend to disk and wrong setup,
"kill my filesystem" is easy; but suspend to RAM? Best bet would be
disk driver doing something really stupid.
								Pavel
-- 
Thanks, Sharp!
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
