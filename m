From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/34] ACPI: processor: unify arch_acpi_processor_cleanup_pdc
Date: Thu, 24 Dec 2009 01:23:43 -0500
Message-ID: <47817254b8637b56730aec26eed2c337d3938bb5.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809AbZLXTbb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:31 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:12 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

The x86 and ia64 implementations of the function in $subject are
exactly the same.

Also, since the arch-specific implementations of setting _PDC have
been completely hollowed out, remove the empty shells.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/kernel/Makefile         |    4 ----
 arch/ia64/kernel/acpi-processor.c |   27 ---------------------------
 arch/x86/kernel/acpi/Makefile     |    2 +-
 arch/x86/kernel/acpi/processor.c  |   25 -------------------------
 drivers/acpi/processor_pdc.c      |   21 ++++++++++++++++++++-
 include/acpi/processor.h          |    2 --
 6 files changed, 21 insertions(+), 60 deletions(-)
 delete mode 100644 arch/ia64/kernel/acpi-processor.c
 delete mode 100644 arch/x86/kernel/acpi/processor.c

diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 2a75e93..e123634 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -18,10 +18,6 @@ obj-$(CONFIG_IA64_GENERIC)	+= acpi-ext.o
 obj-$(CONFIG_IA64_HP_ZX1)	+= acpi-ext.o
 obj-$(CONFIG_IA64_HP_ZX1_SWIOTLB) += acpi-ext.o
 
-ifneq ($(CONFIG_ACPI_PROCESSOR),)
-obj-y				+= acpi-processor.o
-endif
-
 obj-$(CONFIG_IA64_PALINFO)	+= palinfo.o
 obj-$(CONFIG_IOSAPIC)		+= iosapic.o
 obj-$(CONFIG_MODULES)		+= module.o
diff --git a/arch/ia64/kernel/acpi-processor.c b/arch/ia64/kernel/acpi-processor.c
deleted file mode 100644
index 7ba5acc..0000000
--- a/arch/ia64/kernel/acpi-processor.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * arch/ia64/kernel/acpi-processor.c
- *
- * Copyright (C) 2005 Intel Corporation
- * 	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
- * 	- Added _PDC for platforms with Intel CPUs
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/acpi.h>
-
-#include <acpi/processor.h>
-#include <asm/acpi.h>
-
-void arch_acpi_processor_cleanup_pdc(struct acpi_processor *pr)
-{
-	if (pr->pdc) {
-		kfree(pr->pdc->pointer->buffer.pointer);
-		kfree(pr->pdc->pointer);
-		kfree(pr->pdc);
-		pr->pdc = NULL;
-	}
-}
-
-EXPORT_SYMBOL(arch_acpi_processor_cleanup_pdc);
diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
index fd5ca97..6f35260 100644
--- a/arch/x86/kernel/acpi/Makefile
+++ b/arch/x86/kernel/acpi/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_ACPI)		+= boot.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_rm.o wakeup_$(BITS).o
 
 ifneq ($(CONFIG_ACPI_PROCESSOR),)
-obj-y				+= cstate.o processor.o
+obj-y				+= cstate.o
 endif
 
 $(obj)/wakeup_rm.o:    $(obj)/realmode/wakeup.bin
diff --git a/arch/x86/kernel/acpi/processor.c b/arch/x86/kernel/acpi/processor.c
deleted file mode 100644
index 0f57307..0000000
--- a/arch/x86/kernel/acpi/processor.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (C) 2005 Intel Corporation
- * 	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
- * 	- Added _PDC for platforms with Intel CPUs
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/acpi.h>
-
-#include <acpi/processor.h>
-#include <asm/acpi.h>
-
-void arch_acpi_processor_cleanup_pdc(struct acpi_processor *pr)
-{
-	if (pr->pdc) {
-		kfree(pr->pdc->pointer->buffer.pointer);
-		kfree(pr->pdc->pointer);
-		kfree(pr->pdc);
-		pr->pdc = NULL;
-	}
-}
-
-EXPORT_SYMBOL(arch_acpi_processor_cleanup_pdc);
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 48df08e..e786e2c 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -1,3 +1,12 @@
+/*
+ * Copyright (C) 2005 Intel Corporation
+ * Copyright (C) 2009 Hewlett-Packard Development Company, L.P.
+ *
+ *	Alex Chiang <achiang@hp.com>
+ *	- Unified x86/ia64 implementations
+ *	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *	- Added _PDC for platforms with Intel CPUs
+ */
 #include <linux/dmi.h>
 
 #include <acpi/acpi_drivers.h>
@@ -121,6 +130,16 @@ static int acpi_processor_eval_pdc(struct acpi_processor *pr)
 	return status;
 }
 
+static void acpi_processor_cleanup_pdc(struct acpi_processor *pr)
+{
+	if (pr->pdc) {
+		kfree(pr->pdc->pointer->buffer.pointer);
+		kfree(pr->pdc->pointer);
+		kfree(pr->pdc);
+		pr->pdc = NULL;
+	}
+}
+
 void acpi_processor_set_pdc(struct acpi_processor *pr)
 {
 	if (arch_has_acpi_pdc() == false)
@@ -128,7 +147,7 @@ void acpi_processor_set_pdc(struct acpi_processor *pr)
 
 	acpi_processor_init_pdc(pr);
 	acpi_processor_eval_pdc(pr);
-	arch_acpi_processor_cleanup_pdc(pr);
+	acpi_processor_cleanup_pdc(pr);
 }
 EXPORT_SYMBOL_GPL(acpi_processor_set_pdc);
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 50edd73..0873cd5 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -257,8 +257,6 @@ int acpi_processor_notify_smm(struct module *calling_module);
 DECLARE_PER_CPU(struct acpi_processor *, processors);
 extern struct acpi_processor_errata errata;
 
-void arch_acpi_processor_cleanup_pdc(struct acpi_processor *pr);
-
 #ifdef ARCH_HAS_POWER_INIT
 void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 					unsigned int cpu);
-- 
1.6.0.6

