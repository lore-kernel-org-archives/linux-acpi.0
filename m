From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: S3 suspend fails with lockdep BUG warning (TP T60, 2.6.18-rc1)
Date: Sat, 8 Jul 2006 10:17:57 +0200
Message-ID: <200607081017.57969.rjw@sisk.pl>
References: <E1Fz2MM-0007zz-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:61627 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751268AbWGHIR0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Jul 2006 04:17:26 -0400
In-Reply-To: <E1Fz2MM-0007zz-00@skye.ra.phy.cam.ac.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-acpi@vger.kernel.org

Hi,

On Saturday 08 July 2006 04:15, Sanjoy Mahajan wrote:
> I'm trying 2.6.18-rc1, on a Thinkpad T60 (dual-core, T2400) running
> Ubuntu 6.06.  The kernel is SMP, PREEMPT, and has many of the lock
> validation options turned on.  It has a SATA hard drive.  During boot
> the lockdep checker reports good news:
> 
> [   20.936404] Good, all 218 testcases passed! |
> 
> When I pressed Fn-F4 (for suspend-to-ram), it began to suspend,
> blanked the screen, and then came back right away to the X session.  I
> don't think it ever made it into suspend mode.  And this dmesg showed
> up:
> 
> [  459.756000] BUG: warning at kernel/lockdep.c:1799/trace_hardirqs_on()
> [  459.756000]  [<c0105aeb>] show_trace+0x1b/0x20
> [  459.756000]  [<c0105b14>] dump_stack+0x24/0x30
> [  459.756000]  [<c013c186>] trace_hardirqs_on+0x166/0x180
> [  459.756000]  [<c010522d>] do_general_protection+0xcd/0x220
> [  459.756000]  [<c0103e01>] error_code+0x39/0x40

This is a warning from the lock validation code and I think you should report
it separately on LKML.

If you are interested in debugging the suspend issue and have some time,
please do the following:

1) disable all of the lock validation options and see if that helps; if not
2) additionally compile the kernel without SMP and see if that helps; if not
3) additionally compile the kernel without PREEMPT and see if that helps.

You can also boot the kernel with init=/bin/bash and trigger the suspend
with 'echo mem > /sys/power/state'.  If it suspend and resumes successfully,
the problem is probably with one of the modules.

Greetings,
Rafael
