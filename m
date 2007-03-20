From: Len Brown <len.brown@intel.com>
Subject: [PATCH 1/9] ACPI: Add support to parse 2nd MADT
Date: Tue, 20 Mar 2007 11:27:03 -0400
Message-ID: <11744044323719-git-send-email-len.brown@intel.com>
References: <1174404431897-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34190 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933798AbXCTP1a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:27:30 -0400
In-Reply-To: <1174404431897-git-send-email-len.brown@intel.com>
Message-Id: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

When a BIOS bug presents multiple APIC/MADTs,
Linux currently uses the 1st and ignores the 2nd.

But some machines work better if we use the 2nd.

http://bugzilla.kernel.org/show_bug.cgi?id=7465

Add a warning and boot parameter "acpi_apic_instance=2"
to allow parsing the 2nd.

No change to default behaviour in this patch.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    6 ++++
 drivers/acpi/tables.c               |   57 +++++++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 856c8b1..22c6b8c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -138,6 +138,12 @@ and is between 256 and 4096 characters. It is defined in the file
 
 			See also Documentation/pm.txt, pci=noacpi
 
+	acpi_apic_instance=	[ACPI, IOAPIC]
+			Format: <int>
+			2: use 2nd APIC table, if available
+			1,0: use 1st APIC table
+			default: 0
+
 	acpi_sleep=	[HW,ACPI] Sleep options
 			Format: { s3_bios, s3_mode }
 			See Documentation/power/video.txt
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 849e2c3..c341918 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -42,7 +42,9 @@ static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
 
 static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
-void acpi_table_print_madt_entry(struct acpi_subtable_header * header)
+static int acpi_apic_instance __initdata;
+
+void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 {
 	if (!header)
 		return;
@@ -183,8 +185,10 @@ acpi_table_parse_entries(char *id,
 	if (!handler)
 		return -EINVAL;
 
-	/* Locate the table (if exists). There should only be one. */
-	acpi_get_table(id, 0, &table_header);
+	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
+		acpi_get_table(id, acpi_apic_instance, &table_header);
+	else
+		acpi_get_table(id, 0, &table_header);
 
 	if (!table_header) {
 		printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
@@ -237,10 +241,15 @@ acpi_table_parse_madt(enum acpi_madt_type id,
 int __init acpi_table_parse(char *id, acpi_table_handler handler)
 {
 	struct acpi_table_header *table = NULL;
+
 	if (!handler)
 		return -EINVAL;
 
-	acpi_get_table(id, 0, &table);
+	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
+		acpi_get_table(id, acpi_apic_instance, &table);
+	else
+		acpi_get_table(id, 0, &table);
+
 	if (table) {
 		handler(table);
 		return 0;
@@ -248,6 +257,31 @@ int __init acpi_table_parse(char *id, acpi_table_handler handler)
 		return 1;
 }
 
+/* 
+ * The BIOS is supposed to supply a single APIC/MADT,
+ * but some report two.  Provide a knob to use either.
+ * (don't you wish instance 0 and 1 were not the same?)
+ */
+static void __init check_multiple_madt(void)
+{
+	struct acpi_table_header *table = NULL;
+
+	acpi_get_table(ACPI_SIG_MADT, 2, &table);
+	if (table) {
+		printk(KERN_WARNING PREFIX
+		       "BIOS bug: multiple APIC/MADT found,"
+		       " using %d\n", acpi_apic_instance);
+		printk(KERN_WARNING PREFIX
+		       "If \"acpi_apic_instance=%d\" works better, "
+		       "notify linux-acpi@vger.kernel.org\n",
+		       acpi_apic_instance ? 0 : 2);
+
+	} else
+		acpi_apic_instance = 0;
+
+	return;
+}
+
 /*
  * acpi_table_init()
  *
@@ -257,9 +291,22 @@ int __init acpi_table_parse(char *id, acpi_table_handler handler)
  * result: sdt_entry[] is initialized
  */
 
-
 int __init acpi_table_init(void)
 {
 	acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
+	check_multiple_madt();
+	return 0;
+}
+
+static int __init acpi_parse_apic_instance(char *str)
+{
+
+	acpi_apic_instance = simple_strtoul(str, NULL, 0);
+
+	printk(KERN_NOTICE PREFIX "Shall use APIC/MADT table %d\n",
+	       acpi_apic_instance);
+
 	return 0;
 }
+
+early_param("acpi_apic_instance", acpi_parse_apic_instance);
-- 
1.5.0.3.382.g34572
