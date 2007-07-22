From: Len Brown <len.brown@intel.com>
Subject: [PATCH 35/77] ACPICA: Clear reserved fields for incoming ACPI 1.0 FADTs
Date: Sun, 22 Jul 2007 05:14:20 -0400
Message-ID: <11850957384004-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53139 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762050AbXGVJPm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:42 -0400
In-Reply-To: <1185095737422-git-send-email-len.brown@intel.com>
Message-Id: <55f8f3cc4f7c47c7896e2ad08e29eccc292c0c68.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem with the internal FADT conversion where ACPI 1.0
FADTs that contained invalid non-zero values in reserved fields
could cause later failures because these fields have meaning in
later revisions of the FADT. For incoming ACPI 1.0 FADTs, these
fields are now always zeroed. (Preferred_PM_Profile, PSTATE_CNT,
CST_CNT, IAPC_BOOT_FLAGS.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbfadt.c |   44 ++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 1285e91..002bb33 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -211,14 +211,17 @@ void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
  * DESCRIPTION: Get a local copy of the FADT and convert it to a common format.
  *              Performs validation on some important FADT fields.
  *
+ * NOTE:        We create a local copy of the FADT regardless of the version.
+ *
  ******************************************************************************/
 
 void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 {
 
 	/*
-	 * Check if the FADT is larger than what we know about (ACPI 2.0 version).
-	 * Truncate the table, but make some noise.
+	 * Check if the FADT is larger than the largest table that we expect
+	 * (the ACPI 2.0/3.0 version). If so, truncate the table, and issue
+	 * a warning.
 	 */
 	if (length > sizeof(struct acpi_table_fadt)) {
 		ACPI_WARNING((AE_INFO,
@@ -227,10 +230,12 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 			      sizeof(struct acpi_table_fadt)));
 	}
 
-	/* Copy the entire FADT locally. Zero first for tb_convert_fadt */
+	/* Clear the entire local FADT */
 
 	ACPI_MEMSET(&acpi_gbl_FADT, 0, sizeof(struct acpi_table_fadt));
 
+	/* Copy the original FADT, up to sizeof (struct acpi_table_fadt) */
+
 	ACPI_MEMCPY(&acpi_gbl_FADT, table,
 		    ACPI_MIN(length, sizeof(struct acpi_table_fadt)));
 
@@ -251,7 +256,7 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
  * RETURN:      None
  *
  * DESCRIPTION: Converts all versions of the FADT to a common internal format.
- *              -> Expand all 32-bit addresses to 64-bit.
+ *              Expand all 32-bit addresses to 64-bit.
  *
  * NOTE:        acpi_gbl_FADT must be of size (struct acpi_table_fadt),
  *              and must contain a copy of the actual FADT.
@@ -292,8 +297,23 @@ static void acpi_tb_convert_fadt(void)
 	}
 
 	/*
-	 * Expand the 32-bit V1.0 addresses to the 64-bit "X" generic address
-	 * structures as necessary.
+	 * For ACPI 1.0 FADTs (revision 1 or 2), ensure that reserved fields which
+	 * should be zero are indeed zero. This will workaround BIOSs that
+	 * inadvertently place values in these fields.
+	 *
+	 * The ACPI 1.0 reserved fields that will be zeroed are the bytes located at
+	 * offset 45, 55, 95, and the word located at offset 109, 110.
+	 */
+	if (acpi_gbl_FADT.header.revision < 3) {
+		acpi_gbl_FADT.preferred_profile = 0;
+		acpi_gbl_FADT.pstate_control = 0;
+		acpi_gbl_FADT.cst_control = 0;
+		acpi_gbl_FADT.boot_flags = 0;
+	}
+
+	/*
+	 * Expand the ACPI 1.0 32-bit V1.0 addresses to the ACPI 2.0 64-bit "X"
+	 * generic address structures as necessary.
 	 */
 	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
 		target =
@@ -349,18 +369,6 @@ static void acpi_tb_convert_fadt(void)
 		    acpi_gbl_FADT.xpm1a_event_block.space_id;
 
 	}
-
-	/*
-	 * For ACPI 1.0 FADTs, ensure that reserved fields (which should be zero)
-	 * are indeed zero. This will workaround BIOSs that inadvertently placed
-	 * values in these fields.
-	 */
-	if (acpi_gbl_FADT.header.revision < 3) {
-		acpi_gbl_FADT.preferred_profile = 0;
-		acpi_gbl_FADT.pstate_control = 0;
-		acpi_gbl_FADT.cst_control = 0;
-		acpi_gbl_FADT.boot_flags = 0;
-	}
 }
 
 /******************************************************************************
-- 
1.5.3.rc2.22.g69a9b
