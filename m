From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/10] ACPICA: Events: Back port "ACPICA: Save current masks of enabled GPEs after enable register writes".
Date: Thu,  5 Feb 2015 15:19:48 +0800
Message-ID: <8a4eebacaf4919b67f9102ea1b78d76309714fab.1423119574.git.lv.zheng@intel.com>
References: <cover.1423119574.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is the back port result of the Linux commit:
  Commit c50f13c672df758b59e026c15b9118f3ed46edc4
  Subject: ACPICA: Save current masks of enabled GPEs after enable register writes

Besides of the indent divergences, only a missing prototype added due to
the ACPICA internal coding style.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evgpeutil.c |    4 ++--
 drivers/acpi/acpica/evxfgpe.c   |    1 -
 drivers/acpi/acpica/hwgpe.c     |    4 ++++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 17e4bbf..9e2b94c 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -167,8 +167,8 @@ u8 acpi_ev_valid_gpe_event(struct acpi_gpe_event_info *gpe_event_info)
  ******************************************************************************/
 
 acpi_status
-acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
-		       struct acpi_gpe_block_info *gpe_block, void *context)
+acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
+		       struct acpi_gpe_block_info * gpe_block, void *context)
 {
 	struct acpi_gpe_device_info *info = context;
 
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index e889a53..c637666 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -604,7 +604,6 @@ ACPI_EXPORT_SYMBOL(acpi_enable_all_runtime_gpes)
  *              all GPE blocks.
  *
  ******************************************************************************/
-
 acpi_status acpi_enable_all_wakeup_gpes(void)
 {
 	acpi_status status;
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 494027f..6a955a9 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -54,6 +54,10 @@ acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				struct acpi_gpe_block_info *gpe_block,
 				void *context);
 
+static acpi_status
+acpi_hw_gpe_enable_write(u8 enable_mask,
+			 struct acpi_gpe_register_info *gpe_register_info);
+
 /******************************************************************************
  *
  * FUNCTION:	acpi_hw_get_gpe_register_bit
-- 
1.7.10
