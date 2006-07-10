From: Pavel Machek <pavel@ucw.cz>
Subject: Re: S3 suspend fails with lockdep BUG warning (TP T60, 2.6.18-rc1)
Date: Mon, 10 Jul 2006 13:03:37 +0200
Message-ID: <20060710110336.GC7172@atrey.karlin.mff.cuni.cz>
References: <E1FzDIm-0003Zc-00@skye.ra.phy.cam.ac.uk> <200607082033.32579.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37321 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964798AbWGJLDK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jul 2006 07:03:10 -0400
Content-Disposition: inline
In-Reply-To: <200607082033.32579.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, linux-acpi@vger.kernel.org

Hi!

s2ram works okay here -- 2.6.18-rc1-mm1, but I'm not using /sys
activation.

> > I just did that, but found no /sys/power/state file (or anything under
> > /sys).  

You need to mount /sys, first...?!

> > So I rebooted with "init=/sbin/init 1" and got
> > 
> >   $ echo mem > /sys/power/state
> >   bash: echo: write error: Operation not permitted

Anything in dmesg?

> > As a sanity check:
> > 
> >   $ ls -l /sys/power/state
> >   -rw-r--r-- 1 root root 4096 2006-07-08 09:51 /sys/power/state
> > 
> > So I retried both with the regular boot and got the same error.  The
> > state file is at least half working:
> > 
> >   $ cat /sys/power/state
> >   standby mem 
> > 
> > strace shows that the write(1,"mem\n",4) fails with EPERM.  So I'm
> > pretty sure that's what happens to the S3 suspend (with Fn-F4): it
> > bounces back after failing to write to /sys/power/state
> > 
> > The above is with the same kernel as in my original report
> > (SMP+PREEMPT kernel and lock validation code).  Worth retrying without
> > those options, or is this error simple enough to track down with this
> > kernel?

Do you have config_acpi_sleep compiled in?


> Hm, there seems to be something fishy in sysfs on this kernel.  I'm not
> sure what, though, because I've just tested suspend to disk on it and
> there haven't been any problems like that.
> 
> > By the way, I'm not sure why standby is included as a possible
> > /sys/power/state, since the boot messages don't include S1:
> > 
> >   [17179570.492000] ACPI: (supports S0 S3 S4 S5)

Now, that's really strange. My /sys/power/state does not include
standby... Ask on acpi list...
							Pavel
-- 
Thanks, Sharp!
