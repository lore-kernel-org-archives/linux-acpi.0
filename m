From: Keng-Yu Lin <keng-yu.lin@canonical.com>
Subject: [PATCH] acer-wmi: Add DMI quirk to blacklist Acer Aspire One BA01-DV/JM11-ML.
Date: Thu,  3 Dec 2009 11:09:05 +0800
Message-ID: <1259809745-24878-1-git-send-email-keng-yu.lin@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:39443 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbZLCDJJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2009 22:09:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Keng-Yu Lin <keng-yu.lin@canonical.com>

The two Acer Aspire One models should be blacklisted to prevent from
reporting rfkill is enabled since it's hardware controlled.

Signed-off-by: Keng-Yu Lin <keng-yu.lin@canonical.com>
---
 drivers/platform/x86/acer-wmi.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 454970d..b39766c 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -241,6 +241,20 @@ static struct dmi_system_id __devinitdata acer_blacklist[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
 		},
 	},
+	{
+		.ident = "Acer Aspire One (BA01-DV)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AO531h"),
+		},
+	},
+	{
+		.ident = "Acer Aspire One (JM11-ML)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AO751h"),
+		},
+	},
 	{}
 };
 
-- 
1.6.3.3

