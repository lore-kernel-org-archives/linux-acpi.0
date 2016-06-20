From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] ACPICA: Use acpi_os_allocate_zeroed
Date: Mon, 20 Jun 2016 11:22:35 +0530
Message-ID: <20160620055234.GA3104@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: linux-acpi@vger.kernel.org

acpi_os_allocate_zeroed combines acpi_os_allocate and memset 0.

The Coccinelle semantic patch used to make this change is as follows:
@@
type T;
T *d;
expression e;
statement S;
@@

        d =
-            acpi_os_allocate
+            acpi_os_allocate_zeroed
             (...);
        if (!d) S
-       memset(d, 0, sizeof(T));

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/acpi/acpica/utcache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index f8e9978..862f963 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -77,14 +77,13 @@ acpi_os_create_cache(char *cache_name,
 
 	/* Create the cache object */
 
-	cache = acpi_os_allocate(sizeof(struct acpi_memory_list));
+	cache = acpi_os_allocate_zeroed(sizeof(struct acpi_memory_list));
 	if (!cache) {
 		return (AE_NO_MEMORY);
 	}
 
 	/* Populate the cache object and return it */
 
-	memset(cache, 0, sizeof(struct acpi_memory_list));
 	cache->list_name = cache_name;
 	cache->object_size = object_size;
 	cache->max_depth = max_depth;
-- 
1.9.1
