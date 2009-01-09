From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/94] ACPICA: Remove references to obsolete ACPI_DUMP_APP
Date: Fri, 09 Jan 2009 04:26:32 -0500
Message-ID: <319f8b892722f289bb6e07b1067be3b2e0714238.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbZAIJ2O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:14 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700EGN6APOO13@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:02 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This define is no longer used.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsaccess.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/namespace/nsaccess.c
index c39a7f6..29c7c27 100644
--- a/drivers/acpi/namespace/nsaccess.c
+++ b/drivers/acpi/namespace/nsaccess.c
@@ -165,12 +165,9 @@ acpi_status acpi_ns_root_initialize(void)
 
 				obj_desc->method.method_flags =
 				    AML_METHOD_INTERNAL_ONLY;
-
-#ifndef ACPI_DUMP_APP
 				obj_desc->method.implementation =
 				    acpi_ut_osi_implementation;
 #endif
-#endif
 				break;
 
 			case ACPI_TYPE_INTEGER:
@@ -521,11 +518,11 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 	}
 
 	/*
-	 * Search namespace for each segment of the name.  Loop through and
+	 * Search namespace for each segment of the name. Loop through and
 	 * verify (or add to the namespace) each name segment.
 	 *
 	 * The object type is significant only at the last name
-	 * segment.  (We don't care about the types along the path, only
+	 * segment. (We don't care about the types along the path, only
 	 * the type of the final target object.)
 	 */
 	this_search_type = ACPI_TYPE_ANY;
-- 
1.5.6.6

