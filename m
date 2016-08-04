From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/30] ACPICA: FADT support cleanup
Date: Thu,  4 Aug 2016 16:43:58 +0800
Message-ID: <9491f1a8bc67c360eb8cb0bbafe5697966c7e41f.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2930 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757209AbcHDIoo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:44:44 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 34ccd43af3fd1870fddfac0617dd0ba706963558

Remove all vestiges of the version 2 FADT which never was included
in the ACPI specification.
This enabled significant cleanup of both the data table compiler
and the disassembler.
Added many clarification comments to associate each FADT version
with the version of the ACPI spec where it was originally
defined.

Link: https://github.com/acpica/acpica/commit/34ccd43a
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |   10 +--
 include/acpi/actbl.h         |  164 ++++++++++++++++++++++++------------------
 2 files changed, 100 insertions(+), 74 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 6208069..016bcdc 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -476,17 +476,19 @@ static void acpi_tb_convert_fadt(void)
 	u32 i;
 
 	/*
-	 * For ACPI 1.0 FADTs (revision 1 or 2), ensure that reserved fields which
+	 * For ACPI 1.0 FADTs (revision 1), ensure that reserved fields which
 	 * should be zero are indeed zero. This will workaround BIOSs that
 	 * inadvertently place values in these fields.
 	 *
 	 * The ACPI 1.0 reserved fields that will be zeroed are the bytes located
 	 * at offset 45, 55, 95, and the word located at offset 109, 110.
 	 *
-	 * Note: The FADT revision value is unreliable. Only the length can be
-	 * trusted.
+	 * Note: The FADT revision value is unreliable because of BIOS errors.
+	 * The table length is instead used as the final word on the version.
+	 *
+	 * Note: FADT revision 3 is the ACPI 2.0 version of the FADT.
 	 */
