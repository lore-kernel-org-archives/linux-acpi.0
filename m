From: Len Brown <lenb@kernel.org>
Subject: [PATCH 69/70] ACPI : Create "idle=nomwait" bootparam
Date: Fri, 20 Jun 2008 03:44:11 -0400
Message-ID: <5ffc8862cc917ae5107049f3c5fd549fb6c19cac.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:54086 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbYFTHsD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:48:03 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R007AC40E2I91@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:41:18 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Add the boot option of "idle=nomwait" to disable Mwait for CPU C-states.
If the boot option of "idle=nomwait" is added , Linux should not
use mwait for cpu idle even when the mwait is supported. In such case the
C2C3_FFH access mode will be disabled.

http://bugzilla.kernel.org/show_bug.cgi?id=10807

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    4 +++-
 arch/ia64/kernel/process.c          |    2 ++
 arch/x86/kernel/process.c           |   14 ++++++++++++++
 drivers/acpi/processor_core.c       |   12 ++++++++++++
 include/asm-ia64/processor.h        |    1 +
 include/asm-x86/processor.h         |    1 +
 6 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1623c2f..39baaba 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -785,7 +785,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			See Documentation/ide/ide.txt.
 
 	idle=		[X86]
-			Format: idle=poll or idle=mwait, idle = halt
+			Format: idle=poll or idle=mwait, idle = halt, idle=nomwait
 			Poll forces a polling idle loop that can slightly improves the performance
 			of waking up a idle CPU, but will use a lot of power and make the system
 			run hot. Not recommended.
@@ -795,6 +795,8 @@ and is between 256 and 4096 characters. It is defined in the file
 			as idle=poll.
 			idle = halt . Halt is forced to be used for CPU idle.
 			In such case C2/C3 won't be used again.
+			idle = nomwait. disable Mwait for CPU C-state.
+			In such case C2C3_FFH access mode will be disabled.
 
 	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
 			Claim all unknown PCI IDE storage controllers.
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index a3a34b4..34249b2 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -55,6 +55,8 @@ void (*ia64_mark_idle)(int);
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
+unsigned long idle_nomwait;
+EXPORT_SYMBOL(idle_nomwait);
 
 void
 ia64_do_show_stack (struct unw_frame_info *info, void *arg)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 6a35c7d..9ec16e7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -7,6 +7,10 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <asm/system.h>
+#include <asm/processor.h>
+
+unsigned long idle_nomwait;
+EXPORT_SYMBOL(idle_nomwait);
 
 struct kmem_cache *task_xstate_cachep;
 
@@ -172,6 +176,16 @@ static int __init idle_setup(char *str)
 		force_mwait = 1;
 	else if (!strcmp(str, "halt"))
 		pm_idle = default_idle;
+	else if (!strcmp(str, "nomwait")) {
+		/*
+		 * If the boot option of "idle=nomwait" is added,
+		 * it means that mwait will be disabled for CPU C2/C3
+		 * states. In such case it won't touch the variable
+		 * of boot_option_idle_override.
+		 */
+		idle_nomwait = 1;
+		return 0;
+	}
 	else
 		return -1;
 
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 9dd0fa9..9e3c168 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -266,6 +266,18 @@ static int acpi_processor_set_pdc(struct acpi_processor *pr)
 	if (!pdc_in)
 		return status;
 
+	if (idle_nomwait) {
+		/*
+		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
+		 * mode will be disabled in the parameter of _PDC object.
+		 */
+		union acpi_object *obj;
+		u32 *buffer = NULL;
+
+		obj = pdc_in->pointer;
+		buffer = (u32 *)(obj->buffer.pointer);
+		buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH);
+	}
 	status = acpi_evaluate_object(pr->handle, "_PDC", pdc_in, NULL);
 
 	if (ACPI_FAILURE(status))
diff --git a/include/asm-ia64/processor.h b/include/asm-ia64/processor.h
index 6aff126..8d893bb 100644
--- a/include/asm-ia64/processor.h
+++ b/include/asm-ia64/processor.h
@@ -763,6 +763,7 @@ prefetchw (const void *x)
 #define spin_lock_prefetch(x)	prefetchw(x)
 
 extern unsigned long boot_option_idle_override;
+extern unsigned long idle_nomwait;
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/include/asm-x86/processor.h b/include/asm-x86/processor.h
index 5591052..33353cf 100644
--- a/include/asm-x86/processor.h
+++ b/include/asm-x86/processor.h
@@ -732,6 +732,7 @@ extern int			force_mwait;
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
 extern unsigned long		boot_option_idle_override;
+extern unsigned long		idle_nomwait;
 
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
-- 
1.5.6

