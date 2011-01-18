From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/6] ACPICA: Debugger: Lock namespace for duration of a
 namespace dump
Date: Mon, 17 Jan 2011 20:23:00 -0500
Message-ID: <c80a0859fab6a471b8654d26f3af4f9c205ffa4b.1295313738.git.len.brown@intel.com>
References: <1295313783-3490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:48386 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1ARBXS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jan 2011 20:23:18 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LF700CXA2IROPW2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 17 Jan 2011 19:23:16 -0600 (CST)
In-reply-to: <1295313783-3490-1-git-send-email-lenb@kernel.org>
In-reply-to: <9673b4771ec8e378f94c0ab715b40e16f58fc32f.1295313738.git.len.brown@intel.com>
References: <9673b4771ec8e378f94c0ab715b40e16f58fc32f.1295313738.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Prevents issues if the namespace is changing underneath the
debugger.  Especially temporary nodes, since the debugger displays
these also.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsdump.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index a54dc39..82693c3 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -624,9 +624,22 @@ acpi_ns_dump_objects(acpi_object_type type,
 		     acpi_owner_id owner_id, acpi_handle start_handle)
 {
 	struct acpi_walk_info info;
+	acpi_status status;
 
 	ACPI_FUNCTION_ENTRY();
 
+	/*
+	 * Just lock the entire namespace for the duration of the dump.
+	 * We don't want any changes to the namespace during this time,
+	 * especially the temporary nodes since we are going to display
+	 * them also.
+	 */
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not acquire namespace mutex\n");
+		return;
+	}
+
 	info.debug_level = ACPI_LV_TABLES;
 	info.owner_id = owner_id;
 	info.display_type = display_type;
@@ -636,6 +649,8 @@ acpi_ns_dump_objects(acpi_object_type type,
 				     ACPI_NS_WALK_TEMP_NODES,
 				     acpi_ns_dump_one_object, NULL,
 				     (void *)&info, NULL);
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 }
 #endif				/* ACPI_FUTURE_USAGE */
 
-- 
1.7.4.rc2

