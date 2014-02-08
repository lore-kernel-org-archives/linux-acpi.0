From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/10] ACPICA: Utilities: Load of local test tables is now optional.
Date: Sat,  8 Feb 2014 09:42:12 +0800
Message-ID: <1406fdff5f5148abd2fcd44924c8664d1e112157.1390438466.git.lv.zheng@intel.com>
References: <cover.1390438466.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26764 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbaBHBmS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Feb 2014 20:42:18 -0500
In-Reply-To: <cover.1390438466.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

This patch doesn't affect kernel behavior as Linux doesn't use ACPICA
allocation tracking implementation.

The utility has the capability to load some various tables to test
features of ACPICA. However, there are enough of them that the output
of the utility became confusing. With this change, only the required
local tables are displayed (RSDP, XSDT, etc.) along with the actual
tables loaded via the command line specification. This makes the
default output simler and easier to understand. The -el command line
option restores the original behavior for testing purposes.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/uttrack.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index c002777..4e36738 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -276,7 +276,8 @@ acpi_ut_free_and_track(void *allocation,
 	}
 
 	acpi_os_free(debug_block);
-	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "%p freed\n", allocation));
+	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "%p freed (block %p)\n",
+			  allocation, debug_block));
 	return_VOID;
 }
 
-- 
1.7.10

