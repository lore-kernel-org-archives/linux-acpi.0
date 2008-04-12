From: Len Brown <lenb@kernel.org>
Subject: [PATCH 61/73] ACPICA: Fix for resource descriptor optimization issues for _CRS/_SRC
Date: Sat, 12 Apr 2008 00:25:44 -0400
Message-ID: <99f0a4274fcb67c55c23f9b93b01d7096d11e372.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:49384 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754016AbYDLE2M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:12 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem where resource descriptor size optimization
could cause a problem when a _CRS resource template is passed
to a _SRS method. The _SRS resource template must use the same
descriptors (with the same size) as returned from _CRS. This
change affects the following resource descriptors: IRQ/IRQNoFlags
and StartDependendentFn/StartDependentFnNoPri. (BZ 9487)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/resources/rscalc.c |    7 ++++++
 drivers/acpi/resources/rsdump.c |    8 +++++-
 drivers/acpi/resources/rsio.c   |   39 +++++++++++++++++++++++++++++++++-
 drivers/acpi/resources/rsirq.c  |   43 +++++++++++++++++++++++++++++++++++---
 drivers/acpi/resources/rsmisc.c |   11 ++++++++++
 include/acpi/acresrc.h          |    1 +
 include/acpi/actypes.h          |    2 +
 7 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/resources/rscalc.c b/drivers/acpi/resources/rscalc.c
index dcc51e9..db0a835 100644
--- a/drivers/acpi/resources/rscalc.c
+++ b/drivers/acpi/resources/rscalc.c
@@ -211,6 +211,13 @@ acpi_rs_get_aml_length(struct acpi_resource * resource, acpi_size * size_needed)
 		 * variable-length fields
 		 */
 		switch (resource->type) {
+		case ACPI_RESOURCE_TYPE_IRQ:
+
+			if (resource->data.irq.descriptor_length == 2) {
+				total_size--;
+			}
+			break;
+
 		case ACPI_RESOURCE_TYPE_VENDOR:
 			/*
 			 * Vendor Defined Resource:
diff --git a/drivers/acpi/resources/rsdump.c b/drivers/acpi/resources/rsdump.c
index 46da116..ed6447d 100644
--- a/drivers/acpi/resources/rsdump.c
+++ b/drivers/acpi/resources/rsdump.c
@@ -87,8 +87,10 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table);
  *
  ******************************************************************************/
 
-struct acpi_rsdump_info acpi_rs_dump_irq[6] = {
+struct acpi_rsdump_info acpi_rs_dump_irq[7] = {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_irq), "IRQ", NULL},
+	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(irq.descriptor_length),
+	 "Descriptor Length", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(irq.triggering), "Triggering",
 	 acpi_gbl_he_decode},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(irq.polarity), "Polarity",
@@ -115,9 +117,11 @@ struct acpi_rsdump_info acpi_rs_dump_dma[6] = {
 	 NULL}
 };
 
-struct acpi_rsdump_info acpi_rs_dump_start_dpf[3] = {
+struct acpi_rsdump_info acpi_rs_dump_start_dpf[4] = {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_start_dpf),
 	 "Start-Dependent-Functions", NULL},
+	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(start_dpf.descriptor_length),
+	 "Descriptor Length", NULL},
 	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(start_dpf.compatibility_priority),
 	 "Compatibility Priority", acpi_gbl_config_decode},
 	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(start_dpf.performance_robustness),
diff --git a/drivers/acpi/resources/rsio.c b/drivers/acpi/resources/rsio.c
index b297bc3..50f3acd 100644
--- a/drivers/acpi/resources/rsio.c
+++ b/drivers/acpi/resources/rsio.c
@@ -185,7 +185,7 @@ struct acpi_rsconvert_info acpi_rs_convert_end_tag[2] = {
  *
  ******************************************************************************/
 
-struct acpi_rsconvert_info acpi_rs_get_start_dpf[5] = {
+struct acpi_rsconvert_info acpi_rs_get_start_dpf[6] = {
 	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_START_DEPENDENT,
 	 ACPI_RS_SIZE(struct acpi_resource_start_dependent),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_get_start_dpf)},
@@ -196,6 +196,12 @@ struct acpi_rsconvert_info acpi_rs_get_start_dpf[5] = {
 	 ACPI_ACCEPTABLE_CONFIGURATION,
 	 2},
 
+	/* Get the descriptor length (0 or 1 for Start Dpf descriptor) */
+
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.start_dpf.descriptor_length),
+	 AML_OFFSET(start_dpf.descriptor_type),
+	 0},
+
 	/* All done if there is no flag byte present in the descriptor */
 
 	{ACPI_RSC_EXIT_NE, ACPI_RSC_COMPARE_AML_LENGTH, 0, 1},
