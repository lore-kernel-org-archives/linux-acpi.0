From: malattia@linux.it
Subject: [PATCH 8/11] Allow easier debugging for the unknown SNC methods.
Date: Sat, 13 Jan 2007 23:04:38 +0100
Message-ID: <1168725881872-git-send-email-malattia@linux.it>
References: <11687258812893-git-send-email-malattia@linux.it> <1168725881764-git-send-email-malattia@linux.it> <11687258811866-git-send-email-malattia@linux.it> <11687258812417-git-send-email-malattia@linux.it> <11687258812248-git-send-email-malattia@linux.it> <11687258811707-git-send-email-malattia@linux.it> <11687258813214-git-send-email-malattia@linux.it> <1168725881949-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:52618 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbXAMWGG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 17:06:06 -0500
In-Reply-To: <1168725881949-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

Allow the existence of a setter method without a getter and viceversa,
additionaly set /proc file permissions reflecting it.
Fix also the error exit path.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/acpi/sony_acpi.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index 138f2b6..69122ad 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -296,6 +296,7 @@ static int sony_acpi_add(struct acpi_device *device)
 	acpi_status status;
 	int result;
 	acpi_handle handle;
+	mode_t proc_file_mode;
 	struct sony_acpi_value *item;
 
 	sony_acpi_acpi_device = device;
@@ -334,20 +335,31 @@ static int sony_acpi_add(struct acpi_device *device)
 	}
 
 	for (item = sony_acpi_values; item->name; ++item) {
+		proc_file_mode = 0;
+
 		if (!debug && item->debug)
 			continue;
 
 		if (item->acpiget &&
-		    ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
+		    ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle,
 		    		 item->acpiget, &handle)))
-		    	continue;
+			proc_file_mode = S_IRUSR;
+		else
+			printk(LOG_PFX "unable to get ACPI handle for %s (get)\n",
+					item->name);
 
 		if (item->acpiset &&
-		    ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
+		    ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle,
 		    		 item->acpiset, &handle)))
-		    	continue;
+			proc_file_mode |= S_IWUSR;
+		else
+			printk(LOG_PFX "unable to get ACPI handle for %s (set)\n",
+					item->name);
+
+		if (proc_file_mode == 0)
+			continue;
 
-		item->proc = create_proc_entry(item->name, 0666,
+		item->proc = create_proc_entry(item->name, proc_file_mode,
 					       acpi_device_dir(device));
 		if (!item->proc) {
 			printk(LOG_PFX "unable to create proc entry\n");
@@ -366,15 +378,15 @@ static int sony_acpi_add(struct acpi_device *device)
 	return 0;
 
 outproc:
+	for (item = sony_acpi_values; item->name; ++item)
+		if (item->proc)
+			remove_proc_entry(item->name, acpi_device_dir(device));
+outnotify:
 	status = acpi_remove_notify_handler(sony_acpi_handle,
 					    ACPI_DEVICE_NOTIFY,
 					    sony_acpi_notify);
 	if (ACPI_FAILURE(status))
 		printk(LOG_PFX "unable to remove notify handler\n");
-outnotify:
-	for (item = sony_acpi_values; item->name; ++item)
-		if (item->proc)
-			remove_proc_entry(item->name, acpi_device_dir(device));
 outwalk:
 	return result;
 }
-- 
1.4.4.2