-	if (acpi_gbl_FADT.header.length <= ACPI_FADT_V2_SIZE) {
+	if (acpi_gbl_FADT.header.length <= ACPI_FADT_V3_SIZE) {
 		acpi_gbl_FADT.preferred_profile = 0;
 		acpi_gbl_FADT.pstate_control = 0;
 		acpi_gbl_FADT.cst_control = 0;
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index c19700e..1b949e0 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -230,62 +230,72 @@ struct acpi_table_facs {
 /* Fields common to all versions of the FADT */
 
 struct acpi_table_fadt {
-	struct acpi_table_header header;	/* Common ACPI table header */
-	u32 facs;		/* 32-bit physical address of FACS */
-	u32 dsdt;		/* 32-bit physical address of DSDT */
-	u8 model;		/* System Interrupt Model (ACPI 1.0) - not used in ACPI 2.0+ */
-	u8 preferred_profile;	/* Conveys preferred power management profile to OSPM. */
-	u16 sci_interrupt;	/* System vector of SCI interrupt */
-	u32 smi_command;	/* 32-bit Port address of SMI command port */
-	u8 acpi_enable;		/* Value to write to SMI_CMD to enable ACPI */
-	u8 acpi_disable;	/* Value to write to SMI_CMD to disable ACPI */
-	u8 s4_bios_request;	/* Value to write to SMI_CMD to enter S4BIOS state */
-	u8 pstate_control;	/* Processor performance state control */
-	u32 pm1a_event_block;	/* 32-bit port address of Power Mgt 1a Event Reg Blk */
-	u32 pm1b_event_block;	/* 32-bit port address of Power Mgt 1b Event Reg Blk */
-	u32 pm1a_control_block;	/* 32-bit port address of Power Mgt 1a Control Reg Blk */
-	u32 pm1b_control_block;	/* 32-bit port address of Power Mgt 1b Control Reg Blk */
-	u32 pm2_control_block;	/* 32-bit port address of Power Mgt 2 Control Reg Blk */
-	u32 pm_timer_block;	/* 32-bit port address of Power Mgt Timer Ctrl Reg Blk */
-	u32 gpe0_block;		/* 32-bit port address of General Purpose Event 0 Reg Blk */
-	u32 gpe1_block;		/* 32-bit port address of General Purpose Event 1 Reg Blk */
-	u8 pm1_event_length;	/* Byte Length of ports at pm1x_event_block */
-	u8 pm1_control_length;	/* Byte Length of ports at pm1x_control_block */
-	u8 pm2_control_length;	/* Byte Length of ports at pm2_control_block */
-	u8 pm_timer_length;	/* Byte Length of ports at pm_timer_block */
-	u8 gpe0_block_length;	/* Byte Length of ports at gpe0_block */
-	u8 gpe1_block_length;	/* Byte Length of ports at gpe1_block */
-	u8 gpe1_base;		/* Offset in GPE number space where GPE1 events start */
-	u8 cst_control;		/* Support for the _CST object and C-States change notification */
-	u16 c2_latency;		/* Worst case HW latency to enter/exit C2 state */
-	u16 c3_latency;		/* Worst case HW latency to enter/exit C3 state */
-	u16 flush_size;		/* Processor memory cache line width, in bytes */
-	u16 flush_stride;	/* Number of flush strides that need to be read */
-	u8 duty_offset;		/* Processor duty cycle index in processor P_CNT reg */
-	u8 duty_width;		/* Processor duty cycle value bit width in P_CNT register */
-	u8 day_alarm;		/* Index to day-of-month alarm in RTC CMOS RAM */
-	u8 month_alarm;		/* Index to month-of-year alarm in RTC CMOS RAM */
-	u8 century;		/* Index to century in RTC CMOS RAM */
-	u16 boot_flags;		/* IA-PC Boot Architecture Flags (see below for individual flags) */
-	u8 reserved;		/* Reserved, must be zero */
-	u32 flags;		/* Miscellaneous flag bits (see below for individual flags) */
-	struct acpi_generic_address reset_register;	/* 64-bit address of the Reset register */
-	u8 reset_value;		/* Value to write to the reset_register port to reset the system */
-	u16 arm_boot_flags;	/* ARM-Specific Boot Flags (see below for individual flags) (ACPI 5.1) */
-	u8 minor_revision;	/* FADT Minor Revision (ACPI 5.1) */
-	u64 Xfacs;		/* 64-bit physical address of FACS */
-	u64 Xdsdt;		/* 64-bit physical address of DSDT */
-	struct acpi_generic_address xpm1a_event_block;	/* 64-bit Extended Power Mgt 1a Event Reg Blk address */
-	struct acpi_generic_address xpm1b_event_block;	/* 64-bit Extended Power Mgt 1b Event Reg Blk address */
-	struct acpi_generic_address xpm1a_control_block;	/* 64-bit Extended Power Mgt 1a Control Reg Blk address */
-	struct acpi_generic_address xpm1b_control_block;	/* 64-bit Extended Power Mgt 1b Control Reg Blk address */
-	struct acpi_generic_address xpm2_control_block;	/* 64-bit Extended Power Mgt 2 Control Reg Blk address */
-	struct acpi_generic_address xpm_timer_block;	/* 64-bit Extended Power Mgt Timer Ctrl Reg Blk address */
-	struct acpi_generic_address xgpe0_block;	/* 64-bit Extended General Purpose Event 0 Reg Blk address */
-	struct acpi_generic_address xgpe1_block;	/* 64-bit Extended General Purpose Event 1 Reg Blk address */
-	struct acpi_generic_address sleep_control;	/* 64-bit Sleep Control register (ACPI 5.0) */
-	struct acpi_generic_address sleep_status;	/* 64-bit Sleep Status register (ACPI 5.0) */
-	u64 hypervisor_id;	/* Hypervisor Vendor ID (ACPI 6.0) */
+	struct acpi_table_header header;	/* [V1] Common ACPI table header */
+	u32 facs;		/* [V1] 32-bit physical address of FACS */
+	u32 dsdt;		/* [V1] 32-bit physical address of DSDT */
+	u8 model;		/* [V1] System Interrupt Model (ACPI 1.0) - not used in ACPI 2.0+ */
+	u8 preferred_profile;	/* [V1] Conveys preferred power management profile to OSPM. */
+	u16 sci_interrupt;	/* [V1] System vector of SCI interrupt */
+	u32 smi_command;	/* [V1] 32-bit Port address of SMI command port */
+	u8 acpi_enable;		/* [V1] Value to write to SMI_CMD to enable ACPI */
+	u8 acpi_disable;	/* [V1] Value to write to SMI_CMD to disable ACPI */
+	u8 s4_bios_request;	/* [V1] Value to write to SMI_CMD to enter S4BIOS state */
+	u8 pstate_control;	/* [V1] Processor performance state control */
+	u32 pm1a_event_block;	/* [V1] 32-bit port address of Power Mgt 1a Event Reg Blk */
+	u32 pm1b_event_block;	/* [V1] 32-bit port address of Power Mgt 1b Event Reg Blk */
+	u32 pm1a_control_block;	/* [V1] 32-bit port address of Power Mgt 1a Control Reg Blk */
+	u32 pm1b_control_block;	/* [V1] 32-bit port address of Power Mgt 1b Control Reg Blk */
+	u32 pm2_control_block;	/* [V1] 32-bit port address of Power Mgt 2 Control Reg Blk */
+	u32 pm_timer_block;	/* [V1] 32-bit port address of Power Mgt Timer Ctrl Reg Blk */
+	u32 gpe0_block;		/* [V1] 32-bit port address of General Purpose Event 0 Reg Blk */
+	u32 gpe1_block;		/* [V1] 32-bit port address of General Purpose Event 1 Reg Blk */
+	u8 pm1_event_length;	/* [V1] Byte Length of ports at pm1x_event_block */
+	u8 pm1_control_length;	/* [V1] Byte Length of ports at pm1x_control_block */
+	u8 pm2_control_length;	/* [V1] Byte Length of ports at pm2_control_block */
+	u8 pm_timer_length;	/* [V1] Byte Length of ports at pm_timer_block */
+	u8 gpe0_block_length;	/* [V1] Byte Length of ports at gpe0_block */
+	u8 gpe1_block_length;	/* [V1] Byte Length of ports at gpe1_block */
+	u8 gpe1_base;		/* [V1] Offset in GPE number space where GPE1 events start */
+	u8 cst_control;		/* [V1] Support for the _CST object and C-States change notification */
+	u16 c2_latency;		/* [V1] Worst case HW latency to enter/exit C2 state */
+	u16 c3_latency;		/* [V1] Worst case HW latency to enter/exit C3 state */
+	u16 flush_size;		/* [V1] Processor memory cache line width, in bytes */
+	u16 flush_stride;	/* [V1] Number of flush strides that need to be read */
+	u8 duty_offset;		/* [V1] Processor duty cycle index in processor P_CNT reg */
+	u8 duty_width;		/* [V1] Processor duty cycle value bit width in P_CNT register */
+	u8 day_alarm;		/* [V1] Index to day-of-month alarm in RTC CMOS RAM */
+	u8 month_alarm;		/* [V1] Index to month-of-year alarm in RTC CMOS RAM */
+	u8 century;		/* [V1] Index to century in RTC CMOS RAM */
+	u16 boot_flags;		/* [V3] IA-PC Boot Architecture Flags (see below for individual flags) */
+	u8 reserved;		/* [V1] Reserved, must be zero */
+	u32 flags;		/* [V1] Miscellaneous flag bits (see below for individual flags) */
+	/* End of Version 1 FADT fields (ACPI 1.0) */
+
+	struct acpi_generic_address reset_register;	/* [V3] 64-bit address of the Reset register */
+	u8 reset_value;		/* [V3] Value to write to the reset_register port to reset the system */
+	u16 arm_boot_flags;	/* [V5] ARM-Specific Boot Flags (see below for individual flags) (ACPI 5.1) */
+	u8 minor_revision;	/* [V5] FADT Minor Revision (ACPI 5.1) */
+	u64 Xfacs;		/* [V3] 64-bit physical address of FACS */
+	u64 Xdsdt;		/* [V3] 64-bit physical address of DSDT */
+	struct acpi_generic_address xpm1a_event_block;	/* [V3] 64-bit Extended Power Mgt 1a Event Reg Blk address */
+	struct acpi_generic_address xpm1b_event_block;	/* [V3] 64-bit Extended Power Mgt 1b Event Reg Blk address */
+	struct acpi_generic_address xpm1a_control_block;	/* [V3] 64-bit Extended Power Mgt 1a Control Reg Blk address */
+	struct acpi_generic_address xpm1b_control_block;	/* [V3] 64-bit Extended Power Mgt 1b Control Reg Blk address */
+	struct acpi_generic_address xpm2_control_block;	/* [V3] 64-bit Extended Power Mgt 2 Control Reg Blk address */
+	struct acpi_generic_address xpm_timer_block;	/* [V3] 64-bit Extended Power Mgt Timer Ctrl Reg Blk address */
+	struct acpi_generic_address xgpe0_block;	/* [V3] 64-bit Extended General Purpose Event 0 Reg Blk address */
+	struct acpi_generic_address xgpe1_block;	/* [V3] 64-bit Extended General Purpose Event 1 Reg Blk address */
+	/* End of Version 3 FADT fields (ACPI 2.0) */
+
+	struct acpi_generic_address sleep_control;	/* [V4] 64-bit Sleep Control register (ACPI 5.0) */
+	/* End of Version 4 FADT fields (ACPI 3.0 and ACPI 4.0) (Field was originally reserved in ACPI 3.0) */
+
+	struct acpi_generic_address sleep_status;	/* [V5] 64-bit Sleep Status register (ACPI 5.0) */
+	/* End of Version 5 FADT fields (ACPI 5.0) */
+
+	u64 hypervisor_id;	/* [V6] Hypervisor Vendor ID (ACPI 6.0) */
+	/* End of Version 6 FADT fields (ACPI 6.0) */
+
 };
 
 /* Masks for FADT IA-PC Boot Architecture Flags (boot_flags) [Vx]=Introduced in this FADT revision */
@@ -301,8 +311,8 @@ struct acpi_table_fadt {
 
 /* Masks for FADT ARM Boot Architecture Flags (arm_boot_flags) ACPI 5.1 */
 
-#define ACPI_FADT_PSCI_COMPLIANT    (1)	/* 00: [V5+] PSCI 0.2+ is implemented */
-#define ACPI_FADT_PSCI_USE_HVC      (1<<1)	/* 01: [V5+] HVC must be used instead of SMC as the PSCI conduit */
+#define ACPI_FADT_PSCI_COMPLIANT    (1)	/* 00: [V5] PSCI 0.2+ is implemented */
+#define ACPI_FADT_PSCI_USE_HVC      (1<<1)	/* 01: [V5] HVC must be used instead of SMC as the PSCI conduit */
 
 /* Masks for FADT flags */
 
@@ -399,20 +409,34 @@ struct acpi_table_desc {
  * match the expected length. In other words, the length of the
  * FADT is the bottom line as to what the version really is.
  *
- * For reference, the values below are as follows:
- *     FADT V1 size: 0x074
- *     FADT V2 size: 0x084
- *     FADT V3 size: 0x0F4
- *     FADT V4 size: 0x0F4
- *     FADT V5 size: 0x10C
- *     FADT V6 size: 0x114
+ * NOTE: There is no officialy released V2 of the FADT. This
+ * version was used only for prototyping and testing during the
+ * 32-bit to 64-bit transition. V3 was the first official 64-bit
+ * version of the FADT.
+ *
+ * Update this list of defines when a new version of the FADT is
+ * added to the ACPI specification. Note that the FADT version is
+ * only incremented when new fields are appended to the existing
+ * version. Therefore, the FADT version is competely independent
+ * from the version of the ACPI specification where it is
+ * defined.
+ *
+ * For reference, the various FADT lengths are as follows:
+ *     FADT V1 size: 0x074      ACPI 1.0
+ *     FADT V3 size: 0x0F4      ACPI 2.0
+ *     FADT V4 size: 0x100      ACPI 3.0 and ACPI 4.0
+ *     FADT V5 size: 0x10C      ACPI 5.0
+ *     FADT V6 size: 0x114      ACPI 6.0
  */
-#define ACPI_FADT_V1_SIZE       (u32) (ACPI_FADT_OFFSET (flags) + 4)
-#define ACPI_FADT_V2_SIZE       (u32) (ACPI_FADT_OFFSET (minor_revision) + 1)
-#define ACPI_FADT_V3_SIZE       (u32) (ACPI_FADT_OFFSET (sleep_control))
-#define ACPI_FADT_V5_SIZE       (u32) (ACPI_FADT_OFFSET (hypervisor_id))
-#define ACPI_FADT_V6_SIZE       (u32) (sizeof (struct acpi_table_fadt))
+#define ACPI_FADT_V1_SIZE       (u32) (ACPI_FADT_OFFSET (flags) + 4)	/* ACPI 1.0 */
+#define ACPI_FADT_V3_SIZE       (u32) (ACPI_FADT_OFFSET (sleep_control))	/* ACPI 2.0 */
+#define ACPI_FADT_V4_SIZE       (u32) (ACPI_FADT_OFFSET (sleep_status))	/* ACPI 3.0 and ACPI 4.0 */
+#define ACPI_FADT_V5_SIZE       (u32) (ACPI_FADT_OFFSET (hypervisor_id))	/* ACPI 5.0 */
+#define ACPI_FADT_V6_SIZE       (u32) (sizeof (struct acpi_table_fadt))	/* ACPI 6.0 */
+
+/* Update these when new FADT versions are added */
 
+#define ACPI_FADT_MAX_VERSION   6
 #define ACPI_FADT_CONFORMANCE   "ACPI 6.1 (FADT version 6)"
 
 #endif				/* __ACTBL_H__ */
-- 
1.7.10

