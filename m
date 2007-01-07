From: malattia@linux.it
Subject: [PATCH 7/11] Add acpi_bus_generate event
Date: Sun,  7 Jan 2007 18:54:39 +0100
Message-ID: <11681924833473-git-send-email-malattia@linux.it>
References: <1168192483500-git-send-email-malattia@linux.it> <11681924832840-git-send-email-malattia@linux.it> <1168192483207-git-send-email-malattia@linux.it> <11681924833947-git-send-email-malattia@linux.it> <11681924832264-git-send-email-malattia@linux.it> <11681924831582-git-send-email-malattia@linux.it> <11681924831482-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:48414 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbXAGSB5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jan 2007 13:01:57 -0500
In-Reply-To: <11681924831482-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

From: Stelian Pop <stelian@popies.net>

Added acpi_bus_generate event for forwarding Fn-keys pressed to acpi subsystem,
and made correspondent necessary changes for this to work.

Signed-off-by: Nilton Volpato <nilton.volpato@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/acpi/sony_acpi.c |   53 ++++++++++++++++++++++++---------------------
 1 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index 195895c..138f2b6 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -54,6 +54,7 @@ MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
 
 static acpi_handle sony_acpi_handle;
 static struct proc_dir_entry *sony_acpi_dir;
+static struct acpi_device *sony_acpi_acpi_device = NULL;
 
 static int sony_backlight_update_status(struct backlight_device *bd);
 static int sony_backlight_get_brightness(struct backlight_device *bd);
@@ -270,7 +271,9 @@ static int sony_acpi_resume(struct acpi_device *device)
 
 static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	printk(LOG_PFX "sony_acpi_notify\n");
+	if (debug)
+		printk(LOG_PFX "sony_acpi_notify, event: %d\n", event);
+	acpi_bus_generate_event(sony_acpi_acpi_device, 1, event);
 }
 
 static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
@@ -295,6 +298,8 @@ static int sony_acpi_add(struct acpi_device *device)
 	acpi_handle handle;
 	struct sony_acpi_value *item;
 
+	sony_acpi_acpi_device = device;
+
 	sony_acpi_handle = device->handle;
 
 	acpi_driver_data(device) = NULL;
@@ -308,16 +313,16 @@ static int sony_acpi_add(struct acpi_device *device)
 			result = -ENODEV;
 			goto outwalk;
 		}
+	}
 
-		status = acpi_install_notify_handler(sony_acpi_handle,
-						     ACPI_DEVICE_NOTIFY,
-						     sony_acpi_notify,
-						     NULL);
-		if (ACPI_FAILURE(status)) {
-			printk(LOG_PFX "unable to install notify handler\n");
-			result = -ENODEV;
-			goto outnotify;
-		}
+	status = acpi_install_notify_handler(sony_acpi_handle,
+					     ACPI_DEVICE_NOTIFY,
+					     sony_acpi_notify,
+					     NULL);
+	if (ACPI_FAILURE(status)) {
+		printk(LOG_PFX "unable to install notify handler\n");
+		result = -ENODEV;
+		goto outnotify;
 	}
 
 	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
@@ -342,7 +347,7 @@ static int sony_acpi_add(struct acpi_device *device)
 		    		 item->acpiset, &handle)))
 		    	continue;
 
-		item->proc = create_proc_entry(item->name, 0600,
+		item->proc = create_proc_entry(item->name, 0666,
 					       acpi_device_dir(device));
 		if (!item->proc) {
 			printk(LOG_PFX "unable to create proc entry\n");
@@ -361,13 +366,11 @@ static int sony_acpi_add(struct acpi_device *device)
 	return 0;
 
 outproc:
-	if (debug) {
-		status = acpi_remove_notify_handler(sony_acpi_handle,
-						    ACPI_DEVICE_NOTIFY,
-						    sony_acpi_notify);
-		if (ACPI_FAILURE(status))
-			printk(LOG_PFX "unable to remove notify handler\n");
-	}
+	status = acpi_remove_notify_handler(sony_acpi_handle,
+					    ACPI_DEVICE_NOTIFY,
+					    sony_acpi_notify);
+	if (ACPI_FAILURE(status))
+		printk(LOG_PFX "unable to remove notify handler\n");
 outnotify:
 	for (item = sony_acpi_values; item->name; ++item)
 		if (item->proc)
@@ -384,13 +387,13 @@ static int sony_acpi_remove(struct acpi_device *device, int type)
 	if (sony_backlight_device)
 		backlight_device_unregister(sony_backlight_device);
 
-	if (debug) {
-		status = acpi_remove_notify_handler(sony_acpi_handle,
-						    ACPI_DEVICE_NOTIFY,
-						    sony_acpi_notify);
-		if (ACPI_FAILURE(status))
-			printk(LOG_PFX "unable to remove notify handler\n");
-	}
+	sony_acpi_acpi_device = NULL;
+
+	status = acpi_remove_notify_handler(sony_acpi_handle,
+					    ACPI_DEVICE_NOTIFY,
+					    sony_acpi_notify);
+	if (ACPI_FAILURE(status))
+		printk(LOG_PFX "unable to remove notify handler\n");
 
 	for (item = sony_acpi_values; item->name; ++item)
 		if (item->proc)
-- 
1.4.4.2

