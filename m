From: Len Brown <len.brown@intel.com>
Subject: [PATCH 13/65] ACPICA: Update comments for individual table fields
Date: Fri, 24 Nov 2006 02:18:23 -0500
Message-ID: <11643527731111-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50244 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934461AbWKXHPg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:36 -0500
In-Reply-To: <11643527703526-git-send-email-len.brown@intel.com>
Message-Id: <c0f2f417d70ac411c7085aa64ffc44787562e1ca.1164352291.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

comments only

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/actbl.h |   64 +++++++++++++++++++++++++-------------------------
 1 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index c55939e..aed49a5 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -56,7 +56,7 @@
 #define ACPI_SIG_RSDT           "RSDT"	/* Root System Description Table */
 #define ACPI_SIG_XSDT           "XSDT"	/* Extended  System Description Table */
 #define ACPI_SIG_SSDT           "SSDT"	/* Secondary System Description Table */
-#define ACPI_RSDP_NAME          "RSDP"
+#define ACPI_RSDP_NAME          "RSDP"	/* Short name for RSDP, not signature */
 
 /*
  * All tables and structures must be byte-packed to match the ACPI
@@ -185,55 +185,55 @@ struct acpi_table_fadt {
 	struct acpi_table_header header;	/* Common ACPI table header */
 	u32 facs;		/* 32-bit physical address of FACS */
 	u32 dsdt;		/* 32-bit physical address of DSDT */
-	u8 model;		/* System Interrupt Model (ACPI 1.0) not used in ACPI 2.0+ */
+	u8 model;		/* System Interrupt Model (ACPI 1.0) - not used in ACPI 2.0+ */
 	u8 preferred_profile;	/* Conveys preferred power management profile to OSPM. */
 	u16 sci_interrupt;	/* System vector of SCI interrupt */
-	u32 smi_command;	/* Port address of SMI command port */
+	u32 smi_command;	/* 32-bit Port address of SMI command port */
 	u8 acpi_enable;		/* Value to write to smi_cmd to enable ACPI */
 	u8 acpi_disable;	/* Value to write to smi_cmd to disable ACPI */
 	u8 S4bios_request;	/* Value to write to SMI CMD to enter S4BIOS state */
 	u8 pstate_control;	/* Processor performance state control */
-	u32 pm1a_event_block;	/* Port address of Power Mgt 1a Event Reg Blk */
-	u32 pm1b_event_block;	/* Port address of Power Mgt 1b Event Reg Blk */
-	u32 pm1a_control_block;	/* Port address of Power Mgt 1a Control Reg Blk */
-	u32 pm1b_control_block;	/* Port address of Power Mgt 1b Control Reg Blk */
-	u32 pm2_control_block;	/* Port address of Power Mgt 2 Control Reg Blk */
-	u32 pm_timer_block;	/* Port address of Power Mgt Timer Ctrl Reg Blk */
-	u32 gpe0_block;		/* Port addr of General Purpose Event 0 Reg Blk */
-	u32 gpe1_block;		/* Port addr of General Purpose Event 1 Reg Blk */
-	u8 pm1_event_length;	/* Byte Length of ports at pm1_x_evt_blk */
-	u8 pm1_control_length;	/* Byte Length of ports at pm1_x_cnt_blk */
-	u8 pm2_control_length;	/* Byte Length of ports at pm2_cnt_blk */
-	u8 pm_timer_length;	/* Byte Length of ports at pm_tmr_blk */
-	u8 gpe0_block_length;	/* Byte Length of ports at gpe0_blk */
-	u8 gpe1_block_length;	/* Byte Length of ports at gpe1_blk */
-	u8 gpe1_base;		/* Offset in gpe model where gpe1 events start */
-	u8 cst_control;		/* Support for the _CST object and C States change notification. */
+	u32 pm1a_event_block;	/* 32-bit Port address of Power Mgt 1a Event Reg Blk */
+	u32 pm1b_event_block;	/* 32-bit Port address of Power Mgt 1b Event Reg Blk */
+	u32 pm1a_control_block;	/* 32-bit Port address of Power Mgt 1a Control Reg Blk */
+	u32 pm1b_control_block;	/* 32-bit Port address of Power Mgt 1b Control Reg Blk */
+	u32 pm2_control_block;	/* 32-bit Port address of Power Mgt 2 Control Reg Blk */
+	u32 pm_timer_block;	/* 32-bit Port address of Power Mgt Timer Ctrl Reg Blk */
+	u32 gpe0_block;		/* 32-bit Port address of General Purpose Event 0 Reg Blk */
+	u32 gpe1_block;		/* 32-bit Port address of General Purpose Event 1 Reg Blk */
+	u8 pm1_event_length;	/* Byte Length of ports at pm1x_event_block */
+	u8 pm1_control_length;	/* Byte Length of ports at pm1x_control_block */
+	u8 pm2_control_length;	/* Byte Length of ports at pm2_control_block */
+	u8 pm_timer_length;	/* Byte Length of ports at pm_timer_block */
+	u8 gpe0_block_length;	/* Byte Length of ports at gpe0_block */
+	u8 gpe1_block_length;	/* Byte Length of ports at gpe1_block */
+	u8 gpe1_base;		/* Offset in GPE number space where GPE1 events start */
+	u8 cst_control;		/* Support for the _CST object and C States change notification */
 	u16 C2latency;		/* Worst case HW latency to enter/exit C2 state */
 	u16 C3latency;		/* Worst case HW latency to enter/exit C3 state */
 	u16 flush_size;		/* Processor's memory cache line width, in bytes */
 	u16 flush_stride;	/* Number of flush strides that need to be read */
