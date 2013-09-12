From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/14] ACPICA: Improve error message for "too many parent prefixes" condition.
Date: Thu, 12 Sep 2013 16:54:24 +0800
Message-ID: <e7e90557d0aac11427b610a18f35c32bfd103954.1377844863.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:36448 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab3ILIya (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Sep 2013 04:54:30 -0400
In-Reply-To: <cover.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Emit the full offending pathname in the error message.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsaccess.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index c5316e5..aff79c7 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -424,8 +424,9 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 					/* Current scope has no parent scope */
 
 					ACPI_ERROR((AE_INFO,
-						    "ACPI path has too many parent prefixes (^) "
-						    "- reached beyond root node"));
+						    "%s: Path has too many parent prefixes (^) "
+						    "- reached beyond root node",
+						    pathname));
 					return_ACPI_STATUS(AE_NOT_FOUND);
 				}
 			}
-- 
1.7.10

