From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/48] PM / ACPI: Move NVS saving and restoring code to
 drivers/acpi
Date: Wed, 12 Jan 2011 05:19:09 -0500
Message-ID: <976513dbfc1547c7b1822566923058655f0c32fd.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49262 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab1ALSA3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:29 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:28 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The saving of the ACPI NVS area during hibernation and suspend and
restoring it during the subsequent resume is entirely specific to
ACPI, so move it to drivers/acpi and drop the CONFIG_SUSPEND_NVS
configuration option which is redundant.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/e820.c               |    1 +
 drivers/acpi/Makefile                |    2 +-
 drivers/acpi/internal.h              |    8 ++++++++
 {kernel/power => drivers/acpi}/nvs.c |    0
 include/linux/acpi.h                 |    9 +++++++++
 include/linux/suspend.h              |   17 -----------------
 kernel/power/Kconfig                 |    5 -----
 kernel/power/Makefile                |    1 -
 8 files changed, 19 insertions(+), 24 deletions(-)
 rename {kernel/power => drivers/acpi}/nvs.c (100%)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 0c2b7ef..294f26d 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -14,6 +14,7 @@
 #include <linux/bootmem.h>
 #include <linux/pfn.h>
 #include <linux/suspend.h>
+#include <linux/acpi.h>
 #include <linux/firmware-map.h>
 #include <linux/memblock.h>
 
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3d031d0..9cc9f2c 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -24,7 +24,7 @@ acpi-y				+= atomicio.o
 # sleep related files
 acpi-y				+= wakeup.o
 acpi-y				+= sleep.o
-acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
+acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o nvs.o
 
 
 #
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index a212bfe..7c23b76 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -82,8 +82,16 @@ extern int acpi_sleep_init(void);
 
 #ifdef CONFIG_ACPI_SLEEP
 int acpi_sleep_proc_init(void);
+int suspend_nvs_alloc(void);
+void suspend_nvs_free(void);
+int suspend_nvs_save(void);
+void suspend_nvs_restore(void);
 #else
 static inline int acpi_sleep_proc_init(void) { return 0; }
+static inline int suspend_nvs_alloc(void) { return 0; }
+static inline void suspend_nvs_free(void) {}
+static inline int suspend_nvs_save(void) {}
+static inline void suspend_nvs_restore(void) {}
 #endif
 
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/kernel/power/nvs.c b/drivers/acpi/nvs.c
similarity index 100%
rename from kernel/power/nvs.c
rename to drivers/acpi/nvs.c
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 67c91b4..fa7ed6a98 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -254,6 +254,15 @@ void __init acpi_old_suspend_ordering(void);
 void __init acpi_nvs_nosave(void);
 #endif /* CONFIG_PM_SLEEP */
 
+#ifdef CONFIG_ACPI_SLEEP
+int suspend_nvs_register(unsigned long start, unsigned long size);
+#else
+static inline int suspend_nvs_register(unsigned long a, unsigned long b)
+{
+	return 0;
+}
+#endif
+
 struct acpi_osc_context {
 	char *uuid_str; /* uuid string */
 	int rev;
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index acb7d91..0e288e3 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -258,23 +258,6 @@ static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
 #endif /* CONFIG_HIBERNATION */
 
-#ifdef CONFIG_SUSPEND_NVS
-extern int suspend_nvs_register(unsigned long start, unsigned long size);
-extern int suspend_nvs_alloc(void);
-extern void suspend_nvs_free(void);
-extern int suspend_nvs_save(void);
-extern void suspend_nvs_restore(void);
-#else /* CONFIG_SUSPEND_NVS */
-static inline int suspend_nvs_register(unsigned long a, unsigned long b)
-{
-	return 0;
-}
-static inline int suspend_nvs_alloc(void) { return 0; }
-static inline void suspend_nvs_free(void) {}
-static inline int suspend_nvs_save(void) {}
-static inline void suspend_nvs_restore(void) {}
-#endif /* CONFIG_SUSPEND_NVS */
-
 #ifdef CONFIG_PM_SLEEP
 void save_processor_state(void);
 void restore_processor_state(void);
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index a5aff3e..2657299 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -100,13 +100,9 @@ config PM_SLEEP_ADVANCED_DEBUG
 	depends on PM_ADVANCED_DEBUG
 	default n
 
-config SUSPEND_NVS
-       bool
-
 config SUSPEND
 	bool "Suspend to RAM and standby"
 	depends on PM && ARCH_SUSPEND_POSSIBLE
-	select SUSPEND_NVS if HAS_IOMEM
 	default y
 	---help---
 	  Allow the system to enter sleep states in which main memory is
@@ -140,7 +136,6 @@ config HIBERNATION
 	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
-	select SUSPEND_NVS if HAS_IOMEM
 	---help---
 	  Enable the suspend to disk (STD) functionality, which is usually
 	  called "hibernation" in user interfaces.  STD checkpoints the
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index f9063c6..120a158 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -10,6 +10,5 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o \
 				   block_io.o
-obj-$(CONFIG_SUSPEND_NVS)	+= nvs.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
-- 
1.7.4.rc1.7.g2cf08

