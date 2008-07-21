From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 7/7] ACPI: thinkpad-acpi: don't misdetect in get_thinkpad_model_data() on -ENOMEM
Date: Mon, 21 Jul 2008 09:42:20 -0300
Message-ID: <1216644140-13284-7-git-send-email-hmh@hmh.eng.br>
References: <20080721122935.GA12972@khazad-dum.debian.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51803 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751478AbYGUMm2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jul 2008 08:42:28 -0400
In-Reply-To: <20080721122935.GA12972@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Explicitly check for memory allocation failures, and return status to
indicate that we could not collect data due to errors.

This lets the driver have a far more predictable failure mode on ENOMEM in
that codepath: it will refuse to load.  This is far better than trying to
proceed with missing data which is used to detect quirks, etc.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   47 +++++++++++++++++++++++++++++------------
 1 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 3eb01af..d3eb790 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -6340,13 +6340,18 @@ err_out:
 
 /* Probing */
 
-static void __init get_thinkpad_model_data(struct thinkpad_id_data *tp)
+/* returns 0 - probe ok, or < 0 - probe error.
+ * Probe ok doesn't mean thinkpad found.
+ * On error, kfree() cleanup on tp->* is not performed, caller must do it */
+static int __must_check __init get_thinkpad_model_data(
+						struct thinkpad_id_data *tp)
 {
 	const struct dmi_device *dev = NULL;
 	char ec_fw_string[18];
+	char const *s;
 
 	if (!tp)
-		return;
+		return -EINVAL;
 
 	memset(tp, 0, sizeof(*tp));
 
@@ -6355,12 +6360,14 @@ static void __init get_thinkpad_model_data(struct thinkpad_id_data *tp)
 	else if (dmi_name_in_vendors("LENOVO"))
 		tp->vendor = PCI_VENDOR_ID_LENOVO;
 	else
-		return;
+		return 0;
 
-	tp->bios_version_str = kstrdup(dmi_get_system_info(DMI_BIOS_VERSION),
-					GFP_KERNEL);
+	s = dmi_get_system_info(DMI_BIOS_VERSION);
+	tp->bios_version_str = kstrdup(s, GFP_KERNEL);
+	if (s && !tp->bios_version_str)
+		return -ENOMEM;
 	if (!tp->bios_version_str)
-		return;
+		return 0;
 	tp->bios_model = tp->bios_version_str[0]
 			 | (tp->bios_version_str[1] << 8);
 
@@ -6379,21 +6386,27 @@ static void __init get_thinkpad_model_data(struct thinkpad_id_data *tp)
 			ec_fw_string[strcspn(ec_fw_string, " ]")] = 0;
 
 			tp->ec_version_str = kstrdup(ec_fw_string, GFP_KERNEL);
+			if (!tp->ec_version_str)
+				return -ENOMEM;
 			tp->ec_model = ec_fw_string[0]
 					| (ec_fw_string[1] << 8);
 			break;
 		}
 	}
 
-	tp->model_str = kstrdup(dmi_get_system_info(DMI_PRODUCT_VERSION),
-					GFP_KERNEL);
-	if (tp->model_str && strnicmp(tp->model_str, "ThinkPad", 8) != 0) {
-		kfree(tp->model_str);
-		tp->model_str = NULL;
+	s = dmi_get_system_info(DMI_PRODUCT_VERSION);
+	if (s && !strnicmp(s, "ThinkPad", 8)) {
+		tp->model_str = kstrdup(s, GFP_KERNEL);
+		if (!tp->model_str)
+			return -ENOMEM;
 	}
 
-	tp->nummodel_str = kstrdup(dmi_get_system_info(DMI_PRODUCT_NAME),
-					GFP_KERNEL);
+	s = dmi_get_system_info(DMI_PRODUCT_NAME);
+	tp->nummodel_str = kstrdup(s, GFP_KERNEL);
+	if (s && !tp->nummodel_str)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static int __init probe_for_thinkpad(void)
@@ -6656,7 +6669,13 @@ static int __init thinkpad_acpi_module_init(void)
 
 	/* Driver-level probe */
 
-	get_thinkpad_model_data(&thinkpad_id);
+	ret = get_thinkpad_model_data(&thinkpad_id);
+	if (ret) {
+		printk(TPACPI_ERR
+			"unable to get DMI data: %d\n", ret);
+		thinkpad_acpi_module_exit();
+		return ret;
+	}
 	ret = probe_for_thinkpad();
 	if (ret) {
 		thinkpad_acpi_module_exit();
-- 
1.5.6.2

