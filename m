From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI:introduce boot option acpi=rsdt_forced
Date: Mon, 20 Aug 2007 17:48:13 +0800
Message-ID: <1187603293.3894.11.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [192.55.52.93] ([192.55.52.93]:24370 "EHLO mga11.intel.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbXHTJx6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2007 05:53:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Subject: ACPI: introduce boot option acpi=rsdt_forced
From: Zhao Yakui  <yakui.zhao@intel.com>

Maybe XSDT has NULL entry address. When it is found that
XSDT has NULL entry address, the promote info is given to user
(XSDT has NULL entry address, please try to boot with "acpi=rsdt_forced").
The system had better be booted with acpi=rsdt_forced option

http://bugzilla.kernel.org/show_bug.cgi?id=8630

Signed-off-by: Zhao Yakui  <yakui.zhao@intel.com>

---
 Documentation/kernel-parameters.txt |    1 +
 arch/i386/kernel/acpi/boot.c        |    4 ++++
 drivers/acpi/tables/tbutils.c       |   13 ++++++++++---
 include/acpi/acglobal.h             |    2 ++
 4 files changed, 17 insertions(+), 3 deletions(-)

Index: linux-2.6.23-rc3/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.23-rc3.orig/Documentation/kernel-parameters.txt
+++ linux-2.6.23-rc3/Documentation/kernel-parameters.txt
@@ -132,6 +132,7 @@ and is between 256 and 4096 characters. 
 			ht -- run only enough ACPI to enable Hyper Threading
 			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
+			rsdt_forced -- force to use RSDT table
 
 			See also Documentation/pm.txt, pci=noacpi
 
Index: linux-2.6.23-rc3/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.23-rc3.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2.6.23-rc3/arch/i386/kernel/acpi/boot.c
@@ -1248,6 +1248,10 @@ static int __init parse_acpi(char *arg)
 	/* "acpi=noirq" disables ACPI interrupt routing */
 	else if (strcmp(arg, "noirq") == 0) {
 		acpi_noirq_set();
+	}
+	/* "acpi=rsdt_forced" force to use RSDT */
+	else if (strcmp(arg, "rsdt_forced") == 0) {
+		rsdt_forced = 1;
 	} else {
 		/* Core will printk when we return error. */
 		return -EINVAL;
Index: linux-2.6.23-rc3/drivers/acpi/tables/tbutils.c
===================================================================
--- linux-2.6.23-rc3.orig/drivers/acpi/tables/tbutils.c
+++ linux-2.6.23-rc3/drivers/acpi/tables/tbutils.c
@@ -47,6 +47,7 @@
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbutils")
 
+u32 rsdt_forced ;
 /* Local prototypes */
 static acpi_physical_address
 acpi_tb_get_root_table_entry(u8 * table_entry,
@@ -341,6 +342,7 @@ acpi_tb_parse_root_table(acpi_physical_a
 	u32 table_count;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
+	acpi_physical_address entry_address;
 	u32 length;
 	u8 *table_entry;
 	acpi_status status;
@@ -361,7 +363,8 @@ acpi_tb_parse_root_table(acpi_physical_a
 
 	/* Differentiate between RSDT and XSDT root tables */
 
-	if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
+	if (rsdp->revision > 1 && rsdp->xsdt_physical_address
+		&& !rsdt_forced) {
 		/*
 		 * Root table is an XSDT (64-bit physical addresses). We must use the
 		 * XSDT if the revision is > 1 and the XSDT pointer is present, as per
@@ -455,11 +458,15 @@ acpi_tb_parse_root_table(acpi_physical_a
 		acpi_gbl_root_table_list.tables[acpi_gbl_root_table_list.count].
 		    address =
 		    acpi_tb_get_root_table_entry(table_entry, table_entry_size);
-
+		entry_address =
+		    acpi_tb_get_root_table_entry(table_entry, table_entry_size);
+		if (!entry_address && table_entry_size == sizeof(u64) ) {
+			ACPI_WARNING((AE_INFO, "XSDT has NULL entry. "
+			"Please try to boot with \"acpi=rsdt_forced\""));
+		}
 		table_entry += table_entry_size;
 		acpi_gbl_root_table_list.count++;
 	}
-
 	/*
 	 * It is not possible to map more than one entry in some environments,
 	 * so unmap the root table here before mapping other tables
Index: linux-2.6.23-rc3/include/acpi/acglobal.h
===================================================================
--- linux-2.6.23-rc3.orig/include/acpi/acglobal.h
+++ linux-2.6.23-rc3/include/acpi/acglobal.h
@@ -117,6 +117,8 @@ extern u32 acpi_dbg_layer;
 
 extern u32 acpi_gbl_nesting_level;
 
+extern u32 rsdt_forced;
+
 /* Event counters */
 
 ACPI_EXTERN u32 acpi_gpe_count;
