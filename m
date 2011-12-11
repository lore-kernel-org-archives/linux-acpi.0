From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/18] ACPI 5.0: Basic support for FADT version 5
Date: Sun, 11 Dec 2011 12:45:37 -0500
Message-ID: <9bdac99254c0d3f746b88676085d21918a70bc08.1323625426.git.len.brown@intel.com>
References: <1323625549-10775-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:63198 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1LKRqS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Dec 2011 12:46:18 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LW100665W0MCR72@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 11 Dec 2011 11:46:06 -0600 (CST)
In-reply-to: <1323625549-10775-1-git-send-email-lenb@kernel.org>
In-reply-to: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
References: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |    4 ++--
 include/acpi/actbl.h         |   22 ++++++++++++++++------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 6f5588e..536fd2b 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -277,12 +277,12 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 {
 	/*
 	 * Check if the FADT is larger than the largest table that we expect
-	 * (the ACPI 2.0/3.0 version). If so, truncate the table, and issue
+	 * (the ACPI 5.0 version). If so, truncate the table, and issue
 	 * a warning.
 	 */
 	if (length > sizeof(struct acpi_table_fadt)) {
 		ACPI_WARNING((AE_INFO,
-			      "FADT (revision %u) is longer than ACPI 2.0 version, "
+			      "FADT (revision %u) is longer than ACPI 5.0 version, "
 			      "truncating length %u to %u",
 			      table->revision, length,
 			      (u32)sizeof(struct acpi_table_fadt)));
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index f138028..7d0e051 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -255,6 +255,8 @@ struct acpi_table_fadt {
 	struct acpi_generic_address xpm_timer_block;	/* 64-bit Extended Power Mgt Timer Ctrl Reg Blk address */
 	struct acpi_generic_address xgpe0_block;	/* 64-bit Extended General Purpose Event 0 Reg Blk address */
 	struct acpi_generic_address xgpe1_block;	/* 64-bit Extended General Purpose Event 1 Reg Blk address */
+	struct acpi_generic_address sleep_control;	/* 64-bit Sleep Control register */
+	struct acpi_generic_address sleep_status;	/* 64-bit Sleep Status register */
 };
 
 /* Masks for FADT Boot Architecture Flags (boot_flags) */
@@ -264,6 +266,7 @@ struct acpi_table_fadt {
 #define ACPI_FADT_NO_VGA            (1<<2)	/* 02: [V4] It is not safe to probe for VGA hardware */
 #define ACPI_FADT_NO_MSI            (1<<3)	/* 03: [V4] Message Signaled Interrupts (MSI) must not be enabled */
 #define ACPI_FADT_NO_ASPM           (1<<4)	/* 04: [V4] PCIe ASPM control must not be enabled */
+#define ACPI_FADT_NO_CMOS_RTC       (1<<5)	/* 05: [V5] No CMOS real-time clock present */
 
 #define FADT2_REVISION_ID               3
 
@@ -289,6 +292,8 @@ struct acpi_table_fadt {
 #define ACPI_FADT_REMOTE_POWER_ON   (1<<17)	/* 17: [V4] System is compatible with remote power on (ACPI 3.0) */
 #define ACPI_FADT_APIC_CLUSTER      (1<<18)	/* 18: [V4] All local APICs must use cluster model (ACPI 3.0) */
 #define ACPI_FADT_APIC_PHYSICAL     (1<<19)	/* 19: [V4] All local x_aPICs must use physical dest mode (ACPI 3.0) */
+#define ACPI_FADT_HW_REDUCED        (1<<20)	/* 20: [V5] ACPI hardware is not implemented (ACPI 5.0) */
+#define ACPI_FADT_LOW_POWER_S0      (1<<21)	/* 21: [V5] S0 power savings are equal or better than S3 (ACPI 5.0) */
 
 /* Values for preferred_profile (Preferred Power Management Profiles) */
 
@@ -299,14 +304,16 @@ enum acpi_prefered_pm_profiles {
 	PM_WORKSTATION = 3,
 	PM_ENTERPRISE_SERVER = 4,
 	PM_SOHO_SERVER = 5,
-	PM_APPLIANCE_PC = 6
+	PM_APPLIANCE_PC = 6,
+	PM_PERFORMANCE_SERVER = 7,
+	PM_TABLET = 8
 };
 
 /* Reset to default packing */
 
 #pragma pack()
 
-#define ACPI_FADT_OFFSET(f)             (u8) ACPI_OFFSET (struct acpi_table_fadt, f)
+#define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acpi_table_fadt, f)
 
 /*
  * Internal table-related structures
@@ -351,12 +358,15 @@ struct acpi_table_desc {
  * FADT is the bottom line as to what the version really is.
  *
  * For reference, the values below are as follows:
- *     FADT V1  size: 0x74
- *     FADT V2  size: 0x84
- *     FADT V3+ size: 0xF4
+ *     FADT V1  size: 0x074
+ *     FADT V2  size: 0x084
+ *     FADT V3  size: 0x0F4
+ *     FADT V4  size: 0x0F4
+ *     FADT V5  size: 0x10C
  */
 #define ACPI_FADT_V1_SIZE       (u32) (ACPI_FADT_OFFSET (flags) + 4)
 #define ACPI_FADT_V2_SIZE       (u32) (ACPI_FADT_OFFSET (reserved4[0]) + 3)
-#define ACPI_FADT_V3_SIZE       (u32) (sizeof (struct acpi_table_fadt))
+#define ACPI_FADT_V3_SIZE       (u32) (ACPI_FADT_OFFSET (sleep_control))
+#define ACPI_FADT_V5_SIZE       (u32) (sizeof (struct acpi_table_fadt))
 
 #endif				/* __ACTBL_H__ */
-- 
1.7.7.rc0.72.g4b5ea

