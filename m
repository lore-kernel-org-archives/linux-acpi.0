From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/16] suspend: Move NVS save/restore code to generic suspend
 functionality
Date: Fri, 04 Jun 2010 15:51:45 -0400
Message-ID: <cb031741220982290fafdd8e9316d34a227d896e.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:61797 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187Ab0FHTmP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2010 15:42:15 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3P00KKCO2A66I4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 08 Jun 2010 14:42:14 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

Saving platform non-volatile state may be required for suspend to RAM as
well as hibernation. Move it to more generic code.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/e820.c       |    2 +-
 drivers/acpi/sleep.c         |   12 ++--
 include/linux/suspend.h      |   26 ++++----
 kernel/power/Kconfig         |    9 ++-
 kernel/power/Makefile        |    2 +-
 kernel/power/hibernate_nvs.c |  136 ------------------------------------------
 kernel/power/nvs.c           |  136 ++++++++++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c       |    6 ++
 8 files changed, 168 insertions(+), 161 deletions(-)
 delete mode 100644 kernel/power/hibernate_nvs.c
 create mode 100644 kernel/power/nvs.c

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 7bca3c6..0d6fc71 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -729,7 +729,7 @@ static int __init e820_mark_nvs_memory(void)
 		struct e820entry *ei = &e820.map[i];
 
 		if (ei->type == E820_NVS)
-			hibernate_nvs_register(ei->addr, ei->size);
+			suspend_nvs_register(ei->addr, ei->size);
 	}
 
 	return 0;
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 4ab2275..bcaa6ef 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -393,7 +393,7 @@ static int acpi_hibernation_begin(void)
 {
 	int error;
 
-	error = s4_no_nvs ? 0 : hibernate_nvs_alloc();
+	error = s4_no_nvs ? 0 : suspend_nvs_alloc();
 	if (!error) {
 		acpi_target_sleep_state = ACPI_STATE_S4;
 		acpi_sleep_tts_switch(acpi_target_sleep_state);
@@ -407,7 +407,7 @@ static int acpi_hibernation_pre_snapshot(void)
 	int error = acpi_pm_prepare();
 
 	if (!error)
-		hibernate_nvs_save();
+		suspend_nvs_save();
 
 	return error;
 }
@@ -432,7 +432,7 @@ static int acpi_hibernation_enter(void)
 
 static void acpi_hibernation_finish(void)
 {
-	hibernate_nvs_free();
+	suspend_nvs_free();
 	acpi_pm_finish();
 }
 
@@ -452,7 +452,7 @@ static void acpi_hibernation_leave(void)
 		panic("ACPI S4 hardware signature mismatch");
 	}
 	/* Restore the NVS memory area */
-	hibernate_nvs_restore();
+	suspend_nvs_restore();
 }
 
 static int acpi_pm_pre_restore(void)
@@ -501,7 +501,7 @@ static int acpi_hibernation_begin_old(void)
 
 	if (!error) {
 		if (!s4_no_nvs)
-			error = hibernate_nvs_alloc();
+			error = suspend_nvs_alloc();
 		if (!error)
 			acpi_target_sleep_state = ACPI_STATE_S4;
 	}
@@ -513,7 +513,7 @@ static int acpi_hibernation_pre_snapshot_old(void)
 	int error = acpi_pm_disable_gpes();
 
 	if (!error)
-		hibernate_nvs_save();
+		suspend_nvs_save();
 
 	return error;
 }
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 5e781d8..bc7d6bb 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -256,22 +256,22 @@ static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
 #endif /* CONFIG_HIBERNATION */
 
-#ifdef CONFIG_HIBERNATION_NVS
-extern int hibernate_nvs_register(unsigned long start, unsigned long size);
-extern int hibernate_nvs_alloc(void);
-extern void hibernate_nvs_free(void);
-extern void hibernate_nvs_save(void);
-extern void hibernate_nvs_restore(void);
-#else /* CONFIG_HIBERNATION_NVS */
-static inline int hibernate_nvs_register(unsigned long a, unsigned long b)
+#ifdef CONFIG_SUSPEND_NVS
+extern int suspend_nvs_register(unsigned long start, unsigned long size);
+extern int suspend_nvs_alloc(void);
+extern void suspend_nvs_free(void);
+extern void suspend_nvs_save(void);
+extern void suspend_nvs_restore(void);
+#else /* CONFIG_SUSPEND_NVS */
+static inline int suspend_nvs_register(unsigned long a, unsigned long b)
 {
 	return 0;
 }
