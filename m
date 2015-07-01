From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 18/26] ACPICA: acpidump: Allow customized tables to be dumped without accessing /dev/mem.
Date: Wed,  1 Jul 2015 14:44:52 +0800
Message-ID: <0a077dfeea197a444de9665a8b22c41d8a831571.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28321 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504AbbGAGo6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 02:44:58 -0400
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit ab29013cfa2424140446aff196a70b211ab343a9

The /dev/mem can be configured out, in which case, acpidump should still
work with "-c" option as tables can be found in /sys/firmware/acpi/tables.
This patch allows acpidump to work without /dev/mem.
This patch has been tested with "acpidump -c" and "acpidump -c -n FADT".
And it worked as expected. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/ab29013c
Reported-by: Al Stone <ahs3@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   89 ++++++++++----------
 1 file changed, 46 insertions(+), 43 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index db15c9d..3aff9a2 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -582,64 +582,67 @@ static acpi_status osl_table_initialize(void)
 		return (AE_OK);
 	}
 
-	/* Get RSDP from memory */
+	if (!gbl_dump_customized_tables) {
 
-	status = osl_load_rsdp();
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
+		/* Get RSDP from memory */
+
+		status = osl_load_rsdp();
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
 
-	/* Get XSDT from memory */
+		/* Get XSDT from memory */
 
-	if (gbl_rsdp.revision && !gbl_do_not_dump_xsdt) {
-		if (gbl_xsdt) {
-			free(gbl_xsdt);
-			gbl_xsdt = NULL;
+		if (gbl_rsdp.revision && !gbl_do_not_dump_xsdt) {
+			if (gbl_xsdt) {
+				free(gbl_xsdt);
+				gbl_xsdt = NULL;
+			}
+
+			gbl_revision = 2;
+			status = osl_get_bios_table(ACPI_SIG_XSDT, 0,
+						    ACPI_CAST_PTR(struct
+								  acpi_table_header
+								  *, &gbl_xsdt),
+						    &address);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
 		}
 
-		gbl_revision = 2;
-		status = osl_get_bios_table(ACPI_SIG_XSDT, 0,
-					    ACPI_CAST_PTR(struct
-							  acpi_table_header *,
-							  &gbl_xsdt), &address);
-		if (ACPI_FAILURE(status)) {
-			return (status);
+		/* Get RSDT from memory */
+
+		if (gbl_rsdp.rsdt_physical_address) {
+			if (gbl_rsdt) {
+				free(gbl_rsdt);
+				gbl_rsdt = NULL;
+			}
+
+			status = osl_get_bios_table(ACPI_SIG_RSDT, 0,
+						    ACPI_CAST_PTR(struct
+								  acpi_table_header
+								  *, &gbl_rsdt),
+						    &address);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
 		}
-	}
 
-	/* Get RSDT from memory */
+		/* Get FADT from memory */
 
-	if (gbl_rsdp.rsdt_physical_address) {
-		if (gbl_rsdt) {
-			free(gbl_rsdt);
-			gbl_rsdt = NULL;
+		if (gbl_fadt) {
+			free(gbl_fadt);
+			gbl_fadt = NULL;
 		}
 
-		status = osl_get_bios_table(ACPI_SIG_RSDT, 0,
+		status = osl_get_bios_table(ACPI_SIG_FADT, 0,
 					    ACPI_CAST_PTR(struct
 							  acpi_table_header *,
-							  &gbl_rsdt), &address);
+							  &gbl_fadt),
+					    &gbl_fadt_address);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
-	}
-
-	/* Get FADT from memory */
-
-	if (gbl_fadt) {
-		free(gbl_fadt);
-		gbl_fadt = NULL;
-	}
-
-	status = osl_get_bios_table(ACPI_SIG_FADT, 0,
-				    ACPI_CAST_PTR(struct acpi_table_header *,
-						  &gbl_fadt),
-				    &gbl_fadt_address);
-	if (ACPI_FAILURE(status)) {
-		return (status);
-	}
-
-	if (!gbl_dump_customized_tables) {
 
 		/* Add mandatory tables to global table list first */
 
-- 
1.7.10

