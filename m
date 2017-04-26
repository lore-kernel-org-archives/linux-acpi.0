From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/15] ACPICA: Local cache support: Allow small cache objects
Date: Wed, 26 Apr 2017 16:19:10 +0800
Message-ID: <254a32350d2fe8a574a05a9df7d98f08aab60cdc.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:37757 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1953109AbdDZITR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:19:17 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 9c54b8bbd483421ef2fef5225c00f1655b4a491c

Remove apparently arbitrary restriction on the size of the cache
objects to 16 (in acpi_os_create_cache). Now, the input object
size must be simply non-zero.

Link: https://github.com/acpica/acpica/commit/9c54b8bb
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index 11c7f72..5314933 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -71,7 +71,7 @@ acpi_os_create_cache(char *cache_name,
 
 	ACPI_FUNCTION_ENTRY();
 
-	if (!cache_name || !return_cache || (object_size < 16)) {
+	if (!cache_name || !return_cache || !object_size) {
 		return (AE_BAD_PARAMETER);
 	}
 
-- 
2.7.4

