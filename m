From: Pavel Machek <pavel@ucw.cz>
Subject: [patch] Fix up macro abuse in drivers/acpi/sleep/proc.c
Date: Fri, 3 Jun 2005 12:55:56 +0200
Message-ID: <20050603105555.GA3867@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261212AbVFCK4W@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@zip.com.au>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


Macros in proc.c make code both longer *and* less readable; I think
they should die.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -13,10 +13,6 @@
 
 #include "sleep.h"
 
-#define ACPI_SYSTEM_FILE_SLEEP		"sleep"
-#define ACPI_SYSTEM_FILE_ALARM		"alarm"
-#define ACPI_SYSTEM_FILE_WAKEUP_DEVICE   "wakeup"
-
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME		("sleep")
 
@@ -479,26 +475,23 @@ static u32 rtc_handler(void * context)
 
 static int acpi_sleep_proc_init(void)
 {
-	struct proc_dir_entry	*entry = NULL;
+	struct proc_dir_entry *entry = NULL;
 
 	if (acpi_disabled)
 		return 0;
  
-	/* 'sleep' [R/W]*/
-	entry = create_proc_entry(ACPI_SYSTEM_FILE_SLEEP,
-				  S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
+	/* 'sleep' [R/W] */
+	entry = create_proc_entry("sleep", S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_sleep_fops;
 
 	/* 'alarm' [R/W] */
-	entry = create_proc_entry(ACPI_SYSTEM_FILE_ALARM,
-		S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
+	entry = create_proc_entry("alarm", S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_alarm_fops;
 
-	/* 'wakeup device' [R/W]*/
-	entry = create_proc_entry(ACPI_SYSTEM_FILE_WAKEUP_DEVICE,
-				  S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
+	/* 'wakeup device' [R/W] */
+	entry = create_proc_entry("wakeup", S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_wakeup_device_fops;
 