-static inline int hibernate_nvs_alloc(void) { return 0; }
-static inline void hibernate_nvs_free(void) {}
-static inline void hibernate_nvs_save(void) {}
-static inline void hibernate_nvs_restore(void) {}
-#endif /* CONFIG_HIBERNATION_NVS */
+static inline int suspend_nvs_alloc(void) { return 0; }
+static inline void suspend_nvs_free(void) {}
+static inline void suspend_nvs_save(void) {}
+static inline void suspend_nvs_restore(void) {}
+#endif /* CONFIG_SUSPEND_NVS */
 
 #ifdef CONFIG_PM_SLEEP
 void save_processor_state(void);
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 5c36ea9..ca6066a 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -99,9 +99,13 @@ config PM_SLEEP_ADVANCED_DEBUG
 	depends on PM_ADVANCED_DEBUG
 	default n
 
+config SUSPEND_NVS
+       bool
+
 config SUSPEND
 	bool "Suspend to RAM and standby"
 	depends on PM && ARCH_SUSPEND_POSSIBLE
+	select SUSPEND_NVS if HAS_IOMEM
 	default y
 	---help---
 	  Allow the system to enter sleep states in which main memory is
@@ -130,13 +134,10 @@ config SUSPEND_FREEZER
 
 	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
 
-config HIBERNATION_NVS
-	bool
-
 config HIBERNATION
 	bool "Hibernation (aka 'suspend to disk')"
 	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
-	select HIBERNATION_NVS if HAS_IOMEM
+	select SUSPEND_NVS if HAS_IOMEM
 	---help---
 	  Enable the suspend to disk (STD) functionality, which is usually
 	  called "hibernation" in user interfaces.  STD checkpoints the
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 524e058..f9063c6 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -10,6 +10,6 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o \
 				   block_io.o
