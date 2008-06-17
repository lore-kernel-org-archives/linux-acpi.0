From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Tue, 17 Jun 2008 09:12:03 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0806170905221.3395@apollo.tec.linutronix.de>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <Pine.LNX.4.55.0806161636510.20218@cliff.in.clinika.pl> <200806170038.37224.rjw@sisk.pl> <200806170105.45647.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:48410 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbYFQHRE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jun 2008 03:17:04 -0400
In-Reply-To: <200806170105.45647.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tue, 17 Jun 2008, Rafael J. Wysocki wrote:
> 
> BTW, with the C1E patches reverted I don't get the
> WARNING: at /home/rafael/src/linux-next/kernel/smp.c:215 smp_call_function_single+0x3d/0xa2
> in the log.  Thomas?

Yeah, my bad. Fix below.

Thanks,
	tglx

------------------->
Subject: x86: c1e_idle, run BROADCAST_FORCE notify with irqs enabled
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 17 Jun 2008 09:07:53 +0200

The BROADCAST_FORCE notification uses smp_function_call and therefor
must be run with interrupts enabled.

While at it, add a comment for the BROADCAST_EXIT notifier as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 57fa86d..1450e0f 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -267,17 +267,29 @@ static void c1e_idle(void)
 
 		if (!cpu_isset(cpu, c1e_mask)) {
 			cpu_set(cpu, c1e_mask);
-			/* Force broadcast so ACPI can not interfere */
+			/*
+			 * Force broadcast so ACPI can not interfere. Needs
+			 * to run with interrupts enabled as it uses
+			 * smp_function_call.
+			 */
+			local_irq_enable();
 			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_FORCE,
 					   &cpu);
 			printk(KERN_INFO "Switch to broadcast mode on CPU%d\n",
 			       cpu);
+			local_irq_disable();
 		}
 		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
+
 		default_idle();
-		local_irq_disable();
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
-		local_irq_enable();
+
+		/*
+		 * The switch back from broadcast mode needs to be
+		 * called with interrupts disabled.
+		 */
+		 local_irq_disable();
+		 clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
+		 local_irq_enable();
 	} else
 		default_idle();
 }

