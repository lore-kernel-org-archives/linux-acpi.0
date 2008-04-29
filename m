From: Len Brown <lenb@kernel.org>
Subject: [PATCH 158/171] ACPI: thinkpad-acpi: enhance box identification output
Date: Tue, 29 Apr 2008 04:44:23 -0400
Message-ID: <bd40c44c087ceb2519728507b7fd3e27ad8e8976.1209457072.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:1417 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755376AbYD2Ipg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:36 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

During initialization, thinkpad-acpi outputs some messages to make sure
releavant box identification information is easily available in-line with
the rest of the driver messages.

Enhance those messages to output the alfanumeric model number as well.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index cd263c5..c8c1d6c 100644
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
 
@@ -988,12 +989,13 @@ static int __init thinkpad_acpi_driver_init(struct ibm_init_struct *iibm)
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
+			thinkpad_id.nummodel_str);
 
 	return 0;
 }
@@ -5875,6 +5877,9 @@ static void __init get_thinkpad_model_data(struct thinkpad_id_data *tp)
 		kfree(tp->model_str);
 		tp->model_str = NULL;
 	}
+
+	tp->nummodel_str = kstrdup(dmi_get_system_info(DMI_PRODUCT_NAME),
+					GFP_KERNEL);
 }
 
 static int __init probe_for_thinkpad(void)
-- 
1.5.5.1.99.gf0ec4

