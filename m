From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/94] ACPICA: Fix possible memory leak on error in parser
Date: Fri, 09 Jan 2009 04:26:23 -0500
Message-ID: <84d4db7c528e23f8c9ae0be12960549347003eeb.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40934 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbZAIJ2I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:08 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LRJ6AKLN97@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:57 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Fixes a possible memory leak if an allocation failure happens in
the parse loop. Must terminate an executing control method.
Lin Ming, Bob Moore. ACPICA BZ 489.

http://www.acpica.org/bugzilla/show_bug.cgi?id=489

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/parser/psparse.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index 68e932f..dfd3d90 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -451,6 +451,14 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 
 	thread = acpi_ut_create_thread_state();
 	if (!thread) {
+		if (walk_state->method_desc) {
+
+			/* Executing a control method - additional cleanup */
+
+			acpi_ds_terminate_control_method(
+				walk_state->method_desc, walk_state);
+		}
+
 		acpi_ds_delete_walk_state(walk_state);
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
-- 
1.5.6.6

