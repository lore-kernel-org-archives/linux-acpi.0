From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/94] ACPICA: Add support to externally execute _OSI method
Date: Fri, 09 Jan 2009 04:26:31 -0500
Message-ID: <a8fadc923d1659f1a322194d420808d5b255883c.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40934 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbZAIJ2Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:25 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LFO6AOLFF7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:02 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The current implemenation of _OSI within ACPICA only allows other
control methods to execute _OSI. This change allows the host
OS to execute _OSI via the AcpiEvaluateObject interface. _OSI
is a special method -- it does not exist in the AML code, it is
implemented within ACPICA.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsmethod.c |    3 +++
 drivers/acpi/parser/psparse.c      |    4 ++++
 drivers/acpi/parser/psxface.c      |   17 +++++++++++++++++
 drivers/acpi/utilities/uteval.c    |    6 +++---
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index 279a5a6..77b7039 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -412,6 +412,9 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 
 	if (obj_desc->method.method_flags & AML_METHOD_INTERNAL_ONLY) {
 		status = obj_desc->method.implementation(next_walk_state);
+		if (status == AE_OK) {
+			status = AE_CTRL_TERMINATE;
+		}
 	}
 
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index dfd3d90..5156203 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -447,6 +447,10 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 			  walk_state, walk_state->parser_state.aml,
 			  walk_state->parser_state.aml_size));
 
+	if (!walk_state->parser_state.aml) {
+		return_ACPI_STATUS(AE_NULL_OBJECT);
+	}
+
 	/* Create and initialize a new thread state */
 
 	thread = acpi_ut_create_thread_state();
diff --git a/drivers/acpi/parser/psxface.c b/drivers/acpi/parser/psxface.c
index 270469a..4985ce5 100644
--- a/drivers/acpi/parser/psxface.c
+++ b/drivers/acpi/parser/psxface.c
@@ -45,6 +45,7 @@
 #include <acpi/acparser.h>
 #include <acpi/acdispat.h>
 #include <acpi/acinterp.h>
+#include <acpi/amlcode.h>
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psxface")
@@ -278,6 +279,22 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 		goto cleanup;
 	}
 
+	/* Invoke an internal method if necessary */
+
+	if (info->obj_desc->method.method_flags & AML_METHOD_INTERNAL_ONLY) {
+		status = info->obj_desc->method.implementation(walk_state);
+		info->return_object = walk_state->return_desc;
+
+		/* Cleanup states */
+
+		acpi_ds_scope_stack_clear(walk_state);
+		acpi_ps_cleanup_scope(&walk_state->parser_state);
+		acpi_ds_terminate_control_method(walk_state->method_desc,
+						 walk_state);
+		acpi_ds_delete_walk_state(walk_state);
+		goto cleanup;
+	}
+
 	/* Parse the AML */
 
 	status = acpi_ps_parse_aml(walk_state);
diff --git a/drivers/acpi/utilities/uteval.c b/drivers/acpi/utilities/uteval.c
index 352747e..df2b511 100644
--- a/drivers/acpi/utilities/uteval.c
+++ b/drivers/acpi/utilities/uteval.c
@@ -129,7 +129,7 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 
 			/* The interface is supported */
 
-			return_ACPI_STATUS(AE_CTRL_TERMINATE);
+			return_ACPI_STATUS(AE_OK);
 		}
 	}
 
@@ -143,13 +143,13 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 
 		/* The interface is supported */
 
-		return_ACPI_STATUS(AE_CTRL_TERMINATE);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/* The interface is not supported */
 
 	return_desc->integer.value = 0;
-	return_ACPI_STATUS(AE_CTRL_TERMINATE);
+	return_ACPI_STATUS(AE_OK);
 }
 
 /*******************************************************************************
-- 
1.5.6.6

