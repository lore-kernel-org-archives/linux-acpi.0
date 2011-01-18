From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/6] ACPICA: Fix namespace race condition
Date: Mon, 17 Jan 2011 20:22:59 -0500
Message-ID: <3926690eafe94e72368ec17f8570d1f1ef7901e8.1295313738.git.len.brown@intel.com>
References: <1295313783-3490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:64864 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1ARBXO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jan 2011 20:23:14 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LF7008LB2IO8Y82@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 17 Jan 2011 19:23:14 -0600 (CST)
In-reply-to: <1295313783-3490-1-git-send-email-lenb@kernel.org>
In-reply-to: <9673b4771ec8e378f94c0ab715b40e16f58fc32f.1295313738.git.len.brown@intel.com>
References: <9673b4771ec8e378f94c0ab715b40e16f58fc32f.1295313738.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dana Myers <dana.myers@oracle.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Dana Myers <dana.myers@oracle.com>

Fixes a race condition between method execution and namespace
walks that can possibly fault. Problem was apparently introduced
in version 20100528 as a result of a performance optimization
that reduces the number of namespace walks upon method exit
by using the delete_namespace_subtree function instead of the
delete_namespace_by_owner function used previously. Bug is in
the delete_namespace_subtree function.

Signed-off-by: Dana Myers <dana.myers@oracle.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsalloc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 1e5ff80..222a23e 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -341,6 +341,7 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
 {
 	struct acpi_namespace_node *child_node = NULL;
 	u32 level = 1;
+	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ns_delete_namespace_subtree);
 
@@ -348,6 +349,13 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
 		return_VOID;
 	}
 
+	/* Lock namespace for possible update */
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_VOID;
+	}
+
 	/*
 	 * Traverse the tree of objects until we bubble back up
 	 * to where we started.
@@ -397,6 +405,7 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
 		}
 	}
 
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_VOID;
 }
 
-- 
1.7.4.rc2

