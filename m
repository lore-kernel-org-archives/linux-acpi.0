From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 06/12] ACPICA: Create and deploy safe version of strncpy. No functional change
Date: Wed,  3 Jan 2018 15:06:25 -0800
Message-ID: <20180103230631.15939-7-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20180103230631.15939-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43377 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbeACXHm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:42 -0500
In-Reply-To: <20180103230631.15939-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 64ad9c69a1bd534a466e060a33c0bbf5fc9e189c

acpi_ut_safe_strncpy - copy and terminate string. Strncpy is not
guaranteed to terminate the copied string if the input is longer
than the length of the target.

Link: https://github.com/acpica/acpica/commit/64ad9c69
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/acutils.h   | 2 ++
 drivers/acpi/acpica/dbfileio.c  | 4 ++--
 drivers/acpi/acpica/psutils.c   | 8 +++++---
 drivers/acpi/acpica/utnonansi.c | 9 +++++++++
 drivers/acpi/acpica/uttrack.c   | 4 ++--
 5 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 8bb46d8623ca..3de96a1c2950 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -641,6 +641,8 @@ void acpi_ut_repair_name(char *name);
 #if defined (ACPI_DEBUGGER) || defined (ACPI_APPLICATION)
 u8 acpi_ut_safe_strcpy(char *dest, acpi_size dest_size, char *source);
 
+void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size);
+
 u8 acpi_ut_safe_strcat(char *dest, acpi_size dest_size, char *source);
 
 u8
diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
index 4d81ea291d93..cf9607945704 100644
--- a/drivers/acpi/acpica/dbfileio.c
+++ b/drivers/acpi/acpica/dbfileio.c
@@ -99,8 +99,8 @@ void acpi_db_open_debug_file(char *name)
 	}
 
 	acpi_os_printf("Debug output file %s opened\n", name);
-	strncpy(acpi_gbl_db_debug_filename, name,
-		sizeof(acpi_gbl_db_debug_filename));
+	acpi_ut_safe_strncpy(acpi_gbl_db_debug_filename, name,
+			     sizeof(acpi_gbl_db_debug_filename));
 	acpi_gbl_db_output_to_file = TRUE;
 }
 #endif
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index e15b636b1d4b..8bd7d01039cc 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -94,9 +94,11 @@ void acpi_ps_init_op(union acpi_parse_object *op, u16 opcode)
 	op->common.descriptor_type = ACPI_DESC_TYPE_PARSER;
 	op->common.aml_opcode = opcode;
 
-	ACPI_DISASM_ONLY_MEMBERS(strncpy(op->common.aml_op_name,
-					 (acpi_ps_get_opcode_info(opcode))->
-					 name, sizeof(op->common.aml_op_name)));
+	ACPI_DISASM_ONLY_MEMBERS(acpi_ut_safe_strncpy(op->common.aml_op_name,
+						      (acpi_ps_get_opcode_info
+						       (opcode))->name,
+						      sizeof(op->common.
+							     aml_op_name)));
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index 792664982ea3..779229395cde 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -199,4 +199,13 @@ acpi_ut_safe_strncat(char *dest,
 	strncat(dest, source, max_transfer_length);
 	return (FALSE);
 }
+
+void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
+{
+	/* Always terminate destination string */
+
+	strncpy(dest, source, dest_size);
+	dest[dest_size - 1] = 0;
+}
+
 #endif
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 28a302eb2015..633b4e2c669f 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -402,8 +402,8 @@ acpi_ut_track_allocation(struct acpi_debug_mem_block *allocation,
 	allocation->component = component;
 	allocation->line = line;
 
-	strncpy(allocation->module, module, ACPI_MAX_MODULE_NAME);
-	allocation->module[ACPI_MAX_MODULE_NAME - 1] = 0;
+	acpi_ut_safe_strncpy(allocation->module, (char *)module,
+			     ACPI_MAX_MODULE_NAME);
 
 	if (!element) {
 
-- 
2.14.3

