From: Len Brown <lenb@kernel.org>
Subject: [PATCH 072/103] ACPICA: Conditionally perform complex
 per-predefined-name repairs
Date: Wed, 16 Dec 2009 03:36:23 -0500
Message-ID: <465da9eb75665203a826f961de74a817b870850a.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762013AbZLPLGK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:10 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:06:00 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Only attempt the "complex" repairs (package sorting, buffer
expansion) if the previous "generic" validation and repair was
successful.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nspredef.c |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index e352467..239fa2f 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -215,31 +215,42 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	data->node_flags = node->flags;
 	data->pathname = pathname;
 
-	/* TBD: For variable-length Packages, remove NULL elements here */
-
 	/*
-	 * Check that the type of the return object is what is expected for
-	 * this predefined name
+	 * Check that the type of the main return object is what is expected
+	 * for this predefined name
 	 */
 	status = acpi_ns_check_object_type(data, return_object_ptr,
 					   predefined->info.expected_btypes,
 					   ACPI_NOT_PACKAGE_ELEMENT);
-	if (ACPI_SUCCESS(status)) {
-		/*
-		 * For returned Package objects, check the type of all sub-objects.
-		 * Note: Package may have been created by call above.
-		 */
-		if ((*return_object_ptr)->common.type == ACPI_TYPE_PACKAGE) {
-			status = acpi_ns_check_package(data, return_object_ptr);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/*
+	 * For returned Package objects, check the type of all sub-objects.
+	 * Note: Package may have been newly created by call above.
+	 */
+	if ((*return_object_ptr)->common.type == ACPI_TYPE_PACKAGE) {
+
+		/* TBD: For variable-length Packages, remove NULL elements here */
+
+		status = acpi_ns_check_package(data, return_object_ptr);
+		if (ACPI_FAILURE(status)) {
+			goto exit;
 		}
 	}
 
 	/*
-	 * Perform additional, more complicated repairs on a per-name
-	 * basis. Do this regardless of the status from above.
+	 * The return object was OK, or it was successfully repaired above.
+	 * Now make some additional checks such as verifying that package
+	 * objects are sorted correctly (if required) or buffer objects have
+	 * the correct data width (bytes vs. dwords). These repairs are
+	 * performed on a per-name basis, i.e., the code is specific to
+	 * particular predefined names.
 	 */
 	status = acpi_ns_complex_repairs(data, node, status, return_object_ptr);
 
+exit:
 	/*
 	 * If the object validation failed or if we successfully repaired one
 	 * or more objects, mark the parent node to suppress further warning
-- 
1.6.0.6

