From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] ACPICA: Fix namespace race condition
Date: Wed, 15 Dec 2010 08:55:41 +0800
Message-ID: <1292374541.10384.158.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25467 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760251Ab0LOAuu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Dec 2010 19:50:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>, Dana Myers <dana.myers@oracle.com>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

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
---

Len,

This is an emergent regression fix, could you include it for 2.6.37-rc6?
Thanks.

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
 


