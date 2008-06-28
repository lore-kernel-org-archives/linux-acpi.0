From: Len Brown <lenb@kernel.org>
Subject: [PATCH 51/84] ACPI : Create "idle=nomwait" bootparam
Date: Sat, 28 Jun 2008 01:43:55 -0400
Message-ID: <75babb03619281837797f1fb5f5ec1f049930f94.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:50759 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbYF1FpT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:19 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BGVRZH9T12@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:18 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

"idle=nomwait" disables the use of the MWAIT
instruction from both C1 (C1_FFH) and deeper (C2C3_FFH)
C-states.

When MWAIT is unavailable, the BIOS and OS generally
negotiate to use the HALT instruction for C1,
and use IO accesses for deeper C-states.

This option is useful for power and performance
comparisons, and also to work around BIOS bugs
where broken MWAIT support is advertised.

http://bugzilla.kernel.org/show_bug.cgi?id=10807
http://bugzilla.kernel.org/show_bug.cgi?id=10914

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    3 ++-
 arch/ia64/kernel/process.c          |    2 ++
 arch/x86/kernel/process.c           |   11 +++++++++++
 drivers/acpi/processor_core.c       |   13 +++++++++++++
 drivers/acpi/processor_idle.c       |    6 +++++-
 include/asm-ia64/processor.h        |    1 +
 include/asm-x86/processor.h         |    1 +
 7 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index bf8b527..c657339 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -785,7 +785,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			See Documentation/ide/ide.txt.
 
 	idle=		[X86]
-			Format: idle=poll or idle=mwait, idle=halt
+			Format: idle=poll or idle=mwait, idle=halt, idle=nomwait
 			Poll forces a polling idle loop that can slightly improves the performance
 			of waking up a idle CPU, but will use a lot of power and make the system
 			run hot. Not recommended.
@@ -795,6 +795,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			as idle=poll.
 			idle=halt. Halt is forced to be used for CPU idle.
 			In such case C2/C3 won't be used again.
+			idle=nomwait. Disable mwait for CPU C-states
 
 	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
 			Claim all unknown PCI IDE storage controllers.
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 216e395..4d5edae 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -57,6 +57,8 @@ unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
 unsigned long idle_halt;
 EXPORT_SYMBOL(idle_halt);
+unsigned long idle_nomwait;
+EXPORT_SYMBOL(idle_nomwait);
 
 void
 ia64_do_show_stack (struct unw_frame_info *info, void *arg)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 2b38ec8..3a4a99d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -10,6 +10,8 @@
 
 unsigned long idle_halt;
 EXPORT_SYMBOL(idle_halt);
+unsigned long idle_nomwait;
+EXPORT_SYMBOL(idle_nomwait);
 
 struct kmem_cache *task_xstate_cachep;
 
@@ -184,6 +186,15 @@ static int __init idle_setup(char *str)
 		pm_idle = default_idle;
 		idle_halt = 1;
 		return 0;
+	} else if (!strcmp(str, "nomwait")) {
+		/*
+		 * If the boot option of "idle=nomwait" is added,
+		 * it means that mwait will be disabled for CPU C2/C3
+		 * states. In such case it won't touch the variable
+		 * of boot_option_idle_override.
+		 */
+		idle_nomwait = 1;
+		return 0;
 	} else
 		return -1;
 
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 9dd0fa9..eb99e18 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -265,7 +265,20 @@ static int acpi_processor_set_pdc(struct acpi_processor *pr)
 
 	if (!pdc_in)
 		return status;
+	if (idle_nomwait) {
+		/*
+		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
+		 * mode will be disabled in the parameter of _PDC object.
+		 * Of course C1_FFH access mode will also be disabled.
+		 */
+		union acpi_object *obj;
+		u32 *buffer = NULL;
 
+		obj = pdc_in->pointer;
+		buffer = (u32 *)(obj->buffer.pointer);
+		buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
+
+	}
 	status = acpi_evaluate_object(pr->handle, "_PDC", pdc_in, NULL);
 
 	if (ACPI_FAILURE(status))
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index a6edf84..2517b1e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -957,13 +957,17 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 			} else {
 				continue;
 			}
-			if (cx.type == ACPI_STATE_C1 && idle_halt) {
+			if (cx.type == ACPI_STATE_C1 &&
+					(idle_halt || idle_nomwait)) {
 				/*
 				 * In most cases the C1 space_id obtained from
 				 * _CST object is FIXED_HARDWARE access mode.
 				 * But when the option of idle=halt is added,
 				 * the entry_method type should be changed from
 				 * CSTATE_FFH to CSTATE_HALT.
+				 * When the option of idle=nomwait is added,
+				 * the C1 entry_method type should be
+				 * CSTATE_HALT.
 				 */
 				cx.entry_method = ACPI_CSTATE_HALT;
 				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
diff --git a/include/asm-ia64/processor.h b/include/asm-ia64/processor.h
index f36e28a..f88fa05 100644
--- a/include/asm-ia64/processor.h
+++ b/include/asm-ia64/processor.h
@@ -764,6 +764,7 @@ prefetchw (const void *x)
 
 extern unsigned long boot_option_idle_override;
 extern unsigned long idle_halt;
+extern unsigned long idle_nomwait;
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/include/asm-x86/processor.h b/include/asm-x86/processor.h
index 3ee8687..3830854 100644
--- a/include/asm-x86/processor.h
+++ b/include/asm-x86/processor.h
@@ -733,6 +733,7 @@ extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
 extern unsigned long		boot_option_idle_override;
 extern unsigned long		idle_halt;
+extern unsigned long		idle_nomwait;
 
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
-- 
1.5.6.1.89.gd544

