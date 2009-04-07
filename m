From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/17] fujitsu-laptop: use .notify method instead of installing
 handler directly
Date: Tue, 07 Apr 2009 19:04:17 -0400
Message-ID: <700b6721cd1b891b67c2dcee046be12154a21fd6.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55494 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbZDGXEt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:49 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR00EM26RNA2CJ@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:36 -0500 (CDT)
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
 drivers/platform/x86/fujitsu-laptop.c |   28 ++++------------------------
 1 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 45940f3..10f8796 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -203,7 +203,7 @@ struct led_classdev kblamps_led = {
 static u32 dbg_level = 0x03;
 #endif
 
-static void acpi_fujitsu_notify(acpi_handle handle, u32 event, void *data);
+static void acpi_fujitsu_notify(struct acpi_device *device, u32 event);
 
 /* Fujitsu ACPI interface function */
 
@@ -658,7 +658,6 @@ static struct dmi_system_id fujitsu_dmi_table[] = {
 
 static int acpi_fujitsu_add(struct acpi_device *device)
 {
-	acpi_status status;
 	acpi_handle handle;
 	int result = 0;
 	int state = 0;
@@ -673,20 +672,10 @@ static int acpi_fujitsu_add(struct acpi_device *device)
 	sprintf(acpi_device_class(device), "%s", ACPI_FUJITSU_CLASS);
 	device->driver_data = fujitsu;
 
-	status = acpi_install_notify_handler(device->handle,
-					     ACPI_DEVICE_NOTIFY,
-					     acpi_fujitsu_notify, fujitsu);
-
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR "Error installing notify handler\n");
-		error = -ENODEV;
-		goto err_stop;
-	}
-
 	fujitsu->input = input = input_allocate_device();
 	if (!input) {
 		error = -ENOMEM;
-		goto err_uninstall_notify;
+		goto err_stop;
 	}
 
 	snprintf(fujitsu->phys, sizeof(fujitsu->phys),
@@ -743,9 +732,6 @@ static int acpi_fujitsu_add(struct acpi_device *device)
 end:
 err_free_input_dev:
 	input_free_device(input);
-err_uninstall_notify:
-	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-				   acpi_fujitsu_notify);
 err_stop:
 
 	return result;
@@ -753,7 +739,6 @@ err_stop:
 
 static int acpi_fujitsu_remove(struct acpi_device *device, int type)
 {
-	acpi_status status;
 	struct fujitsu_t *fujitsu = NULL;
 
 	if (!device || !acpi_driver_data(device))
@@ -761,10 +746,6 @@ static int acpi_fujitsu_remove(struct acpi_device *device, int type)
 
 	fujitsu = acpi_driver_data(device);
 
-	status = acpi_remove_notify_handler(fujitsu->acpi_handle,
-					    ACPI_DEVICE_NOTIFY,
-					    acpi_fujitsu_notify);
-
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
@@ -775,7 +756,7 @@ static int acpi_fujitsu_remove(struct acpi_device *device, int type)
 
 /* Brightness notify */
 
-static void acpi_fujitsu_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_fujitsu_notify(struct acpi_device *device, u32 event)
 {
 	struct input_dev *input;
 	int keycode;
@@ -829,8 +810,6 @@ static void acpi_fujitsu_notify(acpi_handle handle, u32 event, void *data)
 		input_report_key(input, keycode, 0);
 		input_sync(input);
 	}
-
-	return;
 }
 
 /* ACPI device for hotkey handling */
@@ -1107,6 +1086,7 @@ static struct acpi_driver acpi_fujitsu_driver = {
 	.ops = {
 		.add = acpi_fujitsu_add,
 		.remove = acpi_fujitsu_remove,
+		.notify = acpi_fujitsu_notify,
 		},
 };
 
-- 
1.6.0.6

