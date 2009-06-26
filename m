From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/8] eeepc-laptop.c: use pr_fmt and pr_<level>
Date: Fri, 26 Jun 2009 00:20:14 -0400
Message-ID: <cc4267ff910a628afe7f445d52597a81bc76dfe5.1245989983.git.len.brown@intel.com>
References: <1245990020-20455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:62414 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbZFZEVH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 00:21:07 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLT004OYW26SCE2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 25 Jun 2009 23:20:36 -0500 (CDT)
In-reply-to: <1245990020-20455-1-git-send-email-lenb@kernel.org>
In-reply-to: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
References: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Joe Perches <joe@perches.com>

Convert the unusual printk(EEEPC_<level> uses to
the more standard pr_fmt and pr_<level>(.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   55 ++++++++++++++---------------------
 1 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index c0b203c..d14f714 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -16,6 +16,8 @@
  *  GNU General Public License for more details.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -41,11 +43,6 @@
 #define EEEPC_HOTK_DEVICE_NAME	"Hotkey"
 #define EEEPC_HOTK_HID		"ASUS010"
 
-#define EEEPC_LOG	EEEPC_HOTK_FILE ": "
-#define EEEPC_ERR	KERN_ERR	EEEPC_LOG
-#define EEEPC_WARNING	KERN_WARNING	EEEPC_LOG
-#define EEEPC_NOTICE	KERN_NOTICE	EEEPC_LOG
-#define EEEPC_INFO	KERN_INFO	EEEPC_LOG
 
 /*
  * Definitions for Asus EeePC
@@ -285,7 +282,7 @@ static int set_acpi(int cm, int value)
 		if (method == NULL)
 			return -ENODEV;
 		if (write_acpi_int(ehotk->handle, method, value, NULL))
-			printk(EEEPC_WARNING "Error writing %s\n", method);
+			pr_warning("Error writing %s\n", method);
 	}
 	return 0;
 }
@@ -298,7 +295,7 @@ static int get_acpi(int cm)
 		if (method == NULL)
 			return -ENODEV;
 		if (read_acpi_int(ehotk->handle, method, &value))
-			printk(EEEPC_WARNING "Error reading %s\n", method);
+			pr_warning("Error reading %s\n", method);
 	}
 	return value;
 }
@@ -562,26 +559,23 @@ static int eeepc_hotk_check(void)
 	if (ehotk->device->status.present) {
 		if (write_acpi_int(ehotk->handle, "INIT", ehotk->init_flag,
 				    &buffer)) {
-			printk(EEEPC_ERR "Hotkey initialization failed\n");
+			pr_err("Hotkey initialization failed\n");
 			return -ENODEV;
 		} else {
-			printk(EEEPC_NOTICE "Hotkey init flags 0x%x\n",
-			       ehotk->init_flag);
+			pr_notice("Hotkey init flags 0x%x\n", ehotk->init_flag);
 		}
 		/* get control methods supported */
 		if (read_acpi_int(ehotk->handle, "CMSG"
 				   , &ehotk->cm_supported)) {
-			printk(EEEPC_ERR
-			       "Get control methods supported failed\n");
+			pr_err("Get control methods supported failed\n");
 			return -ENODEV;
 		} else {
-			printk(EEEPC_INFO
-			       "Get control methods supported: 0x%x\n",
-			       ehotk->cm_supported);
+			pr_info("Get control methods supported: 0x%x\n",
+				ehotk->cm_supported);
 		}
 		ehotk->inputdev = input_allocate_device();
 		if (!ehotk->inputdev) {
-			printk(EEEPC_INFO "Unable to allocate input device\n");
+			pr_info("Unable to allocate input device\n");
 			return 0;
 		}
 		ehotk->inputdev->name = "Asus EeePC extra buttons";
@@ -600,12 +594,12 @@ static int eeepc_hotk_check(void)
 		}
 		result = input_register_device(ehotk->inputdev);
 		if (result) {
-			printk(EEEPC_INFO "Unable to register input device\n");
+			pr_info("Unable to register input device\n");
 			input_free_device(ehotk->inputdev);
 			return 0;
 		}
 	} else {
-		printk(EEEPC_ERR "Hotkey device not present, aborting\n");
+		pr_err("Hotkey device not present, aborting\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -643,7 +637,7 @@ static void eeepc_rfkill_hotplug(void)
 	bool blocked;
 
 	if (!bus) {
-		printk(EEEPC_WARNING "Unable to find PCI bus 1?\n");
+		pr_warning("Unable to find PCI bus 1?\n");
 		return;
 	}
 
@@ -659,7 +653,7 @@ static void eeepc_rfkill_hotplug(void)
 		if (dev) {
 			pci_bus_assign_resources(bus);
 			if (pci_bus_add_device(dev))
-				printk(EEEPC_ERR "Unable to hotplug wifi\n");
+				pr_err("Unable to hotplug wifi\n");
 		}
 	} else {
 		dev = pci_get_slot(bus, 0);
@@ -742,8 +736,7 @@ static int eeepc_register_rfkill_notifier(char *node)
 						     eeepc_rfkill_notify,
 						     NULL);
 		if (ACPI_FAILURE(status))
-			printk(EEEPC_WARNING
-			       "Failed to register notify on %s\n", node);
+			pr_warning("Failed to register notify on %s\n", node);
 	} else
 		return -ENODEV;
 
