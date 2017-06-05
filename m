From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 33/53] ACPICA: Dispatcher: Remove unnecessary call to debugger
Date: Mon,  5 Jun 2017 16:40:26 +0800
Message-ID: <59fffccb5db37436f1da18fdfefce65f861c34ae.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:26962 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbdFEIkb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:40:31 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit eaa455accf165fee2df26410e271aab162264f6c

UBSAN reports an index out of range use in dsutils.c.
  acpi_db_display_argument_object(
  	walk_state->operands[walk_state->num_operands - 1],
  	                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  	walk_state);

This call was simply wrong, generated redundant debugger messages, and
resulted in a -1 index into the operand stack. Linux kernel bug #120351
(link #1) and #194845 (link #2).

Originally fixed by Navin P.S. (link #1, comment 8), refined by Lv Zheng
(link #3).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=120351 [#1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=194845 [#2]
Link: https://github.com/acpica/acpica/pull/245          [#3]
Link: https://github.com/acpica/acpica/commit/eaa455ac
Reported-by: Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Reported-by: Ronald Warsow <rwarsow@gmx.de>
Original-by: Navin P.S. <navinp1912@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsutils.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 406edec..0dabd9b 100644
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
2.7.4

