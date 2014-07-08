From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/25] ACPICA: Utilities: Validate full RSDP header
Date: Tue,  8 Jul 2014 10:06:17 +0800
Message-ID: <ea79d73444c11a78dfb13ec891abd36bec719447.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33613 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630AbaGHCG4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:06:56 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>

From: "David E. Box" <david.e.box@linux.intel.com>

Implement proper RSDP validation in acpi_ut_read_table(). Prevents a segmentation
fault that can occur if a user passes the wrong file to iasl.

This patch is only useful for iasl, which is not shipped in the Linux
kernel.
After the new table reading utility functions are well tested, acpidump can
also switch to use the generic acpi_ut_read_table_xxx() APIs. Currently
this patch is no-op as acpidump does not link to the new APIs.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utfileio.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/utfileio.c b/drivers/acpi/acpica/utfileio.c
index c8f6359..bdf9914 100644
--- a/drivers/acpi/acpica/utfileio.c
+++ b/drivers/acpi/acpica/utfileio.c
@@ -150,6 +150,7 @@ acpi_ut_read_table(FILE * fp,
 	acpi_status status;
 	u32 file_size;
 	u8 standard_header = TRUE;
+	s32 count;
 
 	/* Get the file size */
 
@@ -164,27 +165,21 @@ acpi_ut_read_table(FILE * fp,
 
 	/* Read the signature */
 
-	if (fread(&table_header, 1, 4, fp) != 4) {
-		acpi_os_printf("Could not read the table signature\n");
+	fseek(fp, 0, SEEK_SET);
+
+	count = fread(&table_header, 1, sizeof(struct acpi_table_header), fp);
+	if (count != sizeof(struct acpi_table_header)) {
+		acpi_os_printf("Could not read the table header\n");
 		return (AE_BAD_HEADER);
 	}
 
-	fseek(fp, 0, SEEK_SET);
-
 	/* The RSDP table does not have standard ACPI header */
 
-	if (ACPI_COMPARE_NAME(table_header.signature, "RSD ")) {
+	if (ACPI_VALIDATE_RSDP_SIG(table_header.signature)) {
 		*table_length = file_size;
 		standard_header = FALSE;
 	} else {
-		/* Read the table header */
 
-		if (fread
-		    (&table_header, 1, sizeof(struct acpi_table_header),
-		     fp) != sizeof(struct acpi_table_header)) {
-			acpi_os_printf("Could not read the table header\n");
-			return (AE_BAD_HEADER);
-		}
 #if 0
 		/* Validate the table header/length */
 
-- 
1.7.10

