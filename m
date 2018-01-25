From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 1/2] x86/acpi: add retrieval function for rsdp address
Date: Thu, 25 Jan 2018 11:04:53 +0100
Message-ID: <20180125100454.23203-2-jgross@suse.com>
References: <20180125100454.23203-1-jgross@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180125100454.23203-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: lenb@kernel.org, rafael.j.wysocki@intel.com, mingo@redhat.com, boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Add a function to get the address of the RSDP table. Per default use a
__weak annotated function being a nop.

Cc: <stable@vger.kernel.org> # 4.11
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/acpi/osl.c   | 10 +++++++++-
 include/linux/acpi.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

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
2.13.6
