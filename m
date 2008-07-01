From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 7/7] ACPI: thinkpad-acpi: don't misdetect
	in get_thinkpad_model_data() on -ENOMEM
Date: Tue,  1 Jul 2008 15:27:55 -0300
Message-ID: <1214936875-4812-8-git-send-email-hmh@hmh.eng.br>
References: <1214936875-4812-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1214936875-4812-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Explicitly check for memory allocation failures, and return status to
indicate that we could not collect data due to errors.

This lets the driver have a far more predictable failure mode on ENOMEM in
that codepath: it will refuse to load.  This is far better than trying to
proceed with missing data which is used to detect quirks, etc.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
1.5.5.4


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
