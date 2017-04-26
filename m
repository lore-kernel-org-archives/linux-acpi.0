From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/15] ACPICA: Update for automatic repair code for objects returned by evaluate_object
Date: Wed, 26 Apr 2017 16:18:16 +0800
Message-ID: <1d82754b482a289c5c81c7270f6557e01ecd9158.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22415 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952717AbdDZISZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:18:25 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 6b58810b9aad7358fbf1a0f4057fefa8d29838d3

This change fixes two instances where the repair code made an incorrect
assumption about how reference counts are assigned to package objects.
Resolves issues where a warning was issued about a "large reference
count" -- which usually indicates an attempt to delete an object
that has previously been poisoned and released into the object cache.

Link: https://github.com/acpica/acpica/commit/6b58810b
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsrepair.c  | 16 +++-------------
 drivers/acpi/acpica/nsrepair2.c |  6 +-----
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 3831626..418ef2a 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -290,22 +290,12 @@ acpi_ns_simple_repair(struct acpi_evaluate_info *info,
 	/* Object was successfully repaired */
 
 	if (package_index != ACPI_NOT_PACKAGE_ELEMENT) {
-		/*
-		 * The original object is a package element. We need to
-		 * decrement the reference count of the original object,
-		 * for removing it from the package.
-		 *
-		 * However, if the original object was just wrapped with a
-		 * package object as part of the repair, we don't need to
-		 * change the reference count.
-		 */
+
+		/* Update reference count of new object */
+
 		if (!(info->return_flags & ACPI_OBJECT_WRAPPED)) {
 			new_object->common.reference_count =
 			    return_object->common.reference_count;
-
-			if (return_object->common.reference_count > 1) {
-				return_object->common.reference_count--;
-			}
 		}
 
 		ACPI_DEBUG_PRINT((ACPI_DB_REPAIR,
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 3522654..06037e0 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -403,16 +403,12 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
 			return (status);
 		}
 
-		/* Take care with reference counts */
-
 		if (original_element != *element_ptr) {
 
-			/* Element was replaced */
+			/* Update reference count of new object */
 
 			(*element_ptr)->common.reference_count =
 			    original_ref_count;
-
-			acpi_ut_remove_reference(original_element);
 		}
 
 		element_ptr++;
-- 
2.7.4

