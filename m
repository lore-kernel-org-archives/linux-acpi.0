From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/2] x86/acpi: Remove the repeated lapic address override
 entry parsing
Date: Thu, 30 Jun 2016 16:01:18 +0800
Message-ID: <20160630080118.GD7175@x1.redhat.com>
References: <1467070896-4186-1-git-send-email-bhe@redhat.com>
 <1467070896-4186-2-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46761 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbcF3ICq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jun 2016 04:02:46 -0400
Content-Disposition: inline
In-Reply-To: <1467070896-4186-2-git-send-email-bhe@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, Shaohua Li <shli@fb.com>, Viresh Kumar <viresh.kumar@linaro.org>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Juergen Gross <jgross@suse.com>, Joerg Roedel <jroedel@suse.de>, Dave Young <dyoung@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Mark Salter <msalter@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org

ACPI MADT has a 32-bit field providing lapic address at which
each processor can access its lapic information. MADT also contains
an optional entry to provide a 64-bit address to override the 32-bit
one. However the current code does the lapic address override entry
parsing twice. One is in early_acpi_boot_init() because AMD NUMA need
get boot_cpu_id earlier. The other is in acpi_boot_init() which parses
all MADT entries.

So in this patch remove the repeated code in the 2nd part. Meanwhile
print lapic override entry information like other MADT entry.

Signed-off-by: Baoquan He <bhe@redhat.com>
---

v1->v2:
   -Remove the not correct code comment above early_acpi_boot_init()
    as Rafael suggested.

 arch/x86/kernel/acpi/boot.c | 17 ++---------------
 arch/x86/kernel/apic/apic.c |  2 +-
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 9414f84..6ef3694 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -274,6 +274,8 @@ acpi_parse_lapic_addr_ovr(struct acpi_subtable_header * header,
 	if (BAD_MADT_ENTRY(lapic_addr_ovr, end))
 		return -EINVAL;
 
+	acpi_table_print_madt_entry(header);
+
 	acpi_lapic_addr = lapic_addr_ovr->address;
 
 	return 0;
@@ -990,21 +992,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
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
index 60078a6..504311c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1799,7 +1799,7 @@ void __init register_lapic_address(unsigned long address)
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