-	u8 duty_offset;		/* Processor's duty cycle index in processor's P_CNT reg */
-	u8 duty_width;		/* Processor's duty cycle value bit width in P_CNT register. */
+	u8 duty_offset;		/* Processor duty cycle index in processor's P_CNT reg */
+	u8 duty_width;		/* Processor duty cycle value bit width in P_CNT register. */
 	u8 day_alarm;		/* Index to day-of-month alarm in RTC CMOS RAM */
 	u8 month_alarm;		/* Index to month-of-year alarm in RTC CMOS RAM */
 	u8 century;		/* Index to century in RTC CMOS RAM */
 	u16 boot_flags;		/* IA-PC Boot Architecture Flags. See Table 5-10 for description */
 	u8 reserved;		/* Reserved, must be zero */
-	u32 flags;		/* Miscellaneous flag bits */
-	struct acpi_generic_address reset_register;	/* Reset register address in GAS format */
+	u32 flags;		/* Miscellaneous flag bits (see below for individual flags) */
+	struct acpi_generic_address reset_register;	/* 64-bit address of the Reset register */
 	u8 reset_value;		/* Value to write to the reset_register port to reset the system */
-	u8 reserved4[3];	/* These three bytes must be zero */
+	u8 reserved4[3];	/* Reserved, must be zero */
 	u64 Xfacs;		/* 64-bit physical address of FACS */
 	u64 Xdsdt;		/* 64-bit physical address of DSDT */
-	struct acpi_generic_address xpm1a_event_block;	/* Extended Power Mgt 1a Event Reg Blk address */
-	struct acpi_generic_address xpm1b_event_block;	/* Extended Power Mgt 1b Event Reg Blk address */
-	struct acpi_generic_address xpm1a_control_block;	/* Extended Power Mgt 1a Control Reg Blk address */
-	struct acpi_generic_address xpm1b_control_block;	/* Extended Power Mgt 1b Control Reg Blk address */
-	struct acpi_generic_address xpm2_control_block;	/* Extended Power Mgt 2 Control Reg Blk address */
-	struct acpi_generic_address xpm_timer_block;	/* Extended Power Mgt Timer Ctrl Reg Blk address */
-	struct acpi_generic_address xgpe0_block;	/* Extended General Purpose Event 0 Reg Blk address */
-	struct acpi_generic_address xgpe1_block;	/* Extended General Purpose Event 1 Reg Blk address */
+	struct acpi_generic_address xpm1a_event_block;	/* 64-bit Extended Power Mgt 1a Event Reg Blk address */
+	struct acpi_generic_address xpm1b_event_block;	/* 64-bit Extended Power Mgt 1b Event Reg Blk address */
+	struct acpi_generic_address xpm1a_control_block;	/* 64-bit Extended Power Mgt 1a Control Reg Blk address */
+	struct acpi_generic_address xpm1b_control_block;	/* 64-bit Extended Power Mgt 1b Control Reg Blk address */
+	struct acpi_generic_address xpm2_control_block;	/* 64-bit Extended Power Mgt 2 Control Reg Blk address */
+	struct acpi_generic_address xpm_timer_block;	/* 64-bit Extended Power Mgt Timer Ctrl Reg Blk address */
+	struct acpi_generic_address xgpe0_block;	/* 64-bit Extended General Purpose Event 0 Reg Blk address */
+	struct acpi_generic_address xgpe1_block;	/* 64-bit Extended General Purpose Event 1 Reg Blk address */
 };
 
 /* FADT flags */
-- 
1.4.4.1
