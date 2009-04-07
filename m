From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/17] ACPI: WMI: use .notify method instead of installing
 handler directly
Date: Tue, 07 Apr 2009 19:04:21 -0400
Message-ID: <f61bb93927fbc2933abe870813daba9d331aa121.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:64252 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbZDGXFF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:05:05 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR009VF6SF5JO7@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:05:04 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/wmi.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 2f269e1..043b208 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -81,6 +81,7 @@ static struct wmi_block wmi_blocks;
 
 static int acpi_wmi_remove(struct acpi_device *device, int type);
 static int acpi_wmi_add(struct acpi_device *device);
+static void acpi_wmi_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id wmi_device_ids[] = {
 	{"PNP0C14", 0},
@@ -96,6 +97,7 @@ static struct acpi_driver acpi_wmi_driver = {
 	.ops = {
 		.add = acpi_wmi_add,
 		.remove = acpi_wmi_remove,
+		.notify = acpi_wmi_notify,
 		},
 };
 
@@ -643,12 +645,11 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
 	}
 }
 
-static void acpi_wmi_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_wmi_notify(struct acpi_device *device, u32 event)
 {
 	struct guid_block *block;
 	struct wmi_block *wblock;
 	struct list_head *p;
-	struct acpi_device *device = data;
 
 	list_for_each(p, &wmi_blocks.list) {
 		wblock = list_entry(p, struct wmi_block, list);
@@ -669,9 +670,6 @@ static void acpi_wmi_notify(acpi_handle handle, u32 event, void *data)
 
 static int acpi_wmi_remove(struct acpi_device *device, int type)
 {
-	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-		acpi_wmi_notify);
-
 	acpi_remove_address_space_handler(device->handle,
 				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
 
@@ -683,13 +681,6 @@ static int __init acpi_wmi_add(struct acpi_device *device)
 	acpi_status status;
 	int result = 0;
 
-	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-		acpi_wmi_notify, device);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Error installing notify handler\n");
-		return -ENODEV;
-	}
-
 	status = acpi_install_address_space_handler(device->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_wmi_ec_space_handler,
-- 
1.6.0.6

