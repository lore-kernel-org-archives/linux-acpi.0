From: mochel@linux.intel.com
Subject: [PATCH 1/24] Remove unneeded debugging macros in drivers/acpi/ac.c
Date: Mon, 17 Apr 2006 18:21:52 -0700
Message-ID: <11453233122841-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:59023 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932103AbWDRBZY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:24 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PNBH025129
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:23 GMT
In-Reply-To: 
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/ac.c |   60 ++++++++++++++++++-----------------------------------
 1 files changed, 20 insertions(+), 40 deletions(-)

applies-to: c4356ddca2663c11808302198bce89da48a6b675
380d7c94d935cbee91ece702b7ad60247e565d89
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 95223d8..1d2cf05 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -84,19 +84,17 @@ static int acpi_ac_get_state(struct acpi
 {
 	acpi_status status = AE_OK;
 
-	ACPI_FUNCTION_TRACE("acpi_ac_get_state");
-
 	if (!ac)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	status = acpi_evaluate_integer(ac->handle, "_PSR", NULL, &ac->state);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Error reading AC Adapter state"));
 		ac->state = ACPI_AC_STATUS_UNKNOWN;
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 /* --------------------------------------------------------------------------
@@ -109,14 +107,12 @@ static int acpi_ac_seq_show(struct seq_f
 {
 	struct acpi_ac *ac = (struct acpi_ac *)seq->private;
 
-	ACPI_FUNCTION_TRACE("acpi_ac_seq_show");
-
 	if (!ac)
-		return_VALUE(0);
+		return 0;
 
 	if (acpi_ac_get_state(ac)) {
 		seq_puts(seq, "ERROR: Unable to read AC Adapter state\n");
-		return_VALUE(0);
+		return 0;
 	}
 
 	seq_puts(seq, "state:                   ");
@@ -132,7 +128,7 @@ static int acpi_ac_seq_show(struct seq_f
 		break;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_ac_open_fs(struct inode *inode, struct file *file)
@@ -144,13 +140,11 @@ static int acpi_ac_add_fs(struct acpi_de
 {
 	struct proc_dir_entry *entry = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_ac_add_fs");
-
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_ac_dir);
 		if (!acpi_device_dir(device))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 		acpi_device_dir(device)->owner = THIS_MODULE;
 	}
 
@@ -158,20 +152,18 @@ static int acpi_ac_add_fs(struct acpi_de
 	entry = create_proc_entry(ACPI_AC_FILE_STATE,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_ac_fops;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_ac_remove_fs(struct acpi_device *device)
 {
-	ACPI_FUNCTION_TRACE("acpi_ac_remove_fs");
-
 	if (acpi_device_dir(device)) {
 		remove_proc_entry(ACPI_AC_FILE_STATE, acpi_device_dir(device));
 
@@ -179,7 +171,7 @@ static int acpi_ac_remove_fs(struct acpi
 		acpi_device_dir(device) = NULL;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 /* --------------------------------------------------------------------------
@@ -191,13 +183,11 @@ static void acpi_ac_notify(acpi_handle h
 	struct acpi_ac *ac = (struct acpi_ac *)data;
 	struct acpi_device *device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_ac_notify");
-
 	if (!ac)
-		return_VOID;
+		return;
 
 	if (acpi_bus_get_device(ac->handle, &device))
-		return_VOID;
+		return;
 
 	switch (event) {
 	case ACPI_AC_NOTIFY_STATUS:
@@ -210,7 +200,6 @@ static void acpi_ac_notify(acpi_handle h
 		break;
 	}
 
-	return_VOID;
 }
 
 static int acpi_ac_add(struct acpi_device *device)
@@ -219,14 +208,12 @@ static int acpi_ac_add(struct acpi_devic
 	acpi_status status = AE_OK;
 	struct acpi_ac *ac = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_ac_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	ac = kmalloc(sizeof(struct acpi_ac), GFP_KERNEL);
 	if (!ac)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(ac, 0, sizeof(struct acpi_ac));
 
 	ac->handle = device->handle;
@@ -260,7 +247,7 @@ static int acpi_ac_add(struct acpi_devic
 		kfree(ac);
 	}
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_ac_remove(struct acpi_device *device, int type)
@@ -268,10 +255,8 @@ static int acpi_ac_remove(struct acpi_de
 	acpi_status status = AE_OK;
 	struct acpi_ac *ac = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_ac_remove");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	ac = (struct acpi_ac *)acpi_driver_data(device);
 
@@ -282,38 +267,33 @@ static int acpi_ac_remove(struct acpi_de
 
 	kfree(ac);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int __init acpi_ac_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ac_init");
-
 	acpi_ac_dir = proc_mkdir(ACPI_AC_CLASS, acpi_root_dir);
 	if (!acpi_ac_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_ac_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_ac_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_ac_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_ac_exit");
-
 	acpi_bus_unregister_driver(&acpi_ac_driver);
 
 	remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
 
-	return_VOID;
 }
 
 module_init(acpi_ac_init);
---
0.99.9.GIT


