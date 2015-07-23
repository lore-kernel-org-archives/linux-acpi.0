From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/4] ACPI / sysfs: Add support to allow leading "\" missing in trace_method_name.
Date: Thu, 23 Jul 2015 13:07:06 +0800
Message-ID: <ee3412a77efd62e3ed82958c8901c92d80620141.1437627661.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com> <cover.1437627661.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437627661.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Since _SB.PCI0 can be used as relative path from root and can be easily
converted into internal trace_method_name format, we allow users to specify
trace_method_name using relative paths from root.
Note this is useful for grub2 for which users failed to pass "\" from the
grub configuration file.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sysfs.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 8979e4a..40a4265 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -164,14 +164,18 @@ static const struct kernel_param_ops param_ops_debug_level = {
 module_param_cb(debug_layer, &param_ops_debug_layer, &acpi_dbg_layer, 0644);
 module_param_cb(debug_level, &param_ops_debug_level, &acpi_dbg_level, 0644);
 
-static char* trace_method_name;
-static bool trace_method_kmalloced;
+static char trace_method_name[1024];
 
 int param_set_trace_method_name(const char *val, const struct kernel_param *kp)
 {
 	u32 saved_flags = 0;
+	bool is_abs_path = true;
 
-	if (strlen(val) > 1024) {
+	if (*val != '\\')
+		is_abs_path = false;
+
+	if ((is_abs_path && strlen(val) > 1023) ||
+	    (!is_abs_path && strlen(val) > 1022)) {
 		pr_err("%s: string parameter too long\n", kp->name);
 		return -ENOSPC;
 	}
@@ -187,19 +191,13 @@ int param_set_trace_method_name(const char *val, const struct kernel_param *kp)
 			       acpi_gbl_trace_dbg_layer,
 			       0);
 
-	if (trace_method_kmalloced)
-		kfree(trace_method_name);
-	trace_method_name = NULL;
-	trace_method_kmalloced = false;
-
 	/* This is a hack.  We can't kmalloc in early boot. */
-	if (slab_is_available()) {
-		trace_method_name = kstrdup(val, GFP_KERNEL);
-		if (!trace_method_name)
-			return -ENOMEM;
-		trace_method_kmalloced = true;
-	} else
-		trace_method_name = (char *)val;
+	if (is_abs_path)
+		strcpy(trace_method_name, val);
+	else {
+		trace_method_name[0] = '\\';
+		strcpy(trace_method_name+1, val);
+	}
 
 	/* Restore the original tracer state */
 	(void)acpi_debug_trace(trace_method_name,
-- 
1.7.10
