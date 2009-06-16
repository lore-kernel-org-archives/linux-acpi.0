From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 09/15] eeepc-laptop: rfkill refactoring
Date: Tue, 16 Jun 2009 21:28:50 +0200
Message-ID: <1245180536-28009-10-git-send-email-corentincj@iksaif.net>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-2-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-3-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-4-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-5-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-6-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-7-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-8-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-9-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:60972 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754367AbZFPTb0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 15:31:26 -0400
In-Reply-To: <1245180536-28009-9-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Refactor rfkill code, because we'll add another
rfkill for wwan3g later.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |  189 +++++++++++++++++------------------
 1 files changed, 94 insertions(+), 95 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 2a03425..7b7c750 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -128,8 +128,8 @@ struct eeepc_hotk {
 	u16 event_count[128];		/* count for each event */
 	struct input_dev *inputdev;
 	u16 *keycode_map;
-	struct rfkill *eeepc_wlan_rfkill;
-	struct rfkill *eeepc_bluetooth_rfkill;
+	struct rfkill *wlan_rfkill;
+	struct rfkill *bluetooth_rfkill;
 	struct hotplug_slot *hotplug_slot;
 };
 
@@ -570,7 +570,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 		return;
 	}
 
-	eeepc_wlan_rfkill_state(ehotk->eeepc_wlan_rfkill, &state);
+	eeepc_wlan_rfkill_state(ehotk->wlan_rfkill, &state);
 
 	if (state == RFKILL_STATE_UNBLOCKED) {
 		dev = pci_get_slot(bus, 0);
@@ -593,7 +593,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 		}
 	}
 
-	rfkill_force_state(ehotk->eeepc_wlan_rfkill, state);
+	rfkill_force_state(ehotk->wlan_rfkill, state);
 }
 
 static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
@@ -753,89 +753,8 @@ static int eeepc_hotk_add(struct acpi_device *device)
 	if (ACPI_FAILURE(status))
 		pr_err("Error installing notify handler\n");
 
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
-
-	if (get_acpi(CM_ASL_WLAN) != -1) {
-		ehotk->eeepc_wlan_rfkill = rfkill_allocate(&device->dev,
-							   RFKILL_TYPE_WLAN);
-
-		if (!ehotk->eeepc_wlan_rfkill)
-			goto wlan_fail;
-
-		ehotk->eeepc_wlan_rfkill->name = "eeepc-wlan";
-		ehotk->eeepc_wlan_rfkill->toggle_radio = eeepc_wlan_rfkill_set;
-		ehotk->eeepc_wlan_rfkill->get_state = eeepc_wlan_rfkill_state;
-		if (get_acpi(CM_ASL_WLAN) == 1) {
-			ehotk->eeepc_wlan_rfkill->state =
-				RFKILL_STATE_UNBLOCKED;
-			rfkill_set_default(RFKILL_TYPE_WLAN,
-					   RFKILL_STATE_UNBLOCKED);
-		} else {
-			ehotk->eeepc_wlan_rfkill->state =
-				RFKILL_STATE_SOFT_BLOCKED;
-			rfkill_set_default(RFKILL_TYPE_WLAN,
-					   RFKILL_STATE_SOFT_BLOCKED);
-		}
-		result = rfkill_register(ehotk->eeepc_wlan_rfkill);
-		if (result)
-			goto wlan_fail;
-	}
-
-	if (get_acpi(CM_ASL_BLUETOOTH) != -1) {
-		ehotk->eeepc_bluetooth_rfkill =
-			rfkill_allocate(&device->dev, RFKILL_TYPE_BLUETOOTH);
-
-		if (!ehotk->eeepc_bluetooth_rfkill)
-			goto bluetooth_fail;
-
-		ehotk->eeepc_bluetooth_rfkill->name = "eeepc-bluetooth";
-		ehotk->eeepc_bluetooth_rfkill->toggle_radio =
-			eeepc_bluetooth_rfkill_set;
-		ehotk->eeepc_bluetooth_rfkill->get_state =
-			eeepc_bluetooth_rfkill_state;
-		if (get_acpi(CM_ASL_BLUETOOTH) == 1) {
-			ehotk->eeepc_bluetooth_rfkill->state =
-				RFKILL_STATE_UNBLOCKED;
-			rfkill_set_default(RFKILL_TYPE_BLUETOOTH,
-					   RFKILL_STATE_UNBLOCKED);
-		} else {
-			ehotk->eeepc_bluetooth_rfkill->state =
-				RFKILL_STATE_SOFT_BLOCKED;
-			rfkill_set_default(RFKILL_TYPE_BLUETOOTH,
-					   RFKILL_STATE_SOFT_BLOCKED);
-		}
-
-		result = rfkill_register(ehotk->eeepc_bluetooth_rfkill);
-		if (result)
-			goto bluetooth_fail;
-	}
-
-	result = eeepc_setup_pci_hotplug();
-	/*
-	 * If we get -EBUSY then something else is handling the PCI hotplug -
-	 * don't fail in this case
-	 */
-	if (result == -EBUSY)
-		return 0;
-	else if (result)
-		goto pci_fail;
-
 	return 0;
 
