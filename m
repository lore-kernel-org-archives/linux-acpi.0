From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/94] ACPICA: Update debug output for IndexField I/O
Date: Fri, 09 Jan 2009 04:26:26 -0500
Message-ID: <e9a8c6a90953b65326881189a1f3782bb2f6d250.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbZAIJ2G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:06 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700EM06ALP3I2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:58 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Split the "data register I/O" with more informative read and
write messages.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exfldio.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/executer/exfldio.c b/drivers/acpi/executer/exfldio.c
index 9ff9d1f..94500c4 100644
--- a/drivers/acpi/executer/exfldio.c
+++ b/drivers/acpi/executer/exfldio.c
@@ -498,14 +498,13 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 			return_ACPI_STATUS(status);
 		}
 
-		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-				  "I/O to Data Register: ValuePtr %p\n",
-				  value));
-
 		if (read_write == ACPI_READ) {
 
 			/* Read the datum from the data_register */
 
+			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
+					  "Read from Data Register\n"));
+
 			status =
 			    acpi_ex_extract_from_field(obj_desc->index_field.
 						       data_obj, value,
@@ -513,6 +512,10 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 		} else {
 			/* Write the datum to the data_register */
 
+			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
+					  "Write to Data Register: Value %8.8X%8.8X\n",
+					  ACPI_FORMAT_UINT64(*value)));
+
 			status =
 			    acpi_ex_insert_into_field(obj_desc->index_field.
 						      data_obj, value,
-- 
1.5.6.6

