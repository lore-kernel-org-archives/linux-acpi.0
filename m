From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 1/3] ACPI: Make acpi_skip_timer_override cover all
 source_irq==0 cases
Date: Mon, 4 Jun 2012 13:23:21 +0800
Message-ID: <20120604132321.2eb64443@feng-i7>
References: <1338259418-6167-1-git-send-email-feng.tang@intel.com>
	<4FC8F36C.8080409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1348 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645Ab2FDF04 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jun 2012 01:26:56 -0400
In-Reply-To: <4FC8F36C.8080409@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com, fazerxlo@o2.pl, x86@kernel.org

>From b10f528c1973e89bf6a4da8f91d62228c259acba Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Mon, 4 Jun 2012 10:40:26 +0800
Subject: [PATCH 1/3] ACPI: Make acpi_skip_timer_override cover all
 source_irq==0 cases

Currently when acpi_skip_timer_override is set, it only cover the
(source_irq == 0 && global_irq == 2) cases. While there is also
platform which need use this option and its global_irq is not 2.
This patch will extend acpi_skip_timer_override to cover all
timer overriding cases as long as the source irq is 0.

This is the first part of a fix to kernel bug bugzilla 40002:
	"IRQ 0 assigned to VGA"
https://bugzilla.kernel.org/show_bug.cgi?id=40002

Reported-and-tested-by: Szymon Kowalczyk <fazerxlo@o2.pl>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/acpi/boot.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 8afb693..e7c698e 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -422,12 +422,14 @@ acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
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
@@ -1334,7 +1336,7 @@ static int __init dmi_disable_acpi(const struct dmi_system_id *d)
 }
 
 /*
- * Force ignoring BIOS IRQ0 pin2 override
+ * Force ignoring BIOS IRQ0 override
  */
 static int __init dmi_ignore_irq0_timer_override(const struct dmi_system_id *d)
 {
@@ -1344,7 +1346,7 @@ static int __init dmi_ignore_irq0_timer_override(const struct dmi_system_id *d)
 	 */
 	if (!acpi_skip_timer_override) {
 		WARN(1, KERN_ERR "ati_ixp4x0 quirk not complete.\n");
-		pr_notice("%s detected: Ignoring BIOS IRQ0 pin2 override\n",
+		pr_notice("%s detected: Ignoring BIOS IRQ0 override\n",
 			d->ident);
 		acpi_skip_timer_override = 1;
 	}
@@ -1438,7 +1440,7 @@ static struct dmi_system_id __initdata acpi_dmi_table_late[] = {
 	 * is enabled.  This input is incorrectly designated the
 	 * ISA IRQ 0 via an interrupt source override even though
 	 * it is wired to the output of the master 8259A and INTIN0
-	 * is not connected at all.  Force ignoring BIOS IRQ0 pin2
+	 * is not connected at all.  Force ignoring BIOS IRQ0
 	 * override in that cases.
 	 */
 	{
-- 
1.7.9
