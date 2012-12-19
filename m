From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 17/19] ACPICA: Resource Manager: update template walking with ACPI_NEXT_RESOURCE.
Date: Wed, 19 Dec 2012 13:38:31 +0800
Message-ID: <bc05d1c6df02b315a108e3d480504b83eee05e62.1355810294.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com> <cover.1355810292.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60388 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab2LSFih (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 00:38:37 -0500
In-Reply-To: <cover.1355810292.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>

Cleanup the ACPI_NEXT_RESOURCE macro.  Update AcpiWalkResources
to use ACPI_NEXT_RESOURCE.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/rsxface.c |    4 +---
 include/acpi/acrestyp.h       |    5 ++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 5aad744..3a5ace7 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -606,9 +606,7 @@ acpi_walk_resources(acpi_handle device_handle,
 
 		/* Get the next resource descriptor */
 
-		resource =
-		    ACPI_ADD_PTR(struct acpi_resource, resource,
-				 resource->length);
+		resource = ACPI_NEXT_RESOURCE(resource);
 	}
 
 	ACPI_FREE(buffer.pointer);
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 40349ae..17f2d05 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -591,7 +591,10 @@ struct acpi_resource {
 #define ACPI_RS_SIZE_MIN                    (u32) ACPI_ROUND_UP_TO_NATIVE_WORD (12)
 #define ACPI_RS_SIZE(type)                  (u32) (ACPI_RS_SIZE_NO_DATA + sizeof (type))
 
-#define ACPI_NEXT_RESOURCE(res)             (struct acpi_resource *)((u8 *) res + res->length)
+/* Macro for walking resource templates with multiple descriptors */
+
+#define ACPI_NEXT_RESOURCE(res) \
+	ACPI_ADD_PTR (struct acpi_resource, (res), (res)->length)
 
 struct acpi_pci_routing_table {
 	u32 length;
-- 
1.7.10

