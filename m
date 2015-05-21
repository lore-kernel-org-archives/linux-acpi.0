From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/19] ACPICA: ACPI 6.0: Add changes for FADT table.
Date: Thu, 21 May 2015 10:30:52 +0800
Message-ID: <9915992c2e0f9f64f50e1d2614ffb87a89bca16c.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 72b0b6741990f619f6aaa915302836b7cbb41ac4

One new 64-bit field at the end of the table.
FADT version is now 6.

Link: https://github.com/acpica/acpica/commit/72b0b674
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl.h |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index d4081fe..cb8a6b9 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -284,6 +284,7 @@ struct acpi_table_fadt {
 	struct acpi_generic_address xgpe1_block;	/* 64-bit Extended General Purpose Event 1 Reg Blk address */
 	struct acpi_generic_address sleep_control;	/* 64-bit Sleep Control register (ACPI 5.0) */
 	struct acpi_generic_address sleep_status;	/* 64-bit Sleep Status register (ACPI 5.0) */
+	u64 hypervisor_id;	/* Hypervisor Vendor ID (ACPI 6.0) */
 };
 
 /* Masks for FADT IA-PC Boot Architecture Flags (boot_flags) [Vx]=Introduced in this FADT revision */
@@ -341,7 +342,7 @@ enum acpi_preferred_pm_profiles {
 	PM_TABLET = 8
 };
 
-/* Values for sleep_status and sleep_control registers (V5 FADT) */
+/* Values for sleep_status and sleep_control registers (V5+ FADT) */
 
 #define ACPI_X_WAKE_STATUS          0x80
 #define ACPI_X_SLEEP_TYPE_MASK      0x1C
@@ -398,15 +399,17 @@ struct acpi_table_desc {
  * FADT is the bottom line as to what the version really is.
  *
  * For reference, the values below are as follows:
- *     FADT V1  size: 0x074
- *     FADT V2  size: 0x084
- *     FADT V3  size: 0x0F4
- *     FADT V4  size: 0x0F4
- *     FADT V5  size: 0x10C
+ *     FADT V1 size: 0x074
+ *     FADT V2 size: 0x084
+ *     FADT V3 size: 0x0F4
+ *     FADT V4 size: 0x0F4
+ *     FADT V5 size: 0x10C
+ *     FADT V6 size: 0x114
  */
 #define ACPI_FADT_V1_SIZE       (u32) (ACPI_FADT_OFFSET (flags) + 4)
 #define ACPI_FADT_V2_SIZE       (u32) (ACPI_FADT_OFFSET (minor_revision) + 1)
 #define ACPI_FADT_V3_SIZE       (u32) (ACPI_FADT_OFFSET (sleep_control))
-#define ACPI_FADT_V5_SIZE       (u32) (sizeof (struct acpi_table_fadt))
+#define ACPI_FADT_V5_SIZE       (u32) (ACPI_FADT_OFFSET (hypervisor_id))
+#define ACPI_FADT_V6_SIZE       (u32) (sizeof (struct acpi_table_fadt))
 
 #endif				/* __ACTBL_H__ */
-- 
1.7.10
