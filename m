From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/7] ACPICA: Remove some extraneous newlines in ACPI_ERROR type calls
Date: Fri, 25 Jan 2013 13:41:16 +0800
Message-ID: <26a72bd677c5c85f2511e90e619e903bd7cf8c98.1358825277.git.lv.zheng@intel.com>
References: <cover.1358825277.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21011 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab3AYFlb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2013 00:41:31 -0500
In-Reply-To: <cover.1358825277.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

These macros/functions automatically insert a newline, so the
format string should not contain a newline at the end. (This allows
these functions to add information to the end of the output line.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsobject.c |    2 +-
 drivers/acpi/acpica/dswload2.c |    2 +-
 drivers/acpi/acpica/hwgpe.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 2e6288d..e20e9f8 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -525,7 +525,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		}
 
 		ACPI_INFO((AE_INFO,
-			   "Actual Package length (%u) is larger than NumElements field (%u), truncated\n",
+			   "Actual Package length (%u) is larger than NumElements field (%u), truncated",
 			   i, element_count));
 	} else if (i < element_count) {
 		/*
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 620a023..4407ff2 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -222,7 +222,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 			 */
 			ACPI_WARNING((AE_INFO,
 				      "Type override - [%4.4s] had invalid type (%s) "
-				      "for Scope operator, changed to type ANY\n",
+				      "for Scope operator, changed to type ANY",
 				      acpi_ut_get_node_name(node),
 				      acpi_ut_get_type_name(node->type)));
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index d84fd83..20d02e9 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -135,7 +135,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 		break;
 
 	default:
-		ACPI_ERROR((AE_INFO, "Invalid GPE Action, %u\n", action));
+		ACPI_ERROR((AE_INFO, "Invalid GPE Action, %u", action));
 		return (AE_BAD_PARAMETER);
 	}
 
-- 
1.7.10

