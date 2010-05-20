From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/22] ACPICA: Rename
 acpi_ex_system_do_suspend->acpi_ex_system_do_sleep
Date: Thu, 20 May 2010 01:18:47 -0400
Message-ID: <ada241dcec7eb21ff1690a1ba6213299b743bb5b.1274332658.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:36044 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab0ETGPd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 02:15:33 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P007GDG0X9AM5@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 01:15:00 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Suspend has other meanings in ACPI context, name was misleading.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acinterp.h |    2 +-
 drivers/acpi/acpica/exoparg1.c |    2 +-
 drivers/acpi/acpica/exsystem.c |    8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 9a9b893..049e203 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -281,7 +281,7 @@ acpi_status
 acpi_ex_system_do_notify_op(union acpi_operand_object *value,
 			    union acpi_operand_object *obj_desc);
 
-acpi_status acpi_ex_system_do_suspend(u64 time);
+acpi_status acpi_ex_system_do_sleep(u64 time);
 
 acpi_status acpi_ex_system_do_stall(u32 time);
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 38e0f3c..84e4d18 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -173,7 +173,7 @@ acpi_status acpi_ex_opcode_1A_0T_0R(struct acpi_walk_state *walk_state)
 
 	case AML_SLEEP_OP:	/*  Sleep (msec_time) */
 
-		status = acpi_ex_system_do_suspend(operand[0]->integer.value);
+		status = acpi_ex_system_do_sleep(operand[0]->integer.value);
 		break;
 
 	case AML_STALL_OP:	/*  Stall (usec_time) */
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index c9513d5..6d32e09 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -182,18 +182,18 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ex_system_do_suspend
+ * FUNCTION:    acpi_ex_system_do_sleep
  *
- * PARAMETERS:  how_long        - The amount of time to suspend,
+ * PARAMETERS:  how_long        - The amount of time to sleep,
  *                                in milliseconds
  *
  * RETURN:      None
  *
- * DESCRIPTION: Suspend running thread for specified amount of time.
+ * DESCRIPTION: Sleep the running thread for specified amount of time.
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_system_do_suspend(u64 how_long)
+acpi_status acpi_ex_system_do_sleep(u64 how_long)
 {
 	ACPI_FUNCTION_ENTRY();
 
-- 
1.6.0.6

