From: Len Brown <len.brown@intel.com>
Subject: [PATCH 1/8] ACPICA: allow Load(OEMx) tables
Date: Sat,  2 Jun 2007 01:15:37 -0400
Message-ID: <11807613453368-git-send-email-len.brown@intel.com>
References: <1180761344795-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48596 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317AbXFBFPq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Jun 2007 01:15:46 -0400
In-Reply-To: <1180761344795-git-send-email-len.brown@intel.com>
Message-Id: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

HP and Hitachi machines have been implemented with SSDT's
that use the "OEMx" signatures.  But upon Load, ACPICA is rejecting
these tables because they are not using the "SSDT" signature.

ACPI Error (tbinstal-0134): Table has invalid signature [OEMx], must be SSDT...

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbinstal.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/tables/tbinstal.c b/drivers/acpi/tables/tbinstal.c
index 0e7b121..3bc0c67 100644
--- a/drivers/acpi/tables/tbinstal.c
+++ b/drivers/acpi/tables/tbinstal.c
@@ -123,14 +123,14 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc,
 		}
 	}
 
-	/* The table must be either an SSDT or a PSDT */
+	/* The table must be either an SSDT or a PSDT or an OEMx */
 
 	if ((!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_PSDT))
 	    &&
-	    (!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_SSDT)))
-	{
+	    (!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_SSDT))
+	    && (strncmp(table_desc->pointer->signature, "OEM", 3))) {
 		ACPI_ERROR((AE_INFO,
-			    "Table has invalid signature [%4.4s], must be SSDT or PSDT",
+			    "Table has invalid signature [%4.4s], must be SSDT, PSDT or OEMx",
 			    table_desc->pointer->signature));
 		return_ACPI_STATUS(AE_BAD_SIGNATURE);
 	}
-- 
1.5.2.146.gb75c6
