From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/65] ACPICA: Miscellaneous lint changes
Date: Fri, 29 May 2009 21:41:54 -0400
Message-ID: <e4c1ebfc65c125b1289144f5815715f238367683.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50006 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757434AbZE3BnI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:08 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF000N7ORFX7Q2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:52 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Unused variables/headers, casting, etc.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evxfevnt.c |    4 ++--
 drivers/acpi/acpica/nssearch.c |    4 ++++
 drivers/acpi/acpica/rscalc.c   |    3 ---
 drivers/acpi/acpica/tbfadt.c   |   10 +++-------
 drivers/acpi/acpica/tbinstal.c |    2 +-
 5 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index d0a0807..4721f58 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -51,7 +51,7 @@
 ACPI_MODULE_NAME("evxfevnt")
 
 /* Local prototypes */
-acpi_status
+static acpi_status
 acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 		       struct acpi_gpe_block_info *gpe_block, void *context);
 
@@ -785,7 +785,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_gpe_device)
  *              block device. NULL if the GPE is one of the FADT-defined GPEs.
  *
  ******************************************************************************/
-acpi_status
+static acpi_status
 acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 		       struct acpi_gpe_block_info *gpe_block, void *context)
 {
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index f9b4f51..7e86563 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -45,6 +45,10 @@
 #include "accommon.h"
 #include "acnamesp.h"
 
+#ifdef ACPI_ASL_COMPILER
+#include "amlcode.h"
+#endif
+
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nssearch")
 
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 88b5a2c..d3f77a5 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -593,9 +593,6 @@ acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
 			} else {
 				temp_size_needed +=
 				    acpi_ns_get_pathname_length((*sub_object_list)->reference.node);
-				if (!temp_size_needed) {
-					return_ACPI_STATUS(AE_BAD_PARAMETER);
-				}
 			}
 		} else {
 			/*
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index e5fe7c8..82b02dc 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -441,7 +441,7 @@ static void acpi_tb_convert_fadt(void)
 								   &acpi_gbl_FADT,
 								   fadt_info_table
 								   [i].length),
-						     address32);
+						     (u64) address32);
 		}
 	}
 }
@@ -469,7 +469,6 @@ static void acpi_tb_convert_fadt(void)
 static void acpi_tb_validate_fadt(void)
 {
 	char *name;
-	u32 *address32;
 	struct acpi_generic_address *address64;
 	u8 length;
 	u32 i;
@@ -505,15 +504,12 @@ static void acpi_tb_validate_fadt(void)
 
 	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
 		/*
-		 * Generate pointers to the 32-bit and 64-bit addresses, get the
-		 * register length (width), and the register name
+		 * Generate pointer to the 64-bit address, get the register
+		 * length (width) and the register name
 		 */
 		address64 = ACPI_ADD_PTR(struct acpi_generic_address,
 					 &acpi_gbl_FADT,
 					 fadt_info_table[i].address64);
-		address32 =
-		    ACPI_ADD_PTR(u32, &acpi_gbl_FADT,
-				 fadt_info_table[i].address32);
 		length =
 		    *ACPI_ADD_PTR(u8, &acpi_gbl_FADT,
 				  fadt_info_table[i].length);
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index f865d5a..63e8232 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -472,7 +472,7 @@ acpi_status acpi_tb_delete_namespace_by_owner(u32 table_index)
 	 * lock may block, and also since the execution of a namespace walk
 	 * must be allowed to use the interpreter.
 	 */
-	acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
+	(void)acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 	status = acpi_ut_acquire_write_lock(&acpi_gbl_namespace_rw_lock);
 
 	acpi_ns_delete_namespace_by_owner(owner_id);
-- 
1.6.0.6

