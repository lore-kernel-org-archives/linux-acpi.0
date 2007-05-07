From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch] ACPI: Keep TSC stable, when lapic_timer_c2_ok is set
Date: Mon, 07 May 2007 18:33:31 +0200
Message-ID: <1178555611.3042.13.camel@localhost.localdomain>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:47963 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965749AbXEGQas (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 May 2007 12:30:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Len,

can you please integrate the patch into your git tree to make Andrew
happier. I'd like to see this in 2.6.22 if possible.

Thanks,

	tglx

------------------------>

Subject: ACPI: Keep TSC stable, when lapic_timer_c2_ok is set

The local apic timer stop in C2 resp. C3 states is coupled with the
stop of the TSC. When the local apic timer is marked stable in C2
on the kernel commandline, then keep the TSC marked stable in C2 as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/acpi/processor_idle.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

Index: linux-acpi-2.6/drivers/acpi/processor_idle.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/processor_idle.c
+++ linux-acpi-2.6/drivers/acpi/processor_idle.c
@@ -305,18 +305,23 @@ static void acpi_state_timer_broadcast(s
 				       struct acpi_processor_cx *cx,
 				       int broadcast)
 {
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-
 	int state = cx - pr->power.states;
 
 	if (state >= pr->power.timer_broadcast_on_state) {
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
 		unsigned long reason;
 
 		reason = broadcast ?  CLOCK_EVT_NOTIFY_BROADCAST_ENTER :
 			CLOCK_EVT_NOTIFY_BROADCAST_EXIT;
 		clockevents_notify(reason, &pr->id);
-	}
 #endif
+
+#ifdef CONFIG_GENERIC_TIME
+		/* TSC halts in C2/3, so notify users */
+		mark_tsc_unstable();
+#endif
+	}
 }
 
 #else
@@ -481,10 +489,6 @@ static void acpi_processor_idle(void)
 		/* Get end time (ticks) */
 		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
-#ifdef CONFIG_GENERIC_TIME
-		/* TSC halts in C2, so notify users */
-		mark_tsc_unstable();
-#endif
 		/* Re-enable interrupts */
 		local_irq_enable();
 		current_thread_info()->status |= TS_POLLING;
@@ -523,10 +527,6 @@ static void acpi_processor_idle(void)
 			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
 		}
 
-#ifdef CONFIG_GENERIC_TIME
-		/* TSC halts in C3, so notify users */
-		mark_tsc_unstable();
-#endif
 		/* Re-enable interrupts */
 		local_irq_enable();
 		current_thread_info()->status |= TS_POLLING;


