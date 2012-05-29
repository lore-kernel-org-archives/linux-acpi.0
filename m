From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH] ACPI: Fix the irq0 assigning issue for AMILO PRO V2030 platform
Date: Tue, 29 May 2012 10:43:38 +0800
Message-ID: <1338259418-6167-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6832 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab2E2Cra (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 May 2012 22:47:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rui.zhang@intel.com, fazerxlo@o2.pl, Feng Tang <feng.tang@intel.com>, x86@kernel.org

This is to fix the kernel bugzilla 40002: "IRQ 0 assigned to VGA"
 https://bugzilla.kernel.org/show_bug.cgi?id=40002

The root cause is the buggy FW, whose ACPI tables assign the GSI 16
to 2 irqs 0 and 16(VGA), and the VGA is the right owner of GSI 16.
So add a quirk to ignore the irq0 overriding GSI 16 for the
FUJITSU SIEMENS AMILO PRO V2030 platform will solve this issue.

This also slightly modify the current irq0 override handling, as it
only covered the irq0 overriding GSI 2 case.

Reported-and-tested-by: Szymon Kowalczyk <fazerxlo@o2.pl>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/acpi/boot.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4558f0d..06c78c3 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -416,12 +416,14 @@ acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
 		return 0;
 	}
 
-	if (intsrc->source_irq == 0 && intsrc->global_irq == 2) {
+	if (intsrc->source_irq == 0) {
 		if (acpi_skip_timer_override) {
-			printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
+			printk(PREFIX "BIOS IRQ0 override ignored.\n");
 			return 0;
 		}
-		if (acpi_fix_pin2_polarity && (intsrc->inti_flags & ACPI_MADT_POLARITY_MASK)) {
+
+		if ((intsrc->global_irq == 2) && acpi_fix_pin2_polarity
+			&& (intsrc->inti_flags & ACPI_MADT_POLARITY_MASK)) {
 			intsrc->inti_flags &= ~ACPI_MADT_POLARITY_MASK;
 			printk(PREFIX "BIOS IRQ0 pin2 override: forcing polarity to high active.\n");
 		}
@@ -1466,6 +1468,15 @@ static struct dmi_system_id __initdata acpi_dmi_table_late[] = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq 6715b"),
 		     },
 	 },
+	{
+	 .callback = dmi_ignore_irq0_timer_override,
+	 .ident = "FUJITSU SIEMENS",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
+		     },
+	 },
+
 	{}
 };
 
-- 
1.7.9

