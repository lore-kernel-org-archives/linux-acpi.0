From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/30] ACPICA: ACPI 6.1: Add full support for this version of ACPI spec
Date: Thu, 24 Mar 2016 09:39:36 +0800
Message-ID: <ed8ee8a75763cfc2631f2ffe82476ef6335b947c.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 5f21bddaa2cec035ca80608803ce2f0858d4f387

Small changes:
1) A couple new predefined names
2) New _HID values
3) New subtable for HEST

Link: https://github.com/acpica/acpica/commit/5f21bdda
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    9 +++++++++
 drivers/acpi/acpica/utdecode.c |   30 +++++++++++++++++-------------
 include/acpi/actbl1.h          |    6 ++++--
 include/acpi/actypes.h         |    3 ++-
 4 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 5faeab4..4ca426b 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -523,6 +523,9 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (4 Int) */
 	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0),
 
+	{{"_FIT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},	/* ACPI 6.0 */
+
 	{{"_FIX", METHOD_0ARGS,
 	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Ints) */
 	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0, 0, 0, 0),
@@ -1053,6 +1056,12 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 	  METHOD_RETURNS(ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING |
 			 ACPI_RTYPE_BUFFER)}},
 
+	{{"_WPC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* ACPI 6.1 */
+
+	{{"_WPP", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* ACPI 6.1 */
+
 	PACKAGE_INFO(0, 0, 0, 0, 0, 0)	/* Table terminator */
 };
 #else
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index 6ba65b0..efd7988 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -446,7 +446,7 @@ const char *acpi_ut_get_mutex_name(u32 mutex_id)
 
 /* Names for Notify() values, used for debug output */
 
-static const char *acpi_gbl_generic_notify[ACPI_NOTIFY_MAX + 1] = {
+static const char *acpi_gbl_generic_notify[ACPI_GENERIC_NOTIFY_MAX + 1] = {
 	/* 00 */ "Bus Check",
 	/* 01 */ "Device Check",
 	/* 02 */ "Device Wake",
@@ -459,49 +459,53 @@ static const char *acpi_gbl_generic_notify[ACPI_NOTIFY_MAX + 1] = {
 	/* 09 */ "Device PLD Check",
 	/* 0A */ "Reserved",
 	/* 0B */ "System Locality Update",
-	/* 0C */ "Shutdown Request",
+					/* 0C */ "Shutdown Request",
+					/* Reserved in ACPI 6.0 */
 	/* 0D */ "System Resource Affinity Update"
 };
 
-static const char *acpi_gbl_device_notify[4] = {
+static const char *acpi_gbl_device_notify[5] = {
 	/* 80 */ "Status Change",
 	/* 81 */ "Information Change",
 	/* 82 */ "Device-Specific Change",
-	/* 83 */ "Device-Specific Change"
+	/* 83 */ "Device-Specific Change",
+	/* 84 */ "Reserved"
 };
 
-static const char *acpi_gbl_processor_notify[4] = {
+static const char *acpi_gbl_processor_notify[5] = {
 	/* 80 */ "Performance Capability Change",
 	/* 81 */ "C-State Change",
 	/* 82 */ "Throttling Capability Change",
-	/* 83 */ "Device-Specific Change"
+	/* 83 */ "Guaranteed Change",
+	/* 84 */ "Minimum Excursion"
 };
 
-static const char *acpi_gbl_thermal_notify[4] = {
+static const char *acpi_gbl_thermal_notify[5] = {
 	/* 80 */ "Thermal Status Change",
 	/* 81 */ "Thermal Trip Point Change",
 	/* 82 */ "Thermal Device List Change",
-	/* 83 */ "Thermal Relationship Change"
+	/* 83 */ "Thermal Relationship Change",
+	/* 84 */ "Reserved"
 };
 
 const char *acpi_ut_get_notify_name(u32 notify_value, acpi_object_type type)
 {
 
-	/* 00 - 0D are common to all object types */
+	/* 00 - 0D are "common to all object types" (from ACPI Spec) */
 
-	if (notify_value <= ACPI_NOTIFY_MAX) {
+	if (notify_value <= ACPI_GENERIC_NOTIFY_MAX) {
 		return (acpi_gbl_generic_notify[notify_value]);
 	}
 
-	/* 0D - 7F are reserved */
+	/* 0E - 7F are reserved */
 
 	if (notify_value <= ACPI_MAX_SYS_NOTIFY) {
 		return ("Reserved");
 	}
 
-	/* 80 - 83 are per-object-type */
+	/* 80 - 84 are per-object-type */
 
-	if (notify_value <= 0x83) {
+	if (notify_value <= ACPI_SPECIFIC_NOTIFY_MAX) {
 		switch (type) {
 		case ACPI_TYPE_ANY:
 		case ACPI_TYPE_DEVICE:
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 912dff9..796d6ba 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -236,7 +236,8 @@ enum acpi_einj_actions {
 	ACPI_EINJ_CHECK_BUSY_STATUS = 6,
 	ACPI_EINJ_GET_COMMAND_STATUS = 7,
 	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
-	ACPI_EINJ_ACTION_RESERVED = 9,	/* 9 and greater are reserved */
+	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
+	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved */
 	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
 };
 
@@ -348,7 +349,8 @@ enum acpi_erst_actions {
 	ACPI_ERST_GET_ERROR_RANGE = 13,
 	ACPI_ERST_GET_ERROR_LENGTH = 14,
 	ACPI_ERST_GET_ERROR_ATTRIBUTES = 15,
-	ACPI_ERST_ACTION_RESERVED = 16	/* 16 and greater are reserved */
+	ACPI_ERST_EXECUTE_TIMINGS = 16,
+	ACPI_ERST_ACTION_RESERVED = 17	/* 17 and greater are reserved */
 };
 
 /* Values for Instruction field above */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index db46546..140886e 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -630,7 +630,8 @@ typedef u64 acpi_integer;
 #define ACPI_NOTIFY_SHUTDOWN_REQUEST    (u8) 0x0C
 #define ACPI_NOTIFY_AFFINITY_UPDATE     (u8) 0x0D
 
-#define ACPI_NOTIFY_MAX                 0x0D
+#define ACPI_GENERIC_NOTIFY_MAX         0x0D
+#define ACPI_SPECIFIC_NOTIFY_MAX        0x84
 
 /*
  * Types associated with ACPI names and objects. The first group of
-- 
1.7.10
