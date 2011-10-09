From: "Xiao, Hui" <hui.xiao@linux.intel.com>
Subject: [PATCH] ACPI, APEI, EINJ, Refine the fix of resource conflict
Date: Sun, 09 Oct 2011 16:44:51 +0800
Message-ID: <4E915F03.4000309@linux.intel.com>
References: <4E915D36.4060701@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6620 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab1JIIoy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Oct 2011 04:44:54 -0400
Received: from [10.238.128.173] (hxiao12-mobl.ccr.corp.intel.com [10.238.128.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id E25CC6A4087
	for <linux-acpi@vger.kernel.org>; Sun,  9 Oct 2011 01:44:50 -0700 (PDT)
In-Reply-To: <4E915D36.4060701@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Current fix for resource conflict is to remove the address region <param1 &
param2, ~param2+1> from trigger resource, which is highly relies on valid user
input and will cause kernel panic if param1 is not aligned. This patch is trying
to avoid such potential issues by fetching the exact address region from trigger
action table entry and checking for param1 alignment.

Signed-off-by: Xiao, Hui <hui.xiao@linux.intel.com>
---
 drivers/acpi/apei/einj.c |   42 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 1477bc7..6db13e5 100644
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
@@ -264,13 +285,22 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	 */
 	if (param_extension && (type & 0x0038) && param2) {
 		struct apei_resources addr_resources;
-		apei_resources_init(&addr_resources);
-		rc = apei_resources_add(&addr_resources,
-					param1 & param2,
-					~param2 + 1, true);
-		if (rc)
+		if (param1 & 0x3f) {
+			pr_err(EINJ_PFX "Param1 need to be 64 byte aligned!\n");
 			goto out_fini;
-		rc = apei_resources_sub(&trigger_resources, &addr_resources);
+		}
+		apei_resources_init(&addr_resources);
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

