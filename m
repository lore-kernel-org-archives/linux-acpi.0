From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 2/9] eeepc-laptop: Register as a pci-hotplug device
Date: Fri, 19 Jun 2009 14:52:04 +0200
Message-ID: <1245415931-26466-2-git-send-email-corentincj@iksaif.net>
References: <alpine.LFD.2.00.0906180157380.8921@localhost.localdomain>
 <1245415931-26466-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.orange.fr ([80.12.242.49]:23053 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbZFSMyl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jun 2009 08:54:41 -0400
In-Reply-To: <1245415931-26466-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>

The eee contains a logically (but not physically) hotpluggable PCIe slot.
Currently this is handled by adding or removing the PCI device in response
to rfkill events, but if a user has forced pciehp to bind to it (with the
force=1 argument) then both drivers will try to handle the event and
hilarity (in the form of oopses) will ensue. This can be avoided by having
eee-laptop register the slot as a hotplug slot. Only one of pciehp and
eee-laptop will successfully register this, avoiding the problem.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Tested-by: Darren Salt <linux@youmustbejoking.demon.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/platform/x86/Kconfig        |    2 +
 drivers/platform/x86/eeepc-laptop.c |   87 +++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2923cb0..8212e86 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -340,6 +340,8 @@ config EEEPC_LAPTOP
 	depends on RFKILL || RFKILL = n
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
+	select HOTPLUG
+	select HOTPLUG_PCI if PCI
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
 
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 220e4be..870fd1e 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -31,6 +31,7 @@
 #include <linux/input.h>
 #include <linux/rfkill.h>
 #include <linux/pci.h>
+#include <linux/pci_hotplug.h>
 
 #define EEEPC_LAPTOP_VERSION	"0.1"
 
@@ -143,6 +144,7 @@ struct eeepc_hotk {
 	u16 *keycode_map;
 	struct rfkill *eeepc_wlan_rfkill;
 	struct rfkill *eeepc_bluetooth_rfkill;
+	struct hotplug_slot *hotplug_slot;
 };
 
 /* The actual device the driver binds to */
@@ -211,6 +213,15 @@ static struct acpi_driver eeepc_hotk_driver = {
 	},
 };
 
+/* PCI hotplug ops */
+static int eeepc_get_adapter_status(struct hotplug_slot *slot, u8 *value);
+
+static struct hotplug_slot_ops eeepc_hotplug_slot_ops = {
+	.owner = THIS_MODULE,
+	.get_adapter_status = eeepc_get_adapter_status,
+	.get_power_status = eeepc_get_adapter_status,
+};
+
 /* The backlight device /sys/class/backlight */
 static struct backlight_device *eeepc_backlight_device;
 
@@ -610,6 +621,19 @@ static int notify_brn(void)
 	return -1;
 }
 
+static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
+				    u8 *value)
+{
+	int val = get_acpi(CM_ASL_WLAN);
+
+	if (val == 1 || val == 0)
+		*value = val;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
 static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct pci_dev *dev;
@@ -737,6 +761,54 @@ static void eeepc_unregister_rfkill_notifier(char *node)
 	}
 }
 
+static void eeepc_cleanup_pci_hotplug(struct hotplug_slot *hotplug_slot)
+{
+	kfree(hotplug_slot->info);
+	kfree(hotplug_slot);
+}
+
+static int eeepc_setup_pci_hotplug(void)
+{
+	int ret = -ENOMEM;
+	struct pci_bus *bus = pci_find_bus(0, 1);
+
+	if (!bus) {
+		printk(EEEPC_ERR "Unable to find wifi PCI bus\n");
+		return -ENODEV;
+	}
+
+	ehotk->hotplug_slot = kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
+	if (!ehotk->hotplug_slot)
+		goto error_slot;
+
+	ehotk->hotplug_slot->info = kzalloc(sizeof(struct hotplug_slot_info),
+					    GFP_KERNEL);
+	if (!ehotk->hotplug_slot->info)
+		goto error_info;
+
+	ehotk->hotplug_slot->private = ehotk;
+	ehotk->hotplug_slot->release = &eeepc_cleanup_pci_hotplug;
+	ehotk->hotplug_slot->ops = &eeepc_hotplug_slot_ops;
+	eeepc_get_adapter_status(ehotk->hotplug_slot,
+				 &ehotk->hotplug_slot->info->adapter_status);
+
+	ret = pci_hp_register(ehotk->hotplug_slot, bus, 0, "eeepc-wifi");
+	if (ret) {
+		printk(EEEPC_ERR "Unable to register hotplug slot - %d\n", ret);
+		goto error_register;
+	}
+
+	return 0;
+
+error_register:
+	kfree(ehotk->hotplug_slot->info);
+error_info:
+	kfree(ehotk->hotplug_slot);
+	ehotk->hotplug_slot = NULL;
+error_slot:
+	return ret;
+}
+
 static int eeepc_hotk_add(struct acpi_device *device)
 {
 	int result;
@@ -795,8 +867,21 @@ static int eeepc_hotk_add(struct acpi_device *device)
 			goto bluetooth_fail;
 	}
 
+	result = eeepc_setup_pci_hotplug();
+	/*
+	 * If we get -EBUSY then something else is handling the PCI hotplug -
+	 * don't fail in this case
+	 */
+	if (result == -EBUSY)
+		return 0;
+	else if (result)
+		goto pci_fail;
+
 	return 0;
 
+ pci_fail:
+	if (ehotk->eeepc_bluetooth_rfkill)
+		rfkill_unregister(ehotk->eeepc_bluetooth_rfkill);
  bluetooth_fail:
 	rfkill_destroy(ehotk->eeepc_bluetooth_rfkill);
 	rfkill_unregister(ehotk->eeepc_wlan_rfkill);
@@ -818,6 +903,8 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
+	if (ehotk->hotplug_slot)
+		pci_hp_deregister(ehotk->hotplug_slot);
 
 	kfree(ehotk);
 	return 0;
-- 
1.6.3.1


