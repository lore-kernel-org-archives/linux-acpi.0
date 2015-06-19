From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/32] ACPICA: Tables: Fix an issue that ACPI initialization is blocked due to no FACS.
Date: Fri, 19 Jun 2015 11:39:14 +0800
Message-ID: <ea654e92978e26a6b3d53504e9de0caf9c8e8c7c.1434684720.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17280 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbbFSDjT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2015 23:39:19 -0400
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit ebd544ed24c5a4faba11f265e228b7a821a729f5

This patch fixes an issue that when FACS tables do not exist, ACPI
initialization cannot proceed. ACPICA BZ 1122. Lv Zheng.

Link: https://bugs.acpica.org/show_bug.cgi?id=1122
Link: https://github.com/acpica/acpica/commit/ebd544ed
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbutils.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 6a6c5be..2bb6a11 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -84,18 +84,16 @@ acpi_status acpi_tb_initialize_facs(void)
 				      ACPI_CAST_INDIRECT_PTR(struct
 							     acpi_table_header,
 							     &acpi_gbl_facs64));
-	if (!acpi_gbl_facs32 && !acpi_gbl_facs64) {
-		return (AE_NO_MEMORY);
-	}
 
-	if (acpi_gbl_use32_bit_facs_addresses) {
-		acpi_gbl_FACS =
-		    acpi_gbl_facs32 ? acpi_gbl_facs32 : acpi_gbl_facs64;
-	} else {
-		acpi_gbl_FACS =
-		    acpi_gbl_facs64 ? acpi_gbl_facs64 : acpi_gbl_facs32;
+	if (acpi_gbl_facs64
+	    && (!acpi_gbl_facs32 || !acpi_gbl_use32_bit_facs_addresses)) {
+		acpi_gbl_FACS = acpi_gbl_facs64;
+	} else if (acpi_gbl_facs32) {
+		acpi_gbl_FACS = acpi_gbl_facs32;
 	}
 
+	/* If there is no FACS, just continue. There was already an error msg */
+
 	return (AE_OK);
 }
 #endif				/* !ACPI_REDUCED_HARDWARE */
-- 
1.7.10

