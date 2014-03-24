From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/5] ACPICA: Add additional named objects for the auto-serialize method scan.
Date: Mon, 24 Mar 2014 14:49:07 +0800
Message-ID: <718a4a8242f09790c5bcd4155ef05503763e2b86.1395638745.git.lv.zheng@intel.com>
References: <cover.1395638745.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64280 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbaCXGtL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Mar 2014 02:49:11 -0400
In-Reply-To: <cover.1395638745.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This change adds some additional opcodes that are detected and will
cause a method to be auto-serialized. These opcodes are the various
CreateXField and the FieldUnit opcodes. Lv Zheng.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=52191
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 97ed86a..73764c7 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -163,9 +163,11 @@ acpi_ds_detect_named_opcodes(struct acpi_walk_state *walk_state,
 
 	ACPI_FUNCTION_NAME(acpi_ds_detect_named_opcodes);
 
-	/* We are only interested in opcodes that have an associated name */
+	/* We are only interested in opcodes that create a new name */
 
-	if (!(walk_state->op_info->flags & AML_NAMED)) {
+	if (!
+	    (walk_state->op_info->
+	     flags & (AML_NAMED | AML_CREATE | AML_FIELD))) {
 		return (AE_OK);
 	}
 
-- 
1.7.10

