From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/15] ACPICA: acpidump: Add DSDT/FACS instance support for Linux and EFI
Date: Thu,  3 Aug 2017 14:26:56 +0800
Message-ID: <b77d5655879f6c8ca97492e0f22ffabeb4584762.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10998 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbdHCG1A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:27:00 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

ACPICA commit 343fc31840d40c06001f3b170ee5bcdfd3c7f3e0

ACPI spec allows to configure different 32-bit/64-bit table addresses for
DSDT and FACS. And for FACS, it's meaningful to dump both of them as they
are used to support different suspend protocols.

While:
1. on Linux, only 1 instance is supported for DSDT/FACS; and
2. on EFI, the code in osl_get_table() is buggy with special table instances,
   causing endless file dump for such tables (reported by Shao Ming in link
   #2).

This patch adds DSDT/FACS instance support for Linux/EFI acpidump. Fixed by
Lv Zheng.

Link: https://github.com/acpica/acpica/commit/343fc318
Link: https://bugs.acpica.org/show_bug.cgi?id=1407 [#1]
Link: https://github.com/acpica/acpica/issues/285  [#2]
Reported-by: Shao Ming <smbest163@163.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 .../acpi/os_specific/service_layers/oslinuxtbl.c   | 105 ++++++++++++++-------
 1 file changed, 73 insertions(+), 32 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 82a2ff8..52a39ec 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -759,7 +759,7 @@ static acpi_status osl_list_bios_tables(void)
 
 		/* Skip NULL entries in RSDT/XSDT */
 
-		if (!table_address) {
+		if (table_address == 0) {
 			continue;
 		}
 
@@ -808,7 +808,8 @@ osl_get_bios_table(char *signature,
 	u8 number_of_tables;
 	u8 item_size;
 	u32 current_instance = 0;
-	acpi_physical_address table_address = 0;
+	acpi_physical_address table_address;
+	acpi_physical_address first_table_address = 0;
 	u32 table_length = 0;
 	acpi_status status = AE_OK;
 	u32 i;
@@ -820,9 +821,10 @@ osl_get_bios_table(char *signature,
 	    ACPI_COMPARE_NAME(signature, ACPI_SIG_XSDT) ||
 	    ACPI_COMPARE_NAME(signature, ACPI_SIG_DSDT) ||
 	    ACPI_COMPARE_NAME(signature, ACPI_SIG_FACS)) {
-		if (instance > 0) {
-			return (AE_LIMIT);
-		}
+
+find_next_instance:
+
+		table_address = 0;
 
 		/*
 		 * Get the appropriate address, either 32-bit or 64-bit. Be very
@@ -830,41 +832,66 @@ osl_get_bios_table(char *signature,
 		 * Note: The 64-bit addresses have priority.
 		 */
 		if (ACPI_COMPARE_NAME(signature, ACPI_SIG_DSDT)) {
-			if ((gbl_fadt->header.length >= MIN_FADT_FOR_XDSDT) &&
-			    gbl_fadt->Xdsdt) {
-				table_address =
-				    (acpi_physical_address)gbl_fadt->Xdsdt;
-			} else
-			    if ((gbl_fadt->header.length >= MIN_FADT_FOR_DSDT)
-				&& gbl_fadt->dsdt) {
-				table_address =
-				    (acpi_physical_address)gbl_fadt->dsdt;
+			if (current_instance < 2) {
+				if ((gbl_fadt->header.length >=
+				     MIN_FADT_FOR_XDSDT) && gbl_fadt->Xdsdt
+				    && current_instance == 0) {
+					table_address =
+					    (acpi_physical_address)gbl_fadt->
+					    Xdsdt;
+				} else
+				    if ((gbl_fadt->header.length >=
+					 MIN_FADT_FOR_DSDT)
+					&& gbl_fadt->dsdt !=
+					first_table_address) {
+					table_address =
+					    (acpi_physical_address)gbl_fadt->
+					    dsdt;
+				}
 			}
 		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_FACS)) {
-			if ((gbl_fadt->header.length >= MIN_FADT_FOR_XFACS) &&
-			    gbl_fadt->Xfacs) {
-				table_address =
-				    (acpi_physical_address)gbl_fadt->Xfacs;
-			} else
-			    if ((gbl_fadt->header.length >= MIN_FADT_FOR_FACS)
-				&& gbl_fadt->facs) {
-				table_address =
-				    (acpi_physical_address)gbl_fadt->facs;
+			if (current_instance < 2) {
+				if ((gbl_fadt->header.length >=
+				     MIN_FADT_FOR_XFACS) && gbl_fadt->Xfacs
+				    && current_instance == 0) {
+					table_address =
+					    (acpi_physical_address)gbl_fadt->
+					    Xfacs;
+				} else
+				    if ((gbl_fadt->header.length >=
+					 MIN_FADT_FOR_FACS)
+					&& gbl_fadt->facs !=
+					first_table_address) {
+					table_address =
+					    (acpi_physical_address)gbl_fadt->
+					    facs;
+				}
 			}
 		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_XSDT)) {
 			if (!gbl_revision) {
 				return (AE_BAD_SIGNATURE);
 			}
-			table_address =
-			    (acpi_physical_address)gbl_rsdp.
-			    xsdt_physical_address;
+			if (current_instance == 0) {
+				table_address =
+				    (acpi_physical_address)gbl_rsdp.
+				    xsdt_physical_address;
+			}
 		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_RSDT)) {
-			table_address =
-			    (acpi_physical_address)gbl_rsdp.
-			    rsdt_physical_address;
+			if (current_instance == 0) {
+				table_address =
+				    (acpi_physical_address)gbl_rsdp.
+				    rsdt_physical_address;
+			}
 		} else {
-			table_address = (acpi_physical_address)gbl_rsdp_address;
-			signature = ACPI_SIG_RSDP;
+			if (current_instance == 0) {
+				table_address =
+				    (acpi_physical_address)gbl_rsdp_address;
+				signature = ACPI_SIG_RSDP;
+			}
+		}
+
+		if (table_address == 0) {
+			goto exit_find_table;
 		}
 
 		/* Now we can get the requested special table */
@@ -875,6 +902,18 @@ osl_get_bios_table(char *signature,
 		}
 
 		table_length = ap_get_table_length(mapped_table);
+		if (first_table_address == 0) {
+			first_table_address = table_address;
+		}
+
+		/* Match table instance */
+
+		if (current_instance != instance) {
+			osl_unmap_table(mapped_table);
+			mapped_table = NULL;
+			current_instance++;
+			goto find_next_instance;
+		}
 	} else {		/* Case for a normal ACPI table */
 
 		if (osl_can_use_xsdt()) {
@@ -913,7 +952,7 @@ osl_get_bios_table(char *signature,
 
 			/* Skip NULL entries in RSDT/XSDT */
 
-			if (!table_address) {
+			if (table_address == 0) {
 				continue;
 			}
 
@@ -946,6 +985,8 @@ osl_get_bios_table(char *signature,
 		}
 	}
 
+exit_find_table:
+
 	if (!mapped_table) {
 		return (AE_LIMIT);
 	}
-- 
2.7.4

