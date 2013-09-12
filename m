From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/14] ACPICA: Tables: Cleanup table checksum verification code.
Date: Thu, 12 Sep 2013 16:55:26 +0800
Message-ID: <f7a4c7588af6fe873160f72b0065409703cd6c2d.1377844863.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:4968 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742Ab3ILIzb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Sep 2013 04:55:31 -0400
In-Reply-To: <cover.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch reduces code redundancy by moving the FACS/S3PT checksum
verification skip logic into acpi_tb_verify_checksum() and other
calls of this function also get benefit from this change.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbinstal.c |   12 +++---------
 drivers/acpi/acpica/tbprint.c  |   10 ++++++++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 42a13c0..9e6788f 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -80,16 +80,10 @@ acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
 		}
 	}
 
-	/* FACS is the odd table, has no standard ACPI header and no checksum */
+	/* Always calculate checksum, ignore bad checksum if requested */
 
-	if (!ACPI_COMPARE_NAME(&table_desc->signature, ACPI_SIG_FACS)) {
-
-		/* Always calculate checksum, ignore bad checksum if requested */
-
-		status =
-		    acpi_tb_verify_checksum(table_desc->pointer,
-					    table_desc->length);
-	}
+	status =
+	    acpi_tb_verify_checksum(table_desc->pointer, table_desc->length);
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index dc963f8..499759a 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -190,6 +190,16 @@ acpi_status acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length)
 {
 	u8 checksum;
 
+	/*
+	 * FACS/S3PT:
+	 * They are the odd tables, have no standard ACPI header and no checksum
+	 */
+
+	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_S3PT) ||
+	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_FACS)) {
+		return (AE_OK);
+	}
+
 	/* Compute the checksum on the table */
 
 	checksum = acpi_tb_checksum(ACPI_CAST_PTR(u8, table), length);
-- 
1.7.10

