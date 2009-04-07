From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 5/7] panasonic-laptop: use .notify method instead of
	installing handler directly
Date: Tue, 07 Apr 2009 09:37:27 -0600
Message-ID: <20090407153727.21399.90323.stgit@bob.kio>
References: <20090407153532.21399.92051.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:39562 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbZDGPh2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 11:37:28 -0400
In-Reply-To: <20090407153532.21399.92051.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Mattia Dongili <malattia@linux.it>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Harald Welte <laforge@gnumonks.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Harald Welte <laforge@gnumonks.org>
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

