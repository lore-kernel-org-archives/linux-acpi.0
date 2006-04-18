From: mochel@linux.intel.com
Subject: [PATCH 5/24] Remove unneeded debugging macros in drivers/acpi/button.c
Date: Mon, 17 Apr 2006 18:21:53 -0700
Message-ID: <11453233132637-git-send-email-mochel@linux.intel.com>
References: <11453233121169-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:25222 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932110AbWDRBZY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:24 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PO6X013960
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:24 GMT
In-Reply-To: <11453233121169-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/button.c |   64 ++++++++++++++++---------------------------------
 1 files changed, 21 insertions(+), 43 deletions(-)

applies-to: 8874c10f9ca6ee5536a19023aaca34509e89c46f
96969246acf5a176a7fa5916999b377ea4d3a31b
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index a8717da..edccc8b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -112,15 +112,13 @@ static int acpi_button_info_seq_show(str
 {
 	struct acpi_button *button = (struct acpi_button *)seq->private;
 
-	ACPI_FUNCTION_TRACE("acpi_button_info_seq_show");
-
 	if (!button || !button->device)
-		return_VALUE(0);
+		return 0;
 
 	seq_printf(seq, "type:                    %s\n",
 		   acpi_device_name(button->device));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_button_info_open_fs(struct inode *inode, struct file *file)
@@ -134,10 +132,8 @@ static int acpi_button_state_seq_show(st
 	acpi_status status;
 	unsigned long state;
 
-	ACPI_FUNCTION_TRACE("acpi_button_state_seq_show");
-
 	if (!button || !button->device)
-		return_VALUE(0);
+		return 0;
 
 	status = acpi_evaluate_integer(button->handle, "_LID", NULL, &state);
 	if (ACPI_FAILURE(status)) {
@@ -147,7 +143,7 @@ static int acpi_button_state_seq_show(st
 			   (state ? "open" : "closed"));
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_button_state_open_fs(struct inode *inode, struct file *file)
@@ -164,10 +160,8 @@ static int acpi_button_add_fs(struct acp
 	struct proc_dir_entry *entry = NULL;
 	struct acpi_button *button = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_button_add_fs");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	button = acpi_driver_data(device);
 
@@ -195,19 +189,19 @@ static int acpi_button_add_fs(struct acp
 	}
 
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	entry->owner = THIS_MODULE;
 
 	acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device), entry);
 	if (!acpi_device_dir(device))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_device_dir(device)->owner = THIS_MODULE;
 
 	/* 'info' [R] */
 	entry = create_proc_entry(ACPI_BUTTON_FILE_INFO,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_button_info_fops;
 		entry->data = acpi_driver_data(device);
@@ -227,15 +221,13 @@ static int acpi_button_add_fs(struct acp
 		}
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_button_remove_fs(struct acpi_device *device)
 {
 	struct acpi_button *button = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_button_remove_fs");
-
 	button = acpi_driver_data(device);
 	if (acpi_device_dir(device)) {
 		if (button->type == ACPI_BUTTON_TYPE_LID)
@@ -249,7 +241,7 @@ static int acpi_button_remove_fs(struct 
 		acpi_device_dir(device) = NULL;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 /* --------------------------------------------------------------------------
@@ -260,10 +252,8 @@ static void acpi_button_notify(acpi_hand
 {
 	struct acpi_button *button = (struct acpi_button *)data;
 
-	ACPI_FUNCTION_TRACE("acpi_button_notify");
-
 	if (!button || !button->device)
-		return_VOID;
+		return;
 
 	switch (event) {
 	case ACPI_BUTTON_NOTIFY_STATUS:
@@ -276,21 +266,18 @@ static void acpi_button_notify(acpi_hand
 		break;
 	}
 
-	return_VOID;
 }
 
 static acpi_status acpi_button_notify_fixed(void *data)
 {
 	struct acpi_button *button = (struct acpi_button *)data;
 
-	ACPI_FUNCTION_TRACE("acpi_button_notify_fixed");
-
 	if (!button)
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
+		return AE_BAD_PARAMETER;
 
 	acpi_button_notify(button->handle, ACPI_BUTTON_NOTIFY_STATUS, button);
 
-	return_ACPI_STATUS(AE_OK);
+	return AE_OK;
 }
 
 static int acpi_button_add(struct acpi_device *device)
@@ -299,14 +286,12 @@ static int acpi_button_add(struct acpi_d
 	acpi_status status = AE_OK;
 	struct acpi_button *button = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_button_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	button = kmalloc(sizeof(struct acpi_button), GFP_KERNEL);
 	if (!button)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(button, 0, sizeof(struct acpi_button));
 
 	button->device = device;
@@ -400,7 +385,7 @@ static int acpi_button_add(struct acpi_d
 		kfree(button);
 	}
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_button_remove(struct acpi_device *device, int type)
@@ -408,10 +393,8 @@ static int acpi_button_remove(struct acp
 	acpi_status status = 0;
 	struct acpi_button *button = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_button_remove");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	button = acpi_driver_data(device);
 
@@ -438,32 +421,28 @@ static int acpi_button_remove(struct acp
 
 	kfree(button);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int __init acpi_button_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_button_init");
-
 	acpi_button_dir = proc_mkdir(ACPI_BUTTON_CLASS, acpi_root_dir);
 	if (!acpi_button_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	acpi_button_dir->owner = THIS_MODULE;
 	result = acpi_bus_register_driver(&acpi_button_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_button_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_button_exit");
-
 	acpi_bus_unregister_driver(&acpi_button_driver);
 
 	if (acpi_power_dir)
@@ -474,7 +453,6 @@ static void __exit acpi_button_exit(void
 		remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 
-	return_VOID;
 }
 
 module_init(acpi_button_init);
---
0.99.9.GIT


