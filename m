From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/3] ACPI / tables: Convert the initrd table override mechanisms to the table upgrade mechanism
Date: Mon, 11 Apr 2016 10:13:33 +0800
Message-ID: <b4bd2cb8102b66c034f94abae2969797d004f039.1460340514.git.lv.zheng@intel.com>
References: <273fd92043ff4972a71a94efdf01b67ee4638131> <cover.1460340514.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:40599 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbcDKCOB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Apr 2016 22:14:01 -0400
In-Reply-To: <cover.1460340514.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch converts the initrd table override mechanism to the table
upgrade mechanism by restricting its usage to the tables released with
compatibility and more recent revision.

This use case has been encouraged by the ACPI specification:
1. OEMID:
   An OEM-supplied string that identifies the OEM.
2. OEM Table ID:
   An OEM-supplied string that the OEM uses to identify the particular data
   table. This field is particularly useful when defining a definition
   block to distinguish definition block functions. OEM assigns each
   dissimilar table a new OEM Table Id.
3. OEM Revision:
   An OEM-supplied revision number. Larger numbers are assumed to be newer
   revisions.
For OEMs, good practices will ensure consistency when assigning OEMID and
OEM Table ID fields in any table. The intent of these fields is to allow
for a binary control system that support services can use. Because many
support function can be automated, it is useful when a tool can
programatically determine which table release is a compatible and more
recent revision of a prior table on the same OEMID and OEM Table ID.

The facility can now be used by the vendors to upgrade wrong tables for bug
fixing purpose, thus lockdep disabling taint is not suitable for it and it
should be a default 'y' option to implement the spec encouraged use case.

Note that, by implementing table upgrade inside of ACPICA itself, it is
possible to remove acpi_table_initrd_override() and tables can be upgraded
by acpi_install_table() automatically. Though current ACPICA impelentation
hasn't implemented this, this patched changes the table flag setting timing
to allow this to be implemented in ACPICA without changing the code here.

Documentation of initrd override mechanism is upgraded accordingly.

Original-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/acpi/initrd_table_override.txt |   65 +++++++++++++++-----------
 drivers/acpi/Kconfig                         |    8 ++--
 drivers/acpi/tables.c                        |   48 +++++++++++++------
 3 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/Documentation/acpi/initrd_table_override.txt b/Documentation/acpi/initrd_table_override.txt
index 35c3f54..eb651a6 100644
--- a/Documentation/acpi/initrd_table_override.txt
+++ b/Documentation/acpi/initrd_table_override.txt
@@ -1,5 +1,5 @@
-Overriding ACPI tables via initrd
-=================================
+Upgrading ACPI tables via initrd
+================================
 
 1) Introduction (What is this about)
 2) What is this for
@@ -9,12 +9,14 @@ Overriding ACPI tables via initrd
 1) What is this about
 ---------------------
 
-If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible to
-override nearly any ACPI table provided by the BIOS with an instrumented,
-modified one.
+If the ACPI_TABLE_UPGRADE compile option is true, it is possible to
+upgrade the ACPI execution environment that is defined by the ACPI tables
+via upgrading the ACPI tables provided by the BIOS with an instrumented,
+modified, more recent version one, or installing brand new ACPI tables.
 
-For a full list of ACPI tables that can be overridden, take a look at
-the char *table_sigs[MAX_ACPI_SIGNATURE]; definition in drivers/acpi/osl.c
+For a full list of ACPI tables that can be upgraded/installed, take a look
+at the char *table_sigs[MAX_ACPI_SIGNATURE]; definition in
+drivers/acpi/tables.c.
 All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows should
 be overridable, except:
    - ACPI_SIG_RSDP (has a signature of 6 bytes)
@@ -25,17 +27,20 @@ Both could get implemented as well.
 2) What is this for
 -------------------
 
