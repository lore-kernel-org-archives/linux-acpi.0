From: Len Brown <lenb@kernel.org>
Subject: [PATCH 58/140] ACPICA: Add support for DMAR table
Date: Wed,  7 Feb 2007 13:51:12 -0500
Message-ID: <11708744562243-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:6145 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422782AbXBGSyT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:19 -0500
In-Reply-To: <11708744542419-git-send-email-lenb@kernel.org>
Message-Id: <2502fffb1958da66fa50a475081cb6827acdd9f3.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
@@ -147,6 +148,11 @@ extern struct acpi_dmtable_info acpi_dm_table_info_boot[];
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
@@ -201,6 +207,8 @@ void acpi_dm_dump_asf(struct acpi_table_header *table);
 
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
1.5.0.rc3.39.gec804
