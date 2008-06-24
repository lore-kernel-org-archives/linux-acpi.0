From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH3/4] ACPI :  Add boot option of "idle=nomwait" to disable
	mwait for CPU C-states
Date: Tue, 24 Jun 2008 18:01:09 +0800
Message-ID: <1214301669.31069.9.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1166 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096AbYFXJua (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jun 2008 05:50:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject:ACPI:Add boot option of "idle=nomwait" to disable mwait for CPU C-states
From: Zhao Yakui <yakui.zhao@intel.com>

Add the boot option of "idle=nomwait" to disable Mwait for CPU C-states.
If the boot option of "idle=nomwait" is added , OSPM should not
use mwait for cpu idle even when the mwait is supported. In such case the
C2C3_FFH access mode will be disabled. Of course C1_FFH access mode will
also be disabled.

http://bugzilla.kernel.org/show_bug.cgi?id=10807
http://bugzilla.kernel.org/show_bug.cgi?id=10914

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
---
 Documentation/kernel-parameters.txt |    3 ++-
 arch/ia64/kernel/process.c          |    2 ++
 arch/x86/kernel/process.c           |   11 +++++++++++
 drivers/acpi/processor_core.c       |   13 +++++++++++++
 drivers/acpi/processor_idle.c       |    6 +++++-
 include/asm-ia64/processor.h        |    1 +
 include/asm-x86/processor.h         |    1 +
 7 files changed, 35 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/process.c
+++ linux-2.6/arch/ia64/kernel/process.c
@@ -57,6 +57,8 @@ unsigned long boot_option_idle_override 
 EXPORT_SYMBOL(boot_option_idle_override);
 unsigned long idle_halt;
 EXPORT_SYMBOL(idle_halt);
+unsigned long idle_nomwait;
+EXPORT_SYMBOL(idle_nomwait);
 
 void
 ia64_do_show_stack (struct unw_frame_info *info, void *arg)
Index: linux-2.6/include/asm-ia64/processor.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/processor.h
+++ linux-2.6/include/asm-ia64/processor.h
@@ -764,6 +764,7 @@ prefetchw (const void *x)
 
 extern unsigned long boot_option_idle_override;
 extern unsigned long idle_halt;
+extern unsigned long idle_nomwait;
 
 #endif /* !__ASSEMBLY__ */
 
Index: linux-2.6/include/asm-x86/processor.h
===================================================================
--- linux-2.6.orig/include/asm-x86/processor.h
+++ linux-2.6/include/asm-x86/processor.h
@@ -733,6 +733,7 @@ extern void select_idle_routine(const st
 
 extern unsigned long		boot_option_idle_override;
 extern unsigned long		idle_halt;
+extern unsigned long		idle_nomwait;
 
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
Index: linux-2.6/arch/x86/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/process.c
+++ linux-2.6/arch/x86/kernel/process.c
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
 
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -785,7 +785,7 @@ and is between 256 and 4096 characters. 
 			See Documentation/ide/ide.txt.
 
 	idle=		[X86]
-			Format: idle=poll or idle=mwait, idle=halt
+			Format: idle=poll or idle=mwait, idle=halt, idle=nomwait
 			Poll forces a polling idle loop that can slightly improves the performance
 			of waking up a idle CPU, but will use a lot of power and make the system
 			run hot. Not recommended.
@@ -795,6 +795,7 @@ and is between 256 and 4096 characters. 
 			as idle=poll.
 			idle=halt. Halt is forced to be used for CPU idle.
 			In such case C2/C3 won't be used again.
+			idle=nomwait. Disable mwait for CPU C-states
 
 	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
 			Claim all unknown PCI IDE storage controllers.
Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c
+++ linux-2.6/drivers/acpi/processor_core.c
@@ -265,7 +265,20 @@ static int acpi_processor_set_pdc(struct
 
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
Index: linux-2.6/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_idle.c
+++ linux-2.6/drivers/acpi/processor_idle.c
@@ -957,13 +957,17 @@ static int acpi_processor_get_power_info
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


