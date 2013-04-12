From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/11] ACPICA: Remove FORCE_DELETE option for global reference count mechanism
Date: Fri, 12 Apr 2013 08:25:29 +0800
Message-ID: <9381c628eea63d096b44a2ab211cfe7198cfa6d7.1365473142.git.lv.zheng@intel.com>
References: <cover.1364865215.git.lv.zheng@intel.com> <cover.1365473141.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:54778 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab3DLAZd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 20:25:33 -0400
In-Reply-To: <cover.1365473141.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

This option is not used and is obsolete.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    3 ++-
 drivers/acpi/acpica/utdelete.c |   14 +-------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index bbeb961..202f4f1 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -113,9 +113,10 @@ struct acpi_pkg_info {
 	u32 num_packages;
 };
 
+/* Object reference counts */
+
 #define REF_INCREMENT       (u16) 0
 #define REF_DECREMENT       (u16) 1
-#define REF_FORCE_DELETE    (u16) 2
 
 /* acpi_ut_dump_buffer */
 
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 2541de4..fc11ad1 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -424,17 +424,6 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 		}
 		break;
 
-	case REF_FORCE_DELETE:
-
-		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
-				  "Obj %p Refs=%X, Force delete! (Set to 0)\n",
-				  object, count));
-
-		new_count = 0;
-		object->common.reference_count = new_count;
-		acpi_ut_delete_internal_obj(object);
-		break;
-
 	default:
 
 		ACPI_ERROR((AE_INFO, "Unknown action (0x%X)", action));
@@ -458,8 +447,7 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
  *
  * PARAMETERS:  object              - Increment ref count for this object
  *                                    and all sub-objects
- *              action              - Either REF_INCREMENT or REF_DECREMENT or
- *                                    REF_FORCE_DELETE
+ *              action              - Either REF_INCREMENT or REF_DECREMENT
  *
  * RETURN:      Status
  *
-- 
1.7.10

