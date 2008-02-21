From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/26] acer-wmi: Add DMI match for mail LED on Acer TravelMate 4200 series
Date: Thu, 21 Feb 2008 04:25:32 -0500
Message-ID: <262ee35be6a3aae9b4a7aafafc2dba901fc36620.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36615 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756274AbYBUJ3S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:18 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

The TM4200 series use the same method as the TM2490 series to control the
mail LED, so add a DMI based quirk for these laptops.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/acer-wmi.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index d7aea93..74d12b4 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -273,6 +273,15 @@ static struct dmi_system_id acer_quirks[] = {
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "Acer TravelMate 4200",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4200"),
+		},
+		.driver_data = &quirk_acer_travelmate_2490,
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Medion MD 98300",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
-- 
1.5.4.2

