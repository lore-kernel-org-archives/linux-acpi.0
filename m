From: Len Brown <lenb@kernel.org>
Subject: [PATCH 59/73] ACPICA: Disassembler support for new ACPI tables
Date: Sat, 12 Apr 2008 00:25:42 -0400
Message-ID: <48e71ecf042acf8049b1b872bd765f14b4643645.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20142 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754069AbYDLE2P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:15 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented full disassembler support for the following new ACPI
tables: BERT, EINJ, and ERST. Partial disassembler support for
the complicated HEST table. These tables support the Windows
Hardware Error Architecture (WHEA).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acdisasm.h |   26 ++++-
 include/acpi/actbl1.h   |  233 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 249 insertions(+), 10 deletions(-)

diff --git a/include/acpi/acdisasm.h b/include/acpi/acdisasm.h
index 07d5241..73d86eb 100644
--- a/include/acpi/acdisasm.h
+++ b/include/acpi/acdisasm.h
@@ -99,10 +99,13 @@ typedef const struct acpi_dmtable_info {
 #define ACPI_DMT_GAS                    22
 #define ACPI_DMT_ASF                    23
 #define ACPI_DMT_DMAR                   24
-#define ACPI_DMT_MADT                   25
-#define ACPI_DMT_SRAT                   26
-#define ACPI_DMT_EXIT                   27
-#define ACPI_DMT_SIG                    28
+#define ACPI_DMT_HEST                   25
+#define ACPI_DMT_HESTNTFY               26
+#define ACPI_DMT_HESTNTYP               27
+#define ACPI_DMT_MADT                   28
+#define ACPI_DMT_SRAT                   29
+#define ACPI_DMT_EXIT                   30
+#define ACPI_DMT_SIG                    31
 
 typedef
 void (*acpi_dmtable_handler) (struct acpi_table_header * table);
@@ -150,6 +153,7 @@ extern struct acpi_dmtable_info acpi_dm_table_info_asf3[];
 extern struct acpi_dmtable_info acpi_dm_table_info_asf4[];
 extern struct acpi_dmtable_info acpi_dm_table_info_asf_hdr[];
 extern struct acpi_dmtable_info acpi_dm_table_info_boot[];
+extern struct acpi_dmtable_info acpi_dm_table_info_bert[];
 extern struct acpi_dmtable_info acpi_dm_table_info_cpep[];
 extern struct acpi_dmtable_info acpi_dm_table_info_cpep0[];
 extern struct acpi_dmtable_info acpi_dm_table_info_dbgp[];
@@ -159,11 +163,17 @@ extern struct acpi_dmtable_info acpi_dm_table_info_dmar_scope[];
 extern struct acpi_dmtable_info acpi_dm_table_info_dmar0[];
 extern struct acpi_dmtable_info acpi_dm_table_info_dmar1[];
 extern struct acpi_dmtable_info acpi_dm_table_info_ecdt[];
+extern struct acpi_dmtable_info acpi_dm_table_info_einj[];
+extern struct acpi_dmtable_info acpi_dm_table_info_einj0[];
+extern struct acpi_dmtable_info acpi_dm_table_info_erst[];
 extern struct acpi_dmtable_info acpi_dm_table_info_facs[];
 extern struct acpi_dmtable_info acpi_dm_table_info_fadt1[];
 extern struct acpi_dmtable_info acpi_dm_table_info_fadt2[];
 extern struct acpi_dmtable_info acpi_dm_table_info_gas[];
 extern struct acpi_dmtable_info acpi_dm_table_info_header[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest9[];
+extern struct acpi_dmtable_info acpi_dm_table_info_hest_notify[];
 extern struct acpi_dmtable_info acpi_dm_table_info_hpet[];
 extern struct acpi_dmtable_info acpi_dm_table_info_madt[];
 extern struct acpi_dmtable_info acpi_dm_table_info_madt0[];
@@ -215,9 +225,13 @@ void acpi_dm_dump_cpep(struct acpi_table_header *table);
 
 void acpi_dm_dump_dmar(struct acpi_table_header *table);
 
+void acpi_dm_dump_einj(struct acpi_table_header *table);
+
+void acpi_dm_dump_erst(struct acpi_table_header *table);
+
 void acpi_dm_dump_fadt(struct acpi_table_header *table);
 
-void acpi_dm_dump_srat(struct acpi_table_header *table);
+void acpi_dm_dump_hest(struct acpi_table_header *table);
 
 void acpi_dm_dump_mcfg(struct acpi_table_header *table);
 
@@ -229,6 +243,8 @@ void acpi_dm_dump_rsdt(struct acpi_table_header *table);
 
 void acpi_dm_dump_slit(struct acpi_table_header *table);
 
+void acpi_dm_dump_srat(struct acpi_table_header *table);
+
 void acpi_dm_dump_xsdt(struct acpi_table_header *table);
 
 /*
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 5d39992..604dfb3 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -109,8 +109,8 @@ struct acpi_whea_header {
 	u8 flags;
 	u8 reserved;
 	struct acpi_generic_address register_region;
-	u32 value;		/* Value used with Read/Write register */
-	u32 mask;		/* Bitmask required for this register instruction */
+	u64 value;		/* Value used with Read/Write register */
+	u64 mask;		/* Bitmask required for this register instruction */
 };
 
 /*******************************************************************************
@@ -234,13 +234,14 @@ struct acpi_table_bert {
 	u64 address;		/* Physical addresss of the error region */
 };
 
