From: Lin Ming <ming.m.lin@intel.com>
Subject: [RFC][PATCH 3/4] ACPICA: _OSI implementation uses the new
 interfaces
Date: Wed, 28 Jul 2010 14:28:21 +0800
Message-ID: <1280298501.20797.70.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59581 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab0G1G2L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jul 2010 02:28:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

acpi_ut_osi_implementation is the implementation of the _OSI predefined
control method. When an invocation of _OSI is encountered in the system
AML, control is transferred to this function.

Change acpi_ut_osi_implementation to use the new OSI interfaces. 

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utosi.c |   59 +++++++++++++++++++------------------------
 1 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index af09f71..85bdcd7 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -298,11 +298,11 @@ struct acpi_interface_info *acpi_ut_get_interface(acpi_string interface_name)
 
 acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 {
-	acpi_status status;
 	union acpi_operand_object *string_desc;
 	union acpi_operand_object *return_desc;
+	struct acpi_interface_info *interface_info;
 	u32 return_value;
-	u32 i;
+	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_TRACE(ut_osi_implementation);
 
@@ -323,51 +323,44 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 	/* Default return value is 0, NOT SUPPORTED */
 
 	return_value = 0;
+	flags = acpi_os_acquire_lock(acpi_gbl_osi_lock);
 
-	/* Compare input string to static table of supported interfaces */
-
-	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_default_supported_interfaces); i++) {
-		if (!ACPI_STRCMP(string_desc->string.pointer,
-				 acpi_default_supported_interfaces[i].name)) {
-			/*
-			 * The interface is supported.
-			 * Update the osi_data if necessary. We keep track of the latest
-			 * version of Windows that has been requested by the BIOS.
-			 */
-			if (acpi_default_supported_interfaces[i].value >
-			    acpi_gbl_osi_data) {
-				acpi_gbl_osi_data =
-				    acpi_default_supported_interfaces[i].value;
-			}
+	/*
+	 * Call the OSI interface handler first, host OS may do specific handling
+	 * For example, print some warnings or even remove the interface
+	 */
 
-			return_value = ACPI_UINT32_MAX;
-			goto exit;
-		}
+	if (acpi_gbl_interface_handler) {
+		acpi_gbl_interface_handler(string_desc->string.pointer);
 	}
 
-	/*
-	 * Did not match the string in the static table, call the host OSL to
-	 * check for a match with one of the optional strings (such as
-	 * "Module Device", "3.0 Thermal Model", etc.)
-	 */
-	status = acpi_os_validate_interface(string_desc->string.pointer);
-	if (ACPI_SUCCESS(status)) {
+	interface_info = acpi_ut_get_interface(string_desc->string.pointer);
 
-		/* The interface is supported */
+	if (interface_info && !(interface_info->flags & ACPI_OSI_INVALID)) {
+		/*
+		 * The interface is supported.
+		 * Update the osi_data if necessary. We keep track of the latest
+		 * version of Windows that has been requested by the BIOS.
+		 */
+		if (interface_info->value > acpi_gbl_osi_data) {
+			acpi_gbl_osi_data = interface_info->value;
+		}
 
 		return_value = ACPI_UINT32_MAX;
 	}
 
-exit:
-	ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INFO,
-		"ACPI: BIOS _OSI(%s) is %ssupported\n",
-		string_desc->string.pointer, return_value == 0 ? "not " : ""));
+	acpi_os_release_lock(acpi_gbl_osi_lock, flags);
+
+	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO,
+			      "ACPI: BIOS _OSI(%s) is %ssupported\n",
+			      string_desc->string.pointer,
+			      return_value == 0 ? "not " : ""));
 
 	/* Complete the return value */
 
 	return_desc->integer.value = return_value;
 	walk_state->return_desc = return_desc;
-	return_ACPI_STATUS (AE_OK);
+	return_ACPI_STATUS(AE_OK);
 }
 
 /*******************************************************************************




