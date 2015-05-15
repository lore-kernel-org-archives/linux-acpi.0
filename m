From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/6] ACPI / EC: Remove storming threashold enlarging quirk.
Date: Fri, 15 May 2015 14:16:27 +0800
Message-ID: <4c897886c208eb49613ca86d332628c329f6c2a8.1431670199.git.lv.zheng@intel.com>
References: <3b6064b23b148a9c3eed58566e9361a852618556.1430900840.git.lv.zheng@intel.com> <cover.1431670199.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1431670199.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch removes the storming threashold enlarging quirk.

After applying the following commit, we can notice that there is no no-op
GPE handling invocation can be observed, thus it is unlikely that the
no-op counts can exceed the storming threashold:
  Commit: ca37bfdfbc8d0a3ec73e4b97bb26dcfa51d515aa
  Subject: ACPI / EC: Fix several GPE handling issues by deploying ACPI_GPE_DISPATCH_RAW_HANDLER mode.
Even when the storming happens, we have already limited its affection to
the only transaction and no further transactions will be affected. This is
done by this commit:
  Commit: e1d4d90fc0313d3d58cbd7912c90f8ef24df45ff
  Subject: ACPI / EC: Refine command storm prevention support

So it's time to remove this quirk.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=45151
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 99084e8..170d743 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1247,17 +1247,6 @@ static int ec_flag_msi(const struct dmi_system_id *id)
 }
 
 /*
- * Clevo M720 notebook actually works ok with IRQ mode, if we lifted
- * the GPE storm threshold back to 20
- */
-static int ec_enlarge_storm_threshold(const struct dmi_system_id *id)
-{
-	pr_debug("Setting the EC GPE storm threshold to 20\n");
-	ec_storm_threshold  = 20;
-	return 0;
-}
-
-/*
  * Acer EC firmware refuses to respond QR_EC when SCI_EVT is not set, for
  * which case, we complete the QR_EC without issuing it to the firmware.
  * https://bugzilla.kernel.org/show_bug.cgi?id=86211
@@ -1329,10 +1318,6 @@ static struct dmi_system_id ec_dmi_table[] __initdata = {
 	ec_validate_ecdt, "ASUS hardware", {
 	DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc.") }, NULL},
 	{
-	ec_enlarge_storm_threshold, "CLEVO hardware", {
-	DMI_MATCH(DMI_SYS_VENDOR, "CLEVO Co."),
-	DMI_MATCH(DMI_PRODUCT_NAME, "M720T/M730T"),}, NULL},
-	{
 	ec_skip_dsdt_scan, "HP Folio 13", {
 	DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
 	DMI_MATCH(DMI_PRODUCT_NAME, "HP Folio 13"),}, NULL},
-- 
1.7.10
