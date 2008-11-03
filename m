From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 5/7] [sony-laptop] call the extra enable function for SNC on Vaio Z
Date: Mon,  3 Nov 2008 18:41:18 +0900
Message-ID: <1225705280-12775-6-git-send-email-malattia@linux.it>
References: <1225705280-12775-1-git-send-email-malattia@linux.it>
 <1225705280-12775-2-git-send-email-malattia@linux.it>
 <1225705280-12775-3-git-send-email-malattia@linux.it>
 <1225705280-12775-4-git-send-email-malattia@linux.it>
 <1225705280-12775-5-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48108
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754895AbYKCJlY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 04:41:24 -0500
In-Reply-To: <1225705280-12775-5-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>, Mattia Dongili <malattia@linux.it>

From: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 19f3306..31f84ce 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -894,6 +894,15 @@ static const struct dmi_system_id sony_nc_ids[] = {
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-N"),
 			},
 		},
+		{
+			.ident = "Sony Vaio Z Series",
+			.callback = sony_nc_C_enable,
+			.driver_data = sony_C_events,
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-Z"),
+			},
+		},
 		{ }
 };
 
-- 
1.5.6.5

