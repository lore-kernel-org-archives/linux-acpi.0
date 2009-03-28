From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/98] ACPICA: Update FADT flag definitions
Date: Sat, 28 Mar 2009 00:30:53 -0400
Message-ID: <993958fecab6eabc6ee5b7ed65c56d716fd5cfe3.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38046 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbZC1Ecq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700HSD8M7KD8F@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:33 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add new flags in the Boot Architecture flags field. Update comments
for all FADT flags. Add FADT version when each flag was defined.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/pci-acpi.c |    4 +-
 include/acpi/actbl.h   |   69 +++++++++++++++++++++++------------------------
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index deea8a1..368ca72 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -386,12 +386,12 @@ static int __init acpi_pci_init(void)
 {
 	int ret;
 
-	if (acpi_gbl_FADT.boot_flags & BAF_MSI_NOT_SUPPORTED) {
+	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_MSI) {
 		printk(KERN_INFO"ACPI FADT declares the system doesn't support MSI, so disable it\n");
 		pci_no_msi();
 	}
 
-	if (acpi_gbl_FADT.boot_flags & BAF_PCIE_ASPM_CONTROL) {
+	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 		printk(KERN_INFO"ACPI FADT declares the system doesn't support PCIe ASPM, so disable it\n");
 		pcie_no_aspm();
 	}
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 1f3dfdb..222733d 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -214,11 +214,11 @@ struct acpi_table_fadt {
 	u16 flush_size;		/* Processor's memory cache line width, in bytes */
 	u16 flush_stride;	/* Number of flush strides that need to be read */
 	u8 duty_offset;		/* Processor duty cycle index in processor's P_CNT reg */
-	u8 duty_width;		/* Processor duty cycle value bit width in P_CNT register. */
+	u8 duty_width;		/* Processor duty cycle value bit width in P_CNT register */
 	u8 day_alarm;		/* Index to day-of-month alarm in RTC CMOS RAM */
 	u8 month_alarm;		/* Index to month-of-year alarm in RTC CMOS RAM */
 	u8 century;		/* Index to century in RTC CMOS RAM */
-	u16 boot_flags;		/* IA-PC Boot Architecture Flags. See Table 5-10 for description */
+	u16 boot_flags;		/* IA-PC Boot Architecture Flags (see below for individual flags) */
 	u8 reserved;		/* Reserved, must be zero */
 	u32 flags;		/* Miscellaneous flag bits (see below for individual flags) */
 	struct acpi_generic_address reset_register;	/* 64-bit address of the Reset register */
@@ -236,32 +236,41 @@ struct acpi_table_fadt {
 	struct acpi_generic_address xgpe1_block;	/* 64-bit Extended General Purpose Event 1 Reg Blk address */
 };
 
+/* FADT Boot Architecture Flags (boot_flags) */
+
+#define ACPI_FADT_LEGACY_DEVICES    (1)  	/* 00: [V2] System has LPC or ISA bus devices */
+#define ACPI_FADT_8042              (1<<1)	/* 01: [V3] System has an 8042 controller on port 60/64 */
+#define ACPI_FADT_NO_VGA            (1<<2)	/* 02: [V4] It is not safe to probe for VGA hardware */
+#define ACPI_FADT_NO_MSI            (1<<3)	/* 03: [V4] Message Signaled Interrupts (MSI) must not be enabled */
+#define ACPI_FADT_NO_ASPM           (1<<4)	/* 04: [V4] PCIe ASPM control must not be enabled */
+
+#define FADT2_REVISION_ID               3
+
 /* FADT flags */
 
-#define ACPI_FADT_WBINVD            (1)	/* 00: The wbinvd instruction works properly */
-#define ACPI_FADT_WBINVD_FLUSH      (1<<1)	/* 01: The wbinvd flushes but does not invalidate */
-#define ACPI_FADT_C1_SUPPORTED      (1<<2)	/* 02: All processors support C1 state */
-#define ACPI_FADT_C2_MP_SUPPORTED   (1<<3)	/* 03: C2 state works on MP system */
-#define ACPI_FADT_POWER_BUTTON      (1<<4)	/* 04: Power button is handled as a generic feature */
-#define ACPI_FADT_SLEEP_BUTTON      (1<<5)	/* 05: Sleep button is handled as a generic feature, or  not present */
-#define ACPI_FADT_FIXED_RTC         (1<<6)	/* 06: RTC wakeup stat not in fixed register space */
-#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: RTC wakeup possible from S4 */
-#define ACPI_FADT_32BIT_TIMER       (1<<8)	/* 08: tmr_val is 32 bits 0=24-bits */
-#define ACPI_FADT_DOCKING_SUPPORTED (1<<9)	/* 09: Docking supported */
-#define ACPI_FADT_RESET_REGISTER    (1<<10)	/* 10: System reset via the FADT RESET_REG supported */
-#define ACPI_FADT_SEALED_CASE       (1<<11)	/* 11: No internal expansion capabilities and case is sealed */
-#define ACPI_FADT_HEADLESS          (1<<12)	/* 12: No local video capabilities or local input devices */
-#define ACPI_FADT_SLEEP_TYPE        (1<<13)	/* 13: Must execute native instruction after writing  SLP_TYPx register */
-#define ACPI_FADT_PCI_EXPRESS_WAKE  (1<<14)	/* 14: System supports PCIEXP_WAKE (STS/EN) bits (ACPI 3.0) */
-#define ACPI_FADT_PLATFORM_CLOCK    (1<<15)	/* 15: OSPM should use platform-provided timer (ACPI 3.0) */
-#define ACPI_FADT_S4_RTC_VALID      (1<<16)	/* 16: Contents of RTC_STS valid after S4 wake (ACPI 3.0) */
-#define ACPI_FADT_REMOTE_POWER_ON   (1<<17)	/* 17: System is compatible with remote power on (ACPI 3.0) */
-#define ACPI_FADT_APIC_CLUSTER      (1<<18)	/* 18: All local APICs must use cluster model (ACPI 3.0) */
-#define ACPI_FADT_APIC_PHYSICAL     (1<<19)	/* 19: All local x_aPICs must use physical dest mode (ACPI 3.0) */
+#define ACPI_FADT_WBINVD            (1)	/* 00: [V1] The wbinvd instruction works properly */
+#define ACPI_FADT_WBINVD_FLUSH      (1<<1)	/* 01: [V1] wbinvd flushes but does not invalidate caches */
+#define ACPI_FADT_C1_SUPPORTED      (1<<2)	/* 02: [V1] All processors support C1 state */
+#define ACPI_FADT_C2_MP_SUPPORTED   (1<<3)	/* 03: [V1] C2 state works on MP system */
+#define ACPI_FADT_POWER_BUTTON      (1<<4)	/* 04: [V1] Power button is handled as a control method device */
+#define ACPI_FADT_SLEEP_BUTTON      (1<<5)	/* 05: [V1] Sleep button is handled as a control method device */
+#define ACPI_FADT_FIXED_RTC         (1<<6)	/* 06: [V1] RTC wakeup status not in fixed register space */
+#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: [V1] RTC alarm can wake system from S4 */
+#define ACPI_FADT_32BIT_TIMER       (1<<8)	/* 08: [V1] ACPI timer width is 32-bit (0=24-bit) */
+#define ACPI_FADT_DOCKING_SUPPORTED (1<<9)	/* 09: [V1] Docking supported */
+#define ACPI_FADT_RESET_REGISTER    (1<<10)	/* 10: [V2] System reset via the FADT RESET_REG supported */
+#define ACPI_FADT_SEALED_CASE       (1<<11)	/* 11: [V3] No internal expansion capabilities and case is sealed */
+#define ACPI_FADT_HEADLESS          (1<<12)	/* 12: [V3] No local video capabilities or local input devices */
+#define ACPI_FADT_SLEEP_TYPE        (1<<13)	/* 13: [V3] Must execute native instruction after writing  SLP_TYPx register */
+#define ACPI_FADT_PCI_EXPRESS_WAKE  (1<<14)	/* 14: [V4] System supports PCIEXP_WAKE (STS/EN) bits (ACPI 3.0) */
+#define ACPI_FADT_PLATFORM_CLOCK    (1<<15)	/* 15: [V4] OSPM should use platform-provided timer (ACPI 3.0) */
+#define ACPI_FADT_S4_RTC_VALID      (1<<16)	/* 16: [V4] Contents of RTC_STS valid after S4 wake (ACPI 3.0) */
+#define ACPI_FADT_REMOTE_POWER_ON   (1<<17)	/* 17: [V4] System is compatible with remote power on (ACPI 3.0) */
+#define ACPI_FADT_APIC_CLUSTER      (1<<18)	/* 18: [V4] All local APICs must use cluster model (ACPI 3.0) */
+#define ACPI_FADT_APIC_PHYSICAL     (1<<19)	/* 19: [V4] All local x_aPICs must use physical dest mode (ACPI 3.0) */
+
+/* FADT Prefered Power Management Profiles */
 
-/*
- * FADT Prefered Power Management Profiles
- */
 enum acpi_prefered_pm_profiles {
 	PM_UNSPECIFIED = 0,
 	PM_DESKTOP = 1,
@@ -272,16 +281,6 @@ enum acpi_prefered_pm_profiles {
 	PM_APPLIANCE_PC = 6
 };
 
-/* FADT Boot Arch Flags */
-
-#define BAF_LEGACY_DEVICES              0x0001
-#define BAF_8042_KEYBOARD_CONTROLLER    0x0002
-#define BAF_MSI_NOT_SUPPORTED           0x0008
-#define BAF_PCIE_ASPM_CONTROL           0x0010
-
-#define FADT2_REVISION_ID               3
-#define FADT2_MINUS_REVISION_ID         2
-
 /* Reset to default packing */
 
 #pragma pack()
-- 
1.6.0.6

