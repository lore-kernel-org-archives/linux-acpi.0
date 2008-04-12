From: Len Brown <lenb@kernel.org>
Subject: [PATCH 52/73] ACPICA: Include file support for new ACPI tables
Date: Sat, 12 Apr 2008 00:25:35 -0400
Message-ID: <77045adabc1f42332489977202d7fc79d168c9a9.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:11821 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753480AbYDLE2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:11 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented header file support for new ACPI tables - BERT, ERST,
EINJ, HEST, IBFT, UEFI, WDAT. Disassembler support is forthcoming.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/actbl1.h |  335 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 334 insertions(+), 1 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index dd8e11e..5d39992 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -58,12 +58,17 @@
  * it more difficult to inadvertently type in the wrong signature.
  */
 #define ACPI_SIG_ASF            "ASF!"	/* Alert Standard Format table */
+#define ACPI_SIG_BERT           "BERT"	/* Boot Error Record Table */
 #define ACPI_SIG_BOOT           "BOOT"	/* Simple Boot Flag Table */
 #define ACPI_SIG_CPEP           "CPEP"	/* Corrected Platform Error Polling table */
 #define ACPI_SIG_DBGP           "DBGP"	/* Debug Port table */
 #define ACPI_SIG_DMAR           "DMAR"	/* DMA Remapping table */
 #define ACPI_SIG_ECDT           "ECDT"	/* Embedded Controller Boot Resources Table */
+#define ACPI_SIG_EINJ           "EINJ"	/* Error Injection table */
+#define ACPI_SIG_ERST           "ERST"	/* Error Record Serialization Table */
+#define ACPI_SIG_HEST           "HEST"	/* Hardware Error Source Table */
 #define ACPI_SIG_HPET           "HPET"	/* High Precision Event Timer table */
+#define ACPI_SIG_IBFT           "IBFT"	/* i_sCSI Boot Firmware Table */
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
 #define ACPI_SIG_MCFG           "MCFG"	/* PCI Memory Mapped Configuration table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
@@ -73,6 +78,8 @@
 #define ACPI_SIG_SPMI           "SPMI"	/* Server Platform Management Interface table */
 #define ACPI_SIG_SRAT           "SRAT"	/* System Resource Affinity Table */
 #define ACPI_SIG_TCPA           "TCPA"	/* Trusted Computing Platform Alliance table */
+#define ACPI_SIG_UEFI           "UEFI"	/* Uefi Boot Optimization Table */
+#define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDRT           "WDRT"	/* Watchdog Resource Table */
 
 /*
@@ -87,13 +94,25 @@
  * portable, so do not use any other bitfield types.
  */
 
-/* Common Sub-table header (used in MADT, SRAT, etc.) */
+/* Common Subtable header (used in MADT, SRAT, etc.) */
 
 struct acpi_subtable_header {
 	u8 type;
 	u8 length;
 };
 
+/* Common Subtable header for WHEA tables (EINJ, ERST, WDAT) */
+
+struct acpi_whea_header {
+	u8 action;
+	u8 instruction;
+	u8 flags;
+	u8 reserved;
+	struct acpi_generic_address register_region;
+	u32 value;		/* Value used with Read/Write register */
+	u32 mask;		/* Bitmask required for this register instruction */
+};
+
 /*******************************************************************************
  *
  * ASF - Alert Standard Format table (Signature "ASF!")
@@ -205,6 +224,34 @@ struct acpi_asf_address {
 
 /*******************************************************************************
  *
+ * BERT - Boot Error Record Table
+ *
+ ******************************************************************************/
+
+struct acpi_table_bert {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 region_length;	/* Length of the boot error region */
+	u64 address;		/* Physical addresss of the error region */
+};
+
+struct acpi_bert_region {
+	u32 block_status;
+	u32 raw_data_offset;
+	u32 raw_data_length;
+	u32 data_length;
+	u32 error_severity;
+	u8 error_data[1];
+};
+
+/* block_status Flags */
+
+#define ACPI_BERT_UNCORRECTABLE             (1)
+#define ACPI_BERT_CORRECTABLE               (2)
+#define ACPI_BERT_MULTIPLE_UNCORRECTABLE    (4)
+#define ACPI_BERT_MULTIPLE_CORRECTABLE      (8)
+
+/*******************************************************************************
+ *
  * BOOT - Simple Boot Flag Table
  *
  ******************************************************************************/