@@ -219,7 +225,9 @@ struct acpi_rsconvert_info acpi_rs_get_start_dpf[5] = {
  *
  ******************************************************************************/
 
-struct acpi_rsconvert_info acpi_rs_set_start_dpf[6] = {
+struct acpi_rsconvert_info acpi_rs_set_start_dpf[10] = {
+	/* Start with a default descriptor of length 1 */
+
 	{ACPI_RSC_INITSET, ACPI_RESOURCE_NAME_START_DEPENDENT,
 	 sizeof(struct aml_resource_start_dependent),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_set_start_dpf)},
@@ -236,6 +244,33 @@ struct acpi_rsconvert_info acpi_rs_set_start_dpf[6] = {
 	 AML_OFFSET(start_dpf.flags),
 	 2},
 	/*
+	 * All done if the output descriptor length is required to be 1
+	 * (i.e., optimization to 0 bytes cannot be attempted)
+	 */
+	{ACPI_RSC_EXIT_EQ, ACPI_RSC_COMPARE_VALUE,
+	 ACPI_RS_OFFSET(data.start_dpf.descriptor_length),
+	 1},
+
+	/* Set length to 0 bytes (no flags byte) */
+
+	{ACPI_RSC_LENGTH, 0, 0,
+	 sizeof(struct aml_resource_start_dependent_noprio)},
+
+	/*
+	 * All done if the output descriptor length is required to be 0.
+	 *
+	 * TBD: Perhaps we should check for error if input flags are not
+	 * compatible with a 0-byte descriptor.
+	 */
+	{ACPI_RSC_EXIT_EQ, ACPI_RSC_COMPARE_VALUE,
+	 ACPI_RS_OFFSET(data.start_dpf.descriptor_length),
+	 0},
+
+	/* Reset length to 1 byte (descriptor with flags byte) */
+
+	{ACPI_RSC_LENGTH, 0, 0, sizeof(struct aml_resource_irq)},
+
+	/*
 	 * All done if flags byte is necessary -- if either priority value
 	 * is not ACPI_ACCEPTABLE_CONFIGURATION
 	 */
diff --git a/drivers/acpi/resources/rsirq.c b/drivers/acpi/resources/rsirq.c
index 5657f7b..382a77b 100644
--- a/drivers/acpi/resources/rsirq.c
+++ b/drivers/acpi/resources/rsirq.c
@@ -52,7 +52,7 @@ ACPI_MODULE_NAME("rsirq")
  * acpi_rs_get_irq
  *
  ******************************************************************************/
-struct acpi_rsconvert_info acpi_rs_get_irq[7] = {
+struct acpi_rsconvert_info acpi_rs_get_irq[8] = {
 	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_IRQ,
 	 ACPI_RS_SIZE(struct acpi_resource_irq),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_get_irq)},
@@ -69,6 +69,12 @@ struct acpi_rsconvert_info acpi_rs_get_irq[7] = {
 	 ACPI_EDGE_SENSITIVE,
 	 1},
 
+	/* Get the descriptor length (2 or 3 for IRQ descriptor) */
+
+	{ACPI_RSC_2BITFLAG, ACPI_RS_OFFSET(data.irq.descriptor_length),
+	 AML_OFFSET(irq.descriptor_type),
+	 0},
+
 	/* All done if no flag byte present in descriptor */
 
 	{ACPI_RSC_EXIT_NE, ACPI_RSC_COMPARE_AML_LENGTH, 0, 3},
@@ -94,7 +100,9 @@ struct acpi_rsconvert_info acpi_rs_get_irq[7] = {
  *
  ******************************************************************************/
 
-struct acpi_rsconvert_info acpi_rs_set_irq[9] = {
+struct acpi_rsconvert_info acpi_rs_set_irq[13] = {
+	/* Start with a default descriptor of length 3 */
+
 	{ACPI_RSC_INITSET, ACPI_RESOURCE_NAME_IRQ,
 	 sizeof(struct aml_resource_irq),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_set_irq)},
@@ -105,7 +113,7 @@ struct acpi_rsconvert_info acpi_rs_set_irq[9] = {
 	 AML_OFFSET(irq.irq_mask),
 	 ACPI_RS_OFFSET(data.irq.interrupt_count)},
 
-	/* Set the flags byte by default */
+	/* Set the flags byte */
 
 	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.triggering),
 	 AML_OFFSET(irq.flags),
@@ -118,6 +126,33 @@ struct acpi_rsconvert_info acpi_rs_set_irq[9] = {
 	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.irq.sharable),
 	 AML_OFFSET(irq.flags),
 	 4},
+
+	/*
+	 * All done if the output descriptor length is required to be 3
+	 * (i.e., optimization to 2 bytes cannot be attempted)
+	 */
+	{ACPI_RSC_EXIT_EQ, ACPI_RSC_COMPARE_VALUE,
+	 ACPI_RS_OFFSET(data.irq.descriptor_length),
+	 3},
+
+	/* Set length to 2 bytes (no flags byte) */
+
+	{ACPI_RSC_LENGTH, 0, 0, sizeof(struct aml_resource_irq_noflags)},
+
+	/*
+	 * All done if the output descriptor length is required to be 2.
+	 *
+	 * TBD: Perhaps we should check for error if input flags are not
+	 * compatible with a 2-byte descriptor.
+	 */
+	{ACPI_RSC_EXIT_EQ, ACPI_RSC_COMPARE_VALUE,
+	 ACPI_RS_OFFSET(data.irq.descriptor_length),
+	 2},
+
+	/* Reset length to 3 bytes (descriptor with flags byte) */
+
+	{ACPI_RSC_LENGTH, 0, 0, sizeof(struct aml_resource_irq)},
+
 	/*
 	 * Check if the flags byte is necessary. Not needed if the flags are:
 	 * ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH, ACPI_EXCLUSIVE
@@ -134,7 +169,7 @@ struct acpi_rsconvert_info acpi_rs_set_irq[9] = {
 	 ACPI_RS_OFFSET(data.irq.sharable),
 	 ACPI_EXCLUSIVE},
 
-	/* irq_no_flags() descriptor can be used */
+	/* We can optimize to a 2-byte irq_no_flags() descriptor */
 
 	{ACPI_RSC_LENGTH, 0, 0, sizeof(struct aml_resource_irq_noflags)}
 };
diff --git a/drivers/acpi/resources/rsmisc.c b/drivers/acpi/resources/rsmisc.c
index c7081af..3e69eff 100644
--- a/drivers/acpi/resources/rsmisc.c
+++ b/drivers/acpi/resources/rsmisc.c
@@ -497,6 +497,17 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 			}
 			break;
 
