From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 5/9] [sony-laptop] call the extra enable function for SNC on Vaio Z
Date: Sun,  1 Mar 2009 13:40:41 +0900
Message-ID: <1235882445-2404-6-git-send-email-malattia@linux.it>
References: <1235882445-2404-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48657
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756493AbZCAEuU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Feb 2009 23:50:20 -0500
In-Reply-To: <1235882445-2404-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>, Mattia Dongili <malattia@linux.it>

From: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 3322368..f3bd13a 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
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
1.6.1.3

