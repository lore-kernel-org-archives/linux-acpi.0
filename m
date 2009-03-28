From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/98] ACPICA: Debug output: print result of _OSI invocations
Date: Sat, 28 Mar 2009 00:31:06 -0400
Message-ID: <c114e4b6c606c7f174b752f946fcfb0e7e61a347.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38046 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbZC1Ecx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:53 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7007HO8MFX3CT@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:40 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Print input strings and the result (supported or not supported)
for invocations of the _OSI method.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/uteval.c |   32 +++++++++++++++++++++-----------
 1 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 99bfbd2..9c4ae6f 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -98,6 +98,7 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 	acpi_status status;
 	union acpi_operand_object *string_desc;
 	union acpi_operand_object *return_desc;
+	u32 return_value;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE(ut_osi_implementation);
@@ -116,10 +117,9 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
-	/* Default return value is 0, NOT-SUPPORTED */
+	/* Default return value is 0, NOT SUPPORTED */
 
-	return_desc->integer.value = 0;
-	walk_state->return_desc = return_desc;
+	return_value = 0;
 
 	/* Compare input string to static table of supported interfaces */
 
@@ -127,8 +127,11 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 		if (!ACPI_STRCMP
 		    (string_desc->string.pointer,
 		     acpi_interfaces_supported[i])) {
-			return_desc->integer.value = ACPI_UINT32_MAX;
-			goto done;
+
+			/* The interface is supported */
+
+			return_value = ACPI_UINT32_MAX;
+			goto exit;
 		}
 	}
 
@@ -139,15 +142,22 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 	 */
 	status = acpi_os_validate_interface(string_desc->string.pointer);
 	if (ACPI_SUCCESS(status)) {
-		return_desc->integer.value = ACPI_UINT32_MAX;
+
+		/* The interface is supported */
+
+		return_value = ACPI_UINT32_MAX;
 	}
 
-done:
-	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO, "ACPI: BIOS _OSI(%s) %ssupported\n",
-		string_desc->string.pointer,
-		return_desc->integer.value == 0 ? "not-" : ""));
+exit:
+	ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INFO,
+		"ACPI: BIOS _OSI(%s) is %ssupported\n",
+		string_desc->string.pointer, return_value == 0 ? "not " : ""));
 
-	return_ACPI_STATUS(AE_OK);
+	/* Complete the return value */
+
+	return_desc->integer.value = return_value;
+	walk_state->return_desc = return_desc;
+	return_ACPI_STATUS (AE_OK);
 }
 
 /*******************************************************************************
-- 
1.6.0.6