+/* Boot Error Region */
+
 struct acpi_bert_region {
 	u32 block_status;
 	u32 raw_data_offset;
 	u32 raw_data_length;
 	u32 data_length;
 	u32 error_severity;
-	u8 error_data[1];
 };
 
 /* block_status Flags */
@@ -441,6 +442,15 @@ enum acpi_einj_instructions {
 	ACPI_EINJ_INSTRUCTION_RESERVED = 5	/* 5 and greater are reserved */
 };
 
+/* EINJ Trigger Error Action Table */
+
+struct acpi_einj_trigger {
+	u32 header_size;
+	u32 revision;
+	u32 table_size;
+	u32 entry_count;
+};
+
 /*******************************************************************************
  *
  * ERST - Error Record Serialization Table
@@ -518,7 +528,220 @@ struct acpi_table_hest {
 	u32 error_source_count;
 };
 
-/* TBD: Need Error Source Descriptor layout */
+/* HEST subtable header */
+
+struct acpi_hest_header {
+	u16 type;
+};
+
+/* Values for Type field above for subtables */
+
+enum acpi_hest_types {
+	ACPI_HEST_TYPE_XPF_MACHINE_CHECK = 0,
+	ACPI_HEST_TYPE_XPF_CORRECTED_MACHINE_CHECK = 1,
+	ACPI_HEST_TYPE_XPF_UNUSED = 2,
+	ACPI_HEST_TYPE_XPF_NON_MASKABLE_INTERRUPT = 3,
+	ACPI_HEST_TYPE_IPF_CORRECTED_MACHINE_CHECK = 4,
+	ACPI_HEST_TYPE_IPF_CORRECTED_PLATFORM_ERROR = 5,
+	ACPI_HEST_TYPE_AER_ROOT_PORT = 6,
+	ACPI_HEST_TYPE_AER_ENDPOINT = 7,
+	ACPI_HEST_TYPE_AER_BRIDGE = 8,
+	ACPI_HEST_TYPE_GENERIC_HARDWARE_ERROR_SOURCE = 9,
+	ACPI_HEST_TYPE_RESERVED = 10	/* 10 and greater are reserved */
+};
+
+/*
+ * HEST Sub-subtables
+ */
+
+/* XPF Machine Check Error Bank */
+
+struct acpi_hest_xpf_error_bank {
+	u8 bank_number;
+	u8 clear_status_on_init;
+	u8 status_format;
+	u8 config_write_enable;
+	u32 control_register;
+	u64 control_init_data;
+	u32 status_register;
+	u32 address_register;
+	u32 misc_register;
+};
+
+/* Generic Error Status */
+
+struct acpi_hest_generic_status {
+	u32 block_status;
+	u32 raw_data_offset;
+	u32 raw_data_length;
+	u32 data_length;
+	u32 error_severity;
+};
+
+/* Generic Error Data */
+
+struct acpi_hest_generic_data {
+	u8 section_type[16];
+	u32 error_severity;
+	u16 revision;
+	u8 validation_bits;
+	u8 flags;
+	u32 error_data_length;
+	u8 fru_id[16];
+	u8 fru_text[20];
+};
+
+/* Common HEST structure for PCI/AER types below (6,7,8) */
+
+struct acpi_hest_aer_common {
+	u16 source_id;
+	u16 config_write_enable;
+	u8 flags;
+	u8 enabled;
+	u32 records_to_pre_allocate;
+	u32 max_sections_per_record;
+	u32 bus;
+	u16 device;
+	u16 function;
+	u16 device_control;
+	u16 reserved;
+	u32 uncorrectable_error_mask;
+	u32 uncorrectable_error_severity;
+	u32 correctable_error_mask;
+	u32 advanced_error_cababilities;
+};
+
+/* Hardware Error Notification */
+
+struct acpi_hest_notify {
+	u8 type;
+	u8 length;
+	u16 config_write_enable;
+	u32 poll_interval;
+	u32 vector;
+	u32 polling_threshold_value;
+	u32 polling_threshold_window;
+	u32 error_threshold_value;
+	u32 error_threshold_window;
+};
+
+/* Values for Notify Type field above */
+
+enum acpi_hest_notify_types {
+	ACPI_HEST_NOTIFY_POLLED = 0,
+	ACPI_HEST_NOTIFY_EXTERNAL = 1,
+	ACPI_HEST_NOTIFY_LOCAL = 2,
+	ACPI_HEST_NOTIFY_SCI = 3,
+	ACPI_HEST_NOTIFY_NMI = 4,
+	ACPI_HEST_NOTIFY_RESERVED = 5	/* 5 and greater are reserved */
+};
+
+/*
+ * HEST subtables
+ *
+ * From WHEA Design Document, 16 May 2007.
+ * Note: There is no subtable type 2 in this version of the document,
+ * and there are two different subtable type 3s.
+ */
+
+ /* 0: XPF Machine Check Exception */
+
+struct acpi_hest_xpf_machine_check {
+	struct acpi_hest_header header;
+	u16 source_id;
+	u16 config_write_enable;
+	u8 flags;
+	u8 reserved1;
+	u32 records_to_pre_allocate;
+	u32 max_sections_per_record;
+	u64 global_capability_data;
+	u64 global_control_data;
+	u8 num_hardware_banks;
+	u8 reserved2[7];
+};
+
+/* 1: XPF Corrected Machine Check */
+
+struct acpi_table_hest_xpf_corrected {
+	struct acpi_hest_header header;
+	u16 source_id;
+	u16 config_write_enable;
+	u8 flags;
+	u8 enabled;
+	u32 records_to_pre_allocate;
+	u32 max_sections_per_record;
+	struct acpi_hest_notify notify;
+	u8 num_hardware_banks;
+	u8 reserved[3];
+};
+
+/* 3: XPF Non-Maskable Interrupt */
+
+struct acpi_hest_xpf_nmi {
+	struct acpi_hest_header header;
+	u16 source_id;
+	u32 reserved;
+	u32 records_to_pre_allocate;
+	u32 max_sections_per_record;
+	u32 max_raw_data_length;
+};
+
+/* 4: IPF Corrected Machine Check */
+
+struct acpi_hest_ipf_corrected {
+	struct acpi_hest_header header;
+	u8 enabled;
+	u8 reserved;
+};
+
+/* 5: IPF Corrected Platform Error */
+
+struct acpi_hest_ipf_corrected_platform {
+	struct acpi_hest_header header;
+	u8 enabled;
+	u8 reserved;
+};
+
+/* 6: PCI Express Root Port AER */
+
+struct acpi_hest_aer_root {
+	struct acpi_hest_header header;
+	struct acpi_hest_aer_common aer;
+	u32 root_error_command;
+};
+
+/* 7: PCI Express AER (AER Endpoint) */
+
+struct acpi_hest_aer {
+	struct acpi_hest_header header;
+	struct acpi_hest_aer_common aer;
+};
+
+/* 8: PCI Express/PCI-X Bridge AER */
+
+struct acpi_hest_aer_bridge {
+	struct acpi_hest_header header;
+	struct acpi_hest_aer_common aer;
+	u32 secondary_uncorrectable_error_mask;
+	u32 secondary_uncorrectable_error_severity;
+	u32 secondary_advanced_capabilities;
+};
+
+/* 9: Generic Hardware Error Source */
+
+struct acpi_hest_generic {
+	struct acpi_hest_header header;
+	u16 source_id;
+	u16 related_source_id;
+	u8 config_write_enable;
+	u8 enabled;
+	u32 records_to_pre_allocate;
+	u32 max_sections_per_record;
+	u32 max_raw_data_length;
+	struct acpi_generic_address error_status_address;
+	struct acpi_hest_notify notify;
+	u32 error_status_block_length;
+};
 
 /*******************************************************************************
  *
@@ -545,7 +768,7 @@ struct acpi_table_hpet {
 
 /*******************************************************************************
  *
- * IBFT - i_sCSI Boot Firmware Table
+ * IBFT - Boot Firmware Table
  *
  ******************************************************************************/
 
-- 
1.5.5.29.g7134

