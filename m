From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 4/9] eeepc-laptop: rfkill refactoring
Date: Fri, 19 Jun 2009 14:52:06 +0200
Message-ID: <1245415931-26466-4-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
 <1245415931-26466-1-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-2-git-send-email-corentincj@iksaif.net>
 <1245415931-26466-3-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.orange.fr ([80.12.242.49]:23072 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbZFSMym (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jun 2009 08:54:42 -0400
In-Reply-To: <1245415931-26466-3-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Refactor rfkill code, because we'll add another
rfkill for wwan3g later.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |  151 ++++++++++++++++++----------------
 1 files changed, 80 insertions(+), 71 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 20e264f..b2e8a71 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -139,8 +139,8 @@ struct eeepc_hotk {
 	u16 event_count[128];		/* count for each event */
 	struct input_dev *inputdev;
 	u16 *keycode_map;
-	struct rfkill *eeepc_wlan_rfkill;
-	struct rfkill *eeepc_bluetooth_rfkill;
+	struct rfkill *wlan_rfkill;
+	struct rfkill *bluetooth_rfkill;
 	struct hotplug_slot *hotplug_slot;
 };
 
@@ -664,7 +664,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 		}
 	}
 
-	rfkill_set_sw_state(ehotk->eeepc_wlan_rfkill, blocked);
+	rfkill_set_sw_state(ehotk->wlan_rfkill, blocked);
 }
 
 static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
@@ -821,66 +821,8 @@ static int eeepc_hotk_add(struct acpi_device *device)
 	if (result)
 		goto ehotk_fail;
 
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
-
-	if (get_acpi(CM_ASL_WLAN) != -1) {
-		ehotk->eeepc_wlan_rfkill = rfkill_alloc("eeepc-wlan",
-							&device->dev,
-							RFKILL_TYPE_WLAN,
-							&eeepc_rfkill_ops,
-							(void *)CM_ASL_WLAN);
-
-		if (!ehotk->eeepc_wlan_rfkill)
-			goto wlan_fail;
-
-		rfkill_set_sw_state(ehotk->eeepc_wlan_rfkill,
-				    get_acpi(CM_ASL_WLAN) != 1);
-		result = rfkill_register(ehotk->eeepc_wlan_rfkill);
-		if (result)
-			goto wlan_fail;
-	}
-
-	if (get_acpi(CM_ASL_BLUETOOTH) != -1) {
-		ehotk->eeepc_bluetooth_rfkill =
-			rfkill_alloc("eeepc-bluetooth",
-				     &device->dev,
-				     RFKILL_TYPE_BLUETOOTH,
-				     &eeepc_rfkill_ops,
-				     (void *)CM_ASL_BLUETOOTH);
-
-		if (!ehotk->eeepc_bluetooth_rfkill)
-			goto bluetooth_fail;
-
-		rfkill_set_sw_state(ehotk->eeepc_bluetooth_rfkill,
-				    get_acpi(CM_ASL_BLUETOOTH) != 1);
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
-	rfkill_destroy(ehotk->eeepc_bluetooth_rfkill);
-	rfkill_unregister(ehotk->eeepc_wlan_rfkill);
- wlan_fail:
-	rfkill_destroy(ehotk->eeepc_wlan_rfkill);
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
  ehotk_fail:
 	kfree(ehotk);
 	ehotk = NULL;
@@ -893,11 +835,6 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 	if (!device || !acpi_driver_data(device))
 		 return -EINVAL;
 
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
-	if (ehotk->hotplug_slot)
-		pci_hp_deregister(ehotk->hotplug_slot);
-
 	kfree(ehotk);
 	return 0;
 }
@@ -1018,10 +955,14 @@ static void eeepc_backlight_exit(void)
 
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
@@ -1056,6 +997,67 @@ static void __exit eeepc_laptop_exit(void)
 	platform_driver_unregister(&platform_driver);
 }
 
+static int eeepc_new_rfkill(struct rfkill **rfkill,
+			    const char *name, struct device *dev,
+			    enum rfkill_type type, int cm)
+{
+	int result;
+
+	if (get_acpi(cm) == -1)
+		return -ENODEV;
+
+	*rfkill = rfkill_alloc(name, dev, type,
+			       &eeepc_rfkill_ops, (void *)(unsigned long)cm);
+
+	if (!*rfkill)
+		return -EINVAL;
+
+	rfkill_set_sw_state(*rfkill, get_acpi(cm) != 1);
+	result = rfkill_register(*rfkill);
+	if (result) {
+		rfkill_destroy(*rfkill);
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
+				  RFKILL_TYPE_WLAN, CM_ASL_WLAN);
+
+	if (result && result != -ENODEV)
+		goto exit;
+
+	result = eeepc_new_rfkill(&ehotk->bluetooth_rfkill,
+				  "eeepc-bluetooth", dev,
+				  RFKILL_TYPE_BLUETOOTH, CM_ASL_BLUETOOTH);
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
@@ -1139,7 +1141,15 @@ static int __init eeepc_laptop_init(void)
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
@@ -1152,7 +1162,6 @@ fail_hwmon:
 	eeepc_backlight_exit();
 fail_backlight:
 	eeepc_input_exit();
-	eeepc_rfkill_exit();
 	return result;
 }
 
-- 
1.6.3.1


