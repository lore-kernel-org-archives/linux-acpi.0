From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 08/10] eeepc-laptop: Check return values from rfkill_register
Date: Tue, 20 Jan 2009 16:17:47 +0100
Message-ID: <1232464669-29619-9-git-send-email-corentincj@iksaif.net>
References: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:59569 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757449AbZATPR6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jan 2009 10:17:58 -0500
In-Reply-To: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Corentin Chary <corentincj@iksaif.net>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Error out if rfkill registration fails, and also set the default system state
appropriately on boot

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   51 +++++++++++++++++++++++++---------
 1 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index d153871..21e5206 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -562,7 +562,7 @@ static int eeepc_hotk_add(struct acpi_device *device)
 	ehotk->device = device;
 	result = eeepc_hotk_check();
 	if (result)
-		goto end;
+		goto ehotk_fail;
 	status = acpi_install_notify_handler(ehotk->handle, ACPI_SYSTEM_NOTIFY,
 					     eeepc_hotk_notify, ehotk);
 	if (ACPI_FAILURE(status))
@@ -573,18 +573,25 @@ static int eeepc_hotk_add(struct acpi_device *device)
 							   RFKILL_TYPE_WLAN);
 
 		if (!ehotk->eeepc_wlan_rfkill)
-			goto end;
+			goto wlan_fail;
 
 		ehotk->eeepc_wlan_rfkill->name = "eeepc-wlan";
 		ehotk->eeepc_wlan_rfkill->toggle_radio = eeepc_wlan_rfkill_set;
 		ehotk->eeepc_wlan_rfkill->get_state = eeepc_wlan_rfkill_state;
-		if (get_acpi(CM_ASL_WLAN) == 1)
+		if (get_acpi(CM_ASL_WLAN) == 1) {
 			ehotk->eeepc_wlan_rfkill->state =
 				RFKILL_STATE_UNBLOCKED;
-		else
+			rfkill_set_default(RFKILL_TYPE_WLAN,
+					   RFKILL_STATE_UNBLOCKED);
+		} else {
 			ehotk->eeepc_wlan_rfkill->state =
 				RFKILL_STATE_SOFT_BLOCKED;
-		rfkill_register(ehotk->eeepc_wlan_rfkill);
+			rfkill_set_default(RFKILL_TYPE_WLAN,
+					   RFKILL_STATE_SOFT_BLOCKED);
+		}
+		result = rfkill_register(ehotk->eeepc_wlan_rfkill);
+		if (result)
+			goto wlan_fail;
 	}
 
 	if (get_acpi(CM_ASL_BLUETOOTH) != -1) {
@@ -592,27 +599,43 @@ static int eeepc_hotk_add(struct acpi_device *device)
 			rfkill_allocate(&device->dev, RFKILL_TYPE_BLUETOOTH);
 
 		if (!ehotk->eeepc_bluetooth_rfkill)
-			goto end;
+			goto bluetooth_fail;
 
 		ehotk->eeepc_bluetooth_rfkill->name = "eeepc-bluetooth";
 		ehotk->eeepc_bluetooth_rfkill->toggle_radio =
 			eeepc_bluetooth_rfkill_set;
 		ehotk->eeepc_bluetooth_rfkill->get_state =
 			eeepc_bluetooth_rfkill_state;
-		if (get_acpi(CM_ASL_BLUETOOTH) == 1)
+		if (get_acpi(CM_ASL_BLUETOOTH) == 1) {
 			ehotk->eeepc_bluetooth_rfkill->state =
 				RFKILL_STATE_UNBLOCKED;
-		else
+			rfkill_set_default(RFKILL_TYPE_BLUETOOTH,
+					   RFKILL_STATE_UNBLOCKED);
+		} else {
 			ehotk->eeepc_bluetooth_rfkill->state =
 				RFKILL_STATE_SOFT_BLOCKED;
-		rfkill_register(ehotk->eeepc_bluetooth_rfkill);
-	}
+			rfkill_set_default(RFKILL_TYPE_BLUETOOTH,
+					   RFKILL_STATE_SOFT_BLOCKED);
+		}
 
- end:
-	if (result) {
-		kfree(ehotk);
-		ehotk = NULL;
+		result = rfkill_register(ehotk->eeepc_bluetooth_rfkill);
+		if (result)
+			goto bluetooth_fail;
 	}
+	return 0;
+
+ bluetooth_fail:
+	if (ehotk->eeepc_bluetooth_rfkill)
+		rfkill_free(ehotk->eeepc_bluetooth_rfkill);
+	rfkill_unregister(ehotk->eeepc_wlan_rfkill);
+	ehotk->eeepc_wlan_rfkill = NULL;
+ wlan_fail:
+	if (ehotk->eeepc_wlan_rfkill)
+		rfkill_free(ehotk->eeepc_wlan_rfkill);
+ ehotk_fail:
+	kfree(ehotk);
+	ehotk = NULL;
+
 	return result;
 }
 
-- 
1.6.1

