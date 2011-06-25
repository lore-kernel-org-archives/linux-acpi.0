From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] ACPICA: Provide global table flags
Date: Sat, 25 Jun 2011 22:13:11 +0200
Message-ID: <201106252213.12486.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48561 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab1FYUNm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Jun 2011 16:13:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@lists.acpica.org
Cc: robert.moore@intel.com, ming.m.lin@intel.com, linux-acpi@vger.kernel.org, x86@kernel.org, lenb@kernel.org

Most tables get ioremapped before they are used (looks like the DSDT does
not get unmapped, therefore it works without this patch).

This happens in acpi_get_table(/_with_size/_by_index) if no valid virtual
address pointer is assigned yet to:
acpi_gbl_root_table_list.tables[table_index].pointer

In case that a table gets overridden, it already has valid pointer, but
not through ioremapping:
acpi_tb_install_table() -> tbutils.c
Therefore overridden tables must not get iounmapped.

The unmapping of tables which are only needed at boot time (APIC, HPET
and others) happens at least for some from outside of acpica code.
There it's hard to check whether the table needs to get unmapped or not.

Below patch introduces an acpica method which exports the global root
table flags. Functions outside of acpica can now check whether a table
was provided via overriding and must not get iounmapped.

Be aware that there are more places which need modification, for example:
drivers/acpi/apei/einj.c:       status = acpi_get_table(ACPI_SIG_EINJ, 0,
drivers/acpi/apei/erst.c:       status = acpi_get_table(ACPI_SIG_ERST, 0,
drivers/acpi/apei/hest.c:       status = acpi_get_table(ACPI_SIG_HEST, 0,


Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: robert.moore@intel.com
CC: devel@lists.acpica.org
CC: ming.m.lin@intel.com

---
 drivers/acpi/acpica/tbxface.c |   36 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c         |   28 ++++++++++++++++++++--------
 include/acpi/acpixf.h         |    3 +++
 3 files changed, 59 insertions(+), 8 deletions(-)

Index: linux-3.0-rc3-master/drivers/acpi/acpica/tbxface.c
===================================================================
--- linux-3.0-rc3-master.orig/drivers/acpi/acpica/tbxface.c
+++ linux-3.0-rc3-master/drivers/acpi/acpica/tbxface.c
@@ -447,6 +447,42 @@ acpi_get_table(char *signature,
 }
 ACPI_EXPORT_SYMBOL(acpi_get_table)
 
+acpi_status
+acpi_get_table_flags(char *signature,
+		     u32 instance, u8 *flags)
+{
+	u32 i;
+	u32 j;
+	acpi_status status = AE_OK;
+
+	/* Parameter validation */
+
+	if (!signature) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	/* Walk the root table list */
+
+	for (i = 0, j = 0; i < acpi_gbl_root_table_list.current_table_count;
+	     i++) {
+		if (!ACPI_COMPARE_NAME
+		    (&(acpi_gbl_root_table_list.tables[i].signature),
+		     signature)) {
+			continue;
+		}
+
+		if (++j < instance) {
+			continue;
+		}
+
+		*flags = acpi_gbl_root_table_list.tables[i].flags;
+
+		return (status);
+	}
+	return (AE_NOT_FOUND);
+}
+ACPI_EXPORT_SYMBOL(acpi_get_table_flags)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_table_by_index
Index: linux-3.0-rc3-master/drivers/acpi/tables.c
===================================================================
--- linux-3.0-rc3-master.orig/drivers/acpi/tables.c
+++ linux-3.0-rc3-master/drivers/acpi/tables.c
@@ -212,6 +212,7 @@ acpi_table_parse_entries(char *id,
 	unsigned int count = 0;
 	unsigned long table_end;
 	acpi_size tbl_size;
+	u8 tb_flags;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -219,10 +220,14 @@ acpi_table_parse_entries(char *id,
 	if (!handler)
 		return -EINVAL;
 
-	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
-		acpi_get_table_with_size(id, acpi_apic_instance, &table_header, &tbl_size);
-	else
+	if (strncmp(id, ACPI_SIG_MADT, 4) == 0) {
+		acpi_get_table_with_size(id, acpi_apic_instance,
+					 &table_header, &tbl_size);
+		acpi_get_table_flags(id, acpi_apic_instance, &tb_flags);
+	} else {
 		acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
+		acpi_get_table_flags(id, 0, &tb_flags);
+	}
 
 	if (!table_header) {
 		printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
@@ -241,7 +246,8 @@ acpi_table_parse_entries(char *id,
 		if (entry->type == entry_id
 		    && (!max_entries || count++ < max_entries))
 			if (handler(entry, table_end)) {
-				early_acpi_os_unmap_memory((char *)table_header, tbl_size);
+				if (tb_flags != ACPI_TABLE_ORIGIN_OVERRIDE)
+					early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 				return -EINVAL;
 			}
 
@@ -253,7 +259,8 @@ acpi_table_parse_entries(char *id,
 		       "%i found\n", id, entry_id, count - max_entries, count);
 	}
 
-	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
+	if (tb_flags != ACPI_TABLE_ORIGIN_OVERRIDE)
+		early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 	return count;
 }
 
@@ -279,6 +286,7 @@ int __init acpi_table_parse(char *id, ac
 {
 	struct acpi_table_header *table = NULL;
 	acpi_size tbl_size;
+	u8 tb_flags;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -286,14 +294,18 @@ int __init acpi_table_parse(char *id, ac
 	if (!handler)
 		return -EINVAL;
 
-	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
+	if (strncmp(id, ACPI_SIG_MADT, 4) == 0) {
 		acpi_get_table_with_size(id, acpi_apic_instance, &table, &tbl_size);
-	else
+		acpi_get_table_flags(id, acpi_apic_instance, &tb_flags);
+	} else {
 		acpi_get_table_with_size(id, 0, &table, &tbl_size);
+		acpi_get_table_flags(id, 0, &tb_flags);
+	}
 
 	if (table) {
 		handler(table);
-		early_acpi_os_unmap_memory(table, tbl_size);
+		if (tb_flags != ACPI_TABLE_ORIGIN_OVERRIDE)
+			early_acpi_os_unmap_memory(table, tbl_size);
 		return 0;
 	} else
 		return 1;
Index: linux-3.0-rc3-master/include/acpi/acpixf.h
===================================================================
--- linux-3.0-rc3-master.orig/include/acpi/acpixf.h
+++ linux-3.0-rc3-master/include/acpi/acpixf.h
@@ -150,6 +150,9 @@ acpi_get_table_by_index(u32 table_index,
 			struct acpi_table_header **out_table);
 
 acpi_status
+acpi_get_table_flags(acpi_string signature, u32 instance, u8 *flags);
+
+acpi_status
 acpi_install_table_handler(acpi_tbl_handler handler, void *context);
 
 acpi_status acpi_remove_table_handler(acpi_tbl_handler handler);
