From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/25] ACPICA: acpidump: Add support for ACPI 1.0 GUID in Linux
Date: Tue,  8 Jul 2014 10:05:58 +0800
Message-ID: <b482c1414808485217bd589f880bd051da4fba7f.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33613 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbaGHCGy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:06:54 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>

For older EFI platforms, searches for the RSDP using ACPI 1.0 GUID if the
2.0 GUID search fails.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   48 +++++++++++++++++---
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 28c5200..0dc2485 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -77,6 +77,9 @@ osl_map_table(acpi_size address,
 
 static void osl_unmap_table(struct acpi_table_header *table);
 
+static acpi_physical_address
+osl_find_rsdp_via_efi_by_keyword(FILE * file, const char *keyword);
+
 static acpi_physical_address osl_find_rsdp_via_efi(void);
 
 static acpi_status osl_load_rsdp(void);
@@ -417,6 +420,38 @@ acpi_os_get_table_by_index(u32 index,
 
 /******************************************************************************
  *
+ * FUNCTION:    osl_find_rsdp_via_efi_by_keyword
+ *
+ * PARAMETERS:  keyword         - Character string indicating ACPI GUID version
+ *                                in the EFI table
+ *
+ * RETURN:      RSDP address if found
+ *
+ * DESCRIPTION: Find RSDP address via EFI using keyword indicating the ACPI
+ *              GUID version.
+ *
+ *****************************************************************************/
+
+static acpi_physical_address
+osl_find_rsdp_via_efi_by_keyword(FILE * file, const char *keyword)
+{
+	char buffer[80];
+	unsigned long long address = 0;
+	char format[32];
+
+	snprintf(format, 32, "%s=%s", keyword, "%llx");
+	fseek(file, 0, SEEK_SET);
+	while (fgets(buffer, 80, file)) {
+		if (sscanf(buffer, format, &address) == 1) {
+			break;
+		}
+	}
+
+	return ((acpi_physical_address) (address));
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    osl_find_rsdp_via_efi
  *
  * PARAMETERS:  None
@@ -430,20 +465,19 @@ acpi_os_get_table_by_index(u32 index,
 static acpi_physical_address osl_find_rsdp_via_efi(void)
 {
 	FILE *file;
-	char buffer[80];
-	unsigned long address = 0;
+	acpi_physical_address address = 0;
 
 	file = fopen(EFI_SYSTAB, "r");
 	if (file) {
-		while (fgets(buffer, 80, file)) {
-			if (sscanf(buffer, "ACPI20=0x%lx", &address) == 1) {
-				break;
-			}
+		address = osl_find_rsdp_via_efi_by_keyword(file, "ACPI20");
+		if (!address) {
+			address =
+			    osl_find_rsdp_via_efi_by_keyword(file, "ACPI");
 		}
 		fclose(file);
 	}
 
-	return ((acpi_physical_address) (address));
+	return (address);
 }
 
 /******************************************************************************
-- 
1.7.10

