From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/85] ACPICA: Return method arg count from acpi_get_object_info
Date: Sat, 11 Oct 2008 02:35:37 -0400
Message-ID: <08f0360588282c1b61dad602d465b2bc48a23ab4.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172073pub.verizon.net ([206.46.172.73]:58857 "EHLO
	vms172073pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbYJKGgx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:36:53 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
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
index a287ed5..6d31a1f 100644
--- a/drivers/acpi/namespace/nsxfname.c
+++ b/drivers/acpi/namespace/nsxfname.c
@@ -264,6 +264,10 @@ acpi_get_object_info(acpi_handle handle, struct acpi_buffer * buffer)
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
index 4ea4f40..298c636 100644
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

