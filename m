From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/48] PM: Fix oops in suspend/hibernate code related to
 failing ioremap()
Date: Wed, 12 Jan 2011 05:19:08 -0500
Message-ID: <26fcaf60fe3861409eb4c455c5c0d0f00f599b08.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab1ALRAY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:24 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:17 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Jiri Slaby <jslaby@suse.cz>

When ioremap() fails (which might happen for some reason), we nicely
oops in suspend_nvs_save() due to NULL dereference by memcpy() in there.
Fail gracefully instead.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c    |    5 ++---
 include/linux/suspend.h |    4 ++--
 kernel/power/nvs.c      |    8 +++++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index febb153..d8bca6c 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
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
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 2669751..acb7d91 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -262,7 +262,7 @@ static inline bool system_entering_hibernation(void) { return false; }
 extern int suspend_nvs_register(unsigned long start, unsigned long size);
 extern int suspend_nvs_alloc(void);
 extern void suspend_nvs_free(void);
-extern void suspend_nvs_save(void);
+extern int suspend_nvs_save(void);
 extern void suspend_nvs_restore(void);
 #else /* CONFIG_SUSPEND_NVS */
 static inline int suspend_nvs_register(unsigned long a, unsigned long b)
@@ -271,7 +271,7 @@ static inline int suspend_nvs_register(unsigned long a, unsigned long b)
 }
 static inline int suspend_nvs_alloc(void) { return 0; }
 static inline void suspend_nvs_free(void) {}
-static inline void suspend_nvs_save(void) {}
+static inline int suspend_nvs_save(void) {}
 static inline void suspend_nvs_restore(void) {}
 #endif /* CONFIG_SUSPEND_NVS */
 
diff --git a/kernel/power/nvs.c b/kernel/power/nvs.c
index 1836db6..57c6fab 100644
--- a/kernel/power/nvs.c
+++ b/kernel/power/nvs.c
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
-- 
1.7.4.rc1.7.g2cf08

