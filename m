From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/16] ACPI: fix build warnings resulting from merge window
 conflict
Date: Tue, 28 Sep 2010 23:44:37 -0400
Message-ID: <ec652b351f48ed4cd6796181fbb41759ff88cc0a.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:44133 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab0I2DpP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:45:15 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00AQ5P3DLJG3@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:45:14 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

drivers/acpi/sysfs.c:154: warning: passing argument 1 of '__check_old_set_param' from incompatible pointer type
include/linux/moduleparam.h:165: note: expected 'int (*)(const char *, struct kernel_param *)' but argument is of type 'int (*)(const char *, const struct kernel_param *)'

Introduced by commit 1c8fce27e275fd7c6b75bc6455745f02d3903ee6 ("ACPI:
introduce drivers/acpi/sysfs.c") interacting with commit
9bbb9e5a33109b2832e2e63dcc7a132924ab374b ("param: use ops in struct
kernel_param, rather than get and set fns directly").

Use module_param_cb instead of the obsoleted module_param_call to fix a build warning.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sysfs.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 68e2e45..f8588f8 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -100,7 +100,7 @@ static const struct acpi_dlevel acpi_debug_levels[] = {
 	ACPI_DEBUG_INIT(ACPI_LV_EVENTS),
 };
 
-static int param_get_debug_layer(char *buffer, struct kernel_param *kp)
+static int param_get_debug_layer(char *buffer, const struct kernel_param *kp)
 {
 	int result = 0;
 	int i;
@@ -128,7 +128,7 @@ static int param_get_debug_layer(char *buffer, struct kernel_param *kp)
 	return result;
 }
 
-static int param_get_debug_level(char *buffer, struct kernel_param *kp)
+static int param_get_debug_level(char *buffer, const struct kernel_param *kp)
 {
 	int result = 0;
 	int i;
@@ -149,10 +149,18 @@ static int param_get_debug_level(char *buffer, struct kernel_param *kp)
 	return result;
 }
 
-module_param_call(debug_layer, param_set_uint, param_get_debug_layer,
-		  &acpi_dbg_layer, 0644);
-module_param_call(debug_level, param_set_uint, param_get_debug_level,
-		  &acpi_dbg_level, 0644);
+static struct kernel_param_ops param_ops_debug_layer = {
+	.set = param_set_uint,
+	.get = param_get_debug_layer,
+};
+
+static struct kernel_param_ops param_ops_debug_level = {
+	.set = param_set_uint,
+	.get = param_get_debug_level,
+};
+
+module_param_cb(debug_layer, &param_ops_debug_layer, &acpi_dbg_layer, 0644);
+module_param_cb(debug_level, &param_ops_debug_level, &acpi_dbg_level, 0644);
 
 static char trace_method_name[6];
 module_param_string(trace_method_name, trace_method_name, 6, 0644);
-- 
1.7.3.2.g9027fa

