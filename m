From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/26] ACPICA: AcpiExec: Improve algorithm for tracking memory leaks
Date: Wed, 31 Oct 2012 10:27:32 +0800
Message-ID: <a003b873760bfce4b8938f0b27e86163641feb39.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:13253 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab2JaC1j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:27:39 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add some intelligence to the code that maintains the global
list of allocated memory. The list is now ordered by allocated
memory address, significantly improving performance.  When running
AcpiExec on the ASLTS test suite, speed improvements of 3X to 5X
are seen, depending on the platform and/or the environment.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/uttrack.c |  100 +++++++++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 79f311c..a424a9e 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -61,7 +61,9 @@
 ACPI_MODULE_NAME("uttrack")
 
 /* Local prototypes */
-static struct acpi_debug_mem_block *acpi_ut_find_allocation(void *allocation);
+static struct acpi_debug_mem_block *acpi_ut_find_allocation(struct
+							    acpi_debug_mem_block
+							    *allocation);
 
 static acpi_status
 acpi_ut_track_allocation(struct acpi_debug_mem_block *address,
@@ -263,31 +265,61 @@ acpi_ut_free_and_track(void *allocation,
  *
  * PARAMETERS:  allocation              - Address of allocated memory
  *
- * RETURN:      A list element if found; NULL otherwise.
+ * RETURN:      Three cases:
+ *              1) List is empty, NULL is returned.
+ *              2) Element was found. Returns Allocation parameter.
+ *              3) Element was not found. Returns position where it should be
+ *                  inserted into the list.
  *
  * DESCRIPTION: Searches for an element in the global allocation tracking list.
+ *              If the element is not found, returns the location within the
+ *              list where the element should be inserted.
+ *
+ *              Note: The list is ordered by larger-to-smaller addresses.
+ *
+ *              This global list is used to detect memory leaks in ACPICA as
+ *              well as other issues such as an attempt to release the same
+ *              internal object more than once. Although expensive as far
+ *              as cpu time, this list is much more helpful for finding these
+ *              types of issues than using memory leak detectors outside of
+ *              the ACPICA code.
  *
  ******************************************************************************/
 
-static struct acpi_debug_mem_block *acpi_ut_find_allocation(void *allocation)
+static struct acpi_debug_mem_block *acpi_ut_find_allocation(struct
+							    acpi_debug_mem_block
+							    *allocation)
 {
 	struct acpi_debug_mem_block *element;
 
-	ACPI_FUNCTION_ENTRY();
-
 	element = acpi_gbl_global_list->list_head;
+	if (!element) {
+		return (NULL);
+	}
+
+	/*
+	 * Search for the address.
+	 *
+	 * Note: List is ordered by larger-to-smaller addresses, on the
+	 * assumption that a new allocation usually has a larger address
+	 * than previous allocations.
+	 */
+	while (element > allocation) {
 
-	/* Search for the address. */
+		/* Check for end-of-list */
 
-	while (element) {
-		if (element == allocation) {
+		if (!element->next) {
 			return (element);
 		}
 
 		element = element->next;
 	}
 
-	return (NULL);
+	if (element == allocation) {
+		return (element);
+	}
+
+	return (element->previous);
 }
 
 /*******************************************************************************
@@ -301,7 +333,7 @@ static struct acpi_debug_mem_block *acpi_ut_find_allocation(void *allocation)
  *              module              - Source file name of caller
  *              line                - Line number of caller
  *
- * RETURN:      None.
+ * RETURN:      Status
  *
  * DESCRIPTION: Inserts an element into the global allocation tracking list.
  *
@@ -330,22 +362,18 @@ acpi_ut_track_allocation(struct acpi_debug_mem_block *allocation,
 	}
 
 	/*
-	 * Search list for this address to make sure it is not already on the list.
-	 * This will catch several kinds of problems.
+	 * Search the global list for this address to make sure it is not
+	 * already present. This will catch several kinds of problems.
 	 */
 	element = acpi_ut_find_allocation(allocation);
-	if (element) {
+	if (element == allocation) {
 		ACPI_ERROR((AE_INFO,
-			    "UtTrackAllocation: Allocation already present in list! (%p)",
+			    "UtTrackAllocation: Allocation (%p) already present in global list!",
 			    allocation));
-
-		ACPI_ERROR((AE_INFO, "Element %p Address %p",
-			    element, allocation));
-
 		goto unlock_and_exit;
 	}
 
-	/* Fill in the instance data. */
+	/* Fill in the instance data */
 
 	allocation->size = (u32)size;
 	allocation->alloc_type = alloc_type;
@@ -355,17 +383,31 @@ acpi_ut_track_allocation(struct acpi_debug_mem_block *allocation,
 	ACPI_STRNCPY(allocation->module, module, ACPI_MAX_MODULE_NAME);
 	allocation->module[ACPI_MAX_MODULE_NAME - 1] = 0;
 
-	/* Insert at list head */
+	if (!element) {
 
-	if (mem_list->list_head) {
-		((struct acpi_debug_mem_block *)(mem_list->list_head))->
-		    previous = allocation;
-	}
+		/* Insert at list head */
+
+		if (mem_list->list_head) {
+			((struct acpi_debug_mem_block *)(mem_list->list_head))->
+			    previous = allocation;
+		}
+
+		allocation->next = mem_list->list_head;
+		allocation->previous = NULL;
 
-	allocation->next = mem_list->list_head;
-	allocation->previous = NULL;
+		mem_list->list_head = allocation;
+	} else {
+		/* Insert after element */
+
+		allocation->next = element->next;
+		allocation->previous = element;
+
+		if (element->next) {
+			(element->next)->previous = allocation;
+		}
 
-	mem_list->list_head = allocation;
+		element->next = allocation;
+	}
 
       unlock_and_exit:
 	status = acpi_ut_release_mutex(ACPI_MTX_MEMORY);
@@ -381,7 +423,7 @@ acpi_ut_track_allocation(struct acpi_debug_mem_block *allocation,
  *              module              - Source file name of caller
  *              line                - Line number of caller
  *
- * RETURN:
+ * RETURN:      Status
  *
  * DESCRIPTION: Deletes an element from the global allocation tracking list.
  *
@@ -443,7 +485,7 @@ acpi_ut_remove_allocation(struct acpi_debug_mem_block *allocation,
  *
  * FUNCTION:    acpi_ut_dump_allocation_info
  *
- * PARAMETERS:
+ * PARAMETERS:  None
  *
  * RETURN:      None
  *
-- 
1.7.10

