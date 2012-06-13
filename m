From: Corentin Chary <corentin.chary@gmail.com>
Subject: [PATCH 5/7] samsung-laptop: support R40/R41
Date: Wed, 13 Jun 2012 09:32:05 +0200
Message-ID: <1339572727-24744-6-git-send-email-corentin.chary@gmail.com>
References: <1339572727-24744-1-git-send-email-corentin.chary@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51230 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab2FMHcU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jun 2012 03:32:20 -0400
In-Reply-To: <1339572727-24744-1-git-send-email-corentin.chary@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org

> Chassis Information
> 	Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
>	Type: Other

Type should be "Notebook", "Laptop", .. not "Other".

Signed-off-by: Corentin Chary <corentin.chary@gmail.com>
---
 drivers/platform/x86/samsung-laptop.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 98f0758..c1ca7bc 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1465,6 +1465,15 @@ static struct dmi_system_id __initdata samsung_dmi_table[] = {
 			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
 		},
 	},
+	/* DMI ids for laptops with bad Chassis Type */
+	{
+	  .ident = "R40/R41",
+	  .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "R40/R41"),
+		DMI_MATCH(DMI_BOARD_NAME, "R40/R41"),
+		},
+	},
 	/* Specific DMI ids for laptop with quirks */
 	{
 	 .callback = samsung_dmi_matched,
-- 
1.7.9.5

