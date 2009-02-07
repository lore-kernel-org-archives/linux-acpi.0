From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/30] eeepc-laptop: Implement rfkill hotplugging in
 eeepc-laptop
Date: Sat, 07 Feb 2009 01:41:21 -0500
Message-ID: <5740294ca3a9b113fe146f2826effb69ca50008d.1233988825.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:44650 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbZBGGlz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:55 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00L7INPL9S12@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:36:59 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

The Eee implements rfkill by logically unplugging the wireless card from the
PCI bus. Despite sending ACPI notifications, this does not appear to be
implemented using standard ACPI hotplug - nor does the firmware provide the
_OSC method required to support native PCIe hotplug. The only sensible choice
appears to be to handle the hotplugging directly in the eeepc-laptop driver.
Tested successfully on a 700, 900 and 901.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   83 +++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 21e5206..66655d2 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 #include <linux/input.h>
 #include <linux/rfkill.h>
+#include <linux/pci.h>
 
 #define EEEPC_LAPTOP_VERSION	"0.1"
 
@@ -517,6 +518,41 @@ static void notify_brn(void)
 	bd->props.brightness = read_brightness(bd);
 }
 
+static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct pci_dev *dev;
+	struct pci_bus *bus = pci_find_bus(0, 1);
+
+	if (event != ACPI_NOTIFY_BUS_CHECK)
+		return;
+
+	if (!bus) {
+		printk(EEEPC_WARNING "Unable to find PCI bus 1?\n");
+		return;
+	}
+
+	if (get_acpi(CM_ASL_WLAN) == 1) {
+		dev = pci_get_slot(bus, 0);
+		if (dev) {
+			/* Device already present */
+			pci_dev_put(dev);
+			return;
+		}
+		dev = pci_scan_single_device(bus, 0);
+		if (dev) {
+			pci_bus_assign_resources(bus);
+			if (pci_bus_add_device(dev))
+				printk(EEEPC_ERR "Unable to hotplug wifi\n");
+		}
+	} else {
+		dev = pci_get_slot(bus, 0);
+		if (dev) {
+			pci_remove_bus_device(dev);
+			pci_dev_put(dev);
+		}
+	}
+}
+
 static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	static struct key_entry *key;
@@ -543,6 +579,45 @@ static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
 	}
 }
 
+static int eeepc_register_rfkill_notifier(char *node)
+{
+	acpi_status status = AE_OK;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, node, &handle);
+
+	if (ACPI_SUCCESS(status)) {
+		status = acpi_install_notify_handler(handle,
+						     ACPI_SYSTEM_NOTIFY,
+						     eeepc_rfkill_notify,
+						     NULL);
+		if (ACPI_FAILURE(status))
+			printk(EEEPC_WARNING
+			       "Failed to register notify on %s\n", node);
+	} else
+		return -ENODEV;
+
+	return 0;
+}
+
+static void eeepc_unregister_rfkill_notifier(char *node)
+{
+	acpi_status status = AE_OK;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, node, &handle);
+
+	if (ACPI_SUCCESS(status)) {
+		status = acpi_remove_notify_handler(handle,
+						     ACPI_SYSTEM_NOTIFY,
+						     eeepc_rfkill_notify);
+		if (ACPI_FAILURE(status))
+			printk(EEEPC_ERR
+			       "Error removing rfkill notify handler %s\n",
+				node);
+	}
+}
+
 static int eeepc_hotk_add(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
@@ -622,6 +697,10 @@ static int eeepc_hotk_add(struct acpi_device *device)
 		if (result)
 			goto bluetooth_fail;
 	}
+
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
+
 	return 0;
 
  bluetooth_fail:
@@ -649,6 +728,10 @@ static int eeepc_hotk_remove(struct acpi_device *device, int type)
 					    eeepc_hotk_notify);
 	if (ACPI_FAILURE(status))
 		printk(EEEPC_ERR "Error removing notify handler\n");
+
+	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
+	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
+
 	kfree(ehotk);
 	return 0;
 }
-- 
1.5.6.6