-obj-$(CONFIG_HIBERNATION_NVS)	+= hibernate_nvs.o
+obj-$(CONFIG_SUSPEND_NVS)	+= nvs.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
diff --git a/kernel/power/hibernate_nvs.c b/kernel/power/hibernate_nvs.c
deleted file mode 100644
index fdcad9e..0000000
--- a/kernel/power/hibernate_nvs.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/*
- * linux/kernel/power/hibernate_nvs.c - Routines for handling NVS memory
- *
- * Copyright (C) 2008,2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
- *
- * This file is released under the GPLv2.
- */
-
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/suspend.h>
-
-/*
- * Platforms, like ACPI, may want us to save some memory used by them during
- * hibernation and to restore the contents of this memory during the subsequent
- * resume.  The code below implements a mechanism allowing us to do that.
- */
-
-struct nvs_page {
-	unsigned long phys_start;
-	unsigned int size;
-	void *kaddr;
-	void *data;
-	struct list_head node;
-};
-
-static LIST_HEAD(nvs_list);
-
-/**
- *	hibernate_nvs_register - register platform NVS memory region to save
- *	@start - physical address of the region
- *	@size - size of the region
- *
- *	The NVS region need not be page-aligned (both ends) and we arrange
- *	things so that the data from page-aligned addresses in this region will
- *	be copied into separate RAM pages.
- */
-int hibernate_nvs_register(unsigned long start, unsigned long size)
-{
-	struct nvs_page *entry, *next;
-
-	while (size > 0) {
-		unsigned int nr_bytes;
-
-		entry = kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
-		if (!entry)
-			goto Error;
-
-		list_add_tail(&entry->node, &nvs_list);
-		entry->phys_start = start;
-		nr_bytes = PAGE_SIZE - (start & ~PAGE_MASK);
-		entry->size = (size < nr_bytes) ? size : nr_bytes;
-
-		start += entry->size;
-		size -= entry->size;
-	}
-	return 0;
-
- Error:
-	list_for_each_entry_safe(entry, next, &nvs_list, node) {
-		list_del(&entry->node);
-		kfree(entry);
-	}
-	return -ENOMEM;
-}
-
-/**
- *	hibernate_nvs_free - free data pages allocated for saving NVS regions
- */
-void hibernate_nvs_free(void)
-{
-	struct nvs_page *entry;
-
-	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data) {
-			free_page((unsigned long)entry->data);
-			entry->data = NULL;
-			if (entry->kaddr) {
-				iounmap(entry->kaddr);
-				entry->kaddr = NULL;
-			}
-		}
-}
-
-/**
- *	hibernate_nvs_alloc - allocate memory necessary for saving NVS regions
- */
-int hibernate_nvs_alloc(void)
-{
-	struct nvs_page *entry;
-
-	list_for_each_entry(entry, &nvs_list, node) {
-		entry->data = (void *)__get_free_page(GFP_KERNEL);
-		if (!entry->data) {
-			hibernate_nvs_free();
-			return -ENOMEM;
-		}
-	}
-	return 0;
-}
-
-/**
- *	hibernate_nvs_save - save NVS memory regions
- */
-void hibernate_nvs_save(void)
-{
-	struct nvs_page *entry;
-
-	printk(KERN_INFO "PM: Saving platform NVS memory\n");
-
-	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data) {
-			entry->kaddr = ioremap(entry->phys_start, entry->size);
-			memcpy(entry->data, entry->kaddr, entry->size);
-		}
-}
-
-/**
- *	hibernate_nvs_restore - restore NVS memory regions
- *
- *	This function is going to be called with interrupts disabled, so it
- *	cannot iounmap the virtual addresses used to access the NVS region.
- */
-void hibernate_nvs_restore(void)
-{
-	struct nvs_page *entry;
-
-	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
-
-	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data)
-			memcpy(entry->kaddr, entry->data, entry->size);
-}
diff --git a/kernel/power/nvs.c b/kernel/power/nvs.c
new file mode 100644
index 0000000..1836db6
--- /dev/null
+++ b/kernel/power/nvs.c
@@ -0,0 +1,136 @@
+/*
+ * linux/kernel/power/hibernate_nvs.c - Routines for handling NVS memory
+ *
+ * Copyright (C) 2008,2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+
+/*
+ * Platforms, like ACPI, may want us to save some memory used by them during
+ * suspend and to restore the contents of this memory during the subsequent
+ * resume.  The code below implements a mechanism allowing us to do that.
+ */
+
+struct nvs_page {
+	unsigned long phys_start;
+	unsigned int size;
+	void *kaddr;
+	void *data;
+	struct list_head node;
+};
+
+static LIST_HEAD(nvs_list);
+
+/**
+ *	suspend_nvs_register - register platform NVS memory region to save
+ *	@start - physical address of the region
+ *	@size - size of the region
+ *
+ *	The NVS region need not be page-aligned (both ends) and we arrange
+ *	things so that the data from page-aligned addresses in this region will
+ *	be copied into separate RAM pages.
+ */
+int suspend_nvs_register(unsigned long start, unsigned long size)
+{
+	struct nvs_page *entry, *next;
+
+	while (size > 0) {
+		unsigned int nr_bytes;
+
+		entry = kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
+		if (!entry)
+			goto Error;
+
+		list_add_tail(&entry->node, &nvs_list);
+		entry->phys_start = start;
+		nr_bytes = PAGE_SIZE - (start & ~PAGE_MASK);
+		entry->size = (size < nr_bytes) ? size : nr_bytes;
+
+		start += entry->size;
+		size -= entry->size;
+	}
+	return 0;
+
+ Error:
+	list_for_each_entry_safe(entry, next, &nvs_list, node) {
+		list_del(&entry->node);
+		kfree(entry);
+	}
+	return -ENOMEM;
+}
+
+/**
+ *	suspend_nvs_free - free data pages allocated for saving NVS regions
+ */
+void suspend_nvs_free(void)
+{
+	struct nvs_page *entry;
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data) {
+			free_page((unsigned long)entry->data);
+			entry->data = NULL;
+			if (entry->kaddr) {
+				iounmap(entry->kaddr);
+				entry->kaddr = NULL;
+			}
+		}
+}
+
+/**
+ *	suspend_nvs_alloc - allocate memory necessary for saving NVS regions
+ */
+int suspend_nvs_alloc(void)
+{
+	struct nvs_page *entry;
+
+	list_for_each_entry(entry, &nvs_list, node) {
+		entry->data = (void *)__get_free_page(GFP_KERNEL);
+		if (!entry->data) {
+			suspend_nvs_free();
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+/**
+ *	suspend_nvs_save - save NVS memory regions
+ */
+void suspend_nvs_save(void)
+{
+	struct nvs_page *entry;
+
+	printk(KERN_INFO "PM: Saving platform NVS memory\n");
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data) {
+			entry->kaddr = ioremap(entry->phys_start, entry->size);
+			memcpy(entry->data, entry->kaddr, entry->size);
+		}
+}
+
+/**
+ *	suspend_nvs_restore - restore NVS memory regions
+ *
+ *	This function is going to be called with interrupts disabled, so it
+ *	cannot iounmap the virtual addresses used to access the NVS region.
+ */
+void suspend_nvs_restore(void)
+{
+	struct nvs_page *entry;
+
+	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data)
+			memcpy(entry->kaddr, entry->data, entry->size);
+}
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 56e7dbb..f37cb7d 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -16,6 +16,12 @@
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
 #include <linux/gfp.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
 
 #include "power.h"
 
-- 
1.6.0.6

