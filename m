From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/18] ACPICA: Add additional named objects for the auto-serialize method scan.
Date: Wed, 26 Feb 2014 10:31:31 +0800
Message-ID: <c8d46274263035699e0981509bf523c24ca200f5.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41320 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbaBZCcI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:32:08 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
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
 drivers/acpi/acpica/dsmethod.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index f51d8a4..73764c7 100644
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
 
@@ -184,7 +186,7 @@ acpi_ds_detect_named_opcodes(struct acpi_walk_state *walk_state,
 
 	/* Abort the parse, no need to examine this method any further */
 
-	return_ACPI_STATUS(AE_CTRL_TERMINATE);
+	return (AE_CTRL_TERMINATE);
 }
 
 /*******************************************************************************
-- 
1.7.10

