From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/73] ACPICA: Avoid use of invalid pointers in returned object field
Date: Sat, 12 Apr 2008 00:24:48 -0400
Message-ID: <04e336c68ccdc06d307efdf78c3d9e24dc3a0cb8.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:49384 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752267AbYDLE15 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:57 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

During operand evaluation, ensure that the ReturnObj field is
cleared on error and only valid pointers are stored there.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exoparg1.c |    1 +
 drivers/acpi/executer/exoparg2.c |   19 +++++++++++++------
 drivers/acpi/executer/exoparg3.c |    1 +
 drivers/acpi/executer/exoparg6.c |    8 ++++++--
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/executer/exoparg1.c b/drivers/acpi/executer/exoparg1.c
index 252f10a..ab5c037 100644
--- a/drivers/acpi/executer/exoparg1.c
+++ b/drivers/acpi/executer/exoparg1.c
@@ -121,6 +121,7 @@ acpi_status acpi_ex_opcode_0A_0T_1R(struct acpi_walk_state *walk_state)
 
 	if ((ACPI_FAILURE(status)) || walk_state->result_obj) {
 		acpi_ut_remove_reference(return_desc);
+		walk_state->result_obj = NULL;
 	} else {
 		/* Save the return value */
 
diff --git a/drivers/acpi/executer/exoparg2.c b/drivers/acpi/executer/exoparg2.c
index 17e652e..81c02b1 100644
--- a/drivers/acpi/executer/exoparg2.c
+++ b/drivers/acpi/executer/exoparg2.c
@@ -241,10 +241,6 @@ acpi_status acpi_ex_opcode_2A_2T_1R(struct acpi_walk_state *walk_state)
 		goto cleanup;
 	}
 
-	/* Return the remainder */
-
-	walk_state->result_obj = return_desc1;
-
       cleanup:
 	/*
 	 * Since the remainder is not returned indirectly, remove a reference to
@@ -259,6 +255,12 @@ acpi_status acpi_ex_opcode_2A_2T_1R(struct acpi_walk_state *walk_state)
 		acpi_ut_remove_reference(return_desc1);
 	}
 
+	/* Save return object (the remainder) on success */
+
+	else {
+		walk_state->result_obj = return_desc1;
+	}
+
 	return_ACPI_STATUS(status);
 }
 
@@ -490,6 +492,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 
 	if (ACPI_FAILURE(status)) {
 		acpi_ut_remove_reference(return_desc);
+		walk_state->result_obj = NULL;
 	}
 
 	return_ACPI_STATUS(status);
@@ -583,8 +586,6 @@ acpi_status acpi_ex_opcode_2A_0T_1R(struct acpi_walk_state *walk_state)
 		return_desc->integer.value = ACPI_INTEGER_MAX;
 	}
 
-	walk_state->result_obj = return_desc;
-
       cleanup:
 
 	/* Delete return object on error */
@@ -593,5 +594,11 @@ acpi_status acpi_ex_opcode_2A_0T_1R(struct acpi_walk_state *walk_state)
 		acpi_ut_remove_reference(return_desc);
 	}
 
+	/* Save return object on success */
+
+	else {
+		walk_state->result_obj = return_desc;
+	}
+
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/executer/exoparg3.c b/drivers/acpi/executer/exoparg3.c
index 7fe67cf..a573f5d 100644
--- a/drivers/acpi/executer/exoparg3.c
+++ b/drivers/acpi/executer/exoparg3.c
@@ -260,6 +260,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 	if (ACPI_FAILURE(status) || walk_state->result_obj) {
 		acpi_ut_remove_reference(return_desc);
+		walk_state->result_obj = NULL;
 	}
 
 	/* Set the return object and exit */
diff --git a/drivers/acpi/executer/exoparg6.c b/drivers/acpi/executer/exoparg6.c
index bd80a9c..163b2b3 100644
--- a/drivers/acpi/executer/exoparg6.c
+++ b/drivers/acpi/executer/exoparg6.c
@@ -322,8 +322,6 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 		goto cleanup;
 	}
 
-	walk_state->result_obj = return_desc;
-
       cleanup:
 
 	/* Delete return object on error */
@@ -332,5 +330,11 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 		acpi_ut_remove_reference(return_desc);
 	}
 
+	/* Save return object on success */
+
+	else {
+		walk_state->result_obj = return_desc;
+	}
+
 	return_ACPI_STATUS(status);
 }
-- 
1.5.5.29.g7134

