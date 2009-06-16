From: Johannes Stezenbach <js@sig21.net>
Subject: Re: 2.6.30: hibernation/swsusp lockup due to acpi-cpufreq
Date: Tue, 16 Jun 2009 16:22:17 +0200
Message-ID: <20090616142217.GA5548@sig21.net>
References: <20090615232709.GA6059@sig21.net> <200906160216.29537.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759035AbZFPOXO@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200906160216.29537.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 16, 2009 at 02:16:28AM +0200, Rafael J. Wysocki wrote:
> On Tuesday 16 June 2009, Johannes Stezenbach wrote:
> > 
> > on my aging Thinkpad T42p resume from hibernation
> > fails in 2.6.30. There is a backtrace on suspend prior
> > to writing out the disk image, but I cannot capture
> > it due to lack of a serial port on the T42p. On
> > resume the machine is dead after reading the image
> > from disk.
> > 
> > I've bisected this to:
> > 
> >  commit 01599fca6758d2cd133e78f87426fc851c9ea725
> >  Author: Andrew Morton <akpm@linux-foundation.org>
> >  Date:   Mon Apr 13 10:27:49 2009 -0700
> > 
> >     cpufreq: use smp_call_function_[single|many]() in acpi-cpufreq.c
> > 
> > I see in git log that this commit is known broken, but the
> > resume on my machine is still broken in 2.6.30.
> > 
> > If I disable CONFIG_X86_ACPI_CPUFREQ suspend/resume works in 2.6.30.
> 
> Thanks a lot for bisecting this!
> 
> Is it the reason for the enabling of interrupts during cpufreq_suspend()?
> 
> /me wonders
> 
> Is there anything we can do to fix this quickly?

I think your guess was right. The patch below fixes the
problem for me (hang after resume and backtrace on suspend).


Johannes
-----------------------------

Fix swsusp failure on !SMP

Commit 01599fca6758d2cd133e78f87426fc851c9ea725 introduced
a regression which caused a backtrace on suspend and
a hang on resume on a Thinkpad T42p (Pentium M CPU).

Signed-off-by: Johannes Stezenbach <js@sig21.net>


--- linux-2.6.30/kernel/up.c.orig	2009-06-16 15:56:28.000000000 +0200
+++ linux-2.6.30/kernel/up.c	2009-06-16 15:57:27.000000000 +0200
@@ -10,11 +10,13 @@
 int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 				int wait)
 {
+	unsigned long flags;
+
 	WARN_ON(cpu != 0);
 
-	local_irq_disable();
+	local_irq_save(flags);
 	(func)(info);
-	local_irq_enable();
+	local_irq_restore(flags);
 
 	return 0;
 }
