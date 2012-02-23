From: Tang Liang <liang.tang@oracle.com>
Subject: [PATCH 2/5V2] EFI: seperate get efi table info code to single function
Date: Thu, 23 Feb 2012 17:13:30 +0800
Message-ID: <1329988410-26930-1-git-send-email-liang.tang@oracle.com>
References: <1329988283-26722-1-git-send-email-liang.tang@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329988283-26722-1-git-send-email-liang.tang@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mjg59@srcf.ucam.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, konrad.wilk@oracle.com, JBeulich@suse.com
Cc: liang.tang@oracle.com
List-Id: linux-acpi@vger.kernel.org

Seperate get efi table info code to generic function,
xen efi driver will call it too.

Signed-off-by: Tang Liang <liang.tang@oracle.com>
Suggested-by:: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/platform/efi/efi.c |   77 ++++++++++++++++++++++++-------------------
 include/linux/efi.h         |    2 +
 2 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index dd690e6..dcb7842 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -447,6 +447,47 @@ static void __init efi_free_boot_services(void)
 	}
 }
 
+void get_efi_table_info(efi_config_table_t *config_tables, int nr_tables,
+			struct efi *efi_t)
+{
+	int i;
+
+	printk(KERN_INFO);
+	for (i = 0; i < nr_tables; i++) {
+		if (!efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID)) {
+			efi_t->mps = config_tables[i].table;
+			printk(" MPS=0x%lx ", config_tables[i].table);
+		} else if (!efi_guidcmp(config_tables[i].guid,
+					ACPI_20_TABLE_GUID)) {
+			efi_t->acpi20 = config_tables[i].table;
+			printk(" ACPI 2.0=0x%lx ", config_tables[i].table);
+		} else if (!efi_guidcmp(config_tables[i].guid,
+					ACPI_TABLE_GUID)) {
+			efi_t->acpi = config_tables[i].table;
+			printk(" ACPI=0x%lx ", config_tables[i].table);
+		} else if (!efi_guidcmp(config_tables[i].guid,
+					SMBIOS_TABLE_GUID)) {
+			efi_t->smbios = config_tables[i].table;
+			printk(" SMBIOS=0x%lx ", config_tables[i].table);
+#ifdef CONFIG_X86_UV
+		} else if (!efi_guidcmp(config_tables[i].guid,
+					UV_SYSTEM_TABLE_GUID)) {
+			efi_t->uv_systab = config_tables[i].table;
+			printk(" UVsystab=0x%lx ", config_tables[i].table);
+#endif
+		} else if (!efi_guidcmp(config_tables[i].guid,
+					HCDP_TABLE_GUID)) {
+			efi_t->hcdp = config_tables[i].table;
+			printk(" HCDP=0x%lx ", config_tables[i].table);
+		} else if (!efi_guidcmp(config_tables[i].guid,
+					UGA_IO_PROTOCOL_GUID)) {
+			efi_t->uga = config_tables[i].table;
+			printk(" UGA=0x%lx ", config_tables[i].table);
+		}
+	}
+	printk("\n");
+}
+
 static void efi_init_generic(void)
 {
 	efi_config_table_t *config_tables;
@@ -508,40 +549,8 @@ static void efi_init_generic(void)
 	if (config_tables == NULL)
 		printk(KERN_ERR "Could not map EFI Configuration Table!\n");
 
-	printk(KERN_INFO);
-	for (i = 0; i < efi.systab->nr_tables; i++) {
-		if (!efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID)) {
-			efi.mps = config_tables[i].table;
-			printk(" MPS=0x%lx ", config_tables[i].table);
-		} else if (!efi_guidcmp(config_tables[i].guid,
-					ACPI_20_TABLE_GUID)) {
-			efi.acpi20 = config_tables[i].table;
-			printk(" ACPI 2.0=0x%lx ", config_tables[i].table);
-		} else if (!efi_guidcmp(config_tables[i].guid,
-					ACPI_TABLE_GUID)) {
-			efi.acpi = config_tables[i].table;
-			printk(" ACPI=0x%lx ", config_tables[i].table);
-		} else if (!efi_guidcmp(config_tables[i].guid,
-					SMBIOS_TABLE_GUID)) {
-			efi.smbios = config_tables[i].table;
-			printk(" SMBIOS=0x%lx ", config_tables[i].table);
-#ifdef CONFIG_X86_UV
-		} else if (!efi_guidcmp(config_tables[i].guid,
-					UV_SYSTEM_TABLE_GUID)) {
-			efi.uv_systab = config_tables[i].table;
-			printk(" UVsystab=0x%lx ", config_tables[i].table);
-#endif
-		} else if (!efi_guidcmp(config_tables[i].guid,
-					HCDP_TABLE_GUID)) {
-			efi.hcdp = config_tables[i].table;
-			printk(" HCDP=0x%lx ", config_tables[i].table);
-		} else if (!efi_guidcmp(config_tables[i].guid,
-					UGA_IO_PROTOCOL_GUID)) {
-			efi.uga = config_tables[i].table;
-			printk(" UGA=0x%lx ", config_tables[i].table);
-		}
-	}
-	printk("\n");
+	get_efi_table_info(config_tables, efi.systab->nr_tables, &efi);
+
 	early_iounmap(config_tables,
 			  efi.systab->nr_tables * sizeof(efi_config_table_t));
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 469ac66..4276c96 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -475,6 +475,8 @@ extern int efi_set_rtc_mmss(unsigned long nowtime);
 extern void efi_reserve_boot_services(void);
 extern struct efi_memory_map memmap;
 extern void efi_init_function_register(const struct efi_init_funcs *funcs);
+extern void get_efi_table_info(efi_config_table_t *config_tables, int nr_tables,
+			       struct efi *efi_t);
 
 /**
  * efi_range_is_wc - check the WC bit on an address range
-- 
1.7.7.5
