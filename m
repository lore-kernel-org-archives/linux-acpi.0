From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/15] ACPICA: Fix cached object deletion code.
Date: Thu, 31 Oct 2013 09:31:00 +0800
Message-ID: <bdf6ffc2b1ae764d868a76340e01e1fd7aa41ed0.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26396 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3JaBbf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:31:35 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch decreases 16 lines of divergences.

The function acpi_ut_delete_caches() is meant to be used to implement
ACPI_ALLOCATE()/ACPI_FREE() mechanisms in ACPICA, thus it should call
acpi_os_free() rather than ACPI_FREE().  Linux is not affected by this
issue as Linux is using kmem_cache instead of the ACPICA local cache.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utalloc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utalloc.c b/drivers/acpi/acpica/utalloc.c
index d844796..814267f 100644
--- a/drivers/acpi/acpica/utalloc.c
+++ b/drivers/acpi/acpica/utalloc.c
@@ -209,10 +209,10 @@ acpi_status acpi_ut_delete_caches(void)
 
 	/* Free memory lists */
 
-	ACPI_FREE(acpi_gbl_global_list);
+	acpi_os_free(acpi_gbl_global_list);
 	acpi_gbl_global_list = NULL;
 
-	ACPI_FREE(acpi_gbl_ns_node_list);
+	acpi_os_free(acpi_gbl_ns_node_list);
 	acpi_gbl_ns_node_list = NULL;
 #endif
 
-- 
1.7.10

