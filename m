From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/21] ACPICA: Resource Mgr: Prevent infinite loops in resource walks
Date: Fri,  8 Mar 2013 17:19:38 +0800
Message-ID: <75b5ee4083773f619db7605d92bde7b18a33add5.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14662 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133Ab3CHJUG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:20:06 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add checks for zero-length resource descriptors in all code that
loops through a resource descriptor list. This prevents possible
infinite loops because the length is used to increment the traveral
pointer and detect the end-of-descriptor.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rscalc.c  |    6 ++++++
 drivers/acpi/acpica/rsdump.c  |    8 ++++++++
 drivers/acpi/acpica/rslist.c  |    8 ++++++++
 drivers/acpi/acpica/rsxface.c |    8 +++++++-
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 7816d4ee..72077fa 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -202,6 +202,12 @@ acpi_rs_get_aml_length(struct acpi_resource * resource, acpi_size * size_needed)
 			return_ACPI_STATUS(AE_AML_INVALID_RESOURCE_TYPE);
 		}
 
+		/* Sanity check the length. It must not be zero, or we loop forever */
+
+		if (!resource->length) {
+			return_ACPI_STATUS(AE_AML_BAD_RESOURCE_LENGTH);
+		}
+
 		/* Get the base size of the (external stream) resource descriptor */
 
 		total_size = acpi_gbl_aml_resource_sizes[resource->type];
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index cab5144..b5fc0db 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -385,6 +385,14 @@ void acpi_rs_dump_resource_list(struct acpi_resource *resource_list)
 			return;
 		}
 
+		/* Sanity check the length. It must not be zero, or we loop forever */
+
+		if (!resource_list->length) {
+			acpi_os_printf
+			    ("Invalid zero length descriptor in resource list\n");
+			return;
+		}
+
 		/* Dump the resource descriptor */
 
 		if (type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index ee2e206..6053aa1 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -178,6 +178,14 @@ acpi_rs_convert_resources_to_aml(struct acpi_resource *resource,
 			return_ACPI_STATUS(AE_BAD_DATA);
 		}
 
+		/* Sanity check the length. It must not be zero, or we loop forever */
+
+		if (!resource->length) {
+			ACPI_ERROR((AE_INFO,
+				    "Invalid zero length descriptor in resource list\n"));
+			return_ACPI_STATUS(AE_AML_BAD_RESOURCE_LENGTH);
+		}
+
 		/* Perform the conversion */
 
 		if (resource->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 15d6eae..c0e5d2d 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -563,13 +563,19 @@ acpi_walk_resource_buffer(struct acpi_buffer * buffer,
 
 	while (resource < resource_end) {
 
-		/* Sanity check the resource */
+		/* Sanity check the resource type */
 
 		if (resource->type > ACPI_RESOURCE_TYPE_MAX) {
 			status = AE_AML_INVALID_RESOURCE_TYPE;
 			break;
 		}
 
+		/* Sanity check the length. It must not be zero, or we loop forever */
+
+		if (!resource->length) {
+			return_ACPI_STATUS(AE_AML_BAD_RESOURCE_LENGTH);
+		}
+
 		/* Invoke the user function, abort on any error returned */
 
 		status = user_function(resource, context);
-- 
1.7.10

