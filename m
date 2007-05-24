From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPICA: allow Load(OEMx) tables - take 2
Date: Thu, 24 May 2007 02:25:00 -0400
Message-ID: <200705240225.00740.lenb@kernel.org>
References: <200705240116.40229.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52252 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335AbXEXG0Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 May 2007 02:26:16 -0400
In-Reply-To: <200705240116.40229.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

Subject: ACPICA: allow Load(OEMx) tables
From: Len Brown <len.brown@intel.com>

HP and Hitachi machines have been implemented with SSDT's
that use the "OEMx" signatures.  But upon Load, ACPICA is rejecting
these tables because they are not using the "SSDT" signature.

ACPI Error (tbinstal-0134): Table has invalid signature [OEMx], must be SSDT...

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tbinstal.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
