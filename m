From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 20/33] eeepc-laptop: refactor notifications
Date: Thu,  3 Dec 2009 08:45:04 +0100
Message-ID: <1259826317-18809-21-git-send-email-corentincj@iksaif.net>
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
 <1259826317-18809-17-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-18-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-19-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-20-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44228 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667AbZLCHog (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:36 -0500
In-Reply-To: <1259826317-18809-20-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Separate out input_notify(), in a similar way to how notify_brn()
is already separated.  This will allow all the functions which refer to
the input device to be grouped together.

This includes a small behaviour change - we now synthesize brightness
up/down key events even if the brightness is already at the
maximum/minimum value.  This is consistent with the new uevent
interface.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
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
1.6.5.3

