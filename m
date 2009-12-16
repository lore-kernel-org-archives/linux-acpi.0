From: Len Brown <lenb@kernel.org>
Subject: [PATCH 033/103] eeepc-laptop: remove redundant NULL checks
Date: Wed, 16 Dec 2009 03:35:44 -0500
Message-ID: <a2a1d36c78e90977e4ded9a20a7d8d27d84b13e4.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41634 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761332AbZLPKGH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:07 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:56 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

eeepc_hotk_notify() cannot be called with ehotk == NULL or bd == NULL.
We check both variables for allocation failure and would bail out before
the notifier is registered.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   42 +++++++++++++++-------------------
 1 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index abd7389..f6b7796 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -662,12 +662,11 @@ static int notify_brn(void)
 {
 	/* returns the *previous* brightness, or -1 */
 	struct backlight_device *bd = eeepc_backlight_device;
-	if (bd) {
-		int old = bd->props.brightness;
-		backlight_force_update(bd, BACKLIGHT_UPDATE_HOTKEY);
-		return old;
-	}
-	return -1;
+	int old = bd->props.brightness;
+
+	backlight_force_update(bd, BACKLIGHT_UPDATE_HOTKEY);
+
+	return old;
 }
 
 static int eeepc_get_adapter_status(struct hotplug_slot *hotplug_slot,
@@ -741,8 +740,6 @@ static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
 	u16 count;
 	int brn = -ENODEV;
 
-	if (!ehotk)
-		return;
 	if (event > ACPI_MAX_SYS_NOTIFY)
 		return;
 	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX)
@@ -753,21 +750,20 @@ static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
 					dev_name(&ehotk->device->dev), event,
 					count);
 	if (ehotk->inputdev) {
-		if (brn != -ENODEV) {
-			/* brightness-change events need special
-			 * handling for conversion to key events
-			 */
-			if (brn < 0)
-				brn = event;
-			else
-				brn += NOTIFY_BRN_MIN;
-			if (event < brn)
-				event = NOTIFY_BRN_MIN; /* brightness down */
-			else if (event > brn)
-				event = NOTIFY_BRN_MIN + 2; /* ... up */
-			else
-				event = NOTIFY_BRN_MIN + 1; /* ... unchanged */
-		}
+		/* brightness-change events need special
+		 * handling for conversion to key events
+		 */
+		if (brn < 0)
+			brn = event;
+		else
+			brn += NOTIFY_BRN_MIN;
+		if (event < brn)
+			event = NOTIFY_BRN_MIN; /* brightness down */
+		else if (event > brn)
+			event = NOTIFY_BRN_MIN + 2; /* ... up */
+		else
+			event = NOTIFY_BRN_MIN + 1; /* ... unchanged */
+
 		key = eepc_get_entry_by_scancode(event);
 		if (key) {
 			switch (key->type) {
-- 
1.6.0.6

