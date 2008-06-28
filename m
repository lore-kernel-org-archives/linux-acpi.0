From: Len Brown <lenb@kernel.org>
Subject: [PATCH 50/84] ACPI: Create "idle=halt" bootparam
Date: Sat, 28 Jun 2008 01:43:54 -0400
Message-ID: <dbce8340e4549b612ac74fc7175721f9aed67b62.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61962 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbYF1FpY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:24 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500HMGRZHJHLA@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:18 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

"idle=halt" limits the idle loop to using
the halt instruction.  No MWAIT, no IO accesses,
no C-states deeper than C1.

If something is broken in the idle code,
"idle=halt" is a less severe workaround
than "idle=poll" which disables all power savings.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    4 +++-
 arch/ia64/kernel/process.c          |    2 ++
 arch/x86/kernel/process.c           |   17 ++++++++++++++++-
 drivers/acpi/processor_idle.c       |   22 ++++++++++++++++++++++
 include/asm-ia64/processor.h        |    1 +
 include/asm-x86/processor.h         |    1 +
 6 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e07c432..bf8b527 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -785,7 +785,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			See Documentation/ide/ide.txt.
 
 	idle=		[X86]
-			Format: idle=poll or idle=mwait
+			Format: idle=poll or idle=mwait, idle=halt
 			Poll forces a polling idle loop that can slightly improves the performance
 			of waking up a idle CPU, but will use a lot of power and make the system
 			run hot. Not recommended.
@@ -793,6 +793,8 @@ and is between 256 and 4096 characters. It is defined in the file
 			to not use it because it doesn't save as much power as a normal idle
 			loop use the MONITOR/MWAIT idle loop anyways. Performance should be the same
 			as idle=poll.
+			idle=halt. Halt is forced to be used for CPU idle.
+			In such case C2/C3 won't be used again.
 
 	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
 			Claim all unknown PCI IDE storage controllers.
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index a3a34b4..216e395 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -55,6 +55,8 @@ void (*ia64_mark_idle)(int);
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
+unsigned long idle_halt;
+EXPORT_SYMBOL(idle_halt);
 
 void
 ia64_do_show_stack (struct unw_frame_info *info, void *arg)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ba370dc..2b38ec8 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
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
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 556ee15..a6edf84 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
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
@@ -955,6 +957,17 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
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
@@ -1780,6 +1793,15 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
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
diff --git a/include/asm-ia64/processor.h b/include/asm-ia64/processor.h
index 6aff126..f36e28a 100644
--- a/include/asm-ia64/processor.h
+++ b/include/asm-ia64/processor.h
@@ -763,6 +763,7 @@ prefetchw (const void *x)
 #define spin_lock_prefetch(x)	prefetchw(x)
 
 extern unsigned long boot_option_idle_override;
+extern unsigned long idle_halt;
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/include/asm-x86/processor.h b/include/asm-x86/processor.h
index 5591052..3ee8687 100644
--- a/include/asm-x86/processor.h
+++ b/include/asm-x86/processor.h
@@ -732,6 +732,7 @@ extern int			force_mwait;
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
 extern unsigned long		boot_option_idle_override;
+extern unsigned long		idle_halt;
 
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
-- 
1.5.6.1.89.gd544

