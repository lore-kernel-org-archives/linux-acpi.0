From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/29] sony-laptop: SNC input event 38 fix
Date: Thu, 23 Apr 2009 02:23:35 -0400
Message-ID: <351b2aba9baca0ec7b3383123ebb56013342574a.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:41735 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbZDWGYC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:02 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ005F6J42I9F2@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:02 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Almer S. Tigelaar" <almer@gnome.org>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Almer S. Tigelaar <almer@gnome.org>

Fixes the "unknown input event 38" messages. ANYBUTTON_RELEASED is now
treated the same way as FN_KEY_RELEASED.

Signed-off-by: Almer S. Tigelaar <almer@gnome.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 4ff41a7..3541ca0 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -317,7 +317,8 @@ static void sony_laptop_report_input_event(u8 event)
 	struct input_dev *key_dev = sony_laptop_input.key_dev;
 	struct sony_laptop_keypress kp = { NULL };
 
-	if (event == SONYPI_EVENT_FNKEY_RELEASED) {
+	if (event == SONYPI_EVENT_FNKEY_RELEASED ||
+			event == SONYPI_EVENT_ANYBUTTON_RELEASED) {
 		/* Nothing, not all VAIOs generate this event */
 		return;
 	}
-- 
1.6.0.6

