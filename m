From: akpm@osdl.org
Subject: [patch 1/6] asus_acpi: W3000 support
Date: Fri, 30 Jun 2006 02:15:14 -0700
Message-ID: <200606300915.k5U9FEF3001032@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:28299 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750965AbWF3JPR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 05:15:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, marekw1977@yahoo.com.au

From: Marek W <marekw1977@yahoo.com.au>

Add support for W3000 (W3V) and indirectly fixes an issue with kmilo under
KDE (it was triggering excessive LCD read error messages by querying
asus_acpi module) allowing people (I am probably the only one who tested
this) with W3000 to run kmilo.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/asus_acpi.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/asus_acpi.c~asus_acpi-w3000-support drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c~asus_acpi-w3000-support
+++ a/drivers/acpi/asus_acpi.c
@@ -131,6 +131,7 @@ struct asus_hotk {
 		P30,		//Samsung P30
 		S1x,		//S1300A, but also L1400B and M2400A (L84F)
 		S2x,		//S200 (J1 reported), Victor MP-XP7210
+		W3V,            //W3030V
 		xxN,		//M2400N, M3700N, M5200N, S1300N, S5200N, W1OOON
 		//(Centrino)
 		END_MODEL
@@ -345,6 +346,17 @@ static struct model_data model_conf[END_
 	 .brightness_down = S2x_PREFIX "_Q0A"},
 
 	{
+	 .name = "W3V",
+	 .mt_mled = "MLED",
+	 .mt_wled = "WLED",
+	 .mt_lcd_switch = xxN_PREFIX "_Q10",
+	 .lcd_status = "\\BKLT",
+	 .brightness_set = "SPLV",
+	 .brightness_get = "GPLV",
+	 .display_set = "SDSP",
+	 .display_get = "\\INFB"},
+
+       {
 	 .name = "xxN",
 	 .mt_mled = "MLED",
 /* WLED present, but not controlled by ACPI */
@@ -1066,6 +1078,8 @@ static int asus_hotk_get_info(void)
 		hotk->model = S2x;
 	else if (strncmp(model->string.pointer, "L5", 2) == 0)
 		hotk->model = L5x;
+	else if (strncmp(model->string.pointer, "W3V", 3) == 0)
+		hotk->model = W3V;
 
 	if (hotk->model == END_MODEL) {
 		printk("unsupported, trying default values, supply the "
@@ -1087,9 +1101,10 @@ static int asus_hotk_get_info(void)
 		hotk->methods->mt_mled = NULL;
 	/* S5N and M5N have no MLED */
 	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
-		 strncmp(model->string.pointer, "W1N", 3) == 0)
+		 strncmp(model->string.pointer, "W1N", 3) == 0 ||
+		 strncmp(model->string.pointer, "W3V", 3) == 0)
 		hotk->methods->mt_wled = "WLED";
-	/* M2N and W1N have a usable WLED */
+	/* M2N, W1N and W3V have a usable WLED */
 	else if (asus_info) {
 		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
 			hotk->methods->mled_status = NULL;
_
