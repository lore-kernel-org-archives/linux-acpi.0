From: Len Brown <lenb@kernel.org>
Subject: [PATCH 45/65] ACPI: asus-acpi: use .notify method instead of
 installing handler directly
Date: Fri, 29 May 2009 21:42:23 -0400
Message-ID: <81d7654e745d73fc97038742aec509d0b7b98a72.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61730 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756601AbZE3Bm6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:58 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00LQOOROIU13@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:01 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Corentin Chary <corentincj@iksaif.net>, Karol Kozimor <sziwan@users.sourceforge.net>, acpi4asus-user@lists.sourceforge.net, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

This driver relies on seeing system notify events, not device-specific
ones (because it used ACPI_SYSTEM_NOTIFY).  We use the
ACPI_DRIVER_ALL_NOTIFY_EVENTS driver flag to request all events, then
just ignore any device events we get.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Corentin Chary <corentincj@iksaif.net>
CC: Karol Kozimor <sziwan@users.sourceforge.net>
CC: acpi4asus-user@lists.sourceforge.net
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/asus_acpi.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/asus_acpi.c b/drivers/platform/x86/asus_acpi.c
index ba1f749..ddf5240 100644
--- a/drivers/platform/x86/asus_acpi.c
+++ b/drivers/platform/x86/asus_acpi.c
@@ -455,6 +455,8 @@ static struct asus_hotk *hotk;
  */
 static int asus_hotk_add(struct acpi_device *device);
 static int asus_hotk_remove(struct acpi_device *device, int type);
+static void asus_hotk_notify(struct acpi_device *device, u32 event);
+
 static const struct acpi_device_id asus_device_ids[] = {
 	{"ATK0100", 0},
 	{"", 0},
@@ -465,9 +467,11 @@ static struct acpi_driver asus_hotk_driver = {
 	.name = "asus_acpi",
 	.class = ACPI_HOTK_CLASS,
 	.ids = asus_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = asus_hotk_add,
 		.remove = asus_hotk_remove,
+		.notify = asus_hotk_notify,
 		},
 };
 
@@ -1101,12 +1105,20 @@ static int asus_hotk_remove_fs(struct acpi_device *device)
 	return 0;
 }
 
-static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
+static void asus_hotk_notify(struct acpi_device *device, u32 event)
 {
 	/* TODO Find a better way to handle events count. */
 	if (!hotk)
 		return;
 
+	/*
+	 * The BIOS *should* be sending us device events, but apparently
+	 * Asus uses system events instead, so just ignore any device
+	 * events we get.
+	 */
+	if (event > ACPI_MAX_SYS_NOTIFY)
+		return;
+
 	if ((event & ~((u32) BR_UP)) < 16)
 		hotk->brightness = (event & ~((u32) BR_UP));
 	else if ((event & ~((u32) BR_DOWN)) < 16)
@@ -1346,15 +1358,6 @@ static int asus_hotk_add(struct acpi_device *device)
 	if (result)
 		goto end;
 
-	/*
-	 * We install the handler, it will receive the hotk in parameter, so, we
-	 * could add other data to the hotk struct
-	 */
-	status = acpi_install_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
-					     asus_hotk_notify, hotk);
-	if (ACPI_FAILURE(status))
-		printk(KERN_ERR "  Error installing notify handler\n");
-
 	/* For laptops without GPLV: init the hotk->brightness value */
 	if ((!hotk->methods->brightness_get)
 	    && (!hotk->methods->brightness_status)
@@ -1389,16 +1392,9 @@ end:
 
 static int asus_hotk_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
-
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
-	status = acpi_remove_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
-					    asus_hotk_notify);
-	if (ACPI_FAILURE(status))
-		printk(KERN_ERR "Asus ACPI: Error removing notify handler\n");
-
 	asus_hotk_remove_fs(device);
 
 	kfree(hotk);
-- 
1.6.0.6

