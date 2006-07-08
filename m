From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: S3 suspend fails with lockdep BUG warning (TP T60, 2.6.18-rc1)
Date: Sat, 8 Jul 2006 20:33:32 +0200
Message-ID: <200607082033.32579.rjw@sisk.pl>
References: <E1FzDIm-0003Zc-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38590 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964955AbWGHSdC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Jul 2006 14:33:02 -0400
In-Reply-To: <E1FzDIm-0003Zc-00@skye.ra.phy.cam.ac.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-acpi@vger.kernel.org, Pavel Machek <pavel@suse.cz>

On Saturday 08 July 2006 15:56, Sanjoy Mahajan wrote:
> > This is a warning from the lock validation code and I think you
> > should report it separately on LKML.
> 
> Done.
> 
> > You can also boot the kernel with init=/bin/bash and trigger the
> > suspend with 'echo mem > /sys/power/state'.
> 
> I just did that, but found no /sys/power/state file (or anything under
> /sys).  So I rebooted with "init=/sbin/init 1" and got
> 
>   $ echo mem > /sys/power/state
>   bash: echo: write error: Operation not permitted
> 
> As a sanity check:
> 
>   $ ls -l /sys/power/state
>   -rw-r--r-- 1 root root 4096 2006-07-08 09:51 /sys/power/state
> 
> So I retried both with the regular boot and got the same error.  The
> state file is at least half working:
> 
>   $ cat /sys/power/state
>   standby mem 
> 
> strace shows that the write(1,"mem\n",4) fails with EPERM.  So I'm
> pretty sure that's what happens to the S3 suspend (with Fn-F4): it
> bounces back after failing to write to /sys/power/state
> 
> The above is with the same kernel as in my original report
> (SMP+PREEMPT kernel and lock validation code).  Worth retrying without
> those options, or is this error simple enough to track down with this
> kernel?

Hm, there seems to be something fishy in sysfs on this kernel.  I'm not
sure what, though, because I've just tested suspend to disk on it and
there haven't been any problems like that.

> By the way, I'm not sure why standby is included as a possible
> /sys/power/state, since the boot messages don't include S1:
> 
>   [17179570.492000] ACPI: (supports S0 S3 S4 S5)

I'm not sure either.

Greetings,
Rafael
