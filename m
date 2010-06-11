From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/5] ACPI: introduce drivers/acpi/sysfs.c
Date: Fri, 11 Jun 2010 13:47:58 +0800
Message-ID: <1276235278.19052.15873.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58639 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab0FKFrm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jun 2010 01:47:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Introduce driver/acpi/sysfs.c, which contains the code for ACPI sysfs I/F.

Remove driver/acpi/debug.c in this patch,
the code for ACPI debug sysfs I/F is moved to driver/acpi/sysfs.c.

No function change in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Makefile |    2 
 drivers/acpi/debug.c  |  198 --------------------------------------------------
 drivers/acpi/sysfs.c  |  196 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 199 deletions(-)

Index: linux-2.6/drivers/acpi/Makefile
===================================================================
--- linux-2.6.orig/drivers/acpi/Makefile
+++ linux-2.6/drivers/acpi/Makefile
@@ -39,7 +39,7 @@ acpi-y				+= pci_root.o pci_link.o pci_i
 acpi-y				+= power.o
 acpi-y				+= system.o event.o
 acpi-y				+= debugfs.o
-acpi-$(CONFIG_ACPI_DEBUG)	+= debug.o
+acpi-y				+= sysfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 ifdef CONFIG_ACPI_VIDEO
Index: linux-2.6/drivers/acpi/debug.c
===================================================================
--- linux-2.6.orig/drivers/acpi/debug.c
+++ /dev/null
@@ -1,198 +0,0 @@
-/*
- * debug.c - ACPI debug interface to userspace.
- */
-
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/moduleparam.h>
-#include <linux/debugfs.h>
-#include <linux/slab.h>
-#include <asm/uaccess.h>
-#include <acpi/acpi_drivers.h>
-
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("debug");
-
-struct acpi_dlayer {
-	const char *name;
-	unsigned long value;
-};
-struct acpi_dlevel {
-	const char *name;
-	unsigned long value;
-};
-#define ACPI_DEBUG_INIT(v)	{ .name = #v, .value = v }
-
-static const struct acpi_dlayer acpi_debug_layers[] = {
-	ACPI_DEBUG_INIT(ACPI_UTILITIES),
-	ACPI_DEBUG_INIT(ACPI_HARDWARE),
-	ACPI_DEBUG_INIT(ACPI_EVENTS),
-	ACPI_DEBUG_INIT(ACPI_TABLES),
-	ACPI_DEBUG_INIT(ACPI_NAMESPACE),
-	ACPI_DEBUG_INIT(ACPI_PARSER),
-	ACPI_DEBUG_INIT(ACPI_DISPATCHER),
-	ACPI_DEBUG_INIT(ACPI_EXECUTER),
-	ACPI_DEBUG_INIT(ACPI_RESOURCES),
-	ACPI_DEBUG_INIT(ACPI_CA_DEBUGGER),
-	ACPI_DEBUG_INIT(ACPI_OS_SERVICES),
-	ACPI_DEBUG_INIT(ACPI_CA_DISASSEMBLER),
-	ACPI_DEBUG_INIT(ACPI_COMPILER),
-	ACPI_DEBUG_INIT(ACPI_TOOLS),
-
-	ACPI_DEBUG_INIT(ACPI_BUS_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_AC_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_BATTERY_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_PCI_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_POWER_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_CONTAINER_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_THERMAL_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_VIDEO_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_PROCESSOR_COMPONENT),
-};
-
-static const struct acpi_dlevel acpi_debug_levels[] = {
-	ACPI_DEBUG_INIT(ACPI_LV_INIT),
-	ACPI_DEBUG_INIT(ACPI_LV_DEBUG_OBJECT),
-	ACPI_DEBUG_INIT(ACPI_LV_INFO),
-
-	ACPI_DEBUG_INIT(ACPI_LV_INIT_NAMES),
-	ACPI_DEBUG_INIT(ACPI_LV_PARSE),
-	ACPI_DEBUG_INIT(ACPI_LV_LOAD),
-	ACPI_DEBUG_INIT(ACPI_LV_DISPATCH),
-	ACPI_DEBUG_INIT(ACPI_LV_EXEC),
-	ACPI_DEBUG_INIT(ACPI_LV_NAMES),
-	ACPI_DEBUG_INIT(ACPI_LV_OPREGION),
-	ACPI_DEBUG_INIT(ACPI_LV_BFIELD),
-	ACPI_DEBUG_INIT(ACPI_LV_TABLES),
-	ACPI_DEBUG_INIT(ACPI_LV_VALUES),
-	ACPI_DEBUG_INIT(ACPI_LV_OBJECTS),
-	ACPI_DEBUG_INIT(ACPI_LV_RESOURCES),
-	ACPI_DEBUG_INIT(ACPI_LV_USER_REQUESTS),
-	ACPI_DEBUG_INIT(ACPI_LV_PACKAGE),
-
-	ACPI_DEBUG_INIT(ACPI_LV_ALLOCATIONS),
-	ACPI_DEBUG_INIT(ACPI_LV_FUNCTIONS),
-	ACPI_DEBUG_INIT(ACPI_LV_OPTIMIZATIONS),
-
-	ACPI_DEBUG_INIT(ACPI_LV_MUTEX),
-	ACPI_DEBUG_INIT(ACPI_LV_THREADS),
-	ACPI_DEBUG_INIT(ACPI_LV_IO),
-	ACPI_DEBUG_INIT(ACPI_LV_INTERRUPTS),
-
-	ACPI_DEBUG_INIT(ACPI_LV_AML_DISASSEMBLE),
-	ACPI_DEBUG_INIT(ACPI_LV_VERBOSE_INFO),
-	ACPI_DEBUG_INIT(ACPI_LV_FULL_TABLES),
-	ACPI_DEBUG_INIT(ACPI_LV_EVENTS),
-};
-
-/* --------------------------------------------------------------------------
-                              FS Interface (/sys)
-   -------------------------------------------------------------------------- */
-static int param_get_debug_layer(char *buffer, struct kernel_param *kp) {
-	int result = 0;
-	int i;
-
-	result = sprintf(buffer, "%-25s\tHex        SET\n", "Description");
-
-	for(i = 0; i <ARRAY_SIZE(acpi_debug_layers); i++) {
-		result += sprintf(buffer+result, "%-25s\t0x%08lX [%c]\n",
-					acpi_debug_layers[i].name,
-					acpi_debug_layers[i].value,
-					(acpi_dbg_layer & acpi_debug_layers[i].value) ? '*' : ' ');
-	}
-	result += sprintf(buffer+result, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DRIVERS",
-					ACPI_ALL_DRIVERS,
-					(acpi_dbg_layer & ACPI_ALL_DRIVERS) ==
-					ACPI_ALL_DRIVERS ? '*' : (acpi_dbg_layer &
-					ACPI_ALL_DRIVERS) == 0 ? ' ' : '-');
-	result += sprintf(buffer+result, "--\ndebug_layer = 0x%08X ( * = enabled)\n", acpi_dbg_layer);
-
-	return result;
-}
-
-static int param_get_debug_level(char *buffer, struct kernel_param *kp) {
-	int result = 0;
-	int i;
-
-	result = sprintf(buffer, "%-25s\tHex        SET\n", "Description");
-
-	for (i = 0; i < ARRAY_SIZE(acpi_debug_levels); i++) {
-		result += sprintf(buffer+result, "%-25s\t0x%08lX [%c]\n",
-				     acpi_debug_levels[i].name,
-				     acpi_debug_levels[i].value,
-				     (acpi_dbg_level & acpi_debug_levels[i].
-				      value) ? '*' : ' ');
-	}
-	result += sprintf(buffer+result, "--\ndebug_level = 0x%08X (* = enabled)\n",
-			     acpi_dbg_level);
-
-	return result;
-}
-
-module_param_call(debug_layer, param_set_uint, param_get_debug_layer, &acpi_dbg_layer, 0644);
-module_param_call(debug_level, param_set_uint, param_get_debug_level, &acpi_dbg_level, 0644);
-
-static char trace_method_name[6];
-module_param_string(trace_method_name, trace_method_name, 6, 0644);
-static unsigned int trace_debug_layer;
-module_param(trace_debug_layer, uint, 0644);
-static unsigned int trace_debug_level;
-module_param(trace_debug_level, uint, 0644);
-
-static int param_set_trace_state(const char *val, struct kernel_param *kp)
-{
-	int result = 0;
-
-	if (!strncmp(val, "enable", strlen("enable") - 1)) {
-		result = acpi_debug_trace(trace_method_name, trace_debug_level,
-					  trace_debug_layer, 0);
-		if (result)
-			result = -EBUSY;
-		goto exit;
-	}
-
-	if (!strncmp(val, "disable", strlen("disable") - 1)) {
-		int name = 0;
-		result = acpi_debug_trace((char *)&name, trace_debug_level,
-					  trace_debug_layer, 0);
-		if (result)
-			result = -EBUSY;
-		goto exit;
-	}
-
-	if (!strncmp(val, "1", 1)) {
-		result = acpi_debug_trace(trace_method_name, trace_debug_level,
-					  trace_debug_layer, 1);
-		if (result)
-			result = -EBUSY;
-		goto exit;
-	}
-
-	result = -EINVAL;
-exit:
-	return result;
-}
-
-static int param_get_trace_state(char *buffer, struct kernel_param *kp)
-{
-	if (!acpi_gbl_trace_method_name)
-		return sprintf(buffer, "disable");
-	else {
-		if (acpi_gbl_trace_flags & 1)
-			return sprintf(buffer, "1");
-		else
-			return sprintf(buffer, "enable");
-	}
-	return 0;
-}
-
-module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
-		  NULL, 0644);
Index: linux-2.6/drivers/acpi/sysfs.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/acpi/sysfs.c
@@ -0,0 +1,196 @@
+/*
+ * sysfs.c - ACPI sysfs interface to userspace.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <acpi/acpi_drivers.h>
+
+#define _COMPONENT		ACPI_SYSTEM_COMPONENT
+ACPI_MODULE_NAME("sysfs");
+
+#ifdef ACPI_DEBUG
+
+/*
+ * /sys/module/acpi/parameters/debug_layer and
+ * /sys/module/acpi/parameters/debug_level
+ */
+
+struct acpi_dlayer {
+	const char *name;
+	unsigned long value;
+};
+struct acpi_dlevel {
+	const char *name;
+	unsigned long value;
+};
+#define ACPI_DEBUG_INIT(v)	{ .name = #v, .value = v }
+
+static const struct acpi_dlayer acpi_debug_layers[] = {
+	ACPI_DEBUG_INIT(ACPI_UTILITIES),
+	ACPI_DEBUG_INIT(ACPI_HARDWARE),
+	ACPI_DEBUG_INIT(ACPI_EVENTS),
+	ACPI_DEBUG_INIT(ACPI_TABLES),
+	ACPI_DEBUG_INIT(ACPI_NAMESPACE),
+	ACPI_DEBUG_INIT(ACPI_PARSER),
+	ACPI_DEBUG_INIT(ACPI_DISPATCHER),
+	ACPI_DEBUG_INIT(ACPI_EXECUTER),
+	ACPI_DEBUG_INIT(ACPI_RESOURCES),
+	ACPI_DEBUG_INIT(ACPI_CA_DEBUGGER),
+	ACPI_DEBUG_INIT(ACPI_OS_SERVICES),
+	ACPI_DEBUG_INIT(ACPI_CA_DISASSEMBLER),
+	ACPI_DEBUG_INIT(ACPI_COMPILER),
+	ACPI_DEBUG_INIT(ACPI_TOOLS),
+
+	ACPI_DEBUG_INIT(ACPI_BUS_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_AC_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_BATTERY_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_PCI_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_POWER_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_CONTAINER_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_THERMAL_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_VIDEO_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_PROCESSOR_COMPONENT),
+};
+
+static const struct acpi_dlevel acpi_debug_levels[] = {
+	ACPI_DEBUG_INIT(ACPI_LV_INIT),
+	ACPI_DEBUG_INIT(ACPI_LV_DEBUG_OBJECT),
+	ACPI_DEBUG_INIT(ACPI_LV_INFO),
+
+	ACPI_DEBUG_INIT(ACPI_LV_INIT_NAMES),
+	ACPI_DEBUG_INIT(ACPI_LV_PARSE),
+	ACPI_DEBUG_INIT(ACPI_LV_LOAD),
+	ACPI_DEBUG_INIT(ACPI_LV_DISPATCH),
+	ACPI_DEBUG_INIT(ACPI_LV_EXEC),
+	ACPI_DEBUG_INIT(ACPI_LV_NAMES),
+	ACPI_DEBUG_INIT(ACPI_LV_OPREGION),
+	ACPI_DEBUG_INIT(ACPI_LV_BFIELD),
+	ACPI_DEBUG_INIT(ACPI_LV_TABLES),
+	ACPI_DEBUG_INIT(ACPI_LV_VALUES),
+	ACPI_DEBUG_INIT(ACPI_LV_OBJECTS),
+	ACPI_DEBUG_INIT(ACPI_LV_RESOURCES),
+	ACPI_DEBUG_INIT(ACPI_LV_USER_REQUESTS),
+	ACPI_DEBUG_INIT(ACPI_LV_PACKAGE),
+
+	ACPI_DEBUG_INIT(ACPI_LV_ALLOCATIONS),
+	ACPI_DEBUG_INIT(ACPI_LV_FUNCTIONS),
+	ACPI_DEBUG_INIT(ACPI_LV_OPTIMIZATIONS),
+
+	ACPI_DEBUG_INIT(ACPI_LV_MUTEX),
+	ACPI_DEBUG_INIT(ACPI_LV_THREADS),
+	ACPI_DEBUG_INIT(ACPI_LV_IO),
+	ACPI_DEBUG_INIT(ACPI_LV_INTERRUPTS),
+
+	ACPI_DEBUG_INIT(ACPI_LV_AML_DISASSEMBLE),
+	ACPI_DEBUG_INIT(ACPI_LV_VERBOSE_INFO),
+	ACPI_DEBUG_INIT(ACPI_LV_FULL_TABLES),
+	ACPI_DEBUG_INIT(ACPI_LV_EVENTS),
+};
+
+static int param_get_debug_layer(char *buffer, struct kernel_param *kp) {
+	int result = 0;
+	int i;
+
+	result = sprintf(buffer, "%-25s\tHex        SET\n", "Description");
+
+	for(i = 0; i <ARRAY_SIZE(acpi_debug_layers); i++) {
+		result += sprintf(buffer+result, "%-25s\t0x%08lX [%c]\n",
+					acpi_debug_layers[i].name,
+					acpi_debug_layers[i].value,
+					(acpi_dbg_layer & acpi_debug_layers[i].value) ? '*' : ' ');
+	}
+	result += sprintf(buffer+result, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DRIVERS",
+					ACPI_ALL_DRIVERS,
+					(acpi_dbg_layer & ACPI_ALL_DRIVERS) ==
+					ACPI_ALL_DRIVERS ? '*' : (acpi_dbg_layer &
+					ACPI_ALL_DRIVERS) == 0 ? ' ' : '-');
+	result += sprintf(buffer+result, "--\ndebug_layer = 0x%08X ( * = enabled)\n", acpi_dbg_layer);
+
+	return result;
+}
+
+static int param_get_debug_level(char *buffer, struct kernel_param *kp) {
+	int result = 0;
+	int i;
+
+	result = sprintf(buffer, "%-25s\tHex        SET\n", "Description");
+
+	for (i = 0; i < ARRAY_SIZE(acpi_debug_levels); i++) {
+		result += sprintf(buffer+result, "%-25s\t0x%08lX [%c]\n",
+				     acpi_debug_levels[i].name,
+				     acpi_debug_levels[i].value,
+				     (acpi_dbg_level & acpi_debug_levels[i].
+				      value) ? '*' : ' ');
+	}
+	result += sprintf(buffer+result, "--\ndebug_level = 0x%08X (* = enabled)\n",
+			     acpi_dbg_level);
+
+	return result;
+}
+
+module_param_call(debug_layer, param_set_uint, param_get_debug_layer, &acpi_dbg_layer, 0644);
+module_param_call(debug_level, param_set_uint, param_get_debug_level, &acpi_dbg_level, 0644);
+
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
+#endif /* ACPI_DEBUG */


