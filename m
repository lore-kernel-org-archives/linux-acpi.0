From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 31/33] eeepc-laptop: re-add check for eeepc->backlight == NULL
Date: Thu,  3 Dec 2009 08:45:15 +0100
Message-ID: <1259826317-18809-32-git-send-email-corentincj@iksaif.net>
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
 <1259826317-18809-21-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-22-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-23-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-24-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-25-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-26-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-27-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-28-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-29-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-30-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-31-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44217 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbZLCHoj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:39 -0500
In-Reply-To: <1259826317-18809-31-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

As Corentin points out, we do not create a backlight device if the ACPI
video driver is able to provide equivalent functionality. So we do need
to check before we try to update the backlight device.

We now ignore brightness events completely if we have not created a
backlight device.  This is slightly more cautious than the original
check.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |   42 ++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 5f0eb76..d07a4c0 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1230,27 +1230,35 @@ static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
 					dev_name(&device->dev), event,
 					count);
 
+	/* Brightness events are special */
 	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX) {
-		int old_brightness, new_brightness;
 
-		/* Update backlight device. */
-		old_brightness = eeepc_backlight_notify(eeepc);
-
-		/* Convert brightness event to keypress (obsolescent hack). */
-		new_brightness = event - NOTIFY_BRN_MIN;
-
-		if (new_brightness < old_brightness) {
-			event = NOTIFY_BRN_MIN; /* brightness down */
-		} else if (new_brightness > old_brightness) {
-			event = NOTIFY_BRN_MAX; /* brightness up */
-		} else {
-			/*
-			 * no change in brightness - already at min/max,
-			 * event will be desired value (or else ignored).
-			 */
+		/* Ignore them completely if the acpi video driver is used */
+		if (eeepc->backlight_device != NULL) {
+			int old_brightness, new_brightness;
+
+			/* Update the backlight device. */
+			old_brightness = eeepc_backlight_notify(eeepc);
+
+			/* Convert event to keypress (obsolescent hack) */
+			new_brightness = event - NOTIFY_BRN_MIN;
+
+			if (new_brightness < old_brightness) {
+				event = NOTIFY_BRN_MIN; /* brightness down */
+			} else if (new_brightness > old_brightness) {
+				event = NOTIFY_BRN_MAX; /* brightness up */
+			} else {
+				/*
+				* no change in brightness - already at min/max,
+				* event will be desired value (or else ignored)
+				*/
+			}
+			eeepc_input_notify(eeepc, event);
 		}
+	} else {
+		/* Everything else is a bona-fide keypress event */
+		eeepc_input_notify(eeepc, event);
 	}
-	eeepc_input_notify(eeepc, event);
 }
 
 static void cmsg_quirk(struct eeepc_laptop *eeepc, int cm, const char *name)
-- 
1.6.5.3

