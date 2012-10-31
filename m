From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/26] ACPICA: Resource Mgr: Small fix for buffer size calculation
Date: Wed, 31 Oct 2012 10:27:15 +0800
Message-ID: <8deead26946fd63b7ab7fefd61e09e34e16a03cf.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17618 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933202Ab2JaC1W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:27:22 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Feng Tang <feng.tang@intel.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Feng Tang <feng.tang@intel.com>

Fixes a one byte error in the output buffer calculation.
Feng Tang - ACPICA BZ 849:
https://www.acpica.org/bugzilla/show_bug.cgi?id=849

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rscalc.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 6851779..147feb6 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -457,6 +457,15 @@ acpi_rs_get_list_length(u8 * aml_buffer,
 			 * Get the number of vendor data bytes
 			 */
 			extra_struct_bytes = resource_length;
+
+			/*
+			 * There is already one byte included in the minimum
+			 * descriptor size. If there are extra struct bytes,
+			 * subtract one from the count.
+			 */
+			if (extra_struct_bytes) {
+				extra_struct_bytes--;
+			}
 			break;
 
 		case ACPI_RESOURCE_NAME_END_TAG:
-- 
1.7.10

