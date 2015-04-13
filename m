From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/31] ACPICA: Utilities: Remove unused acpi_ut_create_pkg_state_and_push().
Date: Mon, 13 Apr 2015 11:49:24 +0800
Message-ID: <f6859560990d58bf07612e70107f1e43b4bc4993.1428893937.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34766 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbbDMDt2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2015 23:49:28 -0400
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Bob Moore <robert.moore@intel.com>

From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

ACPICA commit 2a9ebd974aee41391f4b0edcd4f0cc5ee23ec2f8

Remove the function acpi_ut_create_pkg_state_and_push() that is not used anywhere.
This was partially found by using a static code analysis program called cppcheck.

Link: https://github.com/acpica/acpica/commit/2a9ebd97
Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h |    6 ------
 drivers/acpi/acpica/utstate.c |   34 ----------------------------------
 2 files changed, 40 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 3ae0447..04f4c31 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -539,12 +539,6 @@ acpi_ut_create_update_state_and_push(union acpi_operand_object *object,
 				     u16 action,
 				     union acpi_generic_state **state_list);
 
-acpi_status
-acpi_ut_create_pkg_state_and_push(void *internal_object,
-				  void *external_object,
-				  u16 index,
-				  union acpi_generic_state **state_list);
-
 union acpi_generic_state *acpi_ut_create_control_state(void);
 
 void acpi_ut_delete_generic_state(union acpi_generic_state *state);
diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstate.c
index 8274cc1..f201171 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -49,39 +49,6 @@ ACPI_MODULE_NAME("utstate")
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ut_create_pkg_state_and_push
- *
- * PARAMETERS:  object          - Object to be added to the new state
- *              action          - Increment/Decrement
- *              state_list      - List the state will be added to
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Create a new state and push it
- *
- ******************************************************************************/
-acpi_status
-acpi_ut_create_pkg_state_and_push(void *internal_object,
-				  void *external_object,
-				  u16 index,
-				  union acpi_generic_state **state_list)
-{
-	union acpi_generic_state *state;
-
-	ACPI_FUNCTION_ENTRY();
-
-	state =
-	    acpi_ut_create_pkg_state(internal_object, external_object, index);
-	if (!state) {
-		return (AE_NO_MEMORY);
-	}
-
-	acpi_ut_push_generic_state(state_list, state);
-	return (AE_OK);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ut_push_generic_state
  *
  * PARAMETERS:  list_head           - Head of the state stack
@@ -92,7 +59,6 @@ acpi_ut_create_pkg_state_and_push(void *internal_object,
  * DESCRIPTION: Push a state object onto a state stack
  *
  ******************************************************************************/
-
 void
 acpi_ut_push_generic_state(union acpi_generic_state **list_head,
 			   union acpi_generic_state *state)
-- 
1.7.10

