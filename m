From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Sat, 12 May 2007 10:46:03 +0200
Message-ID: <1178959563.22481.126.camel@localhost.localdomain>
References: <20070430102837.748238000@linutronix.de>
	 <20070511132846.5ebf4437.akpm@linux-foundation.org>
	 <200705112302.47726.rjw@sisk.pl> <200705112309.15996.rjw@sisk.pl>
	 <20070511235607.83ad0eb5.akpm@linux-foundation.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:53935 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755052AbXELInA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2007 04:43:00 -0400
In-Reply-To: <20070511235607.83ad0eb5.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Fri, 2007-05-11 at 23:56 -0700, Andrew Morton wrote:
> On Fri, 11 May 2007 23:09:15 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > > 
> > > > hm, Fedora don't seem to want to give me an RPM which contains acpidump and
> > > > all the yum servers are featuring scrogged checksums.  I could build it, I
> > > > guess, but there's a principle involved ;)
> > > > 
> > > > http://userweb.kernel.org/~akpm/dsdt is /proc/acpi/dsdt.  Is that OK?
> > > 
> > > Yes, thanks.
> > 
> > Hmm, have you tried to do 'echo shutdown > /sys/power/disk' before the
> > hibernation?
> 
> That didn't change the behaviour.

Andrew,

can you try the desperate witchcraft patch below ?

	tglx

Index: linux-2.6.21/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.21.orig/arch/i386/kernel/apic.c
+++ linux-2.6.21/arch/i386/kernel/apic.c
@@ -238,9 +238,13 @@ static void lapic_timer_setup(enum clock
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
-		v = apic_read(APIC_LVTT);
-		v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
-		apic_write_around(APIC_LVTT, v);
+
+		if (evt->mode == CLOCK_EVT_MODE_PERIODIC ||
+		    evt->mode == CLOCK_EVT_MODE_ONESHOT) {
+			v = apic_read(APIC_LVTT);
+			v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
+			apic_write_around(APIC_LVTT, v);
+		}
 		break;
 	case CLOCK_EVT_MODE_RESUME:
 		/* Nothing to do here */


