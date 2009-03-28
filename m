From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/98] ACPICA: Debug output: decrease verbosity of DB_INFO
 debug level
Date: Sat, 28 Mar 2009 00:31:07 -0400
Message-ID: <7bcc06e845479bde939059bafa088bf25ede9dbf.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:27064 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbZC1Ecn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:43 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7009D88MF5JHG@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:41 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Removed some of the extraneous debug prints using the DB_INFO
level.  This should make the DB_INFO more useful.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nseval.c   |    2 +-
 drivers/acpi/acpica/nsutils.c  |    2 +-
 drivers/acpi/acpica/utobject.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 0f3d5f9..8e7dec1 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -155,7 +155,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 		}
 
 
-		ACPI_DUMP_PATHNAME(info->resolved_node, "Execute Method:",
+		ACPI_DUMP_PATHNAME(info->resolved_node, "ACPI: Execute Method",
 				   ACPI_LV_INFO, _COMPONENT);
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 3e1149b..d30b0e6 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -872,7 +872,7 @@ acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 				(flags | ACPI_NS_DONT_OPEN_SCOPE), NULL,
 				return_node);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%s, %s\n",
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%s, %s\n",
 				  pathname, acpi_format_exception(status)));
 	}
 
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index ae337a7..0207b62 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -310,7 +310,7 @@ u8 acpi_ut_valid_internal_object(void *object)
 	/* Check for a null pointer */
 
 	if (!object) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "**** Null Object Ptr\n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "**** Null Object Ptr\n"));
 		return (FALSE);
 	}
 
@@ -324,7 +324,7 @@ u8 acpi_ut_valid_internal_object(void *object)
 		return (TRUE);
 
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "%p is not not an ACPI operand obj [%s]\n",
 				  object, acpi_ut_get_descriptor_name(object)));
 		break;
-- 
1.6.0.6

