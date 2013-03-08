From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/21] ACPICA: Fix a long-standing bug in local cache
Date: Fri,  8 Mar 2013 17:21:02 +0800
Message-ID: <ba7e5fcc422c0b22221f67d40bbd0662b5635081.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29990 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJVl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:21:41 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Jung-uk Kim <jkim@FreeBSD.org>, Lv Zheng <lv.zheng@intel.com>

From: Jung-uk Kim <jkim@FreeBSD.org>

 Since 20060317, the pointer to next object is the first element in
 its common header.  Remove bogus LinkOffset from ACPI_MEMORY_LIST
 and directly use NextObject.

Signed-off-by: Jung-uk Kim <jkim@FreeBSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utcache.c |   20 +++++++-------------
 include/acpi/actypes.h        |    1 -
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index e0e8579..2de22fb 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -85,7 +85,6 @@ acpi_os_create_cache(char *cache_name,
 	/* Populate the cache object and return it */
 
 	ACPI_MEMSET(cache, 0, sizeof(struct acpi_memory_list));
-	cache->link_offset = 8;
 	cache->list_name = cache_name;
 	cache->object_size = object_size;
 	cache->max_depth = max_depth;
@@ -108,7 +107,7 @@ acpi_os_create_cache(char *cache_name,
 
 acpi_status acpi_os_purge_cache(struct acpi_memory_list * cache)
 {
-	char *next;
+	void *next;
 	acpi_status status;
 
 	ACPI_FUNCTION_ENTRY();
@@ -128,10 +127,9 @@ acpi_status acpi_os_purge_cache(struct acpi_memory_list * cache)
 
 		/* Delete and unlink one cached state object */
 
-		next = *(ACPI_CAST_INDIRECT_PTR(char,
-						&(((char *)cache->
-						   list_head)[cache->
-							      link_offset])));
+		next =
+		    ((struct acpi_object_common *)cache->list_head)->
+		    next_object;
 		ACPI_FREE(cache->list_head);
 
 		cache->list_head = next;
@@ -221,9 +219,7 @@ acpi_os_release_object(struct acpi_memory_list * cache, void *object)
 
 		/* Put the object at the head of the cache list */
 
-		*(ACPI_CAST_INDIRECT_PTR(char,
-					 &(((char *)object)[cache->
-							    link_offset]))) =
+		((struct acpi_object_common *)object)->next_object =
 		    cache->list_head;
 		cache->list_head = object;
 		cache->current_depth++;
@@ -272,10 +268,8 @@ void *acpi_os_acquire_object(struct acpi_memory_list *cache)
 		/* There is an object available, use it */
 
 		object = cache->list_head;
-		cache->list_head = *(ACPI_CAST_INDIRECT_PTR(char,
-							    &(((char *)
-							       object)[cache->
-								       link_offset])));
+		cache->list_head =
+		    ((struct acpi_object_common *)object)->next_object;
 
 		cache->current_depth--;
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 845e75f..3fac1be 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1128,7 +1128,6 @@ struct acpi_memory_list {
 	u16 object_size;
 	u16 max_depth;
 	u16 current_depth;
-	u16 link_offset;
 
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
 
-- 
1.7.10

