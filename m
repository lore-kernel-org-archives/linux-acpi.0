From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH] ACPI, APEI, EINJ: Add missed ACPI5 support error trigger table
Date: Fri, 30 Nov 2012 04:47:59 -0500
Message-ID: <1354268879-5408-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62830 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab2K3JzO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Nov 2012 04:55:14 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com
Cc: ying.huang@intel.com, linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

To handle error trigger table correctly, memory region must be
removed from request region. We ever have a patch to do this
work (commit id: b4e008dc5) but at that time ACPI5 is unrevealed
so this option is missed. When using EINJ table on an ACPI5
enabled machine, we get following error:

APEI: Can not request [mem 0x526b80000-0x526b80007] for APEI EINJ
Trigger registers

This patch fixes this issue.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
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
1.7.10.4

