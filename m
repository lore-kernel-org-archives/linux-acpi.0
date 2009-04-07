From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/17] fujitsu-laptop: use .notify method instead of installing
 hotkey handler directly
Date: Tue, 07 Apr 2009 19:04:18 -0400
Message-ID: <b4ec0275464756f4fd4108b4a4ca7aff61358ad3.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:25536 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZDGXEm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:42 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR00DBN6RO47VY@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:41 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Tested by Tony on Fujitsu-Siemens Lifebook S6420 [FJNB1E6] with
BIOS 1.18 (01/09/2009).  Tested by Jonathan on Fujitsu S7020.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Tony Vroon <tony@linx.net>
Tested-By: Tony Vroon <tony@linx.net>
Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Tested-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/fujitsu-laptop.c |   32 +++++---------------------------
 1 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 10f8796..218b9a1 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -174,8 +174,7 @@ struct fujitsu_hotkey_t {
 
 static struct fujitsu_hotkey_t *fujitsu_hotkey;
 
-static void acpi_fujitsu_hotkey_notify(acpi_handle handle, u32 event,
-				       void *data);
+static void acpi_fujitsu_hotkey_notify(struct acpi_device *device, u32 event);
 
 #ifdef CONFIG_LEDS_CLASS
 static enum led_brightness logolamp_get(struct led_classdev *cdev);
@@ -816,7 +815,6 @@ static void acpi_fujitsu_notify(struct acpi_device *device, u32 event)
 
 static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
 {
-	acpi_status status;
 	acpi_handle handle;
 	int result = 0;
 	int state = 0;
@@ -833,17 +831,6 @@ static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
 	sprintf(acpi_device_class(device), "%s", ACPI_FUJITSU_CLASS);
 	device->driver_data = fujitsu_hotkey;
 
-	status = acpi_install_notify_handler(device->handle,
-					     ACPI_DEVICE_NOTIFY,
-					     acpi_fujitsu_hotkey_notify,
-					     fujitsu_hotkey);
-
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR "Error installing notify handler\n");
-		error = -ENODEV;
-		goto err_stop;
-	}
-
 	/* kfifo */
 	spin_lock_init(&fujitsu_hotkey->fifo_lock);
 	fujitsu_hotkey->fifo =
@@ -858,7 +845,7 @@ static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
 	fujitsu_hotkey->input = input = input_allocate_device();
 	if (!input) {
 		error = -ENOMEM;
-		goto err_uninstall_notify;
+		goto err_free_fifo;
 	}
 
 	snprintf(fujitsu_hotkey->phys, sizeof(fujitsu_hotkey->phys),
@@ -954,9 +941,7 @@ static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
 end:
 err_free_input_dev:
 	input_free_device(input);
-err_uninstall_notify:
-	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-				   acpi_fujitsu_hotkey_notify);
+err_free_fifo:
 	kfifo_free(fujitsu_hotkey->fifo);
 err_stop:
 
@@ -965,7 +950,6 @@ err_stop:
 
 static int acpi_fujitsu_hotkey_remove(struct acpi_device *device, int type)
 {
-	acpi_status status;
 	struct fujitsu_hotkey_t *fujitsu_hotkey = NULL;
 
 	if (!device || !acpi_driver_data(device))
@@ -973,10 +957,6 @@ static int acpi_fujitsu_hotkey_remove(struct acpi_device *device, int type)
 
 	fujitsu_hotkey = acpi_driver_data(device);
 
-	status = acpi_remove_notify_handler(fujitsu_hotkey->acpi_handle,
-					    ACPI_DEVICE_NOTIFY,
-					    acpi_fujitsu_hotkey_notify);
-
 	fujitsu_hotkey->acpi_handle = NULL;
 
 	kfifo_free(fujitsu_hotkey->fifo);
@@ -984,8 +964,7 @@ static int acpi_fujitsu_hotkey_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
-static void acpi_fujitsu_hotkey_notify(acpi_handle handle, u32 event,
-				       void *data)
+static void acpi_fujitsu_hotkey_notify(struct acpi_device *device, u32 event)
 {
 	struct input_dev *input;
 	int keycode, keycode_r;
@@ -1068,8 +1047,6 @@ static void acpi_fujitsu_hotkey_notify(acpi_handle handle, u32 event,
 		input_sync(input);
 		break;
 	}
-
-	return;
 }
 
 /* Initialization */
@@ -1102,6 +1079,7 @@ static struct acpi_driver acpi_fujitsu_hotkey_driver = {
 	.ops = {
 		.add = acpi_fujitsu_hotkey_add,
 		.remove = acpi_fujitsu_hotkey_remove,
+		.notify = acpi_fujitsu_hotkey_notify,
 		},
 };
 
-- 
1.6.0.6

