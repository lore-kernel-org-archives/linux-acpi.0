From: Len Brown <lenb@kernel.org>
Subject: [PATCH 037/103] eeepc-laptop: refactor notifications
Date: Wed, 16 Dec 2009 03:35:48 -0500
Message-ID: <bf9598bcd5a73385ced7880ea09998a545e03dd8.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41634 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761922AbZLPKGL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:11 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:06:00 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Separate out input_notify(), in a similar way to how notify_brn()
is already separated.  This will allow all the functions which refer to
the input device to be grouped together.

This includes a small behaviour change - we now synthesize brightness
up/down key events even if the brightness is already at the
maximum/minimum value.  This is consistent with the new uevent
interface.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   71 +++++++++++++++++++----------------
 1 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 04a59d3..b4eacb6 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -655,9 +655,8 @@ static int eeepc_hotk_init(void)
 	return 0;
 }
 
-static int notify_brn(void)
+static int eeepc_backlight_notify(void)
 {
-	/* returns the *previous* brightness, or -1 */
 	struct backlight_device *bd = eeepc_backlight_device;
 	int old = bd->props.brightness;
 
@@ -731,50 +730,58 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 	eeepc_rfkill_hotplug();
 }
 
-static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
+static void eeepc_input_notify(int event)
 {
 	static struct key_entry *key;
+
+	key = eepc_get_entry_by_scancode(event);
+	if (key) {
+		switch (key->type) {
+		case KE_KEY:
+			input_report_key(ehotk->inputdev, key->keycode,
+						1);
+			input_sync(ehotk->inputdev);
+			input_report_key(ehotk->inputdev, key->keycode,
+						0);
+			input_sync(ehotk->inputdev);
+			break;
+		}
+	}
+}
+
+static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
+{
 	u16 count;
-	int brn = -ENODEV;
 
 	if (event > ACPI_MAX_SYS_NOTIFY)
 		return;
-	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX)
-		brn = notify_brn();
 	count = ehotk->event_count[event % 128]++;
 	acpi_bus_generate_proc_event(ehotk->device, event, count);
 	acpi_bus_generate_netlink_event(ehotk->device->pnp.device_class,
 					dev_name(&ehotk->device->dev), event,
 					count);
-	if (ehotk->inputdev) {
-		/* brightness-change events need special
-		 * handling for conversion to key events
-		 */
-		if (brn < 0)
-			brn = event;
-		else
-			brn += NOTIFY_BRN_MIN;
-		if (event < brn)
+
+	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX) {
+		int old_brightness, new_brightness;
+
+		/* Update backlight device. */
+		old_brightness = eeepc_backlight_notify();
+
+		/* Convert brightness event to keypress (obsolescent hack). */
+		new_brightness = event - NOTIFY_BRN_MIN;
+
+		if (new_brightness < old_brightness) {
 			event = NOTIFY_BRN_MIN; /* brightness down */
-		else if (event > brn)
-			event = NOTIFY_BRN_MIN + 2; /* ... up */
-		else
-			event = NOTIFY_BRN_MIN + 1; /* ... unchanged */
-
-		key = eepc_get_entry_by_scancode(event);
-		if (key) {
-			switch (key->type) {
-			case KE_KEY:
-				input_report_key(ehotk->inputdev, key->keycode,
-						 1);
-				input_sync(ehotk->inputdev);
-				input_report_key(ehotk->inputdev, key->keycode,
-						 0);
-				input_sync(ehotk->inputdev);
-				break;
-			}
+		} else if (new_brightness > old_brightness) {
+			event = NOTIFY_BRN_MAX; /* brightness up */
+		} else {
+			/*
+			 * no change in brightness - already at min/max,
+			 * event will be desired value (or else ignored).
+			 */
 		}
 	}
+	eeepc_input_notify(event);
 }
 
 static int eeepc_register_rfkill_notifier(char *node)
-- 
1.6.0.6

