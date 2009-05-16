From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/19] asus-laptop: fix input keycode
Date: Sat, 16 May 2009 02:02:07 -0400
Message-ID: <309f5fbda37d5e8f1233e8b80b8e9de77262e864.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:16412 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbZEPGC1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ0035W3G0TY09@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:24 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

KEY_STOP is now KEY_STOPCD
 It's the correct key to stop a media
BTN_EXTRA is now KEY_SCREENLOCK:
 The laptop manual tells us that this key is for screenlock
KEY_TV is now KEY_PROG1
 So it can be reported to X server

Ref: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/361505

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/asus-laptop.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index eeafc6c..bfc1a88 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -269,16 +269,16 @@ static struct key_entry asus_keymap[] = {
 	{KE_KEY, 0x34, KEY_SWITCHVIDEOMODE},
 	{KE_KEY, 0x40, KEY_PREVIOUSSONG},
 	{KE_KEY, 0x41, KEY_NEXTSONG},
-	{KE_KEY, 0x43, KEY_STOP},
+	{KE_KEY, 0x43, KEY_STOPCD},
 	{KE_KEY, 0x45, KEY_PLAYPAUSE},
 	{KE_KEY, 0x50, KEY_EMAIL},
 	{KE_KEY, 0x51, KEY_WWW},
-	{KE_KEY, 0x5C, BTN_EXTRA},  /* Performance */
+	{KE_KEY, 0x5C, KEY_SCREENLOCK},  /* Screenlock */
 	{KE_KEY, 0x5D, KEY_WLAN},
 	{KE_KEY, 0x61, KEY_SWITCHVIDEOMODE},
 	{KE_KEY, 0x6B, BTN_TOUCH}, /* Lock Mouse */
 	{KE_KEY, 0x82, KEY_CAMERA},
-	{KE_KEY, 0x8A, KEY_TV},
+	{KE_KEY, 0x8A, KEY_PROG1},
 	{KE_KEY, 0x95, KEY_MEDIA},
 	{KE_KEY, 0x99, KEY_PHONE},
 	{KE_END, 0},
-- 
1.6.0.6

