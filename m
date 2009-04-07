From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/7] fujitsu-laptop: use .notify method instead of installing
	hotkey handler directly
Date: Tue, 07 Apr 2009 09:37:22 -0600
Message-ID: <20090407153722.21399.22689.stgit@bob.kio>
References: <20090407153532.21399.92051.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:8754 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbZDGPhW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 11:37:22 -0400
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
 

