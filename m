From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 3/4] eeepc-laptop.c: use pr_fmt and pr_<level>
Date: Mon,  8 Jun 2009 10:16:49 +0200
Message-ID: <1244449010-7995-4-git-send-email-corentincj@iksaif.net>
References: <1244449010-7995-1-git-send-email-corentincj@iksaif.net>
 <1244449010-7995-2-git-send-email-corentincj@iksaif.net>
 <1244449010-7995-3-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:52395 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbZFHIYV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2009 04:24:21 -0400
In-Reply-To: <1244449010-7995-3-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Joe Perches <joe@perches.com>, Corentin Chary <corentincj@iksaif.net>

From: Joe Perches <joe@perches.com>

Convert the unusual printk(EEEPC_<level> uses to
the more standard pr_fmt and pr_<level>(.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   59 ++++++++++++++--------------------
 1 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index ae1fb7b..dfda948 100644
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
@@ -269,7 +266,7 @@ static int set_acpi(int cm, int value)
 		if (method == NULL)
 			return -ENODEV;
 		if (write_acpi_int(ehotk->handle, method, value, NULL))
-			printk(EEEPC_WARNING "Error writing %s\n", method);
+			pr_warning("Error writing %s\n", method);
 	}
 	return 0;
 }
@@ -282,7 +279,7 @@ static int get_acpi(int cm)
 		if (method == NULL)
 			return -ENODEV;
 		if (read_acpi_int(ehotk->handle, method, &value))
-			printk(EEEPC_WARNING "Error reading %s\n", method);
+			pr_warning("Error reading %s\n", method);
 	}
 	return value;
 }
@@ -535,26 +532,23 @@ static int eeepc_hotk_check(void)
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
@@ -573,12 +567,12 @@ static int eeepc_hotk_check(void)
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
@@ -619,7 +613,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 		return;
 
 	if (!bus) {
-		printk(EEEPC_WARNING "Unable to find PCI bus 1?\n");
+		pr_warning("Unable to find PCI bus 1?\n");
 		return;
 	}
 
@@ -636,7 +630,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 		if (dev) {
 			pci_bus_assign_resources(bus);
 			if (pci_bus_add_device(dev))
-				printk(EEEPC_ERR "Unable to hotplug wifi\n");
+				pr_err("Unable to hotplug wifi\n");
 		}
 	} else {
 		dev = pci_get_slot(bus, 0);
@@ -709,8 +703,7 @@ static int eeepc_register_rfkill_notifier(char *node)
 						     eeepc_rfkill_notify,
 						     NULL);
 		if (ACPI_FAILURE(status))
-			printk(EEEPC_WARNING
-			       "Failed to register notify on %s\n", node);
+			pr_warning("Failed to register notify on %s\n", node);
 	} else
 		return -ENODEV;
 
@@ -729,8 +722,7 @@ static void eeepc_unregister_rfkill_notifier(char *node)
 						     ACPI_SYSTEM_NOTIFY,
 						     eeepc_rfkill_notify);
 		if (ACPI_FAILURE(status))
-			printk(EEEPC_ERR
-			       "Error removing rfkill notify handler %s\n",
+			pr_err("Error removing rfkill notify handler %s\n",
 				node);
 	}
 }
@@ -747,7 +739,7 @@ static int eeepc_setup_pci_hotplug(void)
 	struct pci_bus *bus = pci_find_bus(0, 1);
 
 	if (!bus) {
-		printk(EEEPC_ERR "Unable to find wifi PCI bus\n");
+		pr_err("Unable to find wifi PCI bus\n");
 		return -ENODEV;
 	}
 
@@ -768,7 +760,7 @@ static int eeepc_setup_pci_hotplug(void)
 
 	ret = pci_hp_register(ehotk->hotplug_slot, bus, 0, "eeepc-wifi");
 	if (ret) {
-		printk(EEEPC_ERR "Unable to register hotplug slot - %d\n", ret);
+		pr_err("Unable to register hotplug slot - %d\n", ret);
 		goto error_register;
 	}
 
@@ -790,7 +782,7 @@ static int eeepc_hotk_add(struct acpi_device *device)
 
 	if (!device)
 		 return -EINVAL;
-	printk(EEEPC_NOTICE EEEPC_HOTK_NAME "\n");
+	pr_notice(EEEPC_HOTK_NAME "\n");
 	ehotk = kzalloc(sizeof(struct eeepc_hotk), GFP_KERNEL);
 	if (!ehotk)
 		return -ENOMEM;
@@ -806,7 +798,7 @@ static int eeepc_hotk_add(struct acpi_device *device)
 	status = acpi_install_notify_handler(ehotk->handle, ACPI_SYSTEM_NOTIFY,
 					     eeepc_hotk_notify, ehotk);
 	if (ACPI_FAILURE(status))
-		printk(EEEPC_ERR "Error installing notify handler\n");
+		pr_err("Error installing notify handler\n");
 
 	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
@@ -907,7 +899,7 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 	status = acpi_remove_notify_handler(ehotk->handle, ACPI_SYSTEM_NOTIFY,
 					    eeepc_hotk_notify);
 	if (ACPI_FAILURE(status))
-		printk(EEEPC_ERR "Error removing notify handler\n");
+		pr_err("Error removing notify handler\n");
 
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
@@ -1079,8 +1071,7 @@ static int eeepc_backlight_init(struct device *dev)
 	bd = backlight_device_register(EEEPC_HOTK_FILE, dev,
 				       NULL, &eeepcbl_ops);
 	if (IS_ERR(bd)) {
-		printk(EEEPC_ERR
-		       "Could not register eeepc backlight device\n");
+		pr_err("Could not register eeepc backlight device\n");
 		eeepc_backlight_device = NULL;
 		return PTR_ERR(bd);
 	}
@@ -1099,8 +1090,7 @@ static int eeepc_hwmon_init(struct device *dev)
 
 	hwmon = hwmon_device_register(dev);
 	if (IS_ERR(hwmon)) {
-		printk(EEEPC_ERR
-		       "Could not register eeepc hwmon device\n");
+		pr_err("Could not register eeepc hwmon device\n");
 		eeepc_hwmon_device = NULL;
 		return PTR_ERR(hwmon);
 	}
@@ -1133,8 +1123,7 @@ static int __init eeepc_laptop_init(void)
 		if (result)
 			goto fail_backlight;
 	} else
-		printk(EEEPC_INFO "Backlight controlled by ACPI video "
-		       "driver\n");
+		pr_info("Backlight controlled by ACPI video driver\n");
 
 	result = eeepc_hwmon_init(dev);
 	if (result)
-- 
1.6.3.1

