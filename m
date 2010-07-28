From: Lin Ming <ming.m.lin@intel.com>
Subject: [RFC][PATCH 1/4] ACPICA: New file utosi.c
Date: Wed, 28 Jul 2010 14:27:56 +0800
Message-ID: <1280298476.20797.68.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4764 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab0G1G1r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jul 2010 02:27:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Move all the _OSI handling code to a new file utosi.c.
No functional change.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/Makefile |    2 +-
 drivers/acpi/acpica/uteval.c |  147 -------------------------------
 drivers/acpi/acpica/utosi.c  |  196 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 148 deletions(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index d93cc06..287199b 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -44,4 +44,4 @@ acpi-y += tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
 
 acpi-y += utalloc.o utdebug.o uteval.o utinit.o utmisc.o utxface.o \
 		utcopy.o utdelete.o utglobal.o utmath.o utobject.o \
-		utstate.o utmutex.o utobject.o utresrc.o utlock.o utids.o
+		utstate.o utmutex.o utobject.o utresrc.o utlock.o utids.o utosi.o
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 6dfdeb6..22f59ef 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -48,153 +48,6 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("uteval")
 
-/*
- * Strings supported by the _OSI predefined (internal) method.
- *
- * March 2009: Removed "Linux" as this host no longer wants to respond true
- * for this string. Basically, the only safe OS strings are windows-related
- * and in many or most cases represent the only test path within the
- * BIOS-provided ASL code.
- *
- * The second element of each entry is used to track the newest version of
- * Windows that the BIOS has requested.
- */
-static struct acpi_interface_info acpi_interfaces_supported[] = {
-	/* Operating System Vendor Strings */
-
-	{"Windows 2000", ACPI_OSI_WIN_2000},	/* Windows 2000 */
-	{"Windows 2001", ACPI_OSI_WIN_XP},	/* Windows XP */
-	{"Windows 2001 SP1", ACPI_OSI_WIN_XP_SP1},	/* Windows XP SP1 */
-	{"Windows 2001.1", ACPI_OSI_WINSRV_2003},	/* Windows Server 2003 */
-	{"Windows 2001 SP2", ACPI_OSI_WIN_XP_SP2},	/* Windows XP SP2 */
-	{"Windows 2001.1 SP1", ACPI_OSI_WINSRV_2003_SP1},	/* Windows Server 2003 SP1 - Added 03/2006 */
-	{"Windows 2006", ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
-	{"Windows 2006.1", ACPI_OSI_WINSRV_2008},	/* Windows Server 2008 - Added 09/2009 */
-	{"Windows 2006 SP1", ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
-	{"Windows 2009", ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
-
-	/* Feature Group Strings */
-
-	{"Extended Address Space Descriptor", 0}
-
-	/*
-	 * All "optional" feature group strings (features that are implemented
-	 * by the host) should be implemented in the host version of
-	 * acpi_os_validate_interface and should not be added here.
-	 */
-};
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_osi_implementation
- *
- * PARAMETERS:  walk_state          - Current walk state
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Implementation of the _OSI predefined control method
- *
- ******************************************************************************/
-
-acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
-{
-	acpi_status status;
-	union acpi_operand_object *string_desc;
-	union acpi_operand_object *return_desc;
-	u32 return_value;
-	u32 i;
-
-	ACPI_FUNCTION_TRACE(ut_osi_implementation);
-
-	/* Validate the string input argument */
-
-	string_desc = walk_state->arguments[0].object;
-	if (!string_desc || (string_desc->common.type != ACPI_TYPE_STRING)) {
-		return_ACPI_STATUS(AE_TYPE);
-	}
-
-	/* Create a return object */
-
-	return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
-	if (!return_desc) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	/* Default return value is 0, NOT SUPPORTED */
-
-	return_value = 0;
-
-	/* Compare input string to static table of supported interfaces */
-
-	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
-		if (!ACPI_STRCMP(string_desc->string.pointer,
-				 acpi_interfaces_supported[i].name)) {
-			/*
-			 * The interface is supported.
-			 * Update the osi_data if necessary. We keep track of the latest
-			 * version of Windows that has been requested by the BIOS.
-			 */
-			if (acpi_interfaces_supported[i].value >
-			    acpi_gbl_osi_data) {
-				acpi_gbl_osi_data =
-				    acpi_interfaces_supported[i].value;
-			}
-
-			return_value = ACPI_UINT32_MAX;
-			goto exit;
-		}
-	}
-
-	/*
-	 * Did not match the string in the static table, call the host OSL to
-	 * check for a match with one of the optional strings (such as
-	 * "Module Device", "3.0 Thermal Model", etc.)
-	 */
-	status = acpi_os_validate_interface(string_desc->string.pointer);
-	if (ACPI_SUCCESS(status)) {
-
-		/* The interface is supported */
-
-		return_value = ACPI_UINT32_MAX;
-	}
-
-exit:
-	ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INFO,
-		"ACPI: BIOS _OSI(%s) is %ssupported\n",
-		string_desc->string.pointer, return_value == 0 ? "not " : ""));
-
-	/* Complete the return value */
-
-	return_desc->integer.value = return_value;
-	walk_state->return_desc = return_desc;
-	return_ACPI_STATUS (AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_osi_invalidate
- *
- * PARAMETERS:  interface_string
- *
- * RETURN:      Status
- *
- * DESCRIPTION: invalidate string in pre-defiend _OSI string list
- *
- ******************************************************************************/
-
-acpi_status acpi_osi_invalidate(char *interface)
-{
-	int i;
-
-	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
-		if (!ACPI_STRCMP(interface, acpi_interfaces_supported[i].name)) {
-			*acpi_interfaces_supported[i].name = '\0';
-			return AE_OK;
-		}
-	}
-	return AE_NOT_FOUND;
-}
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_evaluate_object
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
new file mode 100644
index 0000000..b156241
--- /dev/null
+++ b/drivers/acpi/acpica/utosi.c
@@ -0,0 +1,196 @@
+/******************************************************************************
+ *
+ * Module Name: utosi - Support for _OSI predefined control method
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2010, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <linux/acpi.h>
+#include "accommon.h"
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("utosi")
+
+/*
+ * Strings supported by the _OSI predefined (internal) method.
+ *
+ * March 2009: Removed "Linux" as this host no longer wants to respond true
+ * for this string. Basically, the only safe OS strings are windows-related
+ * and in many or most cases represent the only test path within the
+ * BIOS-provided ASL code.
+ *
+ * The second element of each entry is used to track the newest version of
+ * Windows that the BIOS has requested.
+ */
+static struct acpi_interface_info acpi_interfaces_supported[] = {
+	/* Operating System Vendor Strings */
+
+	{"Windows 2000", ACPI_OSI_WIN_2000},	/* Windows 2000 */
+	{"Windows 2001", ACPI_OSI_WIN_XP},	/* Windows XP */
+	{"Windows 2001 SP1", ACPI_OSI_WIN_XP_SP1},	/* Windows XP SP1 */
+	{"Windows 2001.1", ACPI_OSI_WINSRV_2003},	/* Windows Server 2003 */
+	{"Windows 2001 SP2", ACPI_OSI_WIN_XP_SP2},	/* Windows XP SP2 */
+	{"Windows 2001.1 SP1", ACPI_OSI_WINSRV_2003_SP1},	/* Windows Server 2003 SP1 - Added 03/2006 */
+	{"Windows 2006", ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
+	{"Windows 2006.1", ACPI_OSI_WINSRV_2008},	/* Windows Server 2008 - Added 09/2009 */
+	{"Windows 2006 SP1", ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
+	{"Windows 2009", ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
+
+	/* Feature Group Strings */
+
+	{"Extended Address Space Descriptor", 0}
+
+	/*
+	 * All "optional" feature group strings (features that are implemented
+	 * by the host) should be implemented in the host version of
+	 * acpi_os_validate_interface and should not be added here.
+	 */
+};
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_osi_implementation
+ *
+ * PARAMETERS:  walk_state          - Current walk state
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Implementation of the _OSI predefined control method
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
+{
+	acpi_status status;
+	union acpi_operand_object *string_desc;
+	union acpi_operand_object *return_desc;
+	u32 return_value;
+	u32 i;
+
+	ACPI_FUNCTION_TRACE(ut_osi_implementation);
+
+	/* Validate the string input argument */
+
+	string_desc = walk_state->arguments[0].object;
+	if (!string_desc || (string_desc->common.type != ACPI_TYPE_STRING)) {
+		return_ACPI_STATUS(AE_TYPE);
+	}
+
+	/* Create a return object */
+
+	return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+	if (!return_desc) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	/* Default return value is 0, NOT SUPPORTED */
+
+	return_value = 0;
+
+	/* Compare input string to static table of supported interfaces */
+
+	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
+		if (!ACPI_STRCMP(string_desc->string.pointer,
+				 acpi_interfaces_supported[i].name)) {
+			/*
+			 * The interface is supported.
+			 * Update the osi_data if necessary. We keep track of the latest
+			 * version of Windows that has been requested by the BIOS.
+			 */
+			if (acpi_interfaces_supported[i].value >
+			    acpi_gbl_osi_data) {
+				acpi_gbl_osi_data =
+				    acpi_interfaces_supported[i].value;
+			}
+
+			return_value = ACPI_UINT32_MAX;
+			goto exit;
+		}
+	}
+
+	/*
+	 * Did not match the string in the static table, call the host OSL to
+	 * check for a match with one of the optional strings (such as
+	 * "Module Device", "3.0 Thermal Model", etc.)
+	 */
+	status = acpi_os_validate_interface(string_desc->string.pointer);
+	if (ACPI_SUCCESS(status)) {
+
+		/* The interface is supported */
+
+		return_value = ACPI_UINT32_MAX;
+	}
+
+exit:
+	ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INFO,
+		"ACPI: BIOS _OSI(%s) is %ssupported\n",
+		string_desc->string.pointer, return_value == 0 ? "not " : ""));
+
+	/* Complete the return value */
+
+	return_desc->integer.value = return_value;
+	walk_state->return_desc = return_desc;
+	return_ACPI_STATUS (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_osi_invalidate
+ *
+ * PARAMETERS:  interface_string
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: invalidate string in pre-defiend _OSI string list
+ *
+ ******************************************************************************/
+
+acpi_status acpi_osi_invalidate(char *interface)
+{
+	int i;
+
+	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
+		if (!ACPI_STRCMP(interface, acpi_interfaces_supported[i].name)) {
+			*acpi_interfaces_supported[i].name = '\0';
+			return AE_OK;
+		}
+	}
+	return AE_NOT_FOUND;
+}
+




