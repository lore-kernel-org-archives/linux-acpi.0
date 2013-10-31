From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/15] ACPICA: Fix wrong object length returned by acpi_ut_get_simple_object_size().
Date: Thu, 31 Oct 2013 09:30:36 +0800
Message-ID: <5582fbd32dc7125d623f86890199006142577351.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21100 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3JaBbK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:31:10 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch decreases 39 lines of divergences.

There is object length returned by acpi_ut_get_simple_object_size() hasn't
been rounded up to the word boundary.
This patch merges fix from ACPICA upstream as such enhacement already has
been done in ACPICA upstream.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utobject.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index aa61f66..cddb0ef 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -461,25 +461,28 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 
 	ACPI_FUNCTION_TRACE_PTR(ut_get_simple_object_size, internal_object);
 
+	/* Start with the length of the (external) Acpi object */
+
+	length = sizeof(union acpi_object);
+
+	/* A NULL object is allowed, can be a legal uninitialized package element */
+
+	if (!internal_object) {
 	/*
-	 * Handle a null object (Could be a uninitialized package
-	 * element -- which is legal)
+		 * Object is NULL, just return the length of union acpi_object
+		 * (A NULL union acpi_object is an object of all zeroes.)
 	 */
-	if (!internal_object) {
-		*obj_length = sizeof(union acpi_object);
+		*obj_length = ACPI_ROUND_UP_TO_NATIVE_WORD(length);
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	/* Start with the length of the Acpi object */
-
-	length = sizeof(union acpi_object);
+	/* A Namespace Node should never appear here */
 
 	if (ACPI_GET_DESCRIPTOR_TYPE(internal_object) == ACPI_DESC_TYPE_NAMED) {
 
-		/* Object is a named object (reference), just return the length */
+		/* A namespace node should never get here */
 
-		*obj_length = ACPI_ROUND_UP_TO_NATIVE_WORD(length);
-		return_ACPI_STATUS(status);
+		return_ACPI_STATUS(AE_AML_INTERNAL);
 	}
 
 	/*
-- 
1.7.10

