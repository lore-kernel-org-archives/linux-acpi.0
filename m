From: Len Brown <len.brown@intel.com>
Subject: [PATCH 2/65] ACPICA: Handle mis-matched package length
Date: Fri, 24 Nov 2006 02:18:12 -0500
Message-ID: <11643527572123-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50244 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757600AbWKXHPT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:19 -0500
In-Reply-To: <11643527561399-git-send-email-len.brown@intel.com>
Message-Id: <b36e9a5492481728323509aa6179ce6bdab46953.1164352285.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Implement support within the AML interpreter for
package objects that contain a mismatch between the AML
length and package element count. In this case, the lesser
of the two is used. Some BIOS code apparently modifies
the package length on the fly, and this change supports
this. Provides compatibility with the MS AML interpreter.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsobject.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatcher/dsobject.c
index 72190ab..aaeb9f9 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -318,9 +318,7 @@ acpi_ds_build_internal_package_obj(struc
 		obj_desc->package.node = parent->common.node;
 	}
 
-	obj_desc->package.count = package_length;
-
-	/* Count the number of items in the package list */
+	/* Count the *actual* number of items in the package list */
 
 	arg = op->common.value.arg;
 	arg = arg->common.next;
@@ -329,11 +327,24 @@ acpi_ds_build_internal_package_obj(struc
 	}
 
 	/*
-	 * The package length (number of elements) will be the greater
-	 * of the specified length and the length of the initializer list
+	 * The number of elements in the package will be the lesser of the
+	 * specified element count and the length of the initializer list.
+	 *
+	 * Even though the ASL compilers do not allow this to happen (for the
+	 * fixed length package opcode), some BIOS code modifies the AML on the
+	 * fly to adjust the package length, and this code compensates for that.
+	 * This also provides compatibility with other AML interpreters.
 	 */
-	if (package_list_length > package_length) {
-		obj_desc->package.count = package_list_length;
+	obj_desc->package.count = package_length;
+
+	if (package_list_length != package_length) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Package length mismatch, using lesser of %X(Length Arg) and %X(AML Length)\n",
+				  package_length, package_list_length));
+
+		if (package_list_length < package_length) {
+			obj_desc->package.count = package_list_length;
+		}
 	}
 
 	/*
@@ -356,7 +367,7 @@ acpi_ds_build_internal_package_obj(struc
 	 */
 	arg = op->common.value.arg;
 	arg = arg->common.next;
-	for (i = 0; arg; i++) {
+	for (i = 0; i < obj_desc->package.count; i++) {
 		if (arg->common.aml_opcode == AML_INT_RETURN_VALUE_OP) {
 
 			/* Object (package or buffer) is already built */
-- 
1.4.4.1
