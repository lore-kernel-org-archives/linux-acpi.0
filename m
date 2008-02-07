From: Len Brown <lenb@kernel.org>
Subject: [PATCH 086/112] asus_acpi: add support for F3Sa
Date: Thu,  7 Feb 2008 04:34:48 -0500
Message-ID: <31e0729a85c1e8ffaf4d14b4c201c28b5d1c9585.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753724AbYBGJgt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:49 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Luca Tettamanti <kronos.it@gmail.com>, Corentin Chary <corentincj@iksaif.net>, Karol Kozimor <sziwan@users.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Luca Tettamanti <kronos.it@gmail.com>

Add support for ASUS F3Sa notebook. Features:
- LCD on/off
- Brightness
- Wifi kill
- Bluetooth kill

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Karol Kozimor <sziwan@users.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/asus_acpi.c |   55 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index d915fec..d25ef96 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -142,6 +142,7 @@ struct asus_hotk {
 		xxN,		//M2400N, M3700N, M5200N, M6800N, S1300N, S5200N
 		A4S,            //Z81sp
 		//(Centrino)
+		F3Sa,
 		END_MODEL
 	} model;		//Models currently supported
 	u16 event_count[128];	//count for each event TODO make this better
@@ -405,7 +406,20 @@ static struct model_data model_conf[END_MODEL] = {
 		.brightness_get    = "GPLV",
 		.mt_bt_switch      = "BLED",
 		.mt_wled           = "WLED"
-	}
+	},
+
+	{
+		.name		= "F3Sa",
+		.mt_bt_switch	= "BLED",
+		.mt_wled	= "WLED",
+		.mt_mled	= "MLED",
+		.brightness_get	= "GPLV",
+		.brightness_set	= "SPLV",
+		.mt_lcd_switch	= "\\_SB.PCI0.SBRG.EC0._Q10",
+		.lcd_status	= "\\_SB.PCI0.SBRG.EC0.RPIN",
+		.display_get	= "\\ADVG",
+		.display_set	= "SDSP",
+	},
 
 };
 
@@ -710,15 +724,8 @@ static int get_lcd_state(void)
 {
 	int lcd = 0;
 
-	if (hotk->model != L3H) {
-		/* We don't have to check anything if we are here */
-		if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
-			printk(KERN_WARNING
-			       "Asus ACPI: Error reading LCD status\n");
-
-		if (hotk->model == L2D)
-			lcd = ~lcd;
-	} else {		/* L3H and the like have to be handled differently */
+	if (hotk->model == L3H) {
+		/* L3H and the like have to be handled differently */
 		acpi_status status = 0;
 		struct acpi_object_list input;
 		union acpi_object mt_params[2];
@@ -745,6 +752,32 @@ static int get_lcd_state(void)
 		if (out_obj.type == ACPI_TYPE_INTEGER)
 			/* That's what the AML code does */
 			lcd = out_obj.integer.value >> 8;
+	} else if (hotk->model == F3Sa) {
+		unsigned long tmp;
+		union acpi_object param;
+		struct acpi_object_list input;
+		acpi_status status;
+
+		/* Read pin 11 */
+		param.type = ACPI_TYPE_INTEGER;
+		param.integer.value = 0x11;
+		input.count = 1;
+		input.pointer = &param;
+
+		status = acpi_evaluate_integer(NULL, hotk->methods->lcd_status,
+						&input, &tmp);
+		if (status != AE_OK)
+			return -1;
+
+		lcd = tmp;
+	} else {
+		/* We don't have to check anything if we are here */
+		if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
+			printk(KERN_WARNING
+			       "Asus ACPI: Error reading LCD status\n");
+
+		if (hotk->model == L2D)
+			lcd = ~lcd;
 	}
 
 	return (lcd & 1);
@@ -1134,6 +1167,8 @@ static int asus_model_match(char *model)
 		return W5A;
 	else if (strncmp(model, "A4S", 3) == 0)
 		return A4S;
+	else if (strncmp(model, "F3Sa", 4) == 0)
+		return F3Sa;
 	else
 		return END_MODEL;
 }
-- 
1.5.4.23.gef5b9

