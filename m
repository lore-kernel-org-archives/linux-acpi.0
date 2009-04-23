From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/29] ACPI video: fix an error when the brightness levels on
 AC and on Battery are same
Date: Thu, 23 Apr 2009 02:23:48 -0400
Message-ID: <90af2cf6205bfc8def8c5a64c9134031d60b10fb.1240467665.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:54737 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbZDWGYQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:16 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00DJQJ49S9F0@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:09 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

when the brightness level on AC and brightness level on Battery
are same, the level_ac_battery is 1 in the current code,
which is wrong.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index cd4fb75..21968ae 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -770,10 +770,12 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 	 * In this case, the first two elements in _BCL packages
 	 * are also supported brightness levels that OS should take care of.
 	 */
-	for (i = 2; i < count; i++)
-		if (br->levels[i] == br->levels[0] ||
-		    br->levels[i] == br->levels[1])
+	for (i = 2; i < count; i++) {
+		if (br->levels[i] == br->levels[0])
 			level_ac_battery++;
+		if (br->levels[i] == br->levels[1])
+			level_ac_battery++;
+	}
 
 	if (level_ac_battery < 2) {
 		level_ac_battery = 2 - level_ac_battery;
-- 
1.6.0.6