+		case ACPI_RSC_EXIT_EQ:
+			/*
+			 * Control - Exit conversion if equal
+			 */
+			if (*ACPI_ADD_PTR(u8, resource,
+					  COMPARE_TARGET(info)) ==
+			    COMPARE_VALUE(info)) {
+				goto exit;
+			}
+			break;
+
 		default:
 
 			ACPI_ERROR((AE_INFO, "Invalid conversion opcode"));
diff --git a/include/acpi/acresrc.h b/include/acpi/acresrc.h
index 9486ab2..33e9f38 100644
--- a/include/acpi/acresrc.h
+++ b/include/acpi/acresrc.h
@@ -94,6 +94,7 @@ typedef const struct acpi_rsconvert_info {
 #define ACPI_RSC_BITMASK16              18
 #define ACPI_RSC_EXIT_NE                19
 #define ACPI_RSC_EXIT_LE                20
+#define ACPI_RSC_EXIT_EQ                21
 
 /* Resource Conversion sub-opcodes */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index bb44700..599657e 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -986,6 +986,7 @@ struct acpi_vendor_uuid {
  *  Structures used to describe device resources
  */
 struct acpi_resource_irq {
+	u8 descriptor_length;
 	u8 triggering;
 	u8 polarity;
 	u8 sharable;
@@ -1002,6 +1003,7 @@ struct acpi_resource_dma {
 };
 
 struct acpi_resource_start_dependent {
+	u8 descriptor_length;
 	u8 compatibility_priority;
 	u8 performance_robustness;
 };
-- 
1.5.5.29.g7134