-Please keep in mind that this is a debug option.
-ACPI tables should not get overridden for productive use.
-If BIOS ACPI tables are overridden the kernel will get tainted with the
-TAINT_OVERRIDDEN_ACPI_TABLE flag.
-Complain to your platform/BIOS vendor if you find a bug which is so sever
-that a workaround is not accepted in the Linux kernel.
+Complain to your platform/BIOS vendor if you find a bug which is so severe
+that a workaround is not accepted in the Linux kernel. And this facility
+allows you to upgrade the buggy tables before your platform/BIOS vendor
+releases an upgraded BIOS binary.
 
-Still, it can and should be enabled in any kernel, because:
-  - There is no functional change with not instrumented initrds
-  - It provides a powerful feature to easily debug and test ACPI BIOS table
-    compatibility with the Linux kernel.
+This facility can be used by platform/BIOS vendors to provide a Linux
+compatible environment without modifying the underlying platform firmware.
+
+This facility also provides a powerful feature to easily debug and test
+ACPI BIOS table compatibility with the Linux kernel by modifying old
+platform provided ACPI tables or inserting new ACPI tables.
+
+It can and should be enabled in any kernel because there is no functional
+change with not instrumented initrds.
 
 
 3) How does it work
@@ -50,23 +55,31 @@ iasl -d *.dat
 # For example add this statement into a _PRT (PCI Routing Table) function
 # of the DSDT:
 Store("HELLO WORLD", debug)
+# And increase the OEM Revision. For example, before modification:
+DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
+# After modification:
+DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
 iasl -sa dsdt.dsl
 # Add the raw ACPI tables to an uncompressed cpio archive.
-# They must be put into a /kernel/firmware/acpi directory inside the
-# cpio archive.
-# The uncompressed cpio archive must be the first.
-# Other, typically compressed cpio archives, must be
-# concatenated on top of the uncompressed one.
+# They must be put into a /kernel/firmware/acpi directory inside the cpio
+# archive. Note that if the table put here matches a platform table
+# (similar Table Signature, and similar OEMID, and similar OEM Table ID)
+# with a more recent OEM Revision, the platform table will be upgraded by
+# this table. If the table put here doesn't match a platform table
+# (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
+# ID), this table will be appended.
 mkdir -p kernel/firmware/acpi
 cp dsdt.aml kernel/firmware/acpi
-# A maximum of: #define ACPI_OVERRIDE_TABLES 10
-# tables are  currently allowed (see osl.c):
+# A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
+# (see osl.c):
 iasl -sa facp.dsl
 iasl -sa ssdt1.dsl
 cp facp.aml kernel/firmware/acpi
 cp ssdt1.aml kernel/firmware/acpi
-# Create the uncompressed cpio archive and concatenate the original initrd
-# on top:
+# The uncompressed cpio archive must be the first. Other, typically
+# compressed cpio archives, must be concatenated on top of the uncompressed
+# one. Following command creates the uncompressed cpio archive and
+# concatenates the original initrd on top:
 find kernel | cpio -H newc --create > /boot/instrumented_initrd
 cat /boot/initrd >>/boot/instrumented_initrd
 # reboot with increased acpi debug level, e.g. boot params:
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 82b96ee..b225c4b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -311,12 +311,12 @@ config ACPI_CUSTOM_DSDT
 	bool
 	default ACPI_CUSTOM_DSDT_FILE != ""
 
-config ACPI_INITRD_TABLE_OVERRIDE
-	bool "ACPI tables override via initrd"
+config ACPI_TABLE_UPGRADE
+	bool "Allow upgrading ACPI tables via initrd"
 	depends on BLK_DEV_INITRD && X86
-	default n
+	default y
 	help
-	  This option provides functionality to override arbitrary ACPI tables
+	  This option provides functionality to upgrade arbitrary ACPI tables
 	  via initrd. No functional change if no ACPI tables are passed via
 	  initrd, therefore it's safe to say Y.
 	  See Documentation/acpi/initrd_table_override.txt for details
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2e74dbf..08795fb 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -442,7 +442,7 @@ static void acpi_table_taint(struct acpi_table_header *table)
 	add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
 }
 
-#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
+#ifdef CONFIG_ACPI_TABLE_UPGRADE
 static u64 acpi_tables_addr;
 static int all_tables_size;
 
