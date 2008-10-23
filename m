From: Len Brown <lenb@kernel.org>
Subject: [PATCH 103/122] ACPICA: Reduce error to warning for incorrect method
 arg count
Date: Thu, 23 Oct 2008 02:39:17 -0400
Message-ID: <93851b4d13de48753eaae76ed190eef7355e2c19.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbYJWGoM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:12 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:10 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Previously aborted with error if too few arguments were passed to
a control method via the external ACPICA interface. Now issue a
warning instead and continue. Handles the case where the method
inadvertently declares too many arguments, but does not actually
use the extra ones.  Applies mainly to the predefined methods.

http://bugzilla.kernel.org/show_bug.cgi?id=11032

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nseval.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index 0a1ae67..42dae12 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -148,21 +148,22 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 				info->param_count++;
 		}
 
-		/* Error if too few arguments were passed in */
+		/*
+		 * Warning if too few or too many arguments have been passed by the
+		 * caller. We don't want to abort here with an error because an
+		 * incorrect number of arguments may not cause the method to fail.
+		 * However, the method will fail if there are too few arguments passed
+		 * and the method attempts to use one of the missing ones.
+		 */
 
 		if (info->param_count < info->obj_desc->method.param_count) {
-			ACPI_ERROR((AE_INFO,
+			ACPI_WARNING((AE_INFO,
 				    "Insufficient arguments - "
 				    "method [%4.4s] needs %d, found %d",
 				    acpi_ut_get_node_name(info->resolved_node),
 				    info->obj_desc->method.param_count,
 				    info->param_count));
-			return_ACPI_STATUS(AE_MISSING_ARGUMENTS);
-		}
-
-		/* Just a warning if too many arguments */
-
-		else if (info->param_count >
+		} else if (info->param_count >
 				info->obj_desc->method.param_count) {
 			ACPI_WARNING((AE_INFO,
 				      "Excess arguments - "
-- 
1.5.5.1

