From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/94] ACPICA: Enhance implicit return mechanism
Date: Fri, 09 Jan 2009 04:26:37 -0500
Message-ID: <7a4b8131ac7b47feb110b3e0142d4207ee79a025.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbZAIJ2X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:23 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700EGR6ASOO13@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:05 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

For Windows compatibility, return an implicit integer of value
zero for methods that have no executable code. A default implicit
value of zero is provided for methods. Lin Ming.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/parser/psxface.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/parser/psxface.c b/drivers/acpi/parser/psxface.c
index 4985ce5..41b0c8c 100644
--- a/drivers/acpi/parser/psxface.c
+++ b/drivers/acpi/parser/psxface.c
@@ -295,6 +295,22 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 		goto cleanup;
 	}
 
+	/*
+	 * Start method evaluation with an implicit return of zero.
+	 * This is done for Windows compatibility.
+	 */
+	if (acpi_gbl_enable_interpreter_slack) {
+		walk_state->implicit_return_obj =
+		    acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		if (!walk_state->implicit_return_obj) {
+			status = AE_NO_MEMORY;
+			acpi_ds_delete_walk_state(walk_state);
+			goto cleanup;
+		}
+
+		walk_state->implicit_return_obj->integer.value = 0;
+	}
+
 	/* Parse the AML */
 
 	status = acpi_ps_parse_aml(walk_state);
-- 
1.5.6.6

