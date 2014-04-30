From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/27] ACPICA: Update acpi_buffer_to_resource interface.
Date: Wed, 30 Apr 2014 10:03:58 +0800
Message-ID: <f7a36f432663dd8697b97f711c77213f8d2963f9.1398817612.git.lv.zheng@intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1398817612.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

1) Add standard trace mechanism.
2) Add ACPI_EXPORT_SYMBOL macro.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rscreate.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 75d3690..049d9c2 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -72,6 +72,8 @@ acpi_buffer_to_resource(u8 *aml_buffer,
 	void *resource;
 	void *current_resource_ptr;
 
+	ACPI_FUNCTION_TRACE(acpi_buffer_to_resource);
+
 	/*
 	 * Note: we allow AE_AML_NO_RESOURCE_END_TAG, since an end tag
 	 * is not required here.
@@ -85,7 +87,7 @@ acpi_buffer_to_resource(u8 *aml_buffer,
 		status = AE_OK;
 	}
 	if (ACPI_FAILURE(status)) {
-		return (status);
+		return_ACPI_STATUS(status);
 	}
 
 	/* Allocate a buffer for the converted resource */
@@ -93,7 +95,7 @@ acpi_buffer_to_resource(u8 *aml_buffer,
 	resource = ACPI_ALLOCATE_ZEROED(list_size_needed);
 	current_resource_ptr = resource;
 	if (!resource) {
-		return (AE_NO_MEMORY);
+		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
 	/* Perform the AML-to-Resource conversion */
@@ -110,9 +112,11 @@ acpi_buffer_to_resource(u8 *aml_buffer,
 		*resource_ptr = resource;
 	}
 
-	return (status);
+	return_ACPI_STATUS(status);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_buffer_to_resource)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_rs_create_resource_list
@@ -130,10 +134,9 @@ acpi_buffer_to_resource(u8 *aml_buffer,
  *              of device resources.
  *
  ******************************************************************************/
-
 acpi_status
 acpi_rs_create_resource_list(union acpi_operand_object *aml_buffer,
-			     struct acpi_buffer * output_buffer)
+			     struct acpi_buffer *output_buffer)
 {
 
 	acpi_status status;
-- 
1.7.10
