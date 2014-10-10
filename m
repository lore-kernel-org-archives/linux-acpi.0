From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/10] ACPICA: acpidump: Add ACPI 1.0 RSDP support.
Date: Fri, 10 Oct 2014 10:39:32 +0800
Message-ID: <be219dd1cf19e591cb725a3296f9b7a5ff5880ab.1412907188.git.lv.zheng@intel.com>
References: <cover.1412907188.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60865 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaJJCpD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2014 22:45:03 -0400
In-Reply-To: <cover.1412907188.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

The acpidump currently always uses ACPI 2.0 format to dump RSDP, this patch
adds ACPI 1.0 RSDP support.

Link: https://bugs.acpica.org/show_bug.cgi?id=1097
Link: https://bugs.acpica.org/show_bug.cgi?id=1103
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reported-and-tested-by: Rudolf Marek <r.marek@assembler.cz>
Reported-and-tested-by: Rafal <fatwildcat@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/actables.h           |    2 ++
 drivers/acpi/acpica/tbxfroot.c           |   33 +++++++++++++++++++++++++++++-
 tools/power/acpi/tools/acpidump/apdump.c |    2 +-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index f148827..1afe46e 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -49,6 +49,8 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count);
 /*
  * tbxfroot - Root pointer utilities
  */
+u32 acpi_tb_get_rsdp_length(struct acpi_table_rsdp *rsdp);
+
 acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp);
 
 u8 *acpi_tb_scan_memory_for_rsdp(u8 *start_address, u32 length);
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 65ab8fe..43a54af 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -50,6 +50,36 @@ ACPI_MODULE_NAME("tbxfroot")
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_get_rsdp_length
+ *
+ * PARAMETERS:  rsdp                - Pointer to RSDP
+ *
+ * RETURN:      Table length
+ *
+ * DESCRIPTION: Get the length of the RSDP
+ *
+ ******************************************************************************/
+u32 acpi_tb_get_rsdp_length(struct acpi_table_rsdp *rsdp)
+{
+
+	if (!ACPI_VALIDATE_RSDP_SIG(rsdp->signature)) {
+
+		/* BAD Signature */
+
+		return (0);
+	}
+
+	/* "Length" field is available if table version >= 2 */
+
+	if (rsdp->revision >= 2) {
+		return (rsdp->length);
+	} else {
+		return (ACPI_RSDP_CHECKSUM_LENGTH);
+	}
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_validate_rsdp
  *
  * PARAMETERS:  rsdp                - Pointer to unvalidated RSDP
@@ -59,7 +89,8 @@ ACPI_MODULE_NAME("tbxfroot")
  * DESCRIPTION: Validate the RSDP (ptr)
  *
  ******************************************************************************/
-acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
+
+acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp * rsdp)
 {
 
 	/*
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 53cee78..24d3296 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -146,7 +146,7 @@ u32 ap_get_table_length(struct acpi_table_header *table)
 
 	if (ACPI_VALIDATE_RSDP_SIG(table->signature)) {
 		rsdp = ACPI_CAST_PTR(struct acpi_table_rsdp, table);
-		return (rsdp->length);
+		return (acpi_tb_get_rsdp_length(rsdp));
 	}
 
 	/* Normal ACPI table */
-- 
1.7.10

