From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/7] fujitsu-laptop: use .notify method instead of installing
	handler directly
Date: Tue, 07 Apr 2009 09:37:16 -0600
Message-ID: <20090407153716.21399.63713.stgit@bob.kio>
References: <20090407153532.21399.92051.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:8725 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991AbZDGPhR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 11:37:17 -0400
In-Reply-To: <20090407153532.21399.92051.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Mattia Dongili <malattia@linux.it>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Harald Welte <laforge@gnumonks.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

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
 