@@ -762,8 +755,7 @@ static void eeepc_unregister_rfkill_notifier(char *node)
 						     ACPI_SYSTEM_NOTIFY,
 						     eeepc_rfkill_notify);
 		if (ACPI_FAILURE(status))
-			printk(EEEPC_ERR
-			       "Error removing rfkill notify handler %s\n",
+			pr_err("Error removing rfkill notify handler %s\n",
 				node);
 	}
 }
@@ -780,7 +772,7 @@ static int eeepc_setup_pci_hotplug(void)
 	struct pci_bus *bus = pci_find_bus(0, 1);
 
 	if (!bus) {
-		printk(EEEPC_ERR "Unable to find wifi PCI bus\n");
+		pr_err("Unable to find wifi PCI bus\n");
 		return -ENODEV;
 	}
 
@@ -801,7 +793,7 @@ static int eeepc_setup_pci_hotplug(void)
 
 	ret = pci_hp_register(ehotk->hotplug_slot, bus, 0, "eeepc-wifi");
 	if (ret) {
-		printk(EEEPC_ERR "Unable to register hotplug slot - %d\n", ret);
+		pr_err("Unable to register hotplug slot - %d\n", ret);
 		goto error_register;
 	}
 
@@ -822,7 +814,7 @@ static int eeepc_hotk_add(struct acpi_device *device)
 
 	if (!device)
 		 return -EINVAL;
-	printk(EEEPC_NOTICE EEEPC_HOTK_NAME "\n");
+	pr_notice(EEEPC_HOTK_NAME "\n");
 	ehotk = kzalloc(sizeof(struct eeepc_hotk), GFP_KERNEL);
 	if (!ehotk)
 		return -ENOMEM;
@@ -1105,8 +1097,7 @@ static int eeepc_backlight_init(struct device *dev)
 	bd = backlight_device_register(EEEPC_HOTK_FILE, dev,
 				       NULL, &eeepcbl_ops);
 	if (IS_ERR(bd)) {
-		printk(EEEPC_ERR
-		       "Could not register eeepc backlight device\n");
+		pr_err("Could not register eeepc backlight device\n");
 		eeepc_backlight_device = NULL;
 		return PTR_ERR(bd);
 	}
@@ -1125,8 +1116,7 @@ static int eeepc_hwmon_init(struct device *dev)
 
 	hwmon = hwmon_device_register(dev);
 	if (IS_ERR(hwmon)) {
-		printk(EEEPC_ERR
-		       "Could not register eeepc hwmon device\n");
+		pr_err("Could not register eeepc hwmon device\n");
 		eeepc_hwmon_device = NULL;
 		return PTR_ERR(hwmon);
 	}
@@ -1159,8 +1149,7 @@ static int __init eeepc_laptop_init(void)
 		if (result)
 			goto fail_backlight;
 	} else
-		printk(EEEPC_INFO "Backlight controlled by ACPI video "
-		       "driver\n");
+		pr_info("Backlight controlled by ACPI video driver\n");
 
 	result = eeepc_hwmon_init(dev);
 	if (result)
-- 
1.6.0.6

