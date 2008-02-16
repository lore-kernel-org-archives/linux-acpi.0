From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] acer-wmi - Add DMI match for mail LED on Acer TravelMate 4200
	series
Date: Sat, 16 Feb 2008 00:02:56 +0000
Message-ID: <20080216000256.1725.83948.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:47406 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756369AbYBPADO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 19:03:14 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>

The TM4200 series use the same method as the TM2490 series to control the
mail LED, so add a DMI based quirk for these laptops.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Len Brown <lenb@kernel.org>
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

