From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/30] eeepc-laptop: Check return values from rfkill_register
Date: Sat, 07 Feb 2009 01:41:20 -0500
Message-ID: <c9ddf8fede1271bde0a512fa94f77c4cb1ef4040.1233988824.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:10445 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbZBGGl7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:59 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00MDINXSVVZ0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:53 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Error out if rfkill registration fails, and also set the default system state
appropriately on boot

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.6.6

