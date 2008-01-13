From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/6] sony-laptop: Add Vaio N series to the special init sequence to enable Fn keys
Date: Sun, 13 Jan 2008 13:23:28 +0900
Message-ID: <1200198212-10526-3-git-send-email-malattia@linux.it>
References: <1200198212-10526-1-git-send-email-malattia@linux.it>
 <1200198212-10526-2-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi13.ns.itscom.net ([219.110.2.183]:57029 "EHLO
	mtoichi13.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbYAMEXz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jan 2008 23:23:55 -0500
In-Reply-To: <1200198212-10526-2-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Also the recent Vaio N series need some more calls into the DSDT
to enable reporting of FN key events to be delivered to the SNC device.

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

