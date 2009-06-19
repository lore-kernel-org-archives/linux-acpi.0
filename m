From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH] dell-wmi Switch support and Tablet switch definition
Date: Fri, 19 Jun 2009 07:15:12 -0400
Message-ID: <1245410112-13659-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from icgrid41.seas.upenn.edu ([158.130.56.179]:44654 "EHLO
	icgrid41.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbZFSLl6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 07:41:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Rafi Rubin <rafi@seas.upenn.edu>

Added a bit of missing code needed to handle switch events.

Added the definitions for the hinge rotation as seen on the
Latitude XT tablet.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/platform/x86/dell-wmi.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 0f900cc..c0da4d2 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -44,6 +44,7 @@ struct key_entry {
 	char type;		/* See KE_* below */
 	u16 code;
 	u16 keycode;
+   u8  state;
 };
 
 enum { KE_KEY, KE_SW, KE_IGNORE, KE_END };
@@ -58,6 +59,10 @@ static struct key_entry dell_wmi_keymap[] = {
 	{KE_KEY, 0xe045, KEY_PROG1},
 	{KE_KEY, 0xe009, KEY_EJECTCD},
 
+	/* Definitions for the hinge switch */
+	{KE_SW , 0xe046, SW_TABLET_MODE,1},
+	{KE_SW , 0xe047, SW_TABLET_MODE,0},
+
 	/* These also contain the brightness level at offset 6 */
 	{KE_KEY, 0xe006, KEY_BRIGHTNESSUP},
 	{KE_KEY, 0xe005, KEY_BRIGHTNESSDOWN},
@@ -172,10 +177,18 @@ static void dell_wmi_notify(u32 value, void *context)
 		 */
 		key = dell_wmi_get_entry_by_scancode(buffer[1] & 0xFFFF);
 		if (key) {
-			input_report_key(dell_wmi_input_dev, key->keycode, 1);
-			input_sync(dell_wmi_input_dev);
-			input_report_key(dell_wmi_input_dev, key->keycode, 0);
-			input_sync(dell_wmi_input_dev);
+         switch (key->type) {
+         case KE_KEY:
+				input_report_key(dell_wmi_input_dev, key->keycode, 1);
+				input_sync(dell_wmi_input_dev);
+				input_report_key(dell_wmi_input_dev, key->keycode, 0);
+				input_sync(dell_wmi_input_dev);
+            break;
+         case KE_SW:
+            input_report_switch(dell_wmi_input_dev, key->keycode, key->state);
+            input_sync(dell_wmi_input_dev);
+            break;
+         }
 		} else if (buffer[1] & 0xFFFF)
 			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
 			       buffer[1] & 0xFFFF);
-- 
1.6.0