@@ -351,6 +398,130 @@ struct acpi_table_ecdt {
 
 /*******************************************************************************
  *
+ * EINJ - Error Injection Table
+ *
+ ******************************************************************************/
+
+struct acpi_table_einj {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 header_length;
+	u32 reserved;
+	u32 entries;
+};
+
+/* EINJ Injection Instruction Entries (actions) */
+
+struct acpi_einj_entry {
+	struct acpi_whea_header whea_header;	/* Common header for WHEA tables */
+};
+
+/* Values for Action field above */
+
+enum acpi_einj_actions {
+	ACPI_EINJ_BEGIN_OPERATION = 0,
+	ACPI_EINJ_GET_TRIGGER_TABLE = 1,
+	ACPI_EINJ_SET_ERROR_TYPE = 2,
+	ACPI_EINJ_GET_ERROR_TYPE = 3,
+	ACPI_EINJ_END_OPERATION = 4,
+	ACPI_EINJ_EXECUTE_OPERATION = 5,
+	ACPI_EINJ_CHECK_BUSY_STATUS = 6,
+	ACPI_EINJ_GET_COMMAND_STATUS = 7,
+	ACPI_EINJ_ACTION_RESERVED = 8,	/* 8 and greater are reserved */
+	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
+};
+
+/* Values for Instruction field above */
+
+enum acpi_einj_instructions {
+	ACPI_EINJ_READ_REGISTER = 0,
+	ACPI_EINJ_READ_REGISTER_VALUE = 1,
+	ACPI_EINJ_WRITE_REGISTER = 2,
+	ACPI_EINJ_WRITE_REGISTER_VALUE = 3,
+	ACPI_EINJ_NOOP = 4,
+	ACPI_EINJ_INSTRUCTION_RESERVED = 5	/* 5 and greater are reserved */
+};
+
+/*******************************************************************************
+ *
+ * ERST - Error Record Serialization Table
+ *
+ ******************************************************************************/
+
+struct acpi_table_erst {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 header_length;
+	u32 reserved;
+	u32 entries;
+};
+
+/* ERST Serialization Entries (actions) */
+
+struct acpi_erst_entry {
+	struct acpi_whea_header whea_header;	/* Common header for WHEA tables */
+};
+
+/* Values for Action field above */
+
+enum acpi_erst_actions {
+	ACPI_ERST_BEGIN_WRITE_OPERATION = 0,
+	ACPI_ERST_BEGIN_READ_OPERATION = 1,
+	ACPI_ERST_BETGIN_CLEAR_OPERATION = 2,
+	ACPI_ERST_END_OPERATION = 3,
+	ACPI_ERST_SET_RECORD_OFFSET = 4,
+	ACPI_ERST_EXECUTE_OPERATION = 5,
+	ACPI_ERST_CHECK_BUSY_STATUS = 6,
+	ACPI_ERST_GET_COMMAND_STATUS = 7,
+	ACPI_ERST_GET_RECORD_IDENTIFIER = 8,
+	ACPI_ERST_SET_RECORD_IDENTIFIER = 9,
+	ACPI_ERST_GET_RECORD_COUNT = 10,
+	ACPI_ERST_BEGIN_DUMMY_WRIITE = 11,
+	ACPI_ERST_NOT_USED = 12,
+	ACPI_ERST_GET_ERROR_RANGE = 13,
+	ACPI_ERST_GET_ERROR_LENGTH = 14,
+	ACPI_ERST_GET_ERROR_ATTRIBUTES = 15,
+	ACPI_ERST_ACTION_RESERVED = 16	/* 16 and greater are reserved */
+};
+
+/* Values for Instruction field above */
+
+enum acpi_erst_instructions {
+	ACPI_ERST_READ_REGISTER = 0,
+	ACPI_ERST_READ_REGISTER_VALUE = 1,
+	ACPI_ERST_WRITE_REGISTER = 2,
+	ACPI_ERST_WRITE_REGISTER_VALUE = 3,
+	ACPI_ERST_NOOP = 4,
+	ACPI_ERST_LOAD_VAR1 = 5,
+	ACPI_ERST_LOAD_VAR2 = 6,
+	ACPI_ERST_STORE_VAR1 = 7,
+	ACPI_ERST_ADD = 8,
+	ACPI_ERST_SUBTRACT = 9,
+	ACPI_ERST_ADD_VALUE = 10,
+	ACPI_ERST_SUBTRACT_VALUE = 11,
+	ACPI_ERST_STALL = 12,
+	ACPI_ERST_STALL_WHILE_TRUE = 13,
+	ACPI_ERST_SKIP_NEXT_IF_TRUE = 14,
+	ACPI_ERST_GOTO = 15,
+	ACPI_ERST_SET_SRC_ADDRESS_BASE = 16,
+	ACPI_ERST_SET_DST_ADDRESS_BASE = 17,
+	ACPI_ERST_MOVE_DATA = 18,
+	ACPI_ERST_INSTRUCTION_RESERVED = 19	/* 19 and greater are reserved */
+};
+
+/*******************************************************************************
+ *
+ * HEST - Hardware Error Source Table
+ *
+ ******************************************************************************/
+
+struct acpi_table_hest {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 error_source_count;
+};
+
+/* TBD: Need Error Source Descriptor layout */
+
+/*******************************************************************************
+ *
  * HPET - High Precision Event Timer table
  *
  ******************************************************************************/
@@ -374,6 +545,96 @@ struct acpi_table_hpet {
 
 /*******************************************************************************
  *
+ * IBFT - i_sCSI Boot Firmware Table
+ *
+ ******************************************************************************/
+
+struct acpi_table_ibft {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 reserved[12];
+};
+
+/* IBFT common subtable header */
+
+struct acpi_ibft_header {
+	u8 type;
+	u8 version;
+	u16 length;
+	u8 index;
+	u8 flags;
+};
+
+/* Values for Type field above */
+
+enum acpi_ibft_type {
+	ACPI_IBFT_TYPE_NOT_USED = 0,
+	ACPI_IBFT_TYPE_CONTROL = 1,
+	ACPI_IBFT_TYPE_INITIATOR = 2,
+	ACPI_IBFT_TYPE_NIC = 3,
+	ACPI_IBFT_TYPE_TARGET = 4,
+	ACPI_IBFT_TYPE_EXTENSIONS = 5,
+	ACPI_IBFT_TYPE_RESERVED = 6	/* 6 and greater are reserved */
+};
+
+/* IBFT subtables */
+
+struct acpi_ibft_control {
+	struct acpi_ibft_header header;
+	u16 extensions;
+	u16 initiator_offset;
+	u16 nic0_offset;
+	u16 target0_offset;
+	u16 nic1_offset;
+	u16 target1_offset;
+};
+
+struct acpi_ibft_initiator {
+	struct acpi_ibft_header header;
+	u8 sns_server[16];
+	u8 slp_server[16];
+	u8 primary_server[16];
+	u8 secondary_server[16];
+	u16 name_length;
+	u16 name_offset;
+};
+
+struct acpi_ibft_nic {
+	struct acpi_ibft_header header;
+	u8 ip_address[16];
+	u8 subnet_mask_prefix;
+	u8 origin;
+	u8 gateway[16];
+	u8 primary_dns[16];
+	u8 secondary_dns[16];
+	u8 dhcp[16];
+	u16 vlan;
+	u8 mac_address[6];
+	u16 pci_address;
+	u16 name_length;
+	u16 name_offset;
+};
+
+struct acpi_ibft_target {
+	struct acpi_ibft_header header;
+	u8 target_ip_address[16];
+	u16 target_ip_socket;
+	u8 target_boot_lun[8];
+	u8 chap_type;
+	u8 nic_association;
+	u16 target_name_length;
+	u16 target_name_offset;
+	u16 chap_name_length;
+	u16 chap_name_offset;
+	u16 chap_secret_length;
+	u16 chap_secret_offset;
+	u16 reverse_chap_name_length;
+	u16 reverse_chap_name_offset;
+	u16 reverse_chap_secret_length;
+	u16 reverse_chap_secret_offset;
+};
+
+/*******************************************************************************
+ *
  * MADT - Multiple APIC Description Table
  *
  ******************************************************************************/
@@ -698,6 +959,78 @@ struct acpi_table_tcpa {
 
 /*******************************************************************************
  *
+ * UEFI - UEFI Boot optimization Table
+ *
+ ******************************************************************************/
+
+struct acpi_table_uefi {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 identifier[16];	/* UUID identifier */
+	u16 data_offset;	/* Offset of remaining data in table */
+	u8 data;
+};
+
+/*******************************************************************************
+ *
+ * WDAT - Watchdog Action Table
+ *
+ ******************************************************************************/
+
+struct acpi_table_wdat {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 header_length;	/* Watchdog Header Length */
+	u16 pci_segment;	/* PCI Segment number */
+	u8 pci_bus;		/* PCI Bus number */
+	u8 pci_device;		/* PCI Device number */
+	u8 pci_function;	/* PCI Function number */
+	u8 reserved[3];
+	u32 timer_period;	/* Period of one timer count (msec) */
+	u32 max_count;		/* Maximum counter value supported */
+	u32 min_count;		/* Minimum counter value */
+	u8 flags;
+	u8 reserved2[3];
+	u32 entries;		/* Number of watchdog entries that follow */
+};
+
+/* WDAT Instruction Entries (actions) */
+
+struct acpi_wdat_entry {
+	struct acpi_whea_header whea_header;	/* Common header for WHEA tables */
+};
+
+/* Values for Action field above */
+
+enum acpi_wdat_actions {
+	ACPI_WDAT_RESET = 1,
+	ACPI_WDAT_GET_CURRENT_COUNTDOWN = 4,
+	ACPI_WDAT_GET_COUNTDOWN = 5,
+	ACPI_WDAT_SET_COUNTDOWN = 6,
+	ACPI_WDAT_GET_RUNNING_STATE = 8,
+	ACPI_WDAT_SET_RUNNING_STATE = 9,
+	ACPI_WDAT_GET_STOPPED_STATE = 10,
+	ACPI_WDAT_SET_STOPPED_STATE = 11,
+	ACPI_WDAT_GET_REBOOT = 16,
+	ACPI_WDAT_SET_REBOOT = 17,
+	ACPI_WDAT_GET_SHUTDOWN = 18,
+	ACPI_WDAT_SET_SHUTDOWN = 19,
+	ACPI_WDAT_GET_STATUS = 32,
+	ACPI_WDAT_SET_STATUS = 33,
+	ACPI_WDAT_ACTION_RESERVED = 34	/* 34 and greater are reserved */
+};
+
+/* Values for Instruction field above */
+
+enum acpi_wdat_instructions {
+	ACPI_WDAT_READ_VALUE = 0,
+	ACPI_WDAT_READ_COUNTDOWN = 1,
+	ACPI_WDAT_WRITE_VALUE = 2,
+	ACPI_WDAT_WRITE_COUNTDOWN = 3,
+	ACPI_WDAT_INSTRUCTION_RESERVED = 4,	/* 4 and greater are reserved */
+	ACPI_WDAT_PRESERVE_REGISTER = 0x80	/* Except for this value */
+};
+
+/*******************************************************************************
+ *
  * WDRT - Watchdog Resource Table
  *
  ******************************************************************************/
-- 
1.5.5.29.g7134

