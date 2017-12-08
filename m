From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 2/4] x86/acpi: take rsdp address for boot params if available
Date: Fri,  8 Dec 2017 16:11:37 +0100
Message-ID: <20171208151139.30213-3-jgross@suse.com>
References: <20171208151139.30213-1-jgross@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754095AbdLHPLt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Dec 2017 10:11:49 -0500
In-Reply-To: <20171208151139.30213-1-jgross@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Cc: boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Juergen Gross <jgross@suse.com>

In case the rsdp address in struct boot_params is specified don't try
to find the table by searching, but take the address directly as set
by the boot loader.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3: use a generic retrieval function with a __weak annotated default
    function (Ingo Molnar)
---
 arch/x86/kernel/acpi/boot.c |  7 +++++++
 drivers/acpi/osl.c          | 10 +++++++++-
 include/linux/acpi.h        |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index f4c463df8b08..26fc8972dc4b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -47,6 +47,7 @@
 #include <asm/mpspec.h>
 #include <asm/smp.h>
 #include <asm/i8259.h>
+#include <asm/setup.h>
 
 #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force = 0;
@@ -1758,3 +1759,9 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	e820__range_add(addr, size, E820_TYPE_ACPI);
 	e820__update_table_print();
 }
+
+acpi_physical_address acpi_arch_get_root_pointer(void)
+{
+	return boot_params.hdr.acpi_rsdp_addr;
+}
+EXPORT_SYMBOL_GPL(acpi_arch_get_root_pointer);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3bb46cb24a99..2b77db914752 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -178,6 +178,11 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 #endif
 }
 
+__weak acpi_physical_address acpi_arch_get_root_pointer(void)
+{
+	return 0;
+}
+
 #ifdef CONFIG_KEXEC
 static unsigned long acpi_rsdp;
 static int __init setup_acpi_rsdp(char *arg)
@@ -189,12 +194,15 @@ early_param("acpi_rsdp", setup_acpi_rsdp);
 
 acpi_physical_address __init acpi_os_get_root_pointer(void)
 {
-	acpi_physical_address pa = 0;
+	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
 	if (acpi_rsdp)
 		return acpi_rsdp;
 #endif
+	pa = acpi_arch_get_root_pointer();
+	if (pa)
+		return pa;
 
 	if (efi_enabled(EFI_CONFIG_TABLES)) {
 		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index dc1ebfeeb5ec..aa603cc5ad30 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1266,4 +1266,6 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+acpi_physical_address acpi_arch_get_root_pointer(void);
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.12.3

