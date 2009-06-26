From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/8] eeepc-laptop: rfkill refactoring
Date: Fri, 26 Jun 2009 00:20:15 -0400
Message-ID: <8c39e87e5eaa0347fe3d7384445e833fe428c22e.1245989983.git.len.brown@intel.com>
References: <1245990020-20455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:51755 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbZFZEUb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 00:20:31 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLT00K2HW27CCX6@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 25 Jun 2009 23:20:32 -0500 (CDT)
In-reply-to: <1245990020-20455-1-git-send-email-lenb@kernel.org>
In-reply-to: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
References: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Refactor rfkill code, because we'll add another
rfkill for wwan3g later.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |  160 ++++++++++++++++++-----------------
 1 files changed, 84 insertions(+), 76 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index d14f714..e46981a 100644
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
 
@@ -663,7 +663,7 @@ static void eeepc_rfkill_hotplug(void)
 		}
 	}
 
-	rfkill_set_sw_state(ehotk->eeepc_wlan_rfkill, blocked);
+	rfkill_set_sw_state(ehotk->wlan_rfkill, blocked);
 }
 
 static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
@@ -828,66 +828,8 @@ static int eeepc_hotk_add(struct acpi_device *device)
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
-		rfkill_init_sw_state(ehotk->eeepc_wlan_rfkill,
-				     get_acpi(CM_ASL_WLAN) != 1);
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
-		rfkill_init_sw_state(ehotk->eeepc_bluetooth_rfkill,
-				     get_acpi(CM_ASL_BLUETOOTH) != 1);
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
@@ -900,18 +842,13 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
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
 
 static int eeepc_hotk_resume(struct acpi_device *device)
 {
-	if (ehotk->eeepc_wlan_rfkill) {
+	if (ehotk->wlan_rfkill) {
 		bool wlan;
 
 		/* Workaround - it seems that _PTS disables the wireless
@@ -923,14 +860,13 @@ static int eeepc_hotk_resume(struct acpi_device *device)
 		wlan = get_acpi(CM_ASL_WLAN);
 		set_acpi(CM_ASL_WLAN, wlan);
 
-		rfkill_set_sw_state(ehotk->eeepc_wlan_rfkill,
-				    wlan != 1);
+		rfkill_set_sw_state(ehotk->wlan_rfkill, wlan != 1);
 
 		eeepc_rfkill_hotplug();
 	}
 
-	if (ehotk->eeepc_bluetooth_rfkill)
-		rfkill_set_sw_state(ehotk->eeepc_bluetooth_rfkill,
+	if (ehotk->bluetooth_rfkill)
+		rfkill_set_sw_state(ehotk->bluetooth_rfkill,
 				    get_acpi(CM_ASL_BLUETOOTH) != 1);
 
 	return 0;
@@ -1052,10 +988,14 @@ static void eeepc_backlight_exit(void)
 
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
@@ -1090,6 +1030,67 @@ static void __exit eeepc_laptop_exit(void)
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
+	rfkill_init_sw_state(*rfkill, get_acpi(cm) != 1);
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
@@ -1173,7 +1174,15 @@ static int __init eeepc_laptop_init(void)
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
@@ -1186,7 +1195,6 @@ fail_hwmon:
 	eeepc_backlight_exit();
 fail_backlight:
 	eeepc_input_exit();
-	eeepc_rfkill_exit();
 	return result;
 }
 
-- 
1.6.0.6

