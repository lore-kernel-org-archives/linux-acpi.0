From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/5] PM: Fix oops in suspend/hibernate code related to failing ioremap()
Date: Fri, 7 Jan 2011 01:42:31 +0100
Message-ID: <201101070142.31777.rjw@sisk.pl>
References: <201101070141.02951.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201101070141.02951.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-acpi@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

When ioremap() fails (which might happen for some reason), we nicely
oops in suspend_nvs_save() due to NULL dereference by memcpy() in there.
Fail gracefully instead.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c    |    5 ++---
 include/linux/suspend.h |    4 ++--
 kernel/power/nvs.c      |    8 +++++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -124,8 +124,7 @@ static int acpi_pm_freeze(void)
 static int acpi_pm_pre_suspend(void)
 {
 	acpi_pm_freeze();
-	suspend_nvs_save();
-	return 0;
+	return suspend_nvs_save();
 }
 
 /**
@@ -151,7 +150,7 @@ static int acpi_pm_prepare(void)
 {
 	int error = __acpi_pm_prepare();
 	if (!error)
-		acpi_pm_pre_suspend();
+		error = acpi_pm_pre_suspend();
 
 	return error;
 }
Index: linux-2.6/include/linux/suspend.h
===================================================================
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
@@ -262,7 +262,7 @@ static inline bool system_entering_hiber
 extern int suspend_nvs_register(unsigned long start, unsigned long size);
 extern int suspend_nvs_alloc(void);
 extern void suspend_nvs_free(void);
-extern void suspend_nvs_save(void);
+extern int suspend_nvs_save(void);
 extern void suspend_nvs_restore(void);
 #else /* CONFIG_SUSPEND_NVS */
 static inline int suspend_nvs_register(unsigned long a, unsigned long b)
@@ -271,7 +271,7 @@ static inline int suspend_nvs_register(u
 }
 static inline int suspend_nvs_alloc(void) { return 0; }
 static inline void suspend_nvs_free(void) {}
-static inline void suspend_nvs_save(void) {}
+static inline int suspend_nvs_save(void) {}
 static inline void suspend_nvs_restore(void) {}
 #endif /* CONFIG_SUSPEND_NVS */
 
Index: linux-2.6/kernel/power/nvs.c
===================================================================
--- linux-2.6.orig/kernel/power/nvs.c
+++ linux-2.6/kernel/power/nvs.c
@@ -105,7 +105,7 @@ int suspend_nvs_alloc(void)
 /**
  *	suspend_nvs_save - save NVS memory regions
  */
-void suspend_nvs_save(void)
+int suspend_nvs_save(void)
 {
 	struct nvs_page *entry;
 
@@ -114,8 +114,14 @@ void suspend_nvs_save(void)
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data) {
 			entry->kaddr = ioremap(entry->phys_start, entry->size);
+			if (!entry->kaddr) {
+				suspend_nvs_free();
+				return -ENOMEM;
+			}
 			memcpy(entry->data, entry->kaddr, entry->size);
 		}
+
+	return 0;
 }
 
 /**
