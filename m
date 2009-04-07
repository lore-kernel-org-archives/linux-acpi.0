From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/17] panasonic-laptop: use .notify method instead of
 installing handler directly
Date: Tue, 07 Apr 2009 19:04:19 -0400
Message-ID: <cddd1f71d972a43c88f0ef91e1b71023539cd6e0.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:53691 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbZDGXEr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR00CC96RUFDXW@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:47 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Harald Welte <laforge@gnumonks.org>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Harald Welte <laforge@gnumonks.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/panasonic-laptop.c |   26 +++++---------------------
 1 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index a5ce4bc..1a11de0 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -176,6 +176,7 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 static int acpi_pcc_hotkey_add(struct acpi_device *device);
 static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type);
 static int acpi_pcc_hotkey_resume(struct acpi_device *device);
+static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id pcc_device_ids[] = {
 	{ "MAT0012", 0},
@@ -194,6 +195,7 @@ static struct acpi_driver acpi_pcc_driver = {
 				.add =		acpi_pcc_hotkey_add,
 				.remove =	acpi_pcc_hotkey_remove,
 				.resume =       acpi_pcc_hotkey_resume,
+				.notify =	acpi_pcc_hotkey_notify,
 			},
 };
 
@@ -527,9 +529,9 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 	return;
 }
 
-static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
 {
-	struct pcc_acpi *pcc = (struct pcc_acpi *) data;
+	struct pcc_acpi *pcc = acpi_driver_data(device);
 
 	switch (event) {
 	case HKEY_NOTIFY:
@@ -599,7 +601,6 @@ static int acpi_pcc_hotkey_resume(struct acpi_device *device)
 
 static int acpi_pcc_hotkey_add(struct acpi_device *device)
 {
-	acpi_status status;
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
 
@@ -640,22 +641,11 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 		goto out_sinf;
 	}
 
-	/* initialize hotkey input device */
-	status = acpi_install_notify_handler(pcc->handle, ACPI_DEVICE_NOTIFY,
-					     acpi_pcc_hotkey_notify, pcc);
-
-	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing notify handler\n"));
-		result = -ENODEV;
-		goto out_input;
-	}
-
 	/* initialize backlight */
 	pcc->backlight = backlight_device_register("panasonic", NULL, pcc,
 						   &pcc_backlight_ops);
 	if (IS_ERR(pcc->backlight))
-		goto out_notify;
+		goto out_input;
 
 	if (!acpi_pcc_retrieve_biosdata(pcc, pcc->sinf)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
@@ -680,9 +670,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 out_backlight:
 	backlight_device_unregister(pcc->backlight);
-out_notify:
-	acpi_remove_notify_handler(pcc->handle, ACPI_DEVICE_NOTIFY,
-				   acpi_pcc_hotkey_notify);
 out_input:
 	input_unregister_device(pcc->input_dev);
 	/* no need to input_free_device() since core input API refcount and
@@ -723,9 +710,6 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
 
 	backlight_device_unregister(pcc->backlight);
 
-	acpi_remove_notify_handler(pcc->handle, ACPI_DEVICE_NOTIFY,
-				   acpi_pcc_hotkey_notify);
-
 	input_unregister_device(pcc->input_dev);
 	/* no need to input_free_device() since core input API refcount and
 	 * free()s the device */
-- 
1.6.0.6

