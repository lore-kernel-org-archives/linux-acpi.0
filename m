From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH] acpi: set return value to const char for some functions
Date: Wed, 14 Oct 2015 21:07:15 +0200
Message-ID: <1444849635-14456-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This patch set some array of const char as const.
In the same time, some function return pointer to thoses array without
properly giving the information that the data is const.
This patch set the return type of thoses functions as const char *

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/acpi/acpica/acutils.h  | 12 ++++++------
 drivers/acpi/acpica/utdecode.c | 24 ++++++++++++------------
 drivers/acpi/acpica/uthex.c    |  4 ++--
 drivers/acpi/tables.c          |  6 ++++--
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index fb2aa50..e5d9d4f 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -189,21 +189,21 @@ char *acpi_ut_get_mutex_name(u32 mutex_id);
 const char *acpi_ut_get_notify_name(u32 notify_value, acpi_object_type type);
 #endif
 
-char *acpi_ut_get_type_name(acpi_object_type type);
+const char *acpi_ut_get_type_name(acpi_object_type type);
 
 char *acpi_ut_get_node_name(void *object);
 
-char *acpi_ut_get_descriptor_name(void *object);
+const char *acpi_ut_get_descriptor_name(void *object);
 
 const char *acpi_ut_get_reference_name(union acpi_operand_object *object);
 
-char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc);
+const char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc);
 
-char *acpi_ut_get_region_name(u8 space_id);
+const char *acpi_ut_get_region_name(u8 space_id);
 
-char *acpi_ut_get_event_name(u32 event_id);
+const char *acpi_ut_get_event_name(u32 event_id);
 
-char acpi_ut_hex_to_ascii_char(u64 integer, u32 position);
+const char acpi_ut_hex_to_ascii_char(u64 integer, u32 position);
 
 u8 acpi_ut_ascii_char_to_hex(int hex_char);
 
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 988e23b..e08cdb1 100644
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
+	return (ACPI_CAST_PTR(const char, acpi_gbl_region_types[space_id]));
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
+	return (ACPI_CAST_PTR(const char, acpi_gbl_event_types[event_id]));
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
+		return (ACPI_CAST_PTR(const char, acpi_gbl_bad_type));
 	}
 
-	return (ACPI_CAST_PTR(char, acpi_gbl_ns_type_names[type]));
+	return (ACPI_CAST_PTR(const char, acpi_gbl_ns_type_names[type]));
 }
 
-char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc)
+const char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc)
 {
 
 	if (!obj_desc) {
@@ -318,7 +318,7 @@ static const char *acpi_gbl_desc_type_names[] = {
 	/* 15 */ "Node"
 };
 
-char *acpi_ut_get_descriptor_name(void *object)
+const char *acpi_ut_get_descriptor_name(void *object)
 {
 
 	if (!object) {
@@ -329,7 +329,7 @@ char *acpi_ut_get_descriptor_name(void *object)
 		return ("Not a Descriptor");
 	}
 
-	return (ACPI_CAST_PTR(char,
+	return (ACPI_CAST_PTR(const char,
 			      acpi_gbl_desc_type_names[ACPI_GET_DESCRIPTOR_TYPE
 						       (object)]));
 
@@ -400,7 +400,7 @@ const char *acpi_ut_get_reference_name(union acpi_operand_object *object)
 
 /* Names for internal mutex objects, used for debug output */
 
-static char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
+static const char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
 	"ACPI_MTX_Interpreter",
 	"ACPI_MTX_Namespace",
 	"ACPI_MTX_Tables",
@@ -411,7 +411,7 @@ static char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
 	"ACPI_MTX_CommandReady"
 };
 
-char *acpi_ut_get_mutex_name(u32 mutex_id)
+const char *acpi_ut_get_mutex_name(u32 mutex_id)
 {
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
diff --git a/drivers/acpi/acpica/uthex.c b/drivers/acpi/acpica/uthex.c
index fda8b3d..9239711 100644
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
@@ -67,7 +67,7 @@ static char acpi_gbl_hex_to_ascii[] = {
  *
  ******************************************************************************/
 
-char acpi_ut_hex_to_ascii_char(u64 integer, u32 position)
+const char acpi_ut_hex_to_ascii_char(u64 integer, u32 position)
 {
 
 	return (acpi_gbl_hex_to_ascii[(integer >> position) & 0xF]);
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 17a6fa0..7c8a037 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -35,8 +35,10 @@
 
 #define ACPI_MAX_TABLES		128
 
-static char *mps_inti_flags_polarity[] = { "dfl", "high", "res", "low" };
-static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
+static const char * const mps_inti_flags_polarity[] = {
+	"dfl", "high", "res", "low" };
+static const char * const mps_inti_flags_trigger[] = {
+	"dfl", "edge", "res", "level" };
 
 static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
-- 
2.4.9