- pci_fail:
-	if (ehotk->eeepc_bluetooth_rfkill)
-		rfkill_unregister(ehotk->eeepc_bluetooth_rfkill);
- bluetooth_fail:
-	if (ehotk->eeepc_bluetooth_rfkill)
-		rfkill_free(ehotk->eeepc_bluetooth_rfkill);
-	rfkill_unregister(ehotk->eeepc_wlan_rfkill);
-	ehotk->eeepc_wlan_rfkill = NULL;
- wlan_fail:
-	if (ehotk->eeepc_wlan_rfkill)
-		rfkill_free(ehotk->eeepc_wlan_rfkill);
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
  ehotk_fail:
 	kfree(ehotk);
 	ehotk = NULL;
@@ -854,11 +773,6 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 	if (ACPI_FAILURE(status))
 		pr_err("Error removing notify handler\n");
 
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
-	if (ehotk->hotplug_slot)
-		pci_hp_deregister(ehotk->hotplug_slot);
-
 	kfree(ehotk);
 	return 0;
 }
@@ -979,10 +893,14 @@ static void eeepc_backlight_exit(void)
 
 static void eeepc_rfkill_exit(void)
 {
-	if (ehotk->eeepc_wlan_rfkill)
-		rfkill_unregister(ehotk->eeepc_wlan_rfkill);
-	if (ehotk->eeepc_bluetooth_rfkill)
-		rfkill_unregister(ehotk->eeepc_bluetooth_rfkill);
+	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
+	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
+	if (ehotk->wlan_rfkill)
+		rfkill_unregister(ehotk->wlan_rfkill);
+	if (ehotk->bluetooth_rfkill)
+		rfkill_unregister(ehotk->bluetooth_rfkill);
+	if (ehotk->hotplug_slot)
+		pci_hp_deregister(ehotk->hotplug_slot);
 }
 
 static void eeepc_input_exit(void)
@@ -1017,6 +935,80 @@ static void __exit eeepc_laptop_exit(void)
 	platform_driver_unregister(&platform_driver);
 }
 
+static int eeepc_new_rfkill(struct rfkill **rfkill,
+			    const char *name, struct device *dev,
+			    enum rfkill_type type, int cm,
+			    int (*toggle)(void *, enum rfkill_state),
+			    int (*get)(void *, enum rfkill_state *))
+{
+	int result;
+
+	if (get_acpi(cm) == -1)
+		return -ENODEV;
+
+	*rfkill = rfkill_allocate(dev, type);
+	if (!*rfkill)
+		return -EINVAL;
+
+	(*rfkill)->name = name;
+	(*rfkill)->toggle_radio = toggle;
+	(*rfkill)->get_state = get;
+	if (get_acpi(cm) == 1) {
+		(*rfkill)->state = RFKILL_STATE_UNBLOCKED;
+		rfkill_set_default(type, RFKILL_STATE_UNBLOCKED);
+	} else {
+		(*rfkill)->state = RFKILL_STATE_SOFT_BLOCKED;
+		rfkill_set_default(type, RFKILL_STATE_SOFT_BLOCKED);
+	}
+	result = rfkill_register(*rfkill);
+	if (result) {
+		rfkill_free(*rfkill);
+		*rfkill = NULL;
+		return result;
+	}
+	return 0;
+}
+
+
+static int eeepc_rfkill_init(struct device *dev)
+{
+	int result = 0;
+
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
+
+	result = eeepc_new_rfkill(&ehotk->wlan_rfkill,
+				  "eeepc-wlan", dev,
+				  RFKILL_TYPE_WLAN, CM_ASL_WLAN,
+				  eeepc_wlan_rfkill_set,
+				  eeepc_wlan_rfkill_state);
+
+	if (result && result != -ENODEV)
+		goto exit;
+
+	result = eeepc_new_rfkill(&ehotk->bluetooth_rfkill,
+				  "eeepc-bluetooth", dev,
+				  RFKILL_TYPE_BLUETOOTH, CM_ASL_BLUETOOTH,
+				  eeepc_bluetooth_rfkill_set,
+				  eeepc_bluetooth_rfkill_state);
+
+	if (result && result != -ENODEV)
+		goto exit;
+
+	result = eeepc_setup_pci_hotplug();
+	/*
+	 * If we get -EBUSY then something else is handling the PCI hotplug -
+	 * don't fail in this case
+	 */
+	if (result == -EBUSY)
+		result = 0;
+
+exit:
+	if (result && result != -ENODEV)
+		eeepc_rfkill_exit();
+	return result;
+}
+
 static int eeepc_backlight_init(struct device *dev)
 {
 	struct backlight_device *bd;
@@ -1100,7 +1092,15 @@ static int __init eeepc_laptop_init(void)
 				    &platform_attribute_group);
 	if (result)
 		goto fail_sysfs;
+
+	result = eeepc_rfkill_init(dev);
+	if (result)
+		goto fail_rfkill;
+
 	return 0;
+fail_rfkill:
+	sysfs_remove_group(&platform_device->dev.kobj,
+			   &platform_attribute_group);
 fail_sysfs:
 	platform_device_del(platform_device);
 fail_platform_device2:
@@ -1113,7 +1113,6 @@ fail_hwmon:
 	eeepc_backlight_exit();
 fail_backlight:
 	eeepc_input_exit();
-	eeepc_rfkill_exit();
 	return result;
 }
 
-- 
1.6.3.1

