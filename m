From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/17] ACPICA: ACPI 5.1: Update for PCCT table changes.
Date: Wed, 30 Jul 2014 12:22:05 +0800
Message-ID: <eb344e9e604eec866dcb125f4664612dadd19c13.1406689494.git.lv.zheng@intel.com>
References: <cover.1406689493.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1406689493.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

One new subtable.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 41ad964..787bcc8 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -448,7 +448,8 @@ struct acpi_table_pcct {
 
 enum acpi_pcct_type {
 	ACPI_PCCT_TYPE_GENERIC_SUBSPACE = 0,
-	ACPI_PCCT_TYPE_RESERVED = 1	/* 1 and greater are reserved */
+	ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE = 1,
+	ACPI_PCCT_TYPE_RESERVED = 2	/* 2 and greater are reserved */
 };
 
 /*
@@ -470,6 +471,28 @@ struct acpi_pcct_subspace {
 	u16 min_turnaround_time;
 };
 
+/* 1: HW-reduced Communications Subspace (ACPI 5.1) */
+
+struct acpi_pcct_hw_reduced {
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
+};
+
+/* Values for doorbell flags above */
+
+#define ACPI_PCCT_INTERRUPT_POLARITY    (1)
+#define ACPI_PCCT_INTERRUPT_MODE        (1<<1)
+
 /*
  * PCC memory structures (not part of the ACPI table)
  */
-- 
1.7.10
