From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/42] ACPICA: Debugger: reduce old external path format
Date: Tue, 29 Dec 2015 13:53:50 +0800
Message-ID: <2ae320d9603009ec756f3a6a45bdba6e0272b3b2.1451367388.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:31598 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530AbbL2Fxy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 00:53:54 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 75c0da9e796bdf9bdd46d75f028a3e1779903214

In the error logs and debugger outputs, use new external path format that
does not contain a trailing underscore.
This patch takes care of acpi_ns_get_external_pathname() invocations, chaning
them into acpi_ns_get_normalized_pathname(TRUE) where possible. Along with some
error log fixes, the following debugger commands are fixed: resources,
handlers, paths. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/75c0da9e
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbcmds.c    |    2 +-
 drivers/acpi/acpica/dbdisply.c  |    2 +-
 drivers/acpi/acpica/dbnames.c   |    2 +-
 drivers/acpi/acpica/dbtest.c    |    2 +-
 drivers/acpi/acpica/nsdump.c    |    2 +-
 drivers/acpi/acpica/nseval.c    |    2 +-
 drivers/acpi/acpica/nsinit.c    |    3 ++-
 drivers/acpi/acpica/nssearch.c  |    2 +-
 drivers/acpi/acpica/utaddress.c |    5 +++--
 9 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmds.c
index 30414b3..84ab1c2 100644
--- a/drivers/acpi/acpica/dbcmds.c
+++ b/drivers/acpi/acpica/dbcmds.c
@@ -798,7 +798,7 @@ acpi_db_device_resources(acpi_handle obj_handle,
 	acpi_status status;
 
 	node = ACPI_CAST_PTR(struct acpi_namespace_node, obj_handle);
-	parent_path = acpi_ns_get_external_pathname(node);
+	parent_path = acpi_ns_get_normalized_pathname(node, TRUE);
 	if (!parent_path) {
 		return (AE_NO_MEMORY);
 	}
diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index c42ce8a..3acc3a5 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -1091,7 +1091,7 @@ acpi_db_display_non_root_handlers(acpi_handle obj_handle,
 		return (AE_OK);
 	}
 
-	pathname = acpi_ns_get_external_pathname(node);
+	pathname = acpi_ns_get_normalized_pathname(node, TRUE);
 	if (!pathname) {
 		return (AE_OK);
 	}
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 04ff1eb..4f68dfc 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -438,7 +438,7 @@ acpi_db_walk_for_predefined_names(acpi_handle obj_handle,
 		return (AE_OK);
 	}
 
-	pathname = acpi_ns_get_external_pathname(node);
+	pathname = acpi_ns_get_normalized_pathname(node, TRUE);
 	if (!pathname) {
 		return (AE_OK);
 	}
diff --git a/drivers/acpi/acpica/dbtest.c b/drivers/acpi/acpica/dbtest.c
index 10ea8bf..68b4e8d 100644
--- a/drivers/acpi/acpica/dbtest.c
+++ b/drivers/acpi/acpica/dbtest.c
@@ -953,7 +953,7 @@ acpi_db_evaluate_one_predefined_name(acpi_handle obj_handle,
 		return (AE_OK);
 	}
 
-	pathname = acpi_ns_get_external_pathname(node);
+	pathname = acpi_ns_get_normalized_pathname(node, TRUE);
 	if (!pathname) {
 		return (AE_OK);
 	}
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 37aa5c4..e071956 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -717,7 +717,7 @@ acpi_ns_dump_one_object_path(acpi_handle obj_handle,
 		return (AE_OK);
 	}
 
-	pathname = acpi_ns_get_external_pathname(node);
+	pathname = acpi_ns_get_normalized_pathname(node, TRUE);
 
 	path_indent = 1;
 	if (level <= max_level) {
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 7eba578..15e0b2e 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -135,7 +135,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info)
 
 	/* Get the full pathname to the object, for use in warning messages */
 
-	info->full_pathname = acpi_ns_get_external_pathname(info->node);
+	info->full_pathname = acpi_ns_get_normalized_pathname(info->node, TRUE);
 	if (!info->full_pathname) {
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 656eacf..ac59929 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -582,7 +582,8 @@ acpi_ns_init_one_device(acpi_handle obj_handle,
 
 		/* Ignore error and move on to next device */
 
-		char *scope_name = acpi_ns_get_external_pathname(device_node);
+		char *scope_name =
+		    acpi_ns_get_normalized_pathname(device_node, TRUE);
 
 		ACPI_EXCEPTION((AE_INFO, status, "during %s._INI execution",
 				scope_name));
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index d739040..9cc3564d 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -105,7 +105,7 @@ acpi_ns_search_one_scope(u32 target_name,
 	if (ACPI_LV_NAMES & acpi_dbg_level) {
 		char *scope_name;
 
-		scope_name = acpi_ns_get_external_pathname(parent_node);
+		scope_name = acpi_ns_get_normalized_pathname(parent_node, TRUE);
 		if (scope_name) {
 			ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
 					  "Searching %s (%p) For [%4.4s] (%s)\n",
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index 911ea8e..38a29e2 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -239,8 +239,9 @@ acpi_ut_check_address_range(acpi_adr_space_type space_id,
 			overlap_count++;
 			if (warn) {	/* Optional warning message */
 				pathname =
-				    acpi_ns_get_external_pathname(range_info->
-								  region_node);
+				    acpi_ns_get_normalized_pathname(range_info->
+								    region_node,
+								    TRUE);
 
 				ACPI_WARNING((AE_INFO,
 					      "%s range 0x%8.8X%8.8X-0x%8.8X%8.8X conflicts with OpRegion 0x%8.8X%8.8X-0x%8.8X%8.8X (%s)",
-- 
1.7.10

