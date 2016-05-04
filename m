From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/15] ACPICA: ACPI 6.1: Support for new PCCT subtable
Date: Wed,  4 May 2016 13:48:27 +0800
Message-ID: <1844dead994caa25681c2691dfa05b787062d1e1.1462331121.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462331120.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit de3ea7c322b9b6bdb09aa90c2e1d420cd4dce47c

Additional subspace structure was added.

Link: https://github.com/acpica/acpica/commit/de3ea7c3
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index f12f4bb..ebc1f4f 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -481,7 +481,8 @@ struct acpi_table_pcct {
 enum acpi_pcct_type {
 	ACPI_PCCT_TYPE_GENERIC_SUBSPACE = 0,
 	ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE = 1,
-	ACPI_PCCT_TYPE_RESERVED = 2	/* 2 and greater are reserved */
+	ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2 = 2,	/* ACPI 6.1 */
+	ACPI_PCCT_TYPE_RESERVED = 3	/* 3 and greater are reserved */
 };
 
 /*
@@ -520,6 +521,26 @@ struct acpi_pcct_hw_reduced {
 	u16 min_turnaround_time;
 };
 
+/* 2: HW-reduced Communications Subspace Type 2 (ACPI 6.1) */
+
+struct acpi_pcct_hw_reduced_type2 {
+	struct acpi_subtable_header header;
+	u32 doorbell_interrupt;
+	u8 flags;
+	u8 reserved;
+	u64 base_address;
+	u64 length;
+	struct acpi_generic_address doorbell_register;
+	u64 preserve_mask;
+	u64 write_mask;
+	u32 latency;
+	u32 max_access_rate;
+	u16 min_turnaround_time;
+	struct acpi_generic_address doorbell_ack_register;
+	u64 ack_preserve_mask;
+	u64 ack_write_mask;
+};
+
 /* Values for doorbell flags above */
 
 #define ACPI_PCCT_INTERRUPT_POLARITY    (1)
-- 
1.7.10
