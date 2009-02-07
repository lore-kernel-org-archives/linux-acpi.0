From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/30] asus_acpi: Add R1F support
Date: Sat, 07 Feb 2009 01:41:14 -0500
Message-ID: <1021e2119eb33a990a2b9ff1410805dd9bdf7997.1233988823.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:44614 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbZBGGls (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:48 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00L6VNPE9S12@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:36:51 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Add R1F support

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/asus_acpi.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/asus_acpi.c b/drivers/platform/x86/asus_acpi.c
index 1e74988..d63f26e 100644
--- a/drivers/platform/x86/asus_acpi.c
+++ b/drivers/platform/x86/asus_acpi.c
@@ -143,6 +143,7 @@ struct asus_hotk {
 							 S1300N, S5200N*/
 		A4S,            /* Z81sp */
 		F3Sa,		/* (Centrino) */
+		R1F,
 		END_MODEL
 	} model;		/* Models currently supported */
 	u16 event_count[128];	/* Count for each event TODO make this better */
@@ -420,7 +421,18 @@ static struct model_data model_conf[END_MODEL] = {
 		.display_get	= "\\ADVG",
 		.display_set	= "SDSP",
 	},
-
+	{
+		.name = "R1F",
+		.mt_bt_switch = "BLED",
+		.mt_mled = "MLED",
+		.mt_wled = "WLED",
+		.mt_lcd_switch = "\\Q10",
+		.lcd_status = "\\GP06",
+		.brightness_set = "SPLV",
+		.brightness_get = "GPLV",
+		.display_set = "SDSP",
+		.display_get = "\\INFB"
+	}
 };
 
 /* procdir we use */
@@ -1165,6 +1177,8 @@ static int asus_model_match(char *model)
 		return W3V;
 	else if (strncmp(model, "W5A", 3) == 0)
 		return W5A;
+	else if (strncmp(model, "R1F", 3) == 0)
+		return R1F;
 	else if (strncmp(model, "A4S", 3) == 0)
 		return A4S;
 	else if (strncmp(model, "F3Sa", 4) == 0)
-- 
1.5.6.6

