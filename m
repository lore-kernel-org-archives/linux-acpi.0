From: Len Brown <lenb@kernel.org>
Subject: [PATCH 102/122] ACPICA: Disallow evaluation of named object types with
 no value
Date: Thu, 23 Oct 2008 02:39:16 -0400
Message-ID: <b68bacf225e5e9758472e99505d76125ced3ea88.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbYJWGoL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:11 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:08 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Return AE_TYPE for objects that have no value and therefore
evaluation is undefined: Device, Event, Mutex, Region, Thermal,
and Scope.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nseval.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index d369164..0a1ae67 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -195,7 +195,28 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 	} else {
 		/*
 		 * 2) Object is not a method, return its current value
+		 *
+		 * Disallow certain object types. For these, "evaluation" is undefined.
 		 */
+		switch (info->resolved_node->type) {
+		case ACPI_TYPE_DEVICE:
+		case ACPI_TYPE_EVENT:
+		case ACPI_TYPE_MUTEX:
+		case ACPI_TYPE_REGION:
+		case ACPI_TYPE_THERMAL:
+		case ACPI_TYPE_LOCAL_SCOPE:
+
+			ACPI_ERROR((AE_INFO,
+				    "[%4.4s] Evaluation of object type [%s] is not supported",
+				    info->resolved_node->name.ascii,
+				    acpi_ut_get_type_name(info->resolved_node->
+							  type)));
+
+			return_ACPI_STATUS(AE_TYPE);
+
+		default:
+			break;
+		}
 
 		/*
 		 * Objects require additional resolution steps (e.g., the Node may be
-- 
1.5.5.1

