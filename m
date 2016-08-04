From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/30] ACPICA: Use os_allocate_zeroed
Date: Thu,  4 Aug 2016 16:43:32 +0800
Message-ID: <1eb939219ae1e5acdc3ac5ab8fb480879d9a8bc3.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12099 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754695AbcHDIqn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:46:43 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Amitoj Kaur Chawla <amitoj1606@gmail.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 2b896c59e53243c95600f2a3f7e1fd02c044cb37

Eliminates an unnecessary memset.
Change proposed by: Amitoj Kaur Chawla <amitoj1606@gmail.com>

Link: https://github.com/acpica/acpica/commit/2b896c59
Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/uttrack.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 0df07df..df31d71 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -95,13 +95,11 @@ acpi_ut_create_list(const char *list_name,
 {
 	struct acpi_memory_list *cache;
 
-	cache = acpi_os_allocate(sizeof(struct acpi_memory_list));
+	cache = acpi_os_allocate_zeroed(sizeof(struct acpi_memory_list));
 	if (!cache) {
 		return (AE_NO_MEMORY);
 	}
 
-	memset(cache, 0, sizeof(struct acpi_memory_list));
-
 	cache->list_name = list_name;
 	cache->object_size = object_size;
 
-- 
1.7.10

