From: "Xiao, Hui" <hui.xiao@linux.intel.com>
Subject: [PATCH v2] ACPI, APEI, EINJ, Refine the fix of resource conflict
Date: Tue, 11 Oct 2011 14:15:59 +0800
Message-ID: <4E93DF1F.8030004@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15424 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175Ab1JKGQD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Oct 2011 02:16:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "Chen, Gong" <gong.chen@intel.com>, linux-acpi@vger.kernel.org

Current fix for resource conflict is to remove the address region <param1 &
param2, ~param2+1> from trigger resource, which is highly relies on valid user
input. This patch is trying to avoid such potential issues by fetching the
exact address region from trigger action table entry.

v2: minor fixes

Signed-off-by: Xiao, Hui <hui.xiao@linux.intel.com>
---
 drivers/acpi/apei/einj.c |   40 +++++++++++++++++++++++++++++++++-------
 1 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 1477bc7..11b1b73 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -194,6 +194,26 @@ static int einj_check_trigger_header(struct acpi_einj_trigger *trigger_tab)
 	return 0;
 }
 
+static struct acpi_generic_address *einj_get_trigger_parameter_region(
+	struct acpi_einj_trigger *trigger_tab, u64 param1, u64 param2)
+{
+	int i;
+	struct acpi_whea_header *entry;
+
+	entry = (struct acpi_whea_header *)
+		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
+	for (i = 0; i < trigger_tab->entry_count; i++) {
+		if (entry->action == ACPI_EINJ_TRIGGER_ERROR &&
+		entry->instruction == ACPI_EINJ_WRITE_REGISTER_VALUE &&
+		entry->register_region.space_id ==
+			ACPI_ADR_SPACE_SYSTEM_MEMORY &&
+		(entry->register_region.address & param2) == (param1 & param2))
+			return &entry->register_region;
+		entry++;
+	}
+
+	return NULL;
+}
 /* Execute instructions in trigger error action table */
 static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 				u64 param1, u64 param2)
@@ -205,6 +225,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	struct resource *r;
 	u32 table_size;
 	int rc = -EIO;
+	struct acpi_generic_address *trigger_param_region = NULL;
 
 	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
 			       "APEI EINJ Trigger Table");
@@ -263,14 +284,19 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	 * remove it from trigger table resources.
 	 */
 	if (param_extension && (type & 0x0038) && param2) {
-		struct apei_resources addr_resources;
+		struct apei_resources addr_resources;
 		apei_resources_init(&addr_resources);
-		rc = apei_resources_add(&addr_resources,
-					param1 & param2,
-					~param2 + 1, true);
-		if (rc)
-			goto out_fini;
-		rc = apei_resources_sub(&trigger_resources, &addr_resources);
+		trigger_param_region = einj_get_trigger_parameter_region(
+			trigger_tab, param1, param2);
+		if (trigger_param_region) {
+			rc = apei_resources_add(&addr_resources,
+				trigger_param_region->address,
+				trigger_param_region->bit_width/8, true);
+			if (rc)
+				goto out_fini;
+			rc = apei_resources_sub(&trigger_resources,
+					&addr_resources);
+		}
 		apei_resources_fini(&addr_resources);
 		if (rc)
 			goto out_fini;
-- 
1.7.3.4
