From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/8] ACPICA: fix acpi_serialize hang regression
Date: Fri, 11 Jan 2008 15:11:32 -0500
Message-ID: <014d433f35d7f34b55dcc7b57c7635aaefc3757f.1200082105.git.len.brown@intel.com>
References: <1200082294-29742-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:58901 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759945AbYAKUkf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jan 2008 15:40:35 -0500
In-Reply-To: <1200082294-29742-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
References: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=8171

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evregion.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/events/evregion.c b/drivers/acpi/events/evregion.c
index e99f0c4..58ad097 100644
--- a/drivers/acpi/events/evregion.c
+++ b/drivers/acpi/events/evregion.c
@@ -344,7 +344,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		 * setup will potentially execute control methods
 		 * (e.g., _REG method for this region)
 		 */
-		acpi_ex_relinquish_interpreter();
+		acpi_ex_exit_interpreter();
 
 		status = region_setup(region_obj, ACPI_REGION_ACTIVATE,
 				      handler_desc->address_space.context,
@@ -352,7 +352,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 
 		/* Re-enter the interpreter */
 
-		acpi_ex_reacquire_interpreter();
+		acpi_ex_enter_interpreter();
 
 		/* Check for failure of the Region Setup */
 
@@ -405,7 +405,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		 * exit the interpreter because the handler *might* block -- we don't
 		 * know what it will do, so we can't hold the lock on the intepreter.
 		 */
-		acpi_ex_relinquish_interpreter();
+		acpi_ex_exit_interpreter();
 	}
 
 	/* Call the handler */
@@ -426,7 +426,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		 * We just returned from a non-default handler, we must re-enter the
 		 * interpreter
 		 */
-		acpi_ex_reacquire_interpreter();
+		acpi_ex_enter_interpreter();
 	}
 
 	return_ACPI_STATUS(status);
-- 
1.5.4.rc2.84.gf85fd

