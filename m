From: Len Brown <len.brown@intel.com>
Subject: [PATCH 17/65] ACPICA: Add support for DMAR table
Date: Fri, 24 Nov 2006 02:18:27 -0500
Message-ID: <11643527782767-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:3478 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757619AbWKXHPm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:42 -0500
In-Reply-To: <1164352776767-git-send-email-len.brown@intel.com>
Message-Id: <9e50272927495c4480e6476b686d1960b804c5ad.1164352293.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Implement support for ACPI DMAR table (DMA
Remapping Table) in header files and disassembler.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acdisasm.h |   14 +++++++--
 include/acpi/actbl1.h   |   73 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acdisasm.h b/include/acpi/acdisasm.h
index 9a7d692..722583a 100644
--- a/include/acpi/acdisasm.h
+++ b/include/acpi/acdisasm.h
@@ -97,9 +97,10 @@ typedef const struct acpi_dmtable_info {
 #define ACPI_DMT_CHKSUM                 20
 #define ACPI_DMT_SPACEID                21
 #define ACPI_DMT_GAS                    22
-#define ACPI_DMT_MADT                   23
-#define ACPI_DMT_SRAT                   24
-#define ACPI_DMT_EXIT                   25
+#define ACPI_DMT_DMAR                   23
+#define ACPI_DMT_MADT                   24
+#define ACPI_DMT_SRAT                   25
+#define ACPI_DMT_EXIT                   26
 
 typedef
 void (*ACPI_TABLE_HANDLER) (struct acpi_table_header * table);
@@ -147,6 +148,11 @@ extern struct acpi_dmtable_info acpi_dm_
 extern struct acpi_dmtable_info acpi_dm_table_info_cpep[];
 extern struct acpi_dmtable_info acpi_dm_table_info_cpep0[];
 extern struct acpi_dmtable_info acpi_dm_table_info_dbgp[];
+extern struct acpi_dmtable_info acpi_dm_table_info_dmar[];
+extern struct acpi_dmtable_info acpi_dm_table_info_dmar_hdr[];
+extern struct acpi_dmtable_info acpi_dm_table_info_dmar_scope[];
+extern struct acpi_dmtable_info acpi_dm_table_info_dmar0[];
+extern struct acpi_dmtable_info acpi_dm_table_info_dmar1[];
 extern struct acpi_dmtable_info acpi_dm_table_info_ecdt[];
 extern struct acpi_dmtable_info acpi_dm_table_info_facs[];
 extern struct acpi_dmtable_info acpi_dm_table_info_fadt1[];
@@ -201,6 +207,8 @@ void acpi_dm_dump_asf(struct acpi_table_
 
 void acpi_dm_dump_cpep(struct acpi_table_header *table);
 
+void acpi_dm_dump_dmar(struct acpi_table_header *table);
+
 void acpi_dm_dump_fadt(struct acpi_table_header *table);
 
 void acpi_dm_dump_srat(struct acpi_table_header *table);
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8ae30b7..515d82c 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -61,6 +61,7 @@
 #define ACPI_SIG_BOOT           "BOOT"	/* Simple Boot Flag Table */
 #define ACPI_SIG_CPEP           "CPEP"	/* Corrected Platform Error Polling table */
 #define ACPI_SIG_DBGP           "DBGP"	/* Debug Port table */
+#define ACPI_SIG_DMAR           "DMAR"	/* DMA Remapping table */
 #define ACPI_SIG_ECDT           "ECDT"	/* Embedded Controller Boot Resources Table */
 #define ACPI_SIG_HPET           "HPET"	/* High Precision Event Timer table */
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
@@ -228,6 +229,78 @@ struct acpi_table_dbgp {
 
 /*******************************************************************************
  *
+ * DMAR - DMA Remapping table
+ *
+ ******************************************************************************/
+
+struct acpi_table_dmar {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 width;		/* Host Address Width */
+	u8 reserved[11];
+};
+
+/* DMAR subtable header */
+
+struct acpi_dmar_header {
+	u16 type;
+	u16 length;
+	u8 flags;
+	u8 reserved[3];
+};
+
+/* Values for subtable type in struct acpi_dmar_header */
+
+enum acpi_dmar_type {
+	ACPI_DMAR_TYPE_HARDWARE_UNIT = 0,
+	ACPI_DMAR_TYPE_RESERVED_MEMORY = 1,
+	ACPI_DMAR_TYPE_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+struct acpi_dmar_device_scope {
+	u8 entry_type;
+	u8 length;
+	u8 segment;
+	u8 bus;
+};
+
+/* Values for entry_type in struct acpi_dmar_device_scope */
+
+enum acpi_dmar_scope_type {
+	ACPI_DMAR_SCOPE_TYPE_NOT_USED = 0,
+	ACPI_DMAR_SCOPE_TYPE_ENDPOINT = 1,
+	ACPI_DMAR_SCOPE_TYPE_BRIDGE = 2,
+	ACPI_DMAR_SCOPE_TYPE_RESERVED = 3	/* 3 and greater are reserved */
+};
+
+/*
+ * DMAR Sub-tables, correspond to Type in struct acpi_dmar_header
+ */
+
+/* 0: Hardware Unit Definition */
+
+struct acpi_dmar_hardware_unit {
+	struct acpi_dmar_header header;
+	u64 address;		/* Register Base Address */
+};
+
+/* Flags */
+
+#define ACPI_DMAR_INCLUDE_ALL       (1)
+
+/* 1: Reserved Memory Defininition */
+
+struct acpi_dmar_reserved_memory {
+	struct acpi_dmar_header header;
+	u64 address;		/* 4_k aligned base address */
+	u64 end_address;	/* 4_k aligned limit address */
+};
+
+/* Flags */
+
+#define ACPI_DMAR_ALLOW_ALL         (1)
+
+/*******************************************************************************
+ *
  * ECDT - Embedded Controller Boot Resources Table
  *
  ******************************************************************************/
-- 
1.4.4.1
