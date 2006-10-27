From: Len Brown <len.brown@intel.com>
Subject: [PATCH 2.6.16.stable] ACPI: enable SMP C-states on x86_64
Date: Fri, 27 Oct 2006 00:39:58 -0400
Message-ID: <200610270039.59254.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51644 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932287AbWJ0Ekb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Oct 2006 00:40:31 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-acpi@vger.kernel.org

>From ffd642e748c867a7339b57225b8bf8b9a0dcd9c5 Mon Sep 17 00:00:00 2001
Message-Id: <ffd642e748c867a7339b57225b8bf8b9a0dcd9c5.1160815090.git.len.brown@intel.com>
From: Shaohua Li <shaohua.li@intel.com>
Date: Wed, 8 Feb 2006 17:35:00 -0500
Subject: [PATCH 1/1] ACPI: enable SMP C-states on x86_64
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center

http://bugzilla.kernel.org/show_bug.cgi?id=5653

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86_64/kernel/acpi/Makefile    |    1 +
 arch/x86_64/kernel/acpi/processor.c |   72 -----------------------------------
 include/asm-x86_64/acpi.h           |    2 +
 3 files changed, 3 insertions(+), 72 deletions(-)

diff --git a/arch/x86_64/kernel/acpi/Makefile b/arch/x86_64/kernel/acpi/Makefile
index 4fe9707..080b996 100644
--- a/arch/x86_64/kernel/acpi/Makefile
+++ b/arch/x86_64/kernel/acpi/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wake
 
 ifneq ($(CONFIG_ACPI_PROCESSOR),)
 obj-y			+= processor.o
+processor-y		:= ../../../i386/kernel/acpi/processor.o ../../../i386/kernel/acpi/cstate.o
 endif
 
diff --git a/arch/x86_64/kernel/acpi/processor.c b/arch/x86_64/kernel/acpi/processor.c
deleted file mode 100644
index 3bdc2ba..0000000
--- a/arch/x86_64/kernel/acpi/processor.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * arch/x86_64/kernel/acpi/processor.c
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
-static void init_intel_pdc(struct acpi_processor *pr, struct cpuinfo_x86 *c)
-{
-	struct acpi_object_list *obj_list;
-	union acpi_object *obj;
-	u32 *buf;
-
-	/* allocate and initialize pdc. It will be used later. */
-	obj_list = kmalloc(sizeof(struct acpi_object_list), GFP_KERNEL);
-	if (!obj_list) {
-		printk(KERN_ERR "Memory allocation error\n");
-		return;
-	}
-
-	obj = kmalloc(sizeof(union acpi_object), GFP_KERNEL);
-	if (!obj) {
-		printk(KERN_ERR "Memory allocation error\n");
-		kfree(obj_list);
-		return;
-	}
-
-	buf = kmalloc(12, GFP_KERNEL);
-	if (!buf) {
-		printk(KERN_ERR "Memory allocation error\n");
-		kfree(obj);
-		kfree(obj_list);
-		return;
-	}
-
-	buf[0] = ACPI_PDC_REVISION_ID;
-	buf[1] = 1;
-	buf[2] = ACPI_PDC_EST_CAPABILITY_SMP;
-
-	obj->type = ACPI_TYPE_BUFFER;
-	obj->buffer.length = 12;
-	obj->buffer.pointer = (u8 *) buf;
-	obj_list->count = 1;
-	obj_list->pointer = obj;
-	pr->pdc = obj_list;
-
-	return;
-}
-
-/* Initialize _PDC data based on the CPU vendor */
-void arch_acpi_processor_init_pdc(struct acpi_processor *pr)
-{
-	unsigned int cpu = pr->id;
-	struct cpuinfo_x86 *c = cpu_data + cpu;
-
-	pr->pdc = NULL;
-	if (c->x86_vendor == X86_VENDOR_INTEL && cpu_has(c, X86_FEATURE_EST))
-		init_intel_pdc(pr, c);
-
-	return;
-}
-
-EXPORT_SYMBOL(arch_acpi_processor_init_pdc);
diff --git a/include/asm-x86_64/acpi.h b/include/asm-x86_64/acpi.h
index aa1c7b2..2c95a31 100644
--- a/include/asm-x86_64/acpi.h
+++ b/include/asm-x86_64/acpi.h
@@ -162,6 +162,8 @@ extern int acpi_pci_disabled;
 
 extern u8 x86_acpiid_to_apicid[];
 
+#define ARCH_HAS_POWER_INIT 1
+
 extern int acpi_skip_timer_override;
 
 #endif /*__KERNEL__*/
-- 
1.4.3.rc2.g23bed-dirty

