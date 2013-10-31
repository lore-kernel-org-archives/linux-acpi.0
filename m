From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/15] ACPICA: Cleanup useless memset invocations.
Date: Thu, 31 Oct 2013 09:30:48 +0800
Message-ID: <a05540c4178cf34d138d17c60a29eb7f1c983fca.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40467 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3JaBbW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:31:22 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch decreases 22 lines of divergences.

This patch cleans up some memset() invocations where kmem_cache_zalloc()
is just invoked.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utobject.c |    1 -
 drivers/acpi/acpica/utstate.c  |    1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index d2a7b61..13e0450 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -396,7 +396,6 @@ void *acpi_ut_allocate_object_desc_dbg(const char *module_name,
 
 	/* Mark the descriptor type */
 
-	memset(object, 0, sizeof(union acpi_operand_object));
 	ACPI_SET_DESCRIPTOR_TYPE(object, ACPI_DESC_TYPE_OPERAND);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "%p Size %X\n",
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index a6b729d..03c4c2f 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -161,7 +161,6 @@ union acpi_generic_state *acpi_ut_create_generic_state(void)
 	if (state) {
 
 		/* Initialize */
-		memset(state, 0, sizeof(union acpi_generic_state));
 		state->common.descriptor_type = ACPI_DESC_TYPE_STATE;
 	}
 
-- 
1.7.10

