From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH] sony-laptop: Add Vaio N series to the special init sequence to enable Fn keys
Date: Sun, 13 Jan 2008 13:12:30 +0900
Message-ID: <1200197554-9598-3-git-send-email-malattia@linux.it>
References: <1200197554-9598-1-git-send-email-malattia@linux.it>
 <1200197554-9598-2-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mfbichi11.ns.itscom.net ([219.110.2.189]:64346 "EHLO
	mfbichi11.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbYAMG7p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jan 2008 01:59:45 -0500
In-Reply-To: <1200197554-9598-2-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 4211ca7..550f9d9 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -875,6 +875,15 @@ static const struct dmi_system_id sony_nc_ids[] = {
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-C"),
 			},
 		},
+		{
+			.ident = "Sony Vaio N Series",
+			.callback = sony_nc_C_enable,
+			.driver_data = sony_C_events,
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-N"),
+			},
+		},
 		{ }
 };
 
-- 
1.5.3.7

