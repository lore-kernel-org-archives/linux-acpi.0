From: akpm@linux-foundation.org
Subject: [patch 35/74] ACPI keep track of timer broadcasting
Date: Fri, 16 Feb 2007 01:27:55 -0800
Message-ID: <200702160927.l1G9RuRs025952@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:35411 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966262AbXBPJ20 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 04:28:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, tglx@linutronix.de, ak@suse.de, johnstul@us.ibm.com, len.brown@intel.com, linux-acpi@vger.kernel.org, mingo@elte.hu, zippel@linux-m68k.org

From: Thomas Gleixner <tglx@linutronix.de>

This is a preperatory patch for highres/dyntick:

- replace the big #ifdef ARCH_APICTIMER_STOPS_ON_C3 hackery by functions

- remove the double switch in the power verify function (in the worst case
  we switched ipi to apic and 20usec later apic to ipi)

- keep track of the the state which stops local APIC timer

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <len.brown@intel.com>
Cc: <linux-acpi@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_idle.c |   66 ++++++++++++++++++++++----------
 include/acpi/processor.h      |    1 
 2 files changed, 48 insertions(+), 19 deletions(-)

diff -puN drivers/acpi/processor_idle.c~acpi-keep-track-of-timer-broadcasting drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~acpi-keep-track-of-timer-broadcasting
+++ a/drivers/acpi/processor_idle.c
@@ -248,6 +248,48 @@ static void acpi_cstate_enter(struct acp
 	}
 }
 
+#ifdef ARCH_APICTIMER_STOPS_ON_C3
+
+/*
+ * Some BIOS implementations switch to C3 in the published C2 state.
+ * This seems to be a common problem on AMD boxen, but other vendors
+ * are affected too. We pick the most conservative approach: we assume
+ * that the local APIC stops in both C2 and C3.
+ */
+static void acpi_timer_check_state(int state, struct acpi_processor *pr,
+				   struct acpi_processor_cx *cx)
+{
+	struct acpi_processor_power *pwr = &pr->power;
+
+	/*
+	 * Check, if one of the previous states already marked the lapic
+	 * unstable
+	 */
+	if (pwr->timer_broadcast_on_state < state)
+		return;
+
+	if (cx->type >= ACPI_STATE_C2)
+		pr->power.timer_broadcast_on_state = state;
+}
+
+static void acpi_propagate_timer_broadcast(struct acpi_processor *pr)
+{
+	cpumask_t mask = cpumask_of_cpu(pr->id);
+
+	if (pr->power.timer_broadcast_on_state < INT_MAX)
+		on_each_cpu(switch_APIC_timer_to_ipi, &mask, 1, 1);
+	else
+		on_each_cpu(switch_ipi_to_APIC_timer, &mask, 1, 1);
+}
+
+#else
+
+static void acpi_timer_check_state(int state, struct acpi_processor *pr,
+				   struct acpi_processor_cx *cstate) { }
+static void acpi_propagate_timer_broadcast(struct acpi_processor *pr) { }
+
+#endif
+
 static void acpi_processor_idle(void)
 {
 	struct acpi_processor *pr = NULL;
@@ -914,11 +956,7 @@ static int acpi_processor_power_verify(s
 	unsigned int i;
 	unsigned int working = 0;
 
-#ifdef ARCH_APICTIMER_STOPS_ON_C3
-	int timer_broadcast = 0;
-	cpumask_t mask = cpumask_of_cpu(pr->id);
-	on_each_cpu(switch_ipi_to_APIC_timer, &mask, 1, 1);
-#endif
+	pr->power.timer_broadcast_on_state = INT_MAX;
 
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		struct acpi_processor_cx *cx = &pr->power.states[i];
@@ -930,21 +968,14 @@ static int acpi_processor_power_verify(s
 
 		case ACPI_STATE_C2:
 			acpi_processor_power_verify_c2(cx);
-#ifdef ARCH_APICTIMER_STOPS_ON_C3
-			/* Some AMD systems fake C3 as C2, but still
-			   have timer troubles */
-			if (cx->valid && 
-				boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-				timer_broadcast++;
-#endif
+			if (cx->valid)
+				acpi_timer_check_state(i, pr, cx);
 			break;
 
 		case ACPI_STATE_C3:
 			acpi_processor_power_verify_c3(pr, cx);
-#ifdef ARCH_APICTIMER_STOPS_ON_C3
 			if (cx->valid)
-				timer_broadcast++;
-#endif
+				acpi_timer_check_state(i, pr, cx);
 			break;
 		}
 
@@ -952,10 +983,7 @@ static int acpi_processor_power_verify(s
 			working++;
 	}
 
-#ifdef ARCH_APICTIMER_STOPS_ON_C3
-	if (timer_broadcast)
-		on_each_cpu(switch_APIC_timer_to_ipi, &mask, 1, 1);
-#endif
+	acpi_propagate_timer_broadcast(pr);
 
 	return (working);
 }
diff -puN include/acpi/processor.h~acpi-keep-track-of-timer-broadcasting include/acpi/processor.h
--- a/include/acpi/processor.h~acpi-keep-track-of-timer-broadcasting
+++ a/include/acpi/processor.h
@@ -79,6 +79,7 @@ struct acpi_processor_power {
 	u32 bm_activity;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
+	int timer_broadcast_on_state;
 };
 
 /* Performance Management */
_
