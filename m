From: helgaas@kernel.org
Subject: [PATCH 2/4] ACPI / tables: Cleanup whitespace
Date: Mon, 25 Mar 2019 13:34:01 -0500
Message-ID: <20190325183403.251473-3-helgaas@kernel.org>
References: <20190325183403.251473-1-helgaas@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325183403.251473-1-helgaas@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Cleanup some whitespace to match the rest of the file.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/tables.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 8fccbe49612a..4672f9ef183a 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -240,8 +240,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
  * On success returns sum of all matching entries for all proc handlers.
  * Otherwise, -ENODEV or -EINVAL is returned.
  */
-static int __init
-acpi_parse_entries_array(char *id, unsigned long table_size,
+static int __init acpi_parse_entries_array(char *id, unsigned long table_size,
 		struct acpi_table_header *table_header,
 		struct acpi_subtable_proc *proc, int proc_num,
 		unsigned int max_entries)
@@ -314,8 +313,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	return errs ? -EINVAL : count;
 }
 
-int __init
-acpi_table_parse_entries_array(char *id,
+int __init acpi_table_parse_entries_array(char *id,
 			 unsigned long table_size,
 			 struct acpi_subtable_proc *proc, int proc_num,
 			 unsigned int max_entries)
@@ -346,8 +344,7 @@ acpi_table_parse_entries_array(char *id,
 	return count;
 }
 
-int __init
-acpi_table_parse_entries(char *id,
+int __init acpi_table_parse_entries(char *id,
 			unsigned long table_size,
 			int entry_id,
 			acpi_tbl_entry_handler handler,
@@ -362,8 +359,7 @@ acpi_table_parse_entries(char *id,
 						max_entries);
 }
 
-int __init
-acpi_table_parse_madt(enum acpi_madt_type id,
+int __init acpi_table_parse_madt(enum acpi_madt_type id,
 		      acpi_tbl_entry_handler handler, unsigned int max_entries)
 {
 	return acpi_table_parse_entries(ACPI_SIG_MADT,
@@ -725,8 +721,7 @@ static void *amlcode __attribute__ ((weakref("AmlCode")));
 static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
 #endif
 
-acpi_status
-acpi_os_table_override(struct acpi_table_header *existing_table,
+acpi_status acpi_os_table_override(struct acpi_table_header *existing_table,
 		       struct acpi_table_header **new_table)
 {
 	if (!existing_table || !new_table)
@@ -788,7 +783,6 @@ static int __init acpi_parse_apic_instance(char *str)
 
 	return 0;
 }
-
 early_param("acpi_apic_instance", acpi_parse_apic_instance);
 
 static int __init acpi_force_table_verification_setup(char *s)
@@ -797,7 +791,6 @@ static int __init acpi_force_table_verification_setup(char *s)
 
 	return 0;
 }
-
 early_param("acpi_force_table_verification", acpi_force_table_verification_setup);
 
 static int __init acpi_force_32bit_fadt_addr(char *s)
@@ -807,5 +800,4 @@ static int __init acpi_force_32bit_fadt_addr(char *s)
 
 	return 0;
 }
-
 early_param("acpi_force_32bit_fadt_addr", acpi_force_32bit_fadt_addr);
-- 
2.21.0.392.gf8f6787159e-goog
