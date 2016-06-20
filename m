From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 2/5] ACPICA: Dispatcher: Fix an issue that the opregions created by the linked MLC were not tracked
Date: Mon, 20 Jun 2016 17:07:29 +0800
Message-ID: <efb85f56a012ec7605426d07380b0d1ee46b36ba.1466413497.git.lv.zheng@intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5> <cover.1466413497.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3395 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbcFTJHd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jun 2016 05:07:33 -0400
In-Reply-To: <cover.1466413497.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Operation regions created by MLC were not tracked by
acpi_check_address_range(), this patch fixes this issue. ACPICA BZ 1279. Fixed
by Lv Zheng.

Link: https://bugs.acpica.org/show_bug.cgi?id=1279
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsopcode.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 4cc9d98..96f2eef 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -455,6 +455,12 @@ acpi_ds_eval_region_operands(struct acpi_walk_state *walk_state,
 	/* Now the address and length are valid for this opregion */
 
 	obj_desc->region.flags |= AOPOBJ_DATA_VALID;
+	if (walk_state->parse_flags & ACPI_PARSE_MODULE_LEVEL) {
+		status = acpi_ut_add_address_range(obj_desc->region.space_id,
+						   obj_desc->region.address,
+						   obj_desc->region.length,
+						   node);
+	}
 	return_ACPI_STATUS(status);
 }
 
-- 
1.7.10