@@ -471,9 +471,9 @@ static const char * const table_sigs[] = {
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-#define ACPI_OVERRIDE_TABLES 64
-static struct cpio_data __initdata acpi_initrd_files[ACPI_OVERRIDE_TABLES];
-static DECLARE_BITMAP(acpi_initrd_installed, ACPI_OVERRIDE_TABLES);
+#define NR_ACPI_INITRD_TABLES 64
+static struct cpio_data __initdata acpi_initrd_files[NR_ACPI_INITRD_TABLES];
+static DECLARE_BITMAP(acpi_initrd_installed, NR_ACPI_INITRD_TABLES);
 
 #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
 
@@ -488,7 +488,7 @@ static void __init acpi_table_initrd_init(void *data, size_t size)
 	if (data == NULL || size == 0)
 		return;
 
-	for (no = 0; no < ACPI_OVERRIDE_TABLES; no++) {
+	for (no = 0; no < NR_ACPI_INITRD_TABLES; no++) {
 		file = find_cpio_data(cpio_path, data, size, &offset);
 		if (!file.data)
 			break;
@@ -611,19 +611,30 @@ acpi_table_initrd_override(struct acpi_table_header *existing_table,
 		table_length = table->length;
 
 		/* Only override tables matched */
-		if (test_bit(table_index, acpi_initrd_installed) ||
-		    memcmp(existing_table->signature, table->signature, 4) ||
+		if (memcmp(existing_table->signature, table->signature, 4) ||
+		    memcmp(table->oem_id, existing_table->oem_id,
+			   ACPI_OEM_ID_SIZE) ||
 		    memcmp(table->oem_table_id, existing_table->oem_table_id,
 			   ACPI_OEM_TABLE_ID_SIZE)) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 			goto next_table;
 		}
+		/*
+		 * Mark the table to avoid being used in
+		 * acpi_table_initrd_scan() and check the revision.
+		 */
+		if (test_and_set_bit(table_index, acpi_initrd_installed) ||
+		    existing_table->oem_revision >= table->oem_revision) {
+			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+			goto next_table;
+		}
 
 		*length = table_length;
 		*address = acpi_tables_addr + table_offset;
-		acpi_table_taint(existing_table);
+		pr_info("Table Upgrade: override [%4.4s-%6.6s-%8.8s]\n",
+			table->signature, table->oem_id,
+			table->oem_table_id);
 		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
-		set_bit(table_index, acpi_initrd_installed);
 		break;
 
 next_table:
@@ -655,17 +666,26 @@ static void __init acpi_table_initrd_scan(void)
 		table_length = table->length;
 
 		/* Skip RSDT/XSDT which should only be used for override */
-		if (test_bit(table_index, acpi_initrd_installed) ||
-		    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_RSDT) ||
+		if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_RSDT) ||
 		    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_XSDT)) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 			goto next_table;
 		}
+		/*
+		 * Mark the table to avoid being used in
+		 * acpi_table_initrd_override(). Though this is not possible
+		 * because override is disabled in acpi_install_table().
+		 */
+		if (test_and_set_bit(table_index, acpi_initrd_installed)) {
+			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
+			goto next_table;
+		}
 
-		acpi_table_taint(table);
+		pr_info("Table Upgrade: install [%4.4s-%6.6s-%8.8s]\n",
+			table->signature, table->oem_id,
+			table->oem_table_id);
 		acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 		acpi_install_table(acpi_tables_addr + table_offset, TRUE);
-		set_bit(table_index, acpi_initrd_installed);
 next_table:
 		table_offset += table_length;
 		table_index++;
@@ -689,7 +709,7 @@ acpi_table_initrd_override(struct acpi_table_header *existing_table,
 static void __init acpi_table_initrd_scan(void)
 {
 }
-#endif /* CONFIG_ACPI_INITRD_TABLE_OVERRIDE */
+#endif /* CONFIG_ACPI_TABLE_UPGRADE */
 
 acpi_status
 acpi_os_physical_table_override(struct acpi_table_header *existing_table,
-- 
1.7.10

