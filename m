From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/14] ACPICA: Validate start object for acpi_walk_namespace.
Date: Thu, 12 Sep 2013 16:55:01 +0800
Message-ID: <557903201460512616d36b45c10d989f7196a690.1377844863.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37557 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742Ab3ILIzF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Sep 2013 04:55:05 -0400
In-Reply-To: <cover.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Perform a sanity check on the start object to prevent problems
later. ACPICA BZ 1025.

Buglink: http://bugs.acpica.org/show_bug.cgi?id=1025
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsxfeval.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index b38b4b0..481a6b4 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -605,11 +605,19 @@ acpi_walk_namespace(acpi_object_type type,
 		goto unlock_and_exit;
 	}
 
+	/* Now we can validate the starting node */
+
+	if (!acpi_ns_validate_handle(start_object)) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit2;
+	}
+
 	status = acpi_ns_walk_namespace(type, start_object, max_depth,
 					ACPI_NS_WALK_UNLOCK,
 					descending_callback, ascending_callback,
 					context, return_value);
 
+      unlock_and_exit2:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
       unlock_and_exit:
-- 
1.7.10

