From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH2/4] ACPI :  Add the boot option of "idle=halt" to use halt
	for CPU idle
Date: Tue, 24 Jun 2008 17:58:53 +0800
Message-ID: <1214301533.31069.7.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65371 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195AbYFXJsF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jun 2008 05:48:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: Add the boot option of "idle=halt" to use halt for CPU idle
From: Zhao Yakui <yakui.zhao@intel.com>

    If the boot option of "idle=halt" is added, OSPM will be forced to use
Halt for CPU idle. In such case CPU C2/C3 is meaningless and only C1 is used.
At the same time halt instruction is used for CPU C1.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 Documentation/kernel-parameters.txt |    4 +++-
 arch/ia64/kernel/process.c          |    2 ++
 arch/x86/kernel/process.c           |   17 ++++++++++++++++-
 drivers/acpi/processor_idle.c       |   22 ++++++++++++++++++++++
 include/asm-ia64/processor.h        |    1 +
 include/asm-x86/processor.h         |    1 +
 6 files changed, 45 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/x86/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/process.c
+++ linux-2.6/arch/x86/kernel/process.c
@@ -6,6 +6,10 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/pm.h>
+#include <asm/system.h>
+
+unsigned long idle_halt;
+EXPORT_SYMBOL(idle_halt);
 
 struct kmem_cache *task_xstate_cachep;
 
@@ -169,7 +173,18 @@ static int __init idle_setup(char *str)
 		pm_idle = poll_idle;
 	} else if (!strcmp(str, "mwait"))
 		force_mwait = 1;
-	else
+	else if (!strcmp(str, "halt")) {
+		/*
+		 * When the boot option of idle=halt is added, halt is
+		 * forced to be used for CPU idle. In such case CPU C2/C3
+		 * won't be used again.
+		 * To continue to load the CPU idle driver, don't touch
+		 * the boot_option_idle_override.
+		 */
+		pm_idle = default_idle;
+		idle_halt = 1;
+		return 0;
+	} else
 		return -1;
 
 	boot_option_idle_override = 1;
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -785,7 +785,7 @@ and is between 256 and 4096 characters. 
 			See Documentation/ide/ide.txt.
 
 	idle=		[X86]
-			Format: idle=poll or idle=mwait
+			Format: idle=poll or idle=mwait, idle=halt
 			Poll forces a polling idle loop that can slightly improves the performance
 			of waking up a idle CPU, but will use a lot of power and make the system
 			run hot. Not recommended.
@@ -793,6 +793,8 @@ and is between 256 and 4096 characters. 
 			to not use it because it doesn't save as much power as a normal idle
 			loop use the MONITOR/MWAIT idle loop anyways. Performance should be the same
 			as idle=poll.
+			idle=halt. Halt is forced to be used for CPU idle.
+			In such case C2/C3 won't be used again.
 
 	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
 			Claim all unknown PCI IDE storage controllers.
Index: linux-2.6/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/process.c
+++ linux-2.6/arch/ia64/kernel/process.c
@@ -55,6 +55,8 @@ void (*ia64_mark_idle)(int);
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
+unsigned long idle_halt;
+EXPORT_SYMBOL(idle_halt);
 
 void
 ia64_do_show_stack (struct unw_frame_info *info, void *arg)
Index: linux-2.6/include/asm-ia64/processor.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/processor.h
+++ linux-2.6/include/asm-ia64/processor.h
@@ -763,6 +763,7 @@ prefetchw (const void *x)
 #define spin_lock_prefetch(x)	prefetchw(x)
 
 extern unsigned long boot_option_idle_override;
+extern unsigned long idle_halt;
 
 #endif /* !__ASSEMBLY__ */
 
Index: linux-2.6/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_idle.c
+++ linux-2.6/drivers/acpi/processor_idle.c
@@ -41,6 +41,7 @@
 #include <linux/pm_qos_params.h>
 #include <linux/clockchips.h>
 #include <linux/cpuidle.h>
+#include <linux/cpuidle.h>
 
 /*
  * Include the apic definitions for x86 to have the APIC timer related defines
@@ -57,6 +58,7 @@
 
 #include <acpi/acpi_bus.h>
 #include <acpi/processor.h>
+#include <asm/processor.h>
 
 #define ACPI_PROCESSOR_COMPONENT        0x01000000
 #define ACPI_PROCESSOR_CLASS            "processor"
@@ -955,6 +957,17 @@ static int acpi_processor_get_power_info
 			} else {
 				continue;
 			}
+			if (cx.type == ACPI_STATE_C1 && idle_halt) {
+				/*
+				 * In most cases the C1 space_id obtained from
+				 * _CST object is FIXED_HARDWARE access mode.
+				 * But when the option of idle=halt is added,
+				 * the entry_method type should be changed from
+				 * CSTATE_FFH to CSTATE_HALT.
+				 */
+				cx.entry_method = ACPI_CSTATE_HALT;
+				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
+			}
 		} else {
 			snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
 				 cx.address);
@@ -1780,6 +1793,15 @@ int __cpuinit acpi_processor_power_init(
 		return 0;
 
 	if (!first_run) {
+		if (idle_halt) {
+			/*
+			 * When the boot option of "idle=halt" is added, halt
+			 * is used for CPU IDLE.
+			 * In such case C2/C3 is meaningless. So the max_cstate
+			 * is set to one.
+			 */
+			max_cstate = 1;
+		}
 		dmi_check_system(processor_power_dmi_table);
 		max_cstate = acpi_processor_cstate_check(max_cstate);
 		if (max_cstate < ACPI_C_STATES_MAX)
Index: linux-2.6/include/asm-x86/processor.h
===================================================================
--- linux-2.6.orig/include/asm-x86/processor.h
+++ linux-2.6/include/asm-x86/processor.h
@@ -732,6 +732,7 @@ extern int			force_mwait;
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
 extern unsigned long		boot_option_idle_override;
+extern unsigned long		idle_halt;
 
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);


