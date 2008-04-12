From: Len Brown <lenb@kernel.org>
Subject: [PATCH 69/73] ACPICA: Fixes for size of StartDependent resource descriptor
Date: Sat, 12 Apr 2008 00:25:52 -0400
Message-ID: <b806de0494def9671a44a1886f04e6c65cb03718.1207973801.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:36418 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752558AbYDLE2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:16 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a couple of size calculation issues with the variable-length
Start Dependent resource descriptor.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/resources/rscalc.c |   11 +++++++++++
 drivers/acpi/resources/rsio.c   |    2 +-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/resources/rscalc.c b/drivers/acpi/resources/rscalc.c
index db0a835..d801823 100644
--- a/drivers/acpi/resources/rscalc.c
+++ b/drivers/acpi/resources/rscalc.c
@@ -213,11 +213,22 @@ acpi_rs_get_aml_length(struct acpi_resource * resource, acpi_size * size_needed)
 		switch (resource->type) {
 		case ACPI_RESOURCE_TYPE_IRQ:
 
+			/* Length can be 3 or 2 */
+
 			if (resource->data.irq.descriptor_length == 2) {
 				total_size--;
 			}
 			break;
 
+		case ACPI_RESOURCE_TYPE_START_DEPENDENT:
+
+			/* Length can be 1 or 0 */
+
+			if (resource->data.irq.descriptor_length == 0) {
+				total_size--;
+			}
+			break;
+
 		case ACPI_RESOURCE_TYPE_VENDOR:
 			/*
 			 * Vendor Defined Resource:
diff --git a/drivers/acpi/resources/rsio.c b/drivers/acpi/resources/rsio.c
index 50f3acd..610d7c2 100644
--- a/drivers/acpi/resources/rsio.c
+++ b/drivers/acpi/resources/rsio.c
@@ -268,7 +268,7 @@ struct acpi_rsconvert_info acpi_rs_set_start_dpf[10] = {
 
 	/* Reset length to 1 byte (descriptor with flags byte) */
 
-	{ACPI_RSC_LENGTH, 0, 0, sizeof(struct aml_resource_irq)},
+	{ACPI_RSC_LENGTH, 0, 0, sizeof(struct aml_resource_start_dependent)},
 
 	/*
 	 * All done if flags byte is necessary -- if either priority value
-- 
1.5.5.29.g7134

