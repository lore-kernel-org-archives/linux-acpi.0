From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/42] ACPICA: acpiexec: Add support for AML files containing multiple tables
Date: Tue, 29 Dec 2015 13:54:51 +0800
Message-ID: <81827f5d7bf7ae25fe3dd93b14ba0e0a3d168548.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 301f16e4037275888f65b88aec7231c1cd64339f

Add support for multi-AML-table files that originate from
either acpixtract or iASL.

Link: https://github.com/acpica/acpica/commit/301f16e4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    4 ++++
 drivers/acpi/acpica/utfileio.c |   23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 7495421..5d3ae91 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -356,6 +356,10 @@ acpi_ut_execute_power_methods(struct acpi_namespace_node *device_node,
  * utfileio - file operations
  */
 #ifdef ACPI_APPLICATION
+
+acpi_status
+acpi_ut_read_tables_from_file(FILE * file, struct acpi_table_header **table);
+
 acpi_status
 acpi_ut_read_table_from_file(char *filename, struct acpi_table_header **table);
 #endif
diff --git a/drivers/acpi/acpica/utfileio.c b/drivers/acpi/acpica/utfileio.c
index be49c71..e729486 100644
--- a/drivers/acpi/acpica/utfileio.c
+++ b/drivers/acpi/acpica/utfileio.c
@@ -292,6 +292,29 @@ acpi_ut_read_table(FILE * fp,
  ******************************************************************************/
 
 acpi_status
+acpi_ut_read_tables_from_file(FILE * file, struct acpi_table_header ** table)
+{
+	struct acpi_table_header table_header;
+	s32 count;
+	long position;
+
+	position = ftell(file);
+	count = fread(&table_header, 1, sizeof(struct acpi_table_header), file);
+	if (count < sizeof(struct acpi_table_header)) {
+		return (AE_CTRL_TERMINATE);
+	}
+
+	/* Allocate a buffer for the table */
+
+	*table = acpi_os_allocate((size_t) table_header.length);
+	fseek(file, position, SEEK_SET);
+
+	count = fread(*table, 1, table_header.length, file);
+
+	return (AE_OK);
+}
+
+acpi_status
 acpi_ut_read_table_from_file(char *filename, struct acpi_table_header ** table)
 {
 	FILE *file;
-- 
1.7.10
