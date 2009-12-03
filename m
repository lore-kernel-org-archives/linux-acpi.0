From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 16/33] eeepc-laptop: remove redundant NULL checks
Date: Thu,  3 Dec 2009 08:45:00 +0100
Message-ID: <1259826317-18809-17-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-14-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-15-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44216 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbZLCHof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:35 -0500
In-Reply-To: <1259826317-18809-16-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

eeepc_hotk_notify() cannot be called with ehotk == NULL or bd == NULL.
We check both variables for allocation failure and would bail out before
the notifier is registered.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
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
1.6.5.3

