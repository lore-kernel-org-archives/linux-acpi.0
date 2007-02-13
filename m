From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/41] sony_acpi: Allow easier debugging for the unknown SNC methods.
Date: Tue, 13 Feb 2007 00:49:10 -0500
Message-ID: <11713457971245-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39577 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751050AbXBMFt7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:49:59 -0500
In-Reply-To: <11713457953042-git-send-email-lenb@kernel.org>
Message-Id: <3dc86780b4c99fbed04c64279035c32c697863a3.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Allow the existence of a setter method without a getter and viceversa,
additionaly set /proc file permissions reflecting it.
Fix also the error exit path.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.0.rc4.345.gb4d2
