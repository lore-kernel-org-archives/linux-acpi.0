From: Len Brown <lenb@kernel.org>
Subject: [PATCH 42/65] ACPI: ac: use .notify method instead of installing
 handler directly
Date: Fri, 29 May 2009 21:42:20 -0400
Message-ID: <191b302efe1c70ef77b6b67ba35821078048bad4.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40281 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322AbZE3Bm5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:57 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00COUORM7TQ3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:59 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

This driver apparently relies on seeing ALL notify events, not just
device-specific ones (because it used ACPI_ALL_NOTIFY).  We use the
ACPI_DRIVER_ALL_NOTIFY_EVENTS driver flag to request all events.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ac.c |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 88e42ab..0df8fcb 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -61,6 +61,7 @@ static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 static int acpi_ac_add(struct acpi_device *device);
 static int acpi_ac_remove(struct acpi_device *device, int type);
 static int acpi_ac_resume(struct acpi_device *device);
+static void acpi_ac_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id ac_device_ids[] = {
 	{"ACPI0003", 0},
@@ -72,10 +73,12 @@ static struct acpi_driver acpi_ac_driver = {
 	.name = "ac",
 	.class = ACPI_AC_CLASS,
 	.ids = ac_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = acpi_ac_add,
 		.remove = acpi_ac_remove,
 		.resume = acpi_ac_resume,
+		.notify = acpi_ac_notify,
 		},
 };
 
@@ -220,16 +223,14 @@ static int acpi_ac_remove_fs(struct acpi_device *device)
                                    Driver Model
    -------------------------------------------------------------------------- */
 
-static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_ac_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_ac *ac = data;
-	struct acpi_device *device = NULL;
+	struct acpi_ac *ac = acpi_driver_data(device);
 
 
 	if (!ac)
 		return;
 
-	device = ac->device;
 	switch (event) {
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -253,7 +254,6 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 static int acpi_ac_add(struct acpi_device *device)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
 	struct acpi_ac *ac = NULL;
 
 
@@ -286,13 +286,6 @@ static int acpi_ac_add(struct acpi_device *device)
 	ac->charger.get_property = get_ac_property;
 	power_supply_register(&ac->device->dev, &ac->charger);
 #endif
-	status = acpi_install_notify_handler(device->handle,
-					     ACPI_ALL_NOTIFY, acpi_ac_notify,
-					     ac);
-	if (ACPI_FAILURE(status)) {
-		result = -ENODEV;
-		goto end;
-	}
 
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
@@ -328,7 +321,6 @@ static int acpi_ac_resume(struct acpi_device *device)
 
 static int acpi_ac_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = AE_OK;
 	struct acpi_ac *ac = NULL;
 
 
@@ -337,8 +329,6 @@ static int acpi_ac_remove(struct acpi_device *device, int type)
 
 	ac = acpi_driver_data(device);
 
-	status = acpi_remove_notify_handler(device->handle,
-					    ACPI_ALL_NOTIFY, acpi_ac_notify);
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	if (ac->charger.dev)
 		power_supply_unregister(&ac->charger);
-- 
1.6.0.6

