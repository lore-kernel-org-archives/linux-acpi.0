From: akpm@linux-foundation.org
Subject: [patch 1/8] git-acpi: ia64 build fix
Date: Thu, 13 Dec 2007 15:53:33 -0800
Message-ID: <200712132353.lBDNrXQP024818@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57110 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758113AbXLMXyD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 18:54:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org

From: Andrew Morton <akpm@linux-foundation.org>

arch/ia64/kernel/acpi.c: In function `acpi_get_sysname':
arch/ia64/kernel/acpi.c:81: error: implicit declaration of function `acpi_find_rsdp'
arch/ia64/kernel/acpi.c: At top level:
arch/ia64/kernel/acpi.c:631: error: conflicting types for 'acpi_find_rsdp'
arch/ia64/kernel/acpi.c:81: error: previous implicit declaration of 'acpi_find_rsdp' was here

Cc: Len Brown <lenb@kernel.org>
Cc: <linux-acpi@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/ia64/kernel/acpi.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff -puN arch/ia64/kernel/acpi.c~git-acpi-ia64-build-fix arch/ia64/kernel/acpi.c
--- a/arch/ia64/kernel/acpi.c~git-acpi-ia64-build-fix
+++ a/arch/ia64/kernel/acpi.c
@@ -67,7 +67,19 @@ EXPORT_SYMBOL(pm_power_off);
 unsigned int acpi_cpei_override;
 unsigned int acpi_cpei_phys_cpuid;
 
-unsigned long acpi_wakeup_address = 0;
+unsigned long acpi_wakeup_address;
+
+unsigned long __init acpi_find_rsdp(void)
+{
+	unsigned long rsdp_phys = 0;
+
+	if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+		rsdp_phys = efi.acpi20;
+	else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+		printk(KERN_WARNING PREFIX
+		       "v1.0/r0.71 tables no longer supported\n");
+	return rsdp_phys;
+}
 
 const char __init *
 acpi_get_sysname(void)
@@ -627,18 +639,6 @@ static int __init acpi_parse_fadt(struct
 	return 0;
 }
 
-unsigned long __init acpi_find_rsdp(void)
-{
-	unsigned long rsdp_phys = 0;
-
-	if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
-		rsdp_phys = efi.acpi20;
-	else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
-		printk(KERN_WARNING PREFIX
-		       "v1.0/r0.71 tables no longer supported\n");
-	return rsdp_phys;
-}
-
 int __init acpi_boot_init(void)
 {
 
_
