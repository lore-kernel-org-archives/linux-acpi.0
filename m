From: Len Brown <len.brown@intel.com>
Subject: [PATCH 7/9] ACPI: Only use IPI on known broken machines (AMD, Dothan/BaniasPentium M)
Date: Tue, 20 Mar 2007 11:27:09 -0400
Message-ID: <11744044372247-git-send-email-len.brown@intel.com>
References: <1174404431897-git-send-email-len.brown@intel.com> <11744044323719-git-send-email-len.brown@intel.com> <11744044323692-git-send-email-len.brown@intel.com> <11744044333328-git-send-email-len.brown@intel.com> <11744044341614-git-send-email-len.brown@intel.com> <11744044351759-git-send-email-len.brown@intel.com> <11744044363481-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46827 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933834AbXCTP1e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:27:34 -0400
In-Reply-To: <11744044363481-git-send-email-len.brown@intel.com>
Message-Id: <25496caec111481161e7f06bbfa12a533c43cc6f.1174404137.git.len.brown@intel.com>
In-Reply-To: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
References: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Use IPI for blacklisted CPUs, add parameter IPI vs LAPIC

Currently, Linux disables lapic timer for all machines with C2 and higher
C-state support.

According to Intel only specific Intel models (Banias/Dothan) are broken
in respect of not waking up from C2 with lapic.

However, I am not sure about the naming of the parameter and how it
could/should get integrated into the dyntick part
(CONFIG_GENERIC_CLOCKEVENTS). There, a more fine grained check (TSC
still running?, ..) is needed? Does this make sense (always use
CLOCK_EVT_NOTIFY_BROADCAST_ON, but use OFF if forced by use_ipi=0:
clockevents_notify(use_ipi ? CLOCK_EVT_NOTIFY_BROADCAST_ON :
CLOCK_EVT_NOTIFY_BROADCAST_OFF, &pr->id);

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |   38 +++++++++++++++++++++++++++++---------
 1 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6077300..562124e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -89,6 +89,12 @@ module_param(nocst, uint, 0000);
 static unsigned int bm_history __read_mostly =
     (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
 module_param(bm_history, uint, 0644);
+
+static unsigned use_ipi = 2;
+module_param(use_ipi, uint, 0644);
+MODULE_PARM_DESC(use_ipi, "IPI (vs. LAPIC) irqs for not waking up from C2/C3"
+		 " machines. 0=apic, 1=ipi, 2=auto\n");
+
 /* --------------------------------------------------------------------------
                                 Power Management
    -------------------------------------------------------------------------- */
@@ -260,9 +266,8 @@ static void acpi_cstate_enter(struct acpi_processor_cx *cstate)
 
 /*
  * Some BIOS implementations switch to C3 in the published C2 state.
- * This seems to be a common problem on AMD boxen, but other vendors
- * are affected too. We pick the most conservative approach: we assume
- * that the local APIC stops in both C2 and C3.
+ * This seems to be a common problem on AMD boxen and Intel Dothan/Banias
+ * Pentium M machines.
  */
 static void acpi_timer_check_state(int state, struct acpi_processor *pr,
 				   struct acpi_processor_cx *cx)
@@ -276,8 +281,17 @@ static void acpi_timer_check_state(int state, struct acpi_processor *pr,
 	if (pwr->timer_broadcast_on_state < state)
 		return;
 
-	if (cx->type >= ACPI_STATE_C2)
-		pr->power.timer_broadcast_on_state = state;
+	if (cx->type >= ACPI_STATE_C2) {
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+			pr->power.timer_broadcast_on_state = state;
+		else if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+			  boot_cpu_data.x86 == 6) &&
+			 (boot_cpu_data.x86_model == 13 ||
+			  boot_cpu_data.x86_model == 9))
+		{
+			pr->power.timer_broadcast_on_state = state;
+		}
+	}
 }
 
 static void acpi_propagate_timer_broadcast(struct acpi_processor *pr)
@@ -292,10 +306,16 @@ static void acpi_propagate_timer_broadcast(struct acpi_processor *pr)
 #else
 	cpumask_t mask = cpumask_of_cpu(pr->id);
 
-	if (pr->power.timer_broadcast_on_state < INT_MAX)
+	if (use_ipi == 0)
 		on_each_cpu(switch_APIC_timer_to_ipi, &mask, 1, 1);
-	else
+	else if (use_ipi == 1)
 		on_each_cpu(switch_ipi_to_APIC_timer, &mask, 1, 1);
+	else {
+		if (pr->power.timer_broadcast_on_state < INT_MAX)
+			on_each_cpu(switch_APIC_timer_to_ipi, &mask, 1, 1);
+		else
+			on_each_cpu(switch_ipi_to_APIC_timer, &mask, 1, 1);
+	}
 #endif
 }
 
@@ -1013,13 +1033,13 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
 		case ACPI_STATE_C2:
 			acpi_processor_power_verify_c2(cx);
-			if (cx->valid)
+			if (cx->valid && use_ipi != 0 && use_ipi != 1)
 				acpi_timer_check_state(i, pr, cx);
 			break;
 
 		case ACPI_STATE_C3:
 			acpi_processor_power_verify_c3(pr, cx);
-			if (cx->valid)
+			if (cx->valid && use_ipi != 0 && use_ipi != 1)
 				acpi_timer_check_state(i, pr, cx);
 			break;
 		}
-- 
1.5.0.3.382.g34572
