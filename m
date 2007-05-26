From: Andi Drebes <lists-receive@programmierforen.de>
Subject: [KJ] [PATCH] drivers/acpi: sizeof/sizeof array size calculations
	replaced with ARRAY_SIZE
Date: Sat, 26 May 2007 10:39:27 +0000
Message-ID: <200705261239.27485.lists-receive@programmierforen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/kernel-janitors>
List-Post: <mailto:kernel-janitors@lists.linux-foundation.org>
List-Help: <mailto:kernel-janitors-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.linux-foundation.org?subject=subscribe>
Sender: kernel-janitors-bounces@lists.linux-foundation.org
Errors-To: kernel-janitors-bounces@lists.linux-foundation.org
To: kernel-janitors@lists.osdl.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch replaces lines in the acpi subsystem that use
sizeof/sizeof to determine the size of an array with the
ARRAY_SIZE(x) macro.

Signed-off-by: Andi Drebes <lists-receive@programmierforen.de>
---
Compile tested with allyesconfig on i386.
Diffed against Linus' git-tree.


diff --git a/drivers/acpi/resources/rsdump.c b/drivers/acpi/resources/rsdump.c
index 46da116..7b8e12d 100644
--- a/drivers/acpi/resources/rsdump.c
+++ b/drivers/acpi/resources/rsdump.c
@@ -76,7 +76,7 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table);
 
 #define ACPI_RSD_OFFSET(f)          (u8) ACPI_OFFSET (union acpi_resource_data,f)
 #define ACPI_PRT_OFFSET(f)          (u8) ACPI_OFFSET (struct acpi_pci_routing_table,f)
-#define ACPI_RSD_TABLE_SIZE(name)   (sizeof(name) / sizeof (struct acpi_rsdump_info))
+#define ACPI_RSD_TABLE_SIZE(name)   (ARRAY_SIZE(name))
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 1285e91..4d59de2 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -104,7 +104,7 @@ static struct acpi_fadt_info fadt_info_table[] = {
 	 ACPI_FADT_OFFSET(gpe1_block_length), ACPI_FADT_SEPARATE_LENGTH}
 };
 
-#define ACPI_FADT_INFO_ENTRIES        (sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
+#define ACPI_FADT_INFO_ENTRIES        (ARRAY_SIZE(fadt_info_table))
 
 /*******************************************************************************
  *
