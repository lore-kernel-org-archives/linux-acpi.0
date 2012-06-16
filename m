From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH] ACPI,APEI: Fixup parameter check for ACPI5 in EINJ
Date: Sat, 16 Jun 2012 15:13:22 +0800
Message-ID: <1339830802-10891-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62924 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab2FPHM1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Jun 2012 03:12:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, tony.luck@intel.com, Chen Gong <gong.chen@linux.intel.com>

We need the same checks for target address in the trigger
code when using ACPI5 that we already have when using the
parameter mode of ACPI4.x.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/einj.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 8e17936..8d457b5 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -367,7 +367,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	 * This will cause resource conflict with regular memory.  So
 	 * remove it from trigger table resources.
 	 */
-	if (param_extension && (type & 0x0038) && param2) {
+	if ((param_extension || acpi5) && (type & 0x0038) && param2) {
 		struct apei_resources addr_resources;
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
-- 
1.7.10

