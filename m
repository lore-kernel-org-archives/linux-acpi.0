From: Len Brown <lenb@kernel.org>
Subject: [PATCH 54/140] ACPICA: Update comments for individual table fields
Date: Wed,  7 Feb 2007 13:51:08 -0500
Message-ID: <11708744513541-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:41312 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422780AbXBGSyO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:14 -0500
In-Reply-To: <11708744461131-git-send-email-lenb@kernel.org>
Message-Id: <8f34890dce60f7df6dd23a0d04977c6572adaab8.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
1.5.0.rc3.39.gec804
