From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/21] ACPICA: Add macros to access pointer to next object in the descriptor list
Date: Fri,  8 Mar 2013 17:21:54 +0800
Message-ID: <08a8c9c0c98181ffe52e73d0f5236ac5121c6633.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16329 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJWI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:22:08 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Jung-uk Kim <jkim@FreeBSD.org>, Lv Zheng <lv.zheng@intel.com>

From: Jung-uk Kim <jkim@FreeBSD.org>

Signed-off-by: Jung-uk Kim <jkim@FreeBSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    4 +++-
 drivers/acpi/acpica/utcache.c  |   10 +++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index ed7943b..8b7ca40 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -322,8 +322,10 @@
  * where a pointer to an object of type union acpi_operand_object can also
  * appear. This macro is used to distinguish them.
  *
- * The "Descriptor" field is the first field in both structures.
+ * The "DescriptorType" field is the second field in both structures.
  */
+#define ACPI_GET_DESCRIPTOR_PTR(d)      (((union acpi_descriptor *)(void *)(d))->common.common_pointer)
+#define ACPI_SET_DESCRIPTOR_PTR(d, o)   (((union acpi_descriptor *)(void *)(d))->common.common_pointer = o)
 #define ACPI_GET_DESCRIPTOR_TYPE(d)     (((union acpi_descriptor *)(void *)(d))->common.descriptor_type)
 #define ACPI_SET_DESCRIPTOR_TYPE(d, t)  (((union acpi_descriptor *)(void *)(d))->common.descriptor_type = t)
 
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index 2de22fb..a877a96 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -127,9 +127,7 @@ acpi_status acpi_os_purge_cache(struct acpi_memory_list * cache)
 
 		/* Delete and unlink one cached state object */
 
-		next =
-		    ((struct acpi_object_common *)cache->list_head)->
-		    next_object;
+		next = ACPI_GET_DESCRIPTOR_PTR(cache->list_head);
 		ACPI_FREE(cache->list_head);
 
 		cache->list_head = next;
@@ -219,8 +217,7 @@ acpi_os_release_object(struct acpi_memory_list * cache, void *object)
 
 		/* Put the object at the head of the cache list */
 
-		((struct acpi_object_common *)object)->next_object =
-		    cache->list_head;
+		ACPI_SET_DESCRIPTOR_PTR(object, cache->list_head);
 		cache->list_head = object;
 		cache->current_depth++;
 
@@ -268,8 +265,7 @@ void *acpi_os_acquire_object(struct acpi_memory_list *cache)
 		/* There is an object available, use it */
 
 		object = cache->list_head;
-		cache->list_head =
-		    ((struct acpi_object_common *)object)->next_object;
+		cache->list_head = ACPI_GET_DESCRIPTOR_PTR(object);
 
 		cache->current_depth--;
 
-- 
1.7.10

