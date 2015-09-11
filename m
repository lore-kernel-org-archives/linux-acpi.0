From: Rami Rosen <ramirose@gmail.com>
Subject: [PATCH] ACPI: change acpi_sleep_proc_init() to return void.
Date: Fri, 11 Sep 2015 17:49:22 +0300
Message-ID: <1441982962-7299-1-git-send-email-ramirose@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34062 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbIKOtc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Sep 2015 10:49:32 -0400
Received: by wicfx3 with SMTP id fx3so67094125wic.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Sep 2015 07:49:31 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, Rami Rosen <ramirose@gmail.com>

This patch changes the type of the return value of the acpi_sleep_proc_init() 
method to be void, as this method never fails and its return value is never
used.

Signed-off-by: Rami Rosen <ramirose@gmail.com>
---
 drivers/acpi/internal.h | 4 ++--
 drivers/acpi/proc.c     | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 9e42621..685bcb6 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -179,13 +179,13 @@ static inline int acpi_sleep_init(void) { return -ENXIO; }
 #endif
 
 #ifdef CONFIG_ACPI_SLEEP
-int acpi_sleep_proc_init(void);
+void acpi_sleep_proc_init(void);
 int suspend_nvs_alloc(void);
 void suspend_nvs_free(void);
 int suspend_nvs_save(void);
 void suspend_nvs_restore(void);
 #else
-static inline int acpi_sleep_proc_init(void) { return 0; }
+static inline void acpi_sleep_proc_init(void) { return 0; }
 static inline int suspend_nvs_alloc(void) { return 0; }
 static inline void suspend_nvs_free(void) {}
 static inline int suspend_nvs_save(void) { return 0; }
diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 75c28ea..2a35815 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -144,11 +144,9 @@ static const struct file_operations acpi_system_wakeup_device_fops = {
 	.release = single_release,
 };
 
-int __init acpi_sleep_proc_init(void)
+void __init acpi_sleep_proc_init(void)
 {
 	/* 'wakeup device' [R/W] */
 	proc_create("wakeup", S_IFREG | S_IRUGO | S_IWUSR,
 		    acpi_root_dir, &acpi_system_wakeup_device_fops);
-
-	return 0;
 }
-- 
2.4.3

