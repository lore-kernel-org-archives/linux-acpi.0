From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/6] sony-laptop: Add Vaio N series to the special init sequence to enable Fn keys
Date: Mon, 14 Jan 2008 18:05:42 +0900
Message-ID: <1200301546-6079-3-git-send-email-malattia@linux.it>
References: <1200301546-6079-1-git-send-email-malattia@linux.it>
 <1200301546-6079-2-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi15.ns.itscom.net ([219.110.2.185]:49230 "EHLO
	mtoichi15.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbYANJMr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jan 2008 04:12:47 -0500
In-Reply-To: <1200301546-6079-2-git-send-email-malattia@linux.it>
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
index 0435b3d..7a32b35 100644
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

