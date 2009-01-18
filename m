From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH] asus_acpi: Add R1F support
Date: Sun, 18 Jan 2009 19:01:51 +0100
Message-ID: <1232301715-20292-3-git-send-email-corentincj@iksaif.net>
References: <1232301715-20292-1-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-2-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:58971 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757934AbZARSRN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jan 2009 13:17:13 -0500
In-Reply-To: <1232301715-20292-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Corentin Chary <corentincj@iksaif.net>

Add R1F support

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
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
1.6.0.6

