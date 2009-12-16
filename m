From: Len Brown <lenb@kernel.org>
Subject: [PATCH 048/103] eeepc-laptop: re-add check for eeepc->backlight == NULL
Date: Wed, 16 Dec 2009 03:35:59 -0500
Message-ID: <325fb8e9aeddf7bf8a7a892869dca00e7305c41e.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41634 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760855AbZLPKGI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:08 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:57 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

As Corentin points out, we do not create a backlight device if the ACPI
video driver is able to provide equivalent functionality. So we do need
to check before we try to update the backlight device.

We now ignore brightness events completely if we have not created a
backlight device.  This is slightly more cautious than the original
check.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

