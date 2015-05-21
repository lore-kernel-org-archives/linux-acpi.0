From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/19] ACPICA: ACPI 6.0: Add changes for MADT table.
Date: Thu, 21 May 2015 10:31:18 +0800
Message-ID: <e5bb0a9389d04b75d702fbdb747f3015b6be51c3.1432175162.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 02cbb41232bccf7a91967140cab95d5f48291f21

New subtable type. Some additions to existing subtables.

Link: https://github.com/acpica/acpica/commit/02cbb412
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl1.h |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index b80b0e6..cadf21c 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -673,7 +673,8 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR = 12,
 	ACPI_MADT_TYPE_GENERIC_MSI_FRAME = 13,
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
-	ACPI_MADT_TYPE_RESERVED = 15	/* 15 and greater are reserved */
+	ACPI_MADT_TYPE_GENERIC_TRANSLATOR = 15,
+	ACPI_MADT_TYPE_RESERVED = 16	/* 16 and greater are reserved */
 };
 
 /*
@@ -794,7 +795,7 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];		/* reserved - must be zero */
 };
 
-/* 11: Generic Interrupt (ACPI 5.0) */
+/* 11: Generic Interrupt (ACPI 5.0 + ACPI 6.0 changes) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
@@ -811,6 +812,8 @@ struct acpi_madt_generic_interrupt {
 	u32 vgic_interrupt;
 	u64 gicr_base_address;
 	u64 arm_mpidr;
+	u8 efficiency_class;
+	u8 reserved2[3];
 };
 
 /* Masks for Flags field above */
@@ -819,7 +822,7 @@ struct acpi_madt_generic_interrupt {
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
 
-/* 12: Generic Distributor (ACPI 5.0) */
+/* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
 struct acpi_madt_generic_distributor {
 	struct acpi_subtable_header header;
@@ -827,7 +830,8 @@ struct acpi_madt_generic_distributor {
 	u32 gic_id;
 	u64 base_address;
 	u32 global_irq_base;
-	u32 reserved2;		/* reserved - must be zero */
+	u8 version;
+	u8 reserved2[3];	/* reserved - must be zero */
 };
 
 /* 13: Generic MSI Frame (ACPI 5.1) */
@@ -855,6 +859,16 @@ struct acpi_madt_generic_redistributor {
 	u32 length;
 };
 
+/* 15: Generic Translator (ACPI 6.0) */
+
+struct acpi_madt_generic_translator {
+	struct acpi_subtable_header header;
+	u16 reserved;		/* reserved - must be zero */
+	u32 translation_id;
+	u64 base_address;
+	u32 reserved2;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
1.7.10
