From: Len Brown <lenb@kernel.org>
Subject: [PATCH 44/65] ACPI: asus-laptop: use .notify method instead of
 installing handler directly
Date: Fri, 29 May 2009 21:42:22 -0400
Message-ID: <c9bbb29194b7beb8f254645c2379b64c1455137d.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40281 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019AbZE3Bm6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:58 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00CA4ORN8HD4@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:00 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Corentin Chary <corentincj@iksaif.net>, acpi4asus-user@lists.sourceforge.net, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

This driver apparently relies on seeing ALL notify events, not just
device-specific ones (because it used ACPI_ALL_NOTIFY).  We use the
ACPI_DRIVER_ALL_NOTIFY_EVENTS driver flag to request all events.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Corentin Chary <corentincj@iksaif.net>
CC: acpi4asus-user@lists.sourceforge.net
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/asus-laptop.c |   23 +++++------------------
 1 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index bfc1a88..eaffe73 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -207,13 +207,17 @@ MODULE_DEVICE_TABLE(acpi, asus_device_ids);
 
 static int asus_hotk_add(struct acpi_device *device);
 static int asus_hotk_remove(struct acpi_device *device, int type);
+static void asus_hotk_notify(struct acpi_device *device, u32 event);
+
 static struct acpi_driver asus_hotk_driver = {
 	.name = ASUS_HOTK_NAME,
 	.class = ASUS_HOTK_CLASS,
 	.ids = asus_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = asus_hotk_add,
 		.remove = asus_hotk_remove,
+		.notify = asus_hotk_notify,
 		},
 };
 
@@ -812,7 +816,7 @@ static int asus_setkeycode(struct input_dev *dev, int scancode, int keycode)
 	return -EINVAL;
 }
 
-static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
+static void asus_hotk_notify(struct acpi_device *device, u32 event)
 {
 	static struct key_entry *key;
 	u16 count;
@@ -1124,7 +1128,6 @@ static int asus_hotk_found;
 
 static int asus_hotk_add(struct acpi_device *device)
 {
-	acpi_status status = AE_OK;
 	int result;
 
 	if (!device)
@@ -1149,15 +1152,6 @@ static int asus_hotk_add(struct acpi_device *device)
 
 	asus_hotk_add_fs();
 
-	/*
-	 * We install the handler, it will receive the hotk in parameter, so, we
-	 * could add other data to the hotk struct
-	 */
-	status = acpi_install_notify_handler(hotk->handle, ACPI_ALL_NOTIFY,
-					     asus_hotk_notify, hotk);
-	if (ACPI_FAILURE(status))
-		printk(ASUS_ERR "Error installing notify handler\n");
-
 	asus_hotk_found = 1;
 
 	/* WLED and BLED are on by default */
@@ -1198,16 +1192,9 @@ end:
 
 static int asus_hotk_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
-
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
-	status = acpi_remove_notify_handler(hotk->handle, ACPI_ALL_NOTIFY,
-					    asus_hotk_notify);
-	if (ACPI_FAILURE(status))
-		printk(ASUS_ERR "Error removing notify handler\n");
-
 	kfree(hotk->name);
 	kfree(hotk);
 
-- 
1.6.0.6

