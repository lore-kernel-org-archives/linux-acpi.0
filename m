From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/19] eeepc-laptop: report brightness control events via the
 input layer
Date: Sat, 16 May 2009 02:02:04 -0400
Message-ID: <64b86b6583db832b28bb54575e32b9e2a1a7d84f.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:28805 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbZEPGCW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:22 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ00LMJ3FYL90S@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:23 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Darren Salt <linux@youmustbejoking.demon.co.uk>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Darren Salt <linux@youmustbejoking.demon.co.uk>

This maps the brightness control events to one of two keys, either
KEY_BRIGHTNESSDOWN or KEY_BRIGHTNESSUP, as needed.

Some mapping has to be done due to the fact that the BIOS reports them as
<base value> + <current brightness index>; the selection is done according to
the sign of the change in brightness (if this is 0, no keypress is reported).

(Ref. http://lists.alioth.debian.org/pipermail/debian-eeepc-devel/2009-April/002001.html)

Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index e21f7cd..f54cfea 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -166,6 +166,8 @@ static struct key_entry eeepc_keymap[] = {
 	{KE_KEY, 0x1b, KEY_ZOOM },
 	{KE_KEY, 0x1c, KEY_PROG2 },
 	{KE_KEY, 0x1d, KEY_PROG3 },
+	{KE_KEY, NOTIFY_BRN_MIN,     KEY_BRIGHTNESSDOWN },
+	{KE_KEY, NOTIFY_BRN_MIN + 2, KEY_BRIGHTNESSUP },
 	{KE_KEY, 0x30, KEY_SWITCHVIDEOMODE },
 	{KE_KEY, 0x31, KEY_SWITCHVIDEOMODE },
 	{KE_KEY, 0x32, KEY_SWITCHVIDEOMODE },
@@ -512,11 +514,16 @@ static int eeepc_hotk_check(void)
 	return 0;
 }
 
-static void notify_brn(void)
+static int notify_brn(void)
 {
+	/* returns the *previous* brightness, or -1 */
 	struct backlight_device *bd = eeepc_backlight_device;
-	if (bd)
+	if (bd) {
+		int old = bd->props.brightness;
 		bd->props.brightness = read_brightness(bd);
+		return old;
+	}
+	return -1;
 }
 
 static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
@@ -558,17 +565,33 @@ static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	static struct key_entry *key;
 	u16 count;
+	int brn = -ENODEV;
 
 	if (!ehotk)
 		return;
 	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX)
-		notify_brn();
+		brn = notify_brn();
 	count = ehotk->event_count[event % 128]++;
 	acpi_bus_generate_proc_event(ehotk->device, event, count);
 	acpi_bus_generate_netlink_event(ehotk->device->pnp.device_class,
 					dev_name(&ehotk->device->dev), event,
 					count);
 	if (ehotk->inputdev) {
+		if (brn != -ENODEV) {
+			/* brightness-change events need special
+			 * handling for conversion to key events
+			 */
+			if (brn < 0)
+				brn = event;
+			else
+				brn += NOTIFY_BRN_MIN;
+			if (event < brn)
+				event = NOTIFY_BRN_MIN; /* brightness down */
+			else if (event > brn)
+				event = NOTIFY_BRN_MIN + 2; /* ... up */
+			else
+				event = NOTIFY_BRN_MIN + 1; /* ... unchanged */
+		}
 		key = eepc_get_entry_by_scancode(event);
 		if (key) {
 			switch (key->type) {
-- 
1.6.0.6

