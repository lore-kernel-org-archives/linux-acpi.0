From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/18] ACPICA: Update internal address SpaceID for DataTable
 regions
Date: Sun, 29 May 2011 05:44:04 -0400
Message-ID: <82a1b7cb83b6bd7d2fe3972e847c8ccbff55cb9c.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:57418 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab1E2JoZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:44:25 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY00DDEB20X8B0@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:44:25 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Moved this internal space id in preparation for ACPI 5.0 changes
that will include some new space IDs.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acconfig.h |    2 +-
 drivers/acpi/acpica/amlcode.h  |   15 ---------------
 drivers/acpi/acpica/dswload.c  |    2 +-
 drivers/acpi/acpica/dswload2.c |    2 +-
 drivers/acpi/acpica/excreate.c |    3 ++-
 drivers/acpi/acpica/utdecode.c |    5 +++--
 include/acpi/actypes.h         |   13 +++++++++++--
 7 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpica/acconfig.h b/drivers/acpi/acpica/acconfig.h
index ab87396..c115bb9 100644
--- a/drivers/acpi/acpica/acconfig.h
+++ b/drivers/acpi/acpica/acconfig.h
@@ -187,7 +187,7 @@
 
 /* Operation regions */
 
-#define ACPI_NUM_PREDEFINED_REGIONS     9
+#define ACPI_NUM_PREDEFINED_REGIONS     8
 #define ACPI_USER_REGION_BEGIN          0x80
 
 /* Maximum space_ids for Operation Regions */
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index f4f0998..1077f17 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -394,21 +394,6 @@
 #define AML_CLASS_METHOD_CALL       0x09
 #define AML_CLASS_UNKNOWN           0x0A
 
-/* Predefined Operation Region space_iDs */
-
-typedef enum {
-	REGION_MEMORY = 0,
-	REGION_IO,
-	REGION_PCI_CONFIG,
-	REGION_EC,
-	REGION_SMBUS,
-	REGION_CMOS,
-	REGION_PCI_BAR,
-	REGION_IPMI,
-	REGION_DATA_TABLE,	/* Internal use only */
-	REGION_FIXED_HW = 0x7F
-} AML_REGION_TYPES;
-
 /* Comparison operation codes for match_op operator */
 
 typedef enum {
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 23a3b1a..324acec 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -450,7 +450,7 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 			status =
 			    acpi_ex_create_region(op->named.data,
 						  op->named.length,
-						  REGION_DATA_TABLE,
+						  ACPI_ADR_SPACE_DATA_TABLE,
 						  walk_state);
 			if (ACPI_FAILURE(status)) {
 				return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 4be4e92..9763181 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -562,7 +562,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 				    ((op->common.value.arg)->common.value.
 				     integer);
 			} else {
-				region_space = REGION_DATA_TABLE;
+				region_space = ACPI_ADR_SPACE_DATA_TABLE;
 			}
 
 			/*
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index e7b372d..110711a 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -305,7 +305,8 @@ acpi_ex_create_region(u8 * aml_start,
 	 * range
 	 */
 	if ((region_space >= ACPI_NUM_PREDEFINED_REGIONS) &&
-	    (region_space < ACPI_USER_REGION_BEGIN)) {
+	    (region_space < ACPI_USER_REGION_BEGIN) &&
+	    (region_space != ACPI_ADR_SPACE_DATA_TABLE)) {
 		ACPI_ERROR((AE_INFO, "Invalid AddressSpace type 0x%X",
 			    region_space));
 		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 136a814..97cb36f 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -170,8 +170,7 @@ const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS] = {
 	"SMBus",
 	"SystemCMOS",
 	"PCIBARTarget",
-	"IPMI",
-	"DataTable"
+	"IPMI"
 };
 
 char *acpi_ut_get_region_name(u8 space_id)
@@ -179,6 +178,8 @@ char *acpi_ut_get_region_name(u8 space_id)
 
 	if (space_id >= ACPI_USER_REGION_BEGIN) {
 		return ("UserDefinedRegion");
+	} else if (space_id == ACPI_ADR_SPACE_DATA_TABLE) {
+		return ("DataTable");
 	} else if (space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
 		return ("FunctionalFixedHW");
 	} else if (space_id >= ACPI_NUM_PREDEFINED_REGIONS) {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 64f838b..ad77c61 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -712,8 +712,17 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_ADR_SPACE_CMOS             (acpi_adr_space_type) 5
 #define ACPI_ADR_SPACE_PCI_BAR_TARGET   (acpi_adr_space_type) 6
 #define ACPI_ADR_SPACE_IPMI             (acpi_adr_space_type) 7
-#define ACPI_ADR_SPACE_DATA_TABLE       (acpi_adr_space_type) 8
-#define ACPI_ADR_SPACE_FIXED_HARDWARE   (acpi_adr_space_type) 127
+
+/*
+ * Special region types
+ *
+ * Note: A Data Table region is a special type of operation region
+ * that has its own AML opcode. However, internally, the AML
+ * interpreter simply creates an operation region with an an address
+ * space type of ACPI_ADR_SPACE_DATA_TABLE.
+ */
+#define ACPI_ADR_SPACE_DATA_TABLE       (acpi_adr_space_type) 0x7E	/* Internal to ACPICA only */
+#define ACPI_ADR_SPACE_FIXED_HARDWARE   (acpi_adr_space_type) 0x7F
 
 /*
  * bit_register IDs
-- 
1.7.5.3.367.ga9930.dirty

