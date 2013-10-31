From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/15] ACPICA: Fix an ACPI_ALLOCATE_ZEROED() reversal.
Date: Thu, 31 Oct 2013 09:30:42 +0800
Message-ID: <60b93e0e71bc419e12ce6bd11cca90ee4d56340d.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25672 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3JaBbQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:31:16 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch decreases 9 lines of divergences as this enhancement is already
in the ACPICA upstream.

This patch cleans up the code as ACPI_FREE() should be the reversal of
ACPI_ALLOCATE_ZEROED().

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utobject.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index cddb0ef..d2a7b61 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -180,7 +180,7 @@ union acpi_operand_object *acpi_ut_create_package_object(u32 count)
 	package_elements = ACPI_ALLOCATE_ZEROED(((acpi_size) count +
 						 1) * sizeof(void *));
 	if (!package_elements) {
-		acpi_ut_remove_reference(package_desc);
+		ACPI_FREE(package_desc);
 		return_PTR(NULL);
 	}
 
-- 
1.7.10

