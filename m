From: Len Brown <lenb@kernel.org>
Subject: [PATCH 061/103] ACPICA: Fix possible memory leak for module-level code
 execution
Date: Wed, 16 Dec 2009 03:36:12 -0500
Message-ID: <583061c59ffea1ea14f6dca735ab0f99238a7a92.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47226 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762001AbZLPLGA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:00 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:55 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

An object can be leaked for each block of executed module-level
code if the interpreter slack mode is enabled. The change deletes
any implicitly returned object in this case.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nseval.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index f771e97..65e0d1a 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -415,6 +415,12 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 	ACPI_DEBUG_PRINT((ACPI_DB_INIT, "Executed module-level code at %p\n",
 			  method_obj->method.aml_start));
 
+	/* Delete a possible implicit return value (in slack mode) */
+
+	if (info->return_object) {
+		acpi_ut_remove_reference(info->return_object);
+	}
+
 	/* Detach the temporary method object */
 
 	acpi_ns_detach_object(parent_node);
-- 
1.6.0.6

