From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/27] ACPICA: Deploy new ACPI_IS_DEBUG_ENABLED macro in debug output code.
Date: Mon, 31 Dec 2012 08:06:27 +0800
Message-ID: <7f5e3bf5ade46eeecf4fa68b2317fc70f3f5bab3.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53599 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAGh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:06:37 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Simplifies check for debug output enables.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exdump.c |   19 ++++++++++---------
 drivers/acpi/acpica/nsdump.c |    7 ++++---
 drivers/acpi/acpica/rsdump.c |   10 ++++++----
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 858b43a..8698bff 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -464,9 +464,8 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 	ACPI_FUNCTION_NAME(ex_dump_operand)
 
-	    if (!
-		((ACPI_LV_EXEC & acpi_dbg_level)
-		  && (_COMPONENT & acpi_dbg_layer))) {
+	    /* Check if debug output enabled */
+	    if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
 		return;
 	}
 
@@ -811,9 +810,10 @@ void acpi_ex_dump_namespace_node(struct acpi_namespace_node *node, u32 flags)
 	ACPI_FUNCTION_ENTRY();
 
 	if (!flags) {
-		if (!
-		    ((ACPI_LV_OBJECTS & acpi_dbg_level)
-		      && (_COMPONENT & acpi_dbg_layer))) {
+
+		/* Check if debug output enabled */
+
+		if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_OBJECTS, _COMPONENT)) {
 			return;
 		}
 	}
@@ -999,9 +999,10 @@ acpi_ex_dump_object_descriptor(union acpi_operand_object *obj_desc, u32 flags)
 	}
 
 	if (!flags) {
-		if (!
-		    ((ACPI_LV_OBJECTS & acpi_dbg_level)
-		      && (_COMPONENT & acpi_dbg_layer))) {
+
+		/* Check if debug output enabled */
+
+		if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_OBJECTS, _COMPONENT)) {
 			return_VOID;
 		}
 	}
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 8e6f0037..3e04879 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -77,8 +77,9 @@ void acpi_ns_print_pathname(u32 num_segments, char *pathname)
 
 	ACPI_FUNCTION_NAME(ns_print_pathname);
 
-	if (!(acpi_dbg_level & ACPI_LV_NAMES)
-	    || !(acpi_dbg_layer & ACPI_NAMESPACE)) {
+	/* Check if debug output enabled */
+
+	if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_NAMES, ACPI_NAMESPACE)) {
 		return;
 	}
 
@@ -127,7 +128,7 @@ acpi_ns_dump_pathname(acpi_handle handle, char *msg, u32 level, u32 component)
 
 	/* Do this only if the requested debug level and component are enabled */
 
-	if (!(acpi_dbg_level & level) || !(acpi_dbg_layer & component)) {
+	if (!ACPI_IS_DEBUG_ENABLED(level, component)) {
 		return_VOID;
 	}
 
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 0b7381f..203b4ae 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -766,8 +766,9 @@ void acpi_rs_dump_resource_list(struct acpi_resource *resource_list)
 
 	ACPI_FUNCTION_ENTRY();
 
-	if (!(acpi_dbg_level & ACPI_LV_RESOURCES)
-	    || !(_COMPONENT & acpi_dbg_layer)) {
+	/* Check if debug output enabled */
+
+	if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_RESOURCES, _COMPONENT)) {
 		return;
 	}
 
@@ -828,8 +829,9 @@ void acpi_rs_dump_irq_list(u8 * route_table)
 
 	ACPI_FUNCTION_ENTRY();
 
-	if (!(acpi_dbg_level & ACPI_LV_RESOURCES)
-	    || !(_COMPONENT & acpi_dbg_layer)) {
+	/* Check if debug output enabled */
+
+	if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_RESOURCES, _COMPONENT)) {
 		return;
 	}
 
-- 
1.7.10

