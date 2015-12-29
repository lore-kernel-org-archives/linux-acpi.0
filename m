From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/42] ACPICA: Add "const" to some functions that return fixed strings
Date: Tue, 29 Dec 2015 13:54:04 +0800
Message-ID: <96ce27c48627d89d25015885c9b46edcc8a7c684.1451367388.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41345 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbbL2Fy2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 00:54:28 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>, Bob Moore <robert.moore@intel.com>

From: LABBE Corentin <clabbe.montjoie@gmail.com>

ACPICA commit 28645f8a113f346c8db103a4f7565fcba88c746f

Most of the "get_name" - style functions can return "const char *"
with no ill side-effects. Original linux patch from
LABBE Corentin <clabbe.montjoie@gmail.com> and backported to
ACPICA.

Link: https://github.com/acpica/acpica/commit/28645f8a
Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h  |   14 +++++++-------
 drivers/acpi/acpica/nsxfname.c |    2 +-
 drivers/acpi/acpica/utdecode.c |   29 +++++++++++++----------------
 drivers/acpi/acpica/uthex.c    |    2 +-
 4 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 8b8fef6..7495421 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -184,24 +184,24 @@ acpi_status acpi_ut_init_globals(void);
 
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
 
-char *acpi_ut_get_mutex_name(u32 mutex_id);
+const char *acpi_ut_get_mutex_name(u32 mutex_id);
 
 const char *acpi_ut_get_notify_name(u32 notify_value, acpi_object_type type);
 #endif
 
-char *acpi_ut_get_type_name(acpi_object_type type);
+const char *acpi_ut_get_type_name(acpi_object_type type);
 
-char *acpi_ut_get_node_name(void *object);
+const char *acpi_ut_get_node_name(void *object);
 
-char *acpi_ut_get_descriptor_name(void *object);
+const char *acpi_ut_get_descriptor_name(void *object);
 
 const char *acpi_ut_get_reference_name(union acpi_operand_object *object);
 
-char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc);
+const char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc);
 
-char *acpi_ut_get_region_name(u8 space_id);
+const char *acpi_ut_get_region_name(u8 space_id);
 
-char *acpi_ut_get_event_name(u32 event_id);
+const char *acpi_ut_get_event_name(u32 event_id);
 
 char acpi_ut_hex_to_ascii_char(u64 integer, u32 position);
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 4b4d2f4..138cf5e 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -159,7 +159,7 @@ acpi_get_name(acpi_handle handle, u32 name_type, struct acpi_buffer * buffer)
 {
 	acpi_status status;
 	struct acpi_namespace_node *node;
-	char *node_name;
+	const char *node_name;
 
 	/* Parameter validation */
 
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index ecaaaff..7e14400 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -114,7 +114,7 @@ const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS] = {
 	"PCC"			/* 0x0A */
 };
 
-char *acpi_ut_get_region_name(u8 space_id)
+const char *acpi_ut_get_region_name(u8 space_id)
 {
 
 	if (space_id >= ACPI_USER_REGION_BEGIN) {
@@ -127,7 +127,7 @@ char *acpi_ut_get_region_name(u8 space_id)
 		return ("InvalidSpaceId");
 	}
 
-	return (ACPI_CAST_PTR(char, acpi_gbl_region_types[space_id]));
+	return (acpi_gbl_region_types[space_id]);
 }
 
 /*******************************************************************************
@@ -152,14 +152,14 @@ static const char *acpi_gbl_event_types[ACPI_NUM_FIXED_EVENTS] = {
 	"RealTimeClock",
 };
 
-char *acpi_ut_get_event_name(u32 event_id)
+const char *acpi_ut_get_event_name(u32 event_id)
 {
 
 	if (event_id > ACPI_EVENT_MAX) {
 		return ("InvalidEventID");
 	}
 
-	return (ACPI_CAST_PTR(char, acpi_gbl_event_types[event_id]));
+	return (acpi_gbl_event_types[event_id]);
 }
 
 /*******************************************************************************
@@ -220,17 +220,17 @@ static const char *acpi_gbl_ns_type_names[] = {
 	/* 30 */ "Invalid"
 };
 
-char *acpi_ut_get_type_name(acpi_object_type type)
+const char *acpi_ut_get_type_name(acpi_object_type type)
 {
 
 	if (type > ACPI_TYPE_INVALID) {
-		return (ACPI_CAST_PTR(char, acpi_gbl_bad_type));
+		return (acpi_gbl_bad_type);
 	}
 
-	return (ACPI_CAST_PTR(char, acpi_gbl_ns_type_names[type]));
+	return (acpi_gbl_ns_type_names[type]);
 }
 
-char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc)
+const char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc)
 {
 	ACPI_FUNCTION_TRACE(ut_get_object_type_name);
 
@@ -267,7 +267,7 @@ char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc)
  *
  ******************************************************************************/
 
-char *acpi_ut_get_node_name(void *object)
+const char *acpi_ut_get_node_name(void *object)
 {
 	struct acpi_namespace_node *node = (struct acpi_namespace_node *)object;
 
@@ -333,7 +333,7 @@ static const char *acpi_gbl_desc_type_names[] = {
 	/* 15 */ "Node"
 };
 
-char *acpi_ut_get_descriptor_name(void *object)
+const char *acpi_ut_get_descriptor_name(void *object)
 {
 
 	if (!object) {
@@ -344,10 +344,7 @@ char *acpi_ut_get_descriptor_name(void *object)
 		return ("Not a Descriptor");
 	}
 
-	return (ACPI_CAST_PTR(char,
-			      acpi_gbl_desc_type_names[ACPI_GET_DESCRIPTOR_TYPE
-						       (object)]));
-
+	return (acpi_gbl_desc_type_names[ACPI_GET_DESCRIPTOR_TYPE(object)]);
 }
 
 /*******************************************************************************
@@ -415,7 +412,7 @@ const char *acpi_ut_get_reference_name(union acpi_operand_object *object)
 
 /* Names for internal mutex objects, used for debug output */
 
-static char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
+static const char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
 	"ACPI_MTX_Interpreter",
 	"ACPI_MTX_Namespace",
 	"ACPI_MTX_Tables",
@@ -424,7 +421,7 @@ static char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
 	"ACPI_MTX_Memory",
 };
 
-char *acpi_ut_get_mutex_name(u32 mutex_id)
+const char *acpi_ut_get_mutex_name(u32 mutex_id)
 {
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index fda8b3d..8ad086e 100644
--- a/drivers/acpi/acpica/uthex.c
+++ b/drivers/acpi/acpica/uthex.c
@@ -48,7 +48,7 @@
 ACPI_MODULE_NAME("uthex")
 
 /* Hex to ASCII conversion table */
-static char acpi_gbl_hex_to_ascii[] = {
+static const char acpi_gbl_hex_to_ascii[] = {
 	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D',
 	    'E', 'F'
 };
-- 
1.7.10

