From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: git-acpi breaks resume-from-ram on the Vaio
Date: Wed, 19 Sep 2007 13:53:25 +0200
Message-ID: <200709191353.26484.rjw@sisk.pl>
References: <20070917211213.8e0372d6.akpm@linux-foundation.org> <200709181359.04826.rjw@sisk.pl> <20070919002717.a3a0ebfd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33923 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497AbXISLlX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Sep 2007 07:41:23 -0400
In-Reply-To: <20070919002717.a3a0ebfd.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Ingo Molnar <mingo@elte.hu>

On Wednesday, 19 September 2007 09:27, Andrew Morton wrote:
> On Tue, 18 Sep 2007 13:59:04 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Tuesday, 18 September 2007 13:54, Rafael J. Wysocki wrote:
> > > On Tuesday, 18 September 2007 06:40, Andrew Morton wrote:
> > > > On Mon, 17 Sep 2007 21:12:13 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > 
> > > > > 
> > > > > It suspends OK, then during resume it gets partway through it, then everything
> > > > > just stops.
> > > > > 
> > > > > Would prefer not to have to bisect this one - I've done enough bisecting this
> > > > > week to last a lifetime, and bisecting git-acpi is painful due to build bustage
> > > > > at various points (cpuidle).
> > > > 
> > > > And git-acpi breaks suspend-to-disk as well.  It gets up to "Suspending console(s)"
> > > > and then the cursor stops blinking at it wedges up.
> 
> Bisection shows that the resume-from-ram failure is caused by 
> 
> commit 987196fa82d4db52c407e8c9d5dec884ba602183
> Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Date:   Thu Feb 22 13:52:57 2007 -0800
> 
>     cpuidle take2: Core cpuidle infrastructure
>     
> 
> Note that this is the patch which *fixed* resume-from-RAM prior to Thomas's
> git-hrt merge.  Now it breaks it!?!?!

Beats me hands down. :-(

I guess Thomas and Venki should look into it.

> Also, I'm seeing this, in mainline, when I do echo mem > /sys/power/state
> 
> [   26.316685] ipw2200: Failed to send WEP_KEY: Aborted due to RF kill switch.
> [   33.044631] ipw2200: Failed to send WEP_KEY: Command timed out.
> [   39.862821] ipw2200: Failed to send WEP_KEY: Command timed out.
> [   68.962896] PM: Preparing system for mem sleep
> [   68.979485] Stopping tasks ... WARNING: at kernel/lockdep.c:2658 check_flags()
> [   68.980154]  [<c0104ea4>] show_trace_log_lvl+0x1a/0x2f
> [   68.980295]  [<c0105a44>] show_trace+0x12/0x14
> [   68.980416]  [<c0105a5b>] dump_stack+0x15/0x17
> [   68.980535]  [<c0137276>] check_flags+0x93/0x13d
> [   68.980663]  [<c013a8ab>] lock_acquire+0x3a/0x91
> [   68.980789]  [<c031948b>] _spin_lock+0x38/0x62
> [   68.980913]  [<c0142a4d>] refrigerator+0x13/0xc2
> [   68.981040]  [<c01283a2>] get_signal_to_deliver+0x32/0x405
> [   68.981188]  [<c01035f4>] do_notify_resume+0x91/0x69f
> [   68.981323]  [<c010402d>] work_notifysig+0x13/0x1a
> [   68.981453]  =======================
> [   68.981542] irq event stamp: 1511
> [   68.981624] hardirqs last  enabled at (1511): [<c010408d>] syscall_exit_work+0x11/0x26
> [   68.981834] hardirqs last disabled at (1510): [<c0103f63>] syscall_exit+0x9/0x1a
> [   68.982031] softirqs last  enabled at (1418): [<c03104c3>] unix_accept+0xe5/0xfb
> [   68.982230] softirqs last disabled at (1416): [<c031958d>] _write_lock_bh+0xf/0x67

I guess task_lock(current) in refrigerator() triggers this, which probably means that
task_lock(current) has been taken with interrupts disabled somewhere.

I'm not sure if my interpretation is correct, though.

I also don't really know what I'm supposed to do about it ...
 
> > > Can you please compile with CONFIG_DISABLE_CONSOLE_SUSPEND set and try:
> > 
> > Ah, that's -mm, sorry.  Instead of setting CONFIG_DISABLE_CONSOLE_SUSPEND
> > (which has been removed) please pass no_console_suspend in the command line.
> > 
> 
> Didn't appear to change anything.  Bear in mind that e100 netconsole is a
> bit busted across resume anyway, and the video display on this machine has
> never ever survived resume-from-ram (but the X server can bring it back).

s2ram might help here (http://en.opensuse.org/s2ram), but I guess the Vaio is
not on the whitelist ...
