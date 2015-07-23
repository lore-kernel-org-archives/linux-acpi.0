From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/4] ACPI / Documentation: Update method tracing documentation.
Date: Thu, 23 Jul 2015 13:06:58 +0800
Message-ID: <c9282393fad0766263c10e3a7e74df828f8479b7.1437627661.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com> <cover.1437627661.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437627661.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch updates method tracing documentation.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/acpi/method-tracing.txt |   53 ++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/Documentation/acpi/method-tracing.txt b/Documentation/acpi/method-tracing.txt
index f6efb1e..c77f91c 100644
--- a/Documentation/acpi/method-tracing.txt
+++ b/Documentation/acpi/method-tracing.txt
@@ -1,26 +1,51 @@
 /sys/module/acpi/parameters/:
 
 trace_method_name
-	The AML method name that the user wants to trace
+	The full path of the AML method that the user wants to use with the
+	"method"/"method-once" tracing mode.
+	Note that the full path shouldn't contain the trailing "_"s in its
+	name segments but should contain "\" to form an absolute path.
 
 trace_debug_layer
-	The temporary debug_layer used when tracing the method.
-	Using 0xffffffff by default if it is 0.
+	The temporary debug_layer used when the tracing feature is enabled.
+	Using ACPI_EXECUTER (0x80) by default.
 
 trace_debug_level
-	The temporary debug_level used when tracing the method.
-	Using 0x00ffffff by default if it is 0.
+	The temporary debug_level used when the tracing feature is enabled.
+	Using ACPI_LV_TRACE_POINT (0x10) by default.
 
 trace_state
 	The status of the tracing feature.
 
-	"enabled" means this feature is enabled
-	and the AML method is traced every time it's executed.
+	Users can enable/disable this debug tracing feature by executing
+	the following command:
+	    # echo string > /sys/module/acpi/parameters/trace_state
+	Where "string" should be one of the followings:
+	"disable"
+	    Disable the tracing feature.
+	"enable"
+	    Enable the tracing feature.
+	    ACPICA debugging messages matching
+	    "trace_debug_layer/trace_debug_level" during any method
+	    execution will be logged.
+	"method"
+	    Enable the tracing feature.
+	    ACPICA debugging messages matching
+	    "trace_debug_layer/trace_debug_level" during method execution
+	    of "trace_method_name" will be logged.
+	"method-once"
+	    Enable the tracing feature.
+	    ACPICA debugging messages matching
+	    "trace_debug_layer/trace_debug_level" during method execution
+	    of "trace_method_name" will be logged only once.
+	"opcode"
+	    Enable the tracing feature.
+	    ACPICA debugging messages matching
+	    "trace_debug_layer/trace_debug_level" during method/opcode
+	    execution of "trace_method_name" will be logged.
+	"opcode-once"
+	    Enable the tracing feature.
+	    ACPICA debugging messages matching
+	    "trace_debug_layer/trace_debug_level" during method/opcode
+	    execution of "trace_method_name" will be logged only once.
 
-	"1" means this feature is enabled and the AML method
-	will only be traced during the next execution.
-
-	"disabled" means this feature is disabled.
-	Users can enable/disable this debug tracing feature by
-	"echo string > /sys/module/acpi/parameters/trace_state".
-	"string" should be one of "enable", "disable" and "1".
-- 
1.7.10
