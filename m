From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5 2/5] ACPICA: Parser: Fix a regression in LoadTable support
Date: Fri, 23 Sep 2016 11:26:43 +0800
Message-ID: <f42c3327e0be2593c86e4a7e640bd9ebea1800a1.1474600034.git.lv.zheng@intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5> <cover.1474600034.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25297 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934650AbcIWD07 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Sep 2016 23:26:59 -0400
In-Reply-To: <cover.1474600034.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit a78506e0ce8ab1d20db2a055d99cf9143e89eb29

LoadTable allows an alternative RootPathString than the default "\", while
the new table execution support fails to keep this logic.

This regression can be detected by ASLTS - TLT0.tst4, this patch fixes this
regression.

Linux upstream is not affected by this regression as we haven't enabled the
new table execution support there. BZ 1326, Lv Zheng.

Link: https://github.com/acpica/acpica/commit/a78506e0
Link: https://bugs.acpica.org/show_bug.cgi?id=1326
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/psxface.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 8d7e5b5..f3c8726 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -305,6 +305,17 @@ acpi_status acpi_ps_execute_table(struct acpi_evaluate_info *info)
 		walk_state->parse_flags |= ACPI_PARSE_MODULE_LEVEL;
 	}
 
+	/* Info->Node is the default location to load the table  */
+
+	if (info->node && info->node != acpi_gbl_root_node) {
+		status =
+		    acpi_ds_scope_stack_push(info->node, ACPI_TYPE_METHOD,
+					     walk_state);
+		if (ACPI_FAILURE(status)) {
+			goto cleanup;
+		}
+	}
+
 	/*
 	 * Parse the AML, walk_state will be deleted by parse_aml
 	 */
-- 
1.7.10

