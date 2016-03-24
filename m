From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/30] ACPICA: ACPI 6.1: Updates for the HEST ACPI table
Date: Thu, 24 Mar 2016 09:38:57 +0800
Message-ID: <e47d3bf1251795c1da6485288fa85a05627c0a65.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 7e81afb625f5184000713de2b1f280e73251bc03

Additional structure for the generic error entry.
Some additional constants/flags.
With assistance from Abdulhamid, Harb <harba@codeaurora.org>

Link: https://github.com/acpica/acpica/commit/7e81afb6
Reviewed-by: Harb Abdulhamid <harba@codeaurora.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl1.h |   54 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 16e0136..b7c96b7 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -427,7 +427,8 @@ enum acpi_hest_types {
 	ACPI_HEST_TYPE_AER_ENDPOINT = 7,
 	ACPI_HEST_TYPE_AER_BRIDGE = 8,
 	ACPI_HEST_TYPE_GENERIC_ERROR = 9,
-	ACPI_HEST_TYPE_RESERVED = 10	/* 10 and greater are reserved */
+	ACPI_HEST_TYPE_GENERIC_ERROR_V2 = 10,
+	ACPI_HEST_TYPE_RESERVED = 11	/* 11 and greater are reserved */
 };
 
 /*
@@ -506,7 +507,11 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_NMI = 4,
 	ACPI_HEST_NOTIFY_CMCI = 5,	/* ACPI 5.0 */
 	ACPI_HEST_NOTIFY_MCE = 6,	/* ACPI 5.0 */
-	ACPI_HEST_NOTIFY_RESERVED = 7	/* 7 and greater are reserved */
+	ACPI_HEST_NOTIFY_GPIO = 7,	/* ACPI 6.0 */
+	ACPI_HEST_NOTIFY_SEA = 8,	/* ACPI 6.1 */
+	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
+	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
+	ACPI_HEST_NOTIFY_RESERVED = 11	/* 11 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
@@ -603,6 +608,24 @@ struct acpi_hest_generic {
 	u32 error_block_length;
 };
 
+/* 10: Generic Hardware Error Source, version 2 */
+
+struct acpi_hest_generic_v2 {
+	struct acpi_hest_header header;
+	u16 related_source_id;
+	u8 reserved;
+	u8 enabled;
+	u32 records_to_preallocate;
+	u32 max_sections_per_record;
+	u32 max_raw_data_length;
+	struct acpi_generic_address error_status_address;
+	struct acpi_hest_notify notify;
+	u32 error_block_length;
+	struct acpi_generic_address read_ack_register;
+	u64 read_ack_preserve;
+	u64 read_ack_write;
+};
+
 /* Generic Error Status block */
 
 struct acpi_hest_generic_status {
@@ -634,6 +657,33 @@ struct acpi_hest_generic_data {
 	u8 fru_text[20];
 };
 
+/* Extension for revision 0x0300 */
+
+struct acpi_hest_generic_data_v300 {
+	u8 section_type[16];
+	u32 error_severity;
+	u16 revision;
+	u8 validation_bits;
+	u8 flags;
+	u32 error_data_length;
+	u8 fru_id[16];
+	u8 fru_text[20];
+	u64 time_stamp;
+};
+
+/* Values for error_severity above */
+
+#define ACPI_HEST_GEN_ERROR_RECOVERABLE     0
+#define ACPI_HEST_GEN_ERROR_FATAL           1
+#define ACPI_HEST_GEN_ERROR_CORRECTED       2
+#define ACPI_HEST_GEN_ERROR_NONE            3
+
+/* Flags for validation_bits above */
+
+#define ACPI_HEST_GEN_VALID_FRU_ID          (1)
+#define ACPI_HEST_GEN_VALID_FRU_STRING      (1<<1)
+#define ACPI_HEST_GEN_VALID_TIMESTAMP       (1<<2)
+
 /*******************************************************************************
  *
  * MADT - Multiple APIC Description Table
-- 
1.7.10
