From: Len Brown <lenb@kernel.org>
Subject: [PATCH 51/98] ACPICA: FADT: Favor 32-bit register addresses for
 compatibility
Date: Sat, 28 Mar 2009 00:31:26 -0400
Message-ID: <31fbc073a35a017e34840deb9e865a701e986002.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49601 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbZC1Ecy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:54 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700EGD8MRA271@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:52 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Use the 32-bit register addresses whenever they are non-zero. This
means that the 32-bit addresses are favored over the 64-bit
(GAS) addresses. The 64-bit addresses are only used if the 32-bit
addresses are zero. This change provides compatibility with all
versions of Windows. The worst case that this solves is when both
the 32-bit and 64-bit addresses are non-zero, but only the 32-bit
addresses are actually valid. This appears to happen in some
BIOSes because in this case, Windows uses the 32-bit addresses.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |   86 +++++++++++++++++++++++++-----------------
 1 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index ff89cfe..f87bfb2 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -320,29 +320,35 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
  * RETURN:      None
  *
  * DESCRIPTION: Converts all versions of the FADT to a common internal format.
- *              Expand all 32-bit addresses to 64-bit.
+ *              Expand 32-bit addresses to 64-bit as necessary.
  *
  * NOTE:        acpi_gbl_FADT must be of size (struct acpi_table_fadt),
  *              and must contain a copy of the actual FADT.
  *
- * ACPICA will use the "X" fields of the FADT for all addresses.
+ * Notes on 64-bit register addresses:
  *
- * "X" fields are optional extensions to the original V1.0 fields. Even if
- * they are present in the structure, they can be optionally not used by
- * setting them to zero. Therefore, we must selectively expand V1.0 fields
- * if the corresponding X field is zero.
+ * After this FADT conversion, later ACPICA code will only use the 64-bit "X"
+ * fields of the FADT for all ACPI register addresses.
  *
- * For ACPI 1.0 FADTs, all address fields are expanded to the corresponding
- * "X" fields.
+ * The 64-bit "X" fields are optional extensions to the original 32-bit FADT
+ * V1.0 fields. Even if they are present in the FADT, they are optional and
+ * are unused if the BIOS sets them to zero. Therefore, we must copy/expand
+ * 32-bit V1.0 fields if the corresponding X field is zero.
  *
- * For ACPI 2.0 FADTs, any "X" fields that are NULL are filled in by
- * expanding the corresponding ACPI 1.0 field.
+ * For ACPI 1.0 FADTs, all 32-bit address fields are expanded to the
+ * corresponding "X" fields in the internal FADT.
+ *
+ * For ACPI 2.0+ FADTs, all valid (non-zero) 32-bit address fields are expanded
+ * to the corresponding 64-bit X fields. For compatibility with other ACPI
+ * implementations, we ignore the 64-bit field if the 32-bit field is valid,
+ * regardless of whether the host OS is 32-bit or 64-bit.
  *
  ******************************************************************************/
 
 static void acpi_tb_convert_fadt(void)
 {
-	struct acpi_generic_address *target64;
+	struct acpi_generic_address *address64;
+	u32 address32;
 	u32 i;
 
 	/* Update the local FADT table header length */
@@ -391,29 +397,51 @@ static void acpi_tb_convert_fadt(void)
 	 * Expand the ACPI 1.0 32-bit addresses to the ACPI 2.0 64-bit "X"
 	 * generic address structures as necessary. Later code will always use
 	 * the 64-bit address structures.
+	 *
+	 * March 2009:
+	 * We now always use the 32-bit address if it is valid (non-null). This
+	 * is not in accordance with the ACPI specification which states that
+	 * the 64-bit address supersedes the 32-bit version, but we do this for
+	 * compatibility with other ACPI implementations. Most notably, in the
+	 * case where both the 32 and 64 versions are non-null, we use the 32-bit
+	 * version. This is the only address that is guaranteed to have been
+	 * tested by the BIOS manufacturer.
 	 */
 	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
-		target64 =
-		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
-				 fadt_info_table[i].address64);
+		address32 = *ACPI_ADD_PTR(u32,
+					  &acpi_gbl_FADT,
+					  fadt_info_table[i].address32);
 
-		/* Expand only if the 64-bit X target is null */
+		address64 = ACPI_ADD_PTR(struct acpi_generic_address,
+					 &acpi_gbl_FADT,
+					 fadt_info_table[i].address64);
 
-		if (!target64->address) {
+		/*
+		 * If both 32- and 64-bit addresses are valid (non-zero),
+		 * they must match.
+		 */
+		if (address64->address && address32 &&
+		    (address64->address != (u64) address32)) {
+			ACPI_ERROR((AE_INFO,
+				    "32/64X address mismatch in %s: %8.8X/%8.8X%8.8X, using 32",
+				    fadt_info_table[i].name, address32,
+				    ACPI_FORMAT_UINT64(address64->address)));
+		}
 
-			/* The space_id is always I/O for the 32-bit legacy address fields */
+		/* Always use 32-bit address if it is valid (non-null) */
 
-			acpi_tb_init_generic_address(target64,
+		if (address32) {
+			/*
+			 * Copy the 32-bit address to the 64-bit GAS structure. The
+			 * Space ID is always I/O for 32-bit legacy address fields
+			*/
+			acpi_tb_init_generic_address(address64,
 						     ACPI_ADR_SPACE_SYSTEM_IO,
 						     *ACPI_ADD_PTR(u8,
 								   &acpi_gbl_FADT,
 								   fadt_info_table
 								   [i].length),
-						     (u64) * ACPI_ADD_PTR(u32,
-									  &acpi_gbl_FADT,
-									  fadt_info_table
-									  [i].
-									  address32));
+						     address32);
 		}
 	}
 }
@@ -530,18 +558,6 @@ static void acpi_tb_validate_fadt(void)
 					      length));
 			}
 		}
-
-		/*
-		 * If both 32- and 64-bit addresses are valid (non-zero),
-		 * they must match
-		 */
-		if (address64->address && *address32 &&
-		    (address64->address != (u64) * address32)) {
-			ACPI_ERROR((AE_INFO,
-				    "32/64X address mismatch in %s: %8.8X/%8.8X%8.8X, using 64X",
-				    name, *address32,
-				    ACPI_FORMAT_UINT64(address64->address)));
-		}
 	}
 }
 
-- 
1.6.0.6

