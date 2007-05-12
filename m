From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Sat, 12 May 2007 13:44:13 +0200
Message-ID: <1178970253.22481.143.camel@localhost.localdomain>
References: <20070430102837.748238000@linutronix.de>
	 <20070511132846.5ebf4437.akpm@linux-foundation.org>
	 <200705112302.47726.rjw@sisk.pl> <200705112309.15996.rjw@sisk.pl>
	 <20070511235607.83ad0eb5.akpm@linux-foundation.org>
	 <1178959563.22481.126.camel@localhost.localdomain>
	 <20070512020056.a24cf472.akpm@linux-foundation.org>
	 <1178961489.22481.133.camel@localhost.localdomain>
	 <20070512030754.90488f79.akpm@linux-foundation.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:48262 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755828AbXELLlJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2007 07:41:09 -0400
In-Reply-To: <20070512030754.90488f79.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Sat, 2007-05-12 at 03:07 -0700, Andrew Morton wrote:
> On Sat, 12 May 2007 11:18:09 +0200 Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > It's peculiar that the hang happens when acpi_evaluate_object() hits its
> > > return statement.  Any theories there?
> > 
> > Only stack or memory corruption come into mind, but I have no clue how
> > this is related to the resume logic changes.
> 
> So I had the brilliant idea of turning on some kernel debugging.  It's
> a shame that CONFIG_SOFTWARE_SUSPEND disables CONFIG_DEBUG_PAGEALLOC.

Really brilliant. I tried to reproduce your problem and stumbled across
something else.

	tglx

------------------------------->
Subject: clocksource fix lock order in the resume path

lockdep complains about the lock nesting of clocksource and watchdog
lock in the resume path. Move watchdog resume out of the clocksource
lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.21/kernel/time/clocksource.c
===================================================================
--- linux-2.6.21.orig/kernel/time/clocksource.c
+++ linux-2.6.21/kernel/time/clocksource.c
@@ -151,9 +151,11 @@ static void clocksource_watchdog(unsigne
 }
 static void clocksource_resume_watchdog(void)
 {
-	spin_lock(&watchdog_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&watchdog_lock, flags);
 	watchdog_resumed = 1;
-	spin_unlock(&watchdog_lock);
+	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
 static void clocksource_check_watchdog(struct clocksource *cs)
@@ -224,9 +226,9 @@ void clocksource_resume(void)
 			cs->resume();
 	}
 
-	clocksource_resume_watchdog();
-
 	spin_unlock_irqrestore(&clocksource_lock, flags);
+
+	clocksource_resume_watchdog();
 }
 
 /**


