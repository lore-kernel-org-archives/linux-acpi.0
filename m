From: Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH] ACPICA: Remove unnecessary call to debugger
Date: Thu,  8 Jun 2017 23:31:06 +0200
Message-ID: <20170608213106.11982-1-kilobyte@angband.pl>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:39278 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdFHVdh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jun 2017 17:33:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org
Cc: Adam Borowski <kilobyte@angband.pl>

This is a port of https://github.com/acpica/acpica/commit/eaa455ac by
Robert Moore to the kernel:

> This call was simply wrong, and resulted in a -1 index into the operand
> stack.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=120351
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
You guys fixed this in your tool months ago, but it's still unfixed in the
kernel.  Let's apply that patch, then.  The coding styles differ so much the
patch is hardly recognizable, but it's a direct port.

 drivers/acpi/acpica/dsutils.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 406edec20de7..0dabd9b95684 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -633,15 +633,6 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 
 		if ((op_info->flags & AML_HAS_RETVAL) ||
 		    (arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-					  "Argument previously created, already stacked\n"));
-
-			acpi_db_display_argument_object(walk_state->
-							operands[walk_state->
-								 num_operands -
-								 1],
-							walk_state);
-
 			/*
 			 * Use value that was already previously returned
 			 * by the evaluation of this argument
-- 
2.11.0

