From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Sat, 25 Oct 2003 00:23:47 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031024222347.GB728@elf.ucw.cz>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se> <20031023082534.GD643@openzaurus.ucw.cz> <yw1xr813f1a3.fsf@kth.se> <3F98FDDF.1040905@cyberone.com.au> <yw1xbrs6652m.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yw1xbrs6652m.fsf-UNjuZkX4dYU@public.gmane.org>
To: M?ns Rullg?rd <mru-UNjuZkX4dYU@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>I've been trying the new suspend to disk implementation (pmdisk, I
> >>think) lately.  I get these lines in the kernel log when starting
> >>after a suspend:
> >>
> >>PM: Reading pmdisk image.
> >>PM: Resume from disk failed.
> >>ACPI: (supports S0 S1 S3 S4 S5)
> >>
> >>Last time I tried swsusp, I did pass the resume= option, but it didn't
> >>work.
> >>
> >>Could it be that some disk cache is never flushed properly?
> >>Occasionally, some random filesystem is reported as not being cleanly
> >>unmounted when booting normally, which seems to point in the same
> >>direction.
> >>
> >
> > Try turning your disk cache off, or set it to write through caching
> > (even so I heard some IDE drives don't turn it off anyway!). See if
> > it helps.
> 
> That took me one step further.  Now it loaded the image swap, but them
> immediately rebooted.  I didn't have time to see if there were any
> error messages.  I don't have a serial port, so I can't put a console
> there.  This was with lots of modules loaded, so maybe unloading some
> would help.  Are there any known broken drivers in this list:

Try it completely without modules. I'm not sure how it should work
with modules which means it probably does not work at all.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
