From: Len Brown <lenb@kernel.org>
Subject: [PATCH 091/122] ACPICA: Return method arg count from
 acpi_get_object_info
Date: Thu, 23 Oct 2008 02:39:05 -0400
Message-ID: <0a1fbf2db0d275f0f8160bb9c3e51c4df5bafdc2.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51267 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbYJWGkj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:39 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K96006LSIJ333Q1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:16 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Also update the debugger so that the correct number of arguments is
passed to the method. Prevents a warning message from the debugger.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsxfname.c |    4 ++++
 include/acpi/actypes.h            |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/namespace/nsxfname.c b/drivers/acpi/namespace/nsxfname.c
index 3cb910d..5efa4e7 100644
--- a/drivers/acpi/namespace/nsxfname.c
+++ b/drivers/acpi/namespace/nsxfname.c
@@ -265,6 +265,10 @@ acpi_get_object_info(acpi_handle handle, struct acpi_buffer * buffer)
 	info->name = node->name.integer;
 	info->valid = 0;
 
+	if (node->type == ACPI_TYPE_METHOD) {
+		info->param_count = node->object->method.param_count;
+	}
+
 	status = acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 73d6b1c..6bd08e8 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -859,6 +859,7 @@ struct acpi_obj_info_header {
 struct acpi_device_info {
 	ACPI_COMMON_OBJ_INFO;
 
+	u32 param_count;	/* If a method, required parameter count */
 	u32 valid;		/* Indicates which fields below are valid */
 	u32 current_status;	/* _STA value */
 	acpi_integer address;	/* _ADR value if any */
-- 
1.5.5.1

