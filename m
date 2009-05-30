From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/65] ACPI: eeepc-laptop: use .notify method instead of
 installing handler directly
Date: Fri, 29 May 2009 21:42:24 -0400
Message-ID: <9f4b0f13e8346a42178d70b5079f46f7f886d13c.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:45679 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbZE3BnD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:03 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF005DUORO2072@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:01 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Corentin Chary <corentincj@iksaif.net>, acpi4asus-user@lists.sourceforge.net, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

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
CC: acpi4asus-user@lists.sourceforge.net
CC: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 353a898..1e28413 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -180,6 +180,7 @@ static struct key_entry eeepc_keymap[] = {
  */
 static int eeepc_hotk_add(struct acpi_device *device);
 static int eeepc_hotk_remove(struct acpi_device *device, int type);
+static void eeepc_hotk_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id eeepc_device_ids[] = {
 	{EEEPC_HOTK_HID, 0},
@@ -191,9 +192,11 @@ static struct acpi_driver eeepc_hotk_driver = {
 	.name = EEEPC_HOTK_NAME,
 	.class = EEEPC_HOTK_CLASS,
 	.ids = eeepc_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = eeepc_hotk_add,
 		.remove = eeepc_hotk_remove,
+		.notify = eeepc_hotk_notify,
 	},
 };
 
@@ -569,7 +572,7 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 	rfkill_force_state(ehotk->eeepc_wlan_rfkill, state);
 }
 
-static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
+static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
 {
 	static struct key_entry *key;
 	u16 count;
@@ -577,6 +580,8 @@ static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
 
 	if (!ehotk)
 		return;
+	if (event > ACPI_MAX_SYS_NOTIFY)
+		return;
 	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX)
 		brn = notify_brn();
 	count = ehotk->event_count[event % 128]++;
@@ -657,7 +662,6 @@ static void eeepc_unregister_rfkill_notifier(char *node)
 
 static int eeepc_hotk_add(struct acpi_device *device)
 {
-	acpi_status status = AE_OK;
 	int result;
 
 	if (!device)
@@ -675,10 +679,6 @@ static int eeepc_hotk_add(struct acpi_device *device)
 	result = eeepc_hotk_check();
 	if (result)
 		goto ehotk_fail;
-	status = acpi_install_notify_handler(ehotk->handle, ACPI_SYSTEM_NOTIFY,
-					     eeepc_hotk_notify, ehotk);
-	if (ACPI_FAILURE(status))
-		printk(EEEPC_ERR "Error installing notify handler\n");
 
 	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
@@ -759,14 +759,8 @@ static int eeepc_hotk_add(struct acpi_device *device)
 
 static int eeepc_hotk_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
-
 	if (!device || !acpi_driver_data(device))
 		 return -EINVAL;
-	status = acpi_remove_notify_handler(ehotk->handle, ACPI_SYSTEM_NOTIFY,
-					    eeepc_hotk_notify);
-	if (ACPI_FAILURE(status))
-		printk(EEEPC_ERR "Error removing notify handler\n");
 
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
-- 
1.6.0.6

