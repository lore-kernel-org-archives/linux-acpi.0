From: Len Brown <lenb@kernel.org>
Subject: [PATCH 40/65] PCI/ACPI: fix wrong ref count handling in acpi_pci_bind()
Date: Fri, 29 May 2009 21:42:18 -0400
Message-ID: <dacd2549ca61ddbdd1ed62a76ca95dea3f0e02c6.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33022 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064AbZE3BnD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:03 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00B9TORLYG44@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:01 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Len Brown <len.brown@intel.com>

From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

The 'dev' field of struct acpi_pci_data is having a pointer to struct
pci_dev without incrementing the reference counter. Because of this, I
got the following kernel oops when I was doing some pci hotplug
operations. This patch fixes this bug by replacing wrong hand-made
pci_find_slot() with pci_get_slot() in acpi_pci_bind().

 BUG: unable to handle kernel NULL pointer dereference at 00000000000000e8
 IP: [<ffffffff803f0e9b>] acpi_pci_unbind+0xb1/0xdd

 Call Trace:
  [<ffffffff803ecee4>] acpi_bus_remove+0x54/0x68
  [<ffffffff803ecf6d>] acpi_bus_trim+0x75/0xe3
  [<ffffffffa0345ddd>] acpiphp_disable_slot+0x16d/0x1e0 [acpiphp]
  [<ffffffffa03441f0>] disable_slot+0x20/0x60 [acpiphp]
  [<ffffffff803cfc18>] power_write_file+0xc8/0x110
  [<ffffffff803c6a54>] pci_slot_attr_store+0x24/0x30
  [<ffffffff803469ce>] sysfs_write_file+0xce/0x140
  [<ffffffff802e94e7>] vfs_write+0xc7/0x170
  [<ffffffff802e9aa0>] sys_write+0x50/0x90
  [<ffffffff8020bd6b>] system_call_fastpath+0x16/0x1b

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
Tested-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_bind.c |   24 ++++++------------------
 1 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 95650f8..bc46de3 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -116,9 +116,6 @@ int acpi_pci_bind(struct acpi_device *device)
 	struct acpi_pci_data *pdata;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	acpi_handle handle;
-	struct pci_dev *dev;
-	struct pci_bus *bus;
-
 
 	if (!device || !device->parent)
 		return -EINVAL;
@@ -176,20 +173,9 @@ int acpi_pci_bind(struct acpi_device *device)
 	 * Locate matching device in PCI namespace.  If it doesn't exist
 	 * this typically means that the device isn't currently inserted
 	 * (e.g. docking station, port replicator, etc.).
-	 * We cannot simply search the global pci device list, since
-	 * PCI devices are added to the global pci list when the root
-	 * bridge start ops are run, which may not have happened yet.
 	 */
-	bus = pci_find_bus(data->id.segment, data->id.bus);
-	if (bus) {
-		list_for_each_entry(dev, &bus->devices, bus_list) {
-			if (dev->devfn == PCI_DEVFN(data->id.device,
-						    data->id.function)) {
-				data->dev = dev;
-				break;
-			}
-		}
-	}
+	data->dev = pci_get_slot(pdata->bus,
+				PCI_DEVFN(data->id.device, data->id.function));
 	if (!data->dev) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Device %04x:%02x:%02x.%d not present in PCI namespace\n",
@@ -259,9 +245,10 @@ int acpi_pci_bind(struct acpi_device *device)
 
       end:
 	kfree(buffer.pointer);
-	if (result)
+	if (result) {
+		pci_dev_put(data->dev);
 		kfree(data);
-
+	}
 	return result;
 }
 
@@ -303,6 +290,7 @@ static int acpi_pci_unbind(struct acpi_device *device)
 	if (data->dev->subordinate) {
 		acpi_pci_irq_del_prt(data->id.segment, data->bus->number);
 	}
+	pci_dev_put(data->dev);
 	kfree(data);
 
       end:
-- 
1.6.0.6

