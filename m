From: Baoquan He <bhe@redhat.com>
Subject: [Patch v4 2/2] x86/acpi: Remove the repeated lapic address override entry parsing
Date: Fri, 12 Aug 2016 14:57:13 +0800
Message-ID: <1470985033-22493-2-git-send-email-bhe@redhat.com>
References: <1470985033-22493-1-git-send-email-bhe@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57960 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbcHLG5q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Aug 2016 02:57:46 -0400
In-Reply-To: <1470985033-22493-1-git-send-email-bhe@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@kernel.org
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Baoquan He <bhe@redhat.com>

ACPI MADT has a 32-bit field providing lapic address at which
each processor can access its lapic information. MADT also contains
an optional entry to provide a 64-bit address to override the 32-bit
one. However the current code does the lapic address override entry
parsing twice. One is in early_acpi_boot_init() because AMD NUMA need
get boot_cpu_id earlier. The other is in acpi_boot_init() which parses
all MADT entries.

So in this patch remove the repeated code in the 2nd part.

Meanwhile print lapic override entry information like other MADT entry,
this will be added to boot log.

This patch is not supposed to change any runtime behavior, other than
improving kernel messages.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
  -Remove the incorrect code comment above early_acpi_boot_init()
   as Rafael suggested.

v2->v4:
  -Spell out that this patch is not supposed to change any runtime
   behavior, other than improving kernel messages.

 arch/x86/kernel/acpi/boot.c | 17 ++---------------
 arch/x86/kernel/apic/apic.c |  2 +-
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 90d84c3..2087bea 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -282,6 +282,8 @@ acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
 	if (BAD_MADT_ENTRY(lapic_addr_ovr, end))
 		return -EINVAL;
 
+	acpi_table_print_madt_entry(header);
+
 	acpi_lapic_addr = lapic_addr_ovr->address;
 
 	return 0;
@@ -998,21 +1000,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
 
-	/*
-	 * Note that the LAPIC address is obtained from the MADT (32-bit value)
-	 * and (optionally) overridden by a LAPIC_ADDR_OVR entry (64-bit value).
-	 */
-
-	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_OVERRIDE,
-				      acpi_parse_lapic_addr_ovr, 0);
-	if (count < 0) {
-		printk(KERN_ERR PREFIX
-		       "Error parsing LAPIC address override entry\n");
-		return count;
-	}
-
-	register_lapic_address(acpi_lapic_addr);
-
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC,
 				      acpi_parse_sapic, MAX_LOCAL_APIC);
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 20abd91..cb87da2 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1801,7 +1801,7 @@ void __init register_lapic_address(unsigned long address)
 	if (!x2apic_mode) {
 		set_fixmap_nocache(FIX_APIC_BASE, address);
 		apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
-			    APIC_BASE, mp_lapic_addr);
+			    APIC_BASE, address);
 	}
 	if (boot_cpu_physical_apicid == -1U) {
 		boot_cpu_physical_apicid  = read_apic_id();
-- 
2.5.5

