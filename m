From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/19] ACPICA: ACPI 6.0: Add changes for LPIT table.
Date: Thu, 21 May 2015 10:30:59 +0800
Message-ID: <36b043362d119a522de8448c3956e2de02251b0e.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit d527908bb33a3ed515cfb349cbec57121deafcc8

Second subtable type was removed from the July 2014 LPIT
document.

Link: https://github.com/acpica/acpica/commit/d527908b
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |   20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index cafdeb5..93f85e8 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -824,7 +824,7 @@ struct acpi_ivrs_memory {
  *
  * LPIT - Low Power Idle Table
  *
- * Conforms to "ACPI Low Power Idle Table (LPIT) and _LPD Proposal (DRAFT)"
+ * Conforms to "ACPI Low Power Idle Table (LPIT)" July 2014.
  *
  ******************************************************************************/
 
@@ -846,8 +846,7 @@ struct acpi_lpit_header {
 
 enum acpi_lpit_type {
 	ACPI_LPIT_TYPE_NATIVE_CSTATE = 0x00,
-	ACPI_LPIT_TYPE_SIMPLE_IO = 0x01,
-	ACPI_LPIT_TYPE_RESERVED = 0x02	/* 2 and above are reserved */
+	ACPI_LPIT_TYPE_RESERVED = 0x01	/* 1 and above are reserved */
 };
 
 /* Masks for Flags field above  */
@@ -870,21 +869,6 @@ struct acpi_lpit_native {
 	u64 counter_frequency;
 };
 
-/* 0x01: Simple I/O based LPI structure */
-
-struct acpi_lpit_io {
-	struct acpi_lpit_header header;
-	struct acpi_generic_address entry_trigger;
-	u32 trigger_action;
-	u64 trigger_value;
-	u64 trigger_mask;
-	struct acpi_generic_address minimum_idle_state;
-	u32 residency;
-	u32 latency;
-	struct acpi_generic_address residency_counter;
-	u64 counter_frequency;
-};
-
 /*******************************************************************************
  *
  * MCFG - PCI Memory Mapped Configuration table and subtable
-- 
1.7.10
