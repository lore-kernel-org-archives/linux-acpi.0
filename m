From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: S3 suspend fails with lockdep BUG warning (TP T60, 2.6.18-rc1)
Date: Sat, 08 Jul 2006 14:56:56 +0100
Message-ID: <E1FzDIm-0003Zc-00@skye.ra.phy.cam.ac.uk>
References: <200607081017.57969.rjw@sisk.pl>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:50082 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964833AbWGHN46 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Jul 2006 09:56:58 -0400
In-Reply-To: Your message of "Sat, 08 Jul 2006 10:17:57 +0200."
             <200607081017.57969.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

> This is a warning from the lock validation code and I think you
> should report it separately on LKML.

Done.

> You can also boot the kernel with init=/bin/bash and trigger the
> suspend with 'echo mem > /sys/power/state'.

I just did that, but found no /sys/power/state file (or anything under
/sys).  So I rebooted with "init=/sbin/init 1" and got

  $ echo mem > /sys/power/state
  bash: echo: write error: Operation not permitted

As a sanity check:

  $ ls -l /sys/power/state
  -rw-r--r-- 1 root root 4096 2006-07-08 09:51 /sys/power/state

So I retried both with the regular boot and got the same error.  The
state file is at least half working:

  $ cat /sys/power/state
  standby mem 

strace shows that the write(1,"mem\n",4) fails with EPERM.  So I'm
pretty sure that's what happens to the S3 suspend (with Fn-F4): it
bounces back after failing to write to /sys/power/state

The above is with the same kernel as in my original report
(SMP+PREEMPT kernel and lock validation code).  Worth retrying without
those options, or is this error simple enough to track down with this
kernel?

By the way, I'm not sure why standby is included as a possible
/sys/power/state, since the boot messages don't include S1:

  [17179570.492000] ACPI: (supports S0 S3 S4 S5)

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
