From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/21] ACPICA: Debug output: Fix a couple of small output issues.
Date: Wed,  8 Jan 2014 13:43:12 +0800
Message-ID: <a6137b686de69cca5ccd99d0f76b71ad5446c0c9.1387505702.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49710 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895AbaAHFna (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:43:30 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Linux kernel behaviour is not affected by this patch as Linux doesn't
use ACPICA object cache mechanism currently.

1) Fix utcache to use the proper return macros in order to maintain
the function nesting level.

2) Enable the function nesting level for all ACPI applications instead
of just acpiexec.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utcache.c |   12 ++++++------
 drivers/acpi/acpica/utdebug.c |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index 366bfec..cacd2fd 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -248,12 +248,12 @@ void *acpi_os_acquire_object(struct acpi_memory_list *cache)
 	ACPI_FUNCTION_NAME(os_acquire_object);
 
 	if (!cache) {
-		return (NULL);
+		return_PTR(NULL);
 	}
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_CACHES);
 	if (ACPI_FAILURE(status)) {
-		return (NULL);
+		return_PTR(NULL);
 	}
 
 	ACPI_MEM_TRACKING(cache->requests++);
@@ -276,7 +276,7 @@ void *acpi_os_acquire_object(struct acpi_memory_list *cache)
 
 		status = acpi_ut_release_mutex(ACPI_MTX_CACHES);
 		if (ACPI_FAILURE(status)) {
-			return (NULL);
+			return_PTR(NULL);
 		}
 
 		/* Clear (zero) the previously used Object */
@@ -299,15 +299,15 @@ void *acpi_os_acquire_object(struct acpi_memory_list *cache)
 
 		status = acpi_ut_release_mutex(ACPI_MTX_CACHES);
 		if (ACPI_FAILURE(status)) {
-			return (NULL);
+			return_PTR(NULL);
 		}
 
 		object = ACPI_ALLOCATE_ZEROED(cache->object_size);
 		if (!object) {
-			return (NULL);
+			return_PTR(NULL);
 		}
 	}
 
-	return (object);
+	return_PTR(object);
 }
 #endif				/* ACPI_USE_LOCAL_CACHE */
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 03ae8af..d971c86 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -194,9 +194,9 @@ acpi_debug_print(u32 requested_debug_level,
 	 */
 	acpi_os_printf("%9s-%04ld ", module_name, line_number);
 
-#ifdef ACPI_EXEC_APP
+#ifdef ACPI_APPLICATION
 	/*
-	 * For acpi_exec only, emit the thread ID and nesting level.
+	 * For acpi_exec/iASL only, emit the thread ID and nesting level.
 	 * Note: nesting level is really only useful during a single-thread
 	 * execution. Otherwise, multiple threads will keep resetting the
 	 * level.
-- 
1.7.10

