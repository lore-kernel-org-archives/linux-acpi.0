From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 08/10] panasonic-laptop: use .notify method instead of
	installing handler directly
Date: Mon, 30 Mar 2009 11:48:49 -0600
Message-ID: <20090330174849.20905.70883.stgit@bob.kio>
References: <20090330174646.20905.18465.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:41885 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956AbZC3Rsv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2009 13:48:51 -0400
In-Reply-To: <20090330174646.20905.18465.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Harald Welte <laforge@gnumonks.org>
---
 drivers/platform/x86/panasonic-laptop.c |   26 +++++---------------------
 1 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index c47a44d..6356031 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -176,6 +176,7 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 static int acpi_pcc_hotkey_add(struct acpi_device *device);
 static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type);
 static int acpi_pcc_hotkey_resume(struct acpi_device *device);
+static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id pcc_device_ids[] = {
 	{ "MAT0012", 0},
@@ -193,6 +194,7 @@ static struct acpi_driver acpi_pcc_driver = {
 				.add =		acpi_pcc_hotkey_add,
 				.remove =	acpi_pcc_hotkey_remove,
 				.resume =       acpi_pcc_hotkey_resume,
+				.notify =	acpi_pcc_hotkey_notify,
 			},
 };
 
@@ -526,9 +528,9 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 	return;
 }
 
-static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
 {
-	struct pcc_acpi *pcc = (struct pcc_acpi *) data;
+	struct pcc_acpi *pcc = acpi_driver_data(device);
 
 	switch (event) {
 	case HKEY_NOTIFY:
@@ -598,7 +600,6 @@ static int acpi_pcc_hotkey_resume(struct acpi_device *device)
 
 static int acpi_pcc_hotkey_add(struct acpi_device *device)
 {
-	acpi_status status;
 	struct pcc_acpi *pcc;
 	int num_sifr, result;
 
@@ -639,22 +640,11 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
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
@@ -679,9 +669,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 out_backlight:
 	backlight_device_unregister(pcc->backlight);
-out_notify:
-	acpi_remove_notify_handler(pcc->handle, ACPI_DEVICE_NOTIFY,
-				   acpi_pcc_hotkey_notify);
 out_input:
 	input_unregister_device(pcc->input_dev);
 	/* no need to input_free_device() since core input API refcount and
@@ -722,9 +709,6 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
 
 	backlight_device_unregister(pcc->backlight);
 
-	acpi_remove_notify_handler(pcc->handle, ACPI_DEVICE_NOTIFY,
-				   acpi_pcc_hotkey_notify);
-
 	input_unregister_device(pcc->input_dev);
 	/* no need to input_free_device() since core input API refcount and
 	 * free()s the device */

