From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 03/14] ACPI: thinkpad-acpi: enhance box identification output (v2)
Date: Sat, 26 Apr 2008 01:02:19 -0300
Message-ID: <1209182550-32725-4-git-send-email-hmh@hmh.eng.br>
References: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58421 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708AbYDZECe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Apr 2008 00:02:34 -0400
In-Reply-To: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

During initialization, thinkpad-acpi outputs some messages to make sure
releavant box identification information is easily available in-line with
the rest of the driver messages.

Enhance those messages to output the alfanumeric model number as well.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index cd263c5..601dbe8 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -251,7 +251,8 @@ struct thinkpad_id_data {
 	u16 bios_model;		/* Big Endian, TP-1Y = 0x5931, 0 = unknown */
 	u16 ec_model;
 
-	char *model_str;
+	char *model_str;	/* ThinkPad T43 */
+	char *nummodel_str;	/* 9384A9C for a 9384-A9C model */
 };
 static struct thinkpad_id_data thinkpad_id;
 
@@ -988,12 +989,14 @@ static int __init thinkpad_acpi_driver_init(struct ibm_init_struct *iibm)
 			thinkpad_id.ec_version_str : "unknown");
 
 	if (thinkpad_id.vendor && thinkpad_id.model_str)
-		printk(TPACPI_INFO "%s %s\n",
+		printk(TPACPI_INFO "%s %s, model %s\n",
 			(thinkpad_id.vendor == PCI_VENDOR_ID_IBM) ?
 				"IBM" : ((thinkpad_id.vendor ==
 						PCI_VENDOR_ID_LENOVO) ?
 					"Lenovo" : "Unknown vendor"),
-			thinkpad_id.model_str);
+			thinkpad_id.model_str,
+			(thinkpad_id.nummodel_str) ?
+				thinkpad_id.nummodel_str : "unknown");
 
 	return 0;
 }
@@ -5875,6 +5878,9 @@ static void __init get_thinkpad_model_data(struct thinkpad_id_data *tp)
 		kfree(tp->model_str);
 		tp->model_str = NULL;
 	}
+
+	tp->nummodel_str = kstrdup(dmi_get_system_info(DMI_PRODUCT_NAME),
+					GFP_KERNEL);
 }
 
 static int __init probe_for_thinkpad(void)
-- 
1.5.4.4

