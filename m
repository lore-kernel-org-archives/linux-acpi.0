From: Len Brown <lenb@kernel.org>
Subject: [PATCH 001/112] ACPI: add control method tracing support
Date: Thu,  7 Feb 2008 04:33:23 -0500
Message-ID: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753611AbYBGJfT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:19 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Add debug tracing support during certain AML method execution.

Four more module parameters are created under /sys/module/acpi/parameters/:
trace_method_name:	the AML method name that user wants to trace

trace_debug_layer:	the temporary debug_layer used when tracing the method.
			Using 0xffffffff by default if it is 0.

trace_debug_level:	the temporary debug_level used when tracing the method.
			Using 0x00ffffff by default if it is 0.

trace_state:		The status of the tracing feature.
			"enabled" means this feature is enabled
			and the AML method is traced every time it's executed.
			"1" means this feature is enabled and the AML method
			will only be traced during the next execution.
			"disabled" means this feature is disabled.
			Users can enable/disable this debug tracing feature by
			"echo string > /sys/module/acpi/parameters/trace_state".
			"string" should be one of "enable", "disable" and "1".

http://bugzilla.kernel.org/show_bug.cgi?id=6629

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/debug.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index bf513e0..6df564f 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -130,6 +130,63 @@ static int param_get_debug_level(char *buffer, struct kernel_param *kp) {
 module_param_call(debug_layer, param_set_uint, param_get_debug_layer, &acpi_dbg_layer, 0644);
 module_param_call(debug_level, param_set_uint, param_get_debug_level, &acpi_dbg_level, 0644);
 
+static char trace_method_name[6];
+module_param_string(trace_method_name, trace_method_name, 6, 0644);
+static unsigned int trace_debug_layer;
+module_param(trace_debug_layer, uint, 0644);
+static unsigned int trace_debug_level;
+module_param(trace_debug_level, uint, 0644);
+
+static int param_set_trace_state(const char *val, struct kernel_param *kp)
+{
+	int result = 0;
+
+	if (!strncmp(val, "enable", strlen("enable") - 1)) {
+		result = acpi_debug_trace(trace_method_name, trace_debug_level,
+					  trace_debug_layer, 0);
+		if (result)
+			result = -EBUSY;
+		goto exit;
+	}
+
+	if (!strncmp(val, "disable", strlen("disable") - 1)) {
+		int name = 0;
+		result = acpi_debug_trace((char *)&name, trace_debug_level,
+					  trace_debug_layer, 0);
+		if (result)
+			result = -EBUSY;
+		goto exit;
+	}
+
+	if (!strncmp(val, "1", 1)) {
+		result = acpi_debug_trace(trace_method_name, trace_debug_level,
+					  trace_debug_layer, 1);
+		if (result)
+			result = -EBUSY;
+		goto exit;
+	}
+
+	result = -EINVAL;
+exit:
+	return result;
+}
+
+static int param_get_trace_state(char *buffer, struct kernel_param *kp)
+{
+	if (!acpi_gbl_trace_method_name)
+		return sprintf(buffer, "disable");
+	else {
+		if (acpi_gbl_trace_flags & 1)
+			return sprintf(buffer, "1");
+		else
+			return sprintf(buffer, "enable");
+	}
+	return 0;
+}
+
+module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
+		  NULL, 0644);
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
-- 
1.5.4.23.gef5b9

