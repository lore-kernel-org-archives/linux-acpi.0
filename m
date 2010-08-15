From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/20] ACPI: introduce drivers/acpi/sysfs.c
Date: Sun, 15 Aug 2010 01:23:18 -0400
Message-ID: <1c8fce27e275fd7c6b75bc6455745f02d3903ee6.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:57637 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab0HOFaQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:30:16 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600HN2HY5RHB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:30:16 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Introduce drivers/acpi/sysfs.c.

code for ACPI sysfs I/F, including
#ifdef ACPI_DEBUG
/sys/module/acpi/parameters/debug_layer
/sys/module/acpi/parameters/debug_level
/sys/module/acpi/parameters/trace_method_name
/sys/module/acpi/parameters/trace_debug_layer
/sys/module/acpi/parameters/trace_debug_level
/sys/module/acpi/parameters/trace_state
#endif
/sys/module/acpi/parameters/acpica_version
/sys/firmware/acpi/tables/
/sys/firmware/acpi/interrupts/
is moved to this file.

No function change in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile              |    1 +
 drivers/acpi/bus.c                 |    1 +
 drivers/acpi/debug.c               |  104 -----
 drivers/acpi/internal.h            |    1 +
 drivers/acpi/{system.c => sysfs.c} |  466 ++++++++++++----------
 drivers/acpi/system.c              |  807 ++++++++----------------------------
 6 files changed, 430 insertions(+), 950 deletions(-)
 rename drivers/acpi/{system.c => sysfs.c} (57%)
 rewrite drivers/acpi/system.c (72%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 7891904..03a81a8 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -38,6 +38,7 @@ acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 acpi-y				+= power.o
 acpi-y				+= system.o event.o
+acpi-y				+= sysfs.o
 acpi-$(CONFIG_ACPI_DEBUG)	+= debug.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 7136f24..bd9708b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1036,6 +1036,7 @@ static int __init acpi_init(void)
 	acpi_power_init();
 	acpi_system_init();
 	acpi_debug_init();
+	acpi_sysfs_init();
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index 22476ea..f82240d 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -94,110 +94,6 @@ static const struct acpi_dlevel acpi_debug_levels[] = {
 };
 
 /* --------------------------------------------------------------------------
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
-
-/* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_PROCFS
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 0650e34..eed8234 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -23,6 +23,7 @@
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
 int acpi_system_init(void);
+int acpi_sysfs_init(void);
 
 #ifdef CONFIG_ACPI_DEBUG
 int acpi_debug_init(void);
diff --git a/drivers/acpi/system.c b/drivers/acpi/sysfs.c
similarity index 57%
rename from drivers/acpi/system.c
rename to drivers/acpi/sysfs.c
index 5981bd0..68e2e45 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/sysfs.c
@@ -1,51 +1,218 @@
 /*
- *  acpi_system.c - ACPI System Driver ($Revision: 63 $)
- *
- *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
- *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or (at
- *  your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * sysfs.c - ACPI sysfs interface to userspace.
  */
 
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/string.h>
-#include <asm/uaccess.h>
-
+#include <linux/kernel.h>
+#include <linux/moduleparam.h>
 #include <acpi/acpi_drivers.h>
 
-#define PREFIX "ACPI: "
-
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("system");
-
-#define ACPI_SYSTEM_CLASS		"system"
-#define ACPI_SYSTEM_DEVICE_NAME		"System"
+ACPI_MODULE_NAME("sysfs");
 
-u32 acpi_irq_handled;
-u32 acpi_irq_not_handled;
+#define PREFIX "ACPI: "
 
+#ifdef CONFIG_ACPI_DEBUG
 /*
- * Make ACPICA version work as module param
+ * ACPI debug sysfs I/F, including:
+ * /sys/modules/acpi/parameters/debug_layer
+ * /sys/modules/acpi/parameters/debug_level
+ * /sys/modules/acpi/parameters/trace_method_name
+ * /sys/modules/acpi/parameters/trace_state
+ * /sys/modules/acpi/parameters/trace_debug_layer
+ * /sys/modules/acpi/parameters/trace_debug_level
  */
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
+static int param_get_debug_layer(char *buffer, struct kernel_param *kp)
+{
+	int result = 0;
+	int i;
+
+	result = sprintf(buffer, "%-25s\tHex        SET\n", "Description");
+
+	for (i = 0; i < ARRAY_SIZE(acpi_debug_layers); i++) {
+		result += sprintf(buffer + result, "%-25s\t0x%08lX [%c]\n",
+				  acpi_debug_layers[i].name,
+				  acpi_debug_layers[i].value,
+				  (acpi_dbg_layer & acpi_debug_layers[i].value)
+				  ? '*' : ' ');
+	}
+	result +=
+	    sprintf(buffer + result, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DRIVERS",
+		    ACPI_ALL_DRIVERS,
+		    (acpi_dbg_layer & ACPI_ALL_DRIVERS) ==
+		    ACPI_ALL_DRIVERS ? '*' : (acpi_dbg_layer & ACPI_ALL_DRIVERS)
+		    == 0 ? ' ' : '-');
+	result +=
+	    sprintf(buffer + result,
+		    "--\ndebug_layer = 0x%08X ( * = enabled)\n",
+		    acpi_dbg_layer);
+
+	return result;
+}
+
+static int param_get_debug_level(char *buffer, struct kernel_param *kp)
+{
+	int result = 0;
+	int i;
+
+	result = sprintf(buffer, "%-25s\tHex        SET\n", "Description");
+
+	for (i = 0; i < ARRAY_SIZE(acpi_debug_levels); i++) {
+		result += sprintf(buffer + result, "%-25s\t0x%08lX [%c]\n",
+				  acpi_debug_levels[i].name,
+				  acpi_debug_levels[i].value,
+				  (acpi_dbg_level & acpi_debug_levels[i].value)
+				  ? '*' : ' ');
+	}
+	result +=
+	    sprintf(buffer + result, "--\ndebug_level = 0x%08X (* = enabled)\n",
+		    acpi_dbg_level);
+
+	return result;
+}
+
+module_param_call(debug_layer, param_set_uint, param_get_debug_layer,
+		  &acpi_dbg_layer, 0644);
+module_param_call(debug_level, param_set_uint, param_get_debug_level,
+		  &acpi_dbg_level, 0644);
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
+#endif /* CONFIG_ACPI_DEBUG */
+
+/* /sys/module/acpi/parameters/acpica_version */
 static int param_get_acpica_version(char *buffer, struct kernel_param *kp)
 {
 	int result;
@@ -57,9 +224,12 @@ static int param_get_acpica_version(char *buffer, struct kernel_param *kp)
 
 module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, 0444);
 
-/* --------------------------------------------------------------------------
-                              FS Interface (/sys)
-   -------------------------------------------------------------------------- */
+/*
+ * ACPI table sysfs I/F:
+ * /sys/firmware/acpi/tables/
+ * /sys/firmware/acpi/tables/dynamic/
+ */
+
 static LIST_HEAD(acpi_table_attr_list);
 static struct kobject *tables_kobj;
 static struct kobject *dynamic_tables_kobj;
@@ -86,14 +256,12 @@ static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
 	else
 		memcpy(name, "\0\0\0\0", 4);
 
-	status =
-	    acpi_get_table(name, table_attr->instance,
-			   &table_header);
+	status = acpi_get_table(name, table_attr->instance, &table_header);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
 	return memory_read_from_buffer(buf, count, &offset,
-					table_header, table_header->length);
+				       table_header, table_header->length);
 }
 
 static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
@@ -105,7 +273,7 @@ static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
 	sysfs_attr_init(&table_attr->attr.attr);
 	if (table_header->signature[0] != '\0')
 		memcpy(table_attr->name, table_header->signature,
-			ACPI_NAME_SIZE);
+		       ACPI_NAME_SIZE);
 	else
 		memcpy(table_attr->name, "NULL", 4);
 
@@ -117,8 +285,8 @@ static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
 	table_attr->instance++;
 
 	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
-					!acpi_get_table
-					(table_header->signature, 2, &header)))
+					 !acpi_get_table
+					 (table_header->signature, 2, &header)))
 		sprintf(table_attr->name + ACPI_NAME_SIZE, "%d",
 			table_attr->instance);
 
@@ -138,18 +306,17 @@ acpi_sysfs_table_handler(u32 event, void *table, void *context)
 	switch (event) {
 	case ACPI_TABLE_EVENT_LOAD:
 		table_attr =
-			kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
+		    kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
 		if (!table_attr)
 			return AE_NO_MEMORY;
 
 		acpi_table_attr_init(table_attr, table);
 		if (sysfs_create_bin_file(dynamic_tables_kobj,
-					&table_attr->attr)) {
+					  &table_attr->attr)) {
 			kfree(table_attr);
 			return AE_ERROR;
 		} else
-			list_add_tail(&table_attr->node,
-					&acpi_table_attr_list);
+			list_add_tail(&table_attr->node, &acpi_table_attr_list);
 		break;
 	case ACPI_TABLE_EVENT_UNLOAD:
 		/*
@@ -164,7 +331,7 @@ acpi_sysfs_table_handler(u32 event, void *table, void *context)
 	return AE_OK;
 }
 
-static int acpi_system_sysfs_init(void)
+static int acpi_tables_sysfs_init(void)
 {
 	struct acpi_table_attr *table_attr;
 	struct acpi_table_header *table_header = NULL;
@@ -213,14 +380,17 @@ err:
 }
 
 /*
- * Detailed ACPI IRQ counters in /sys/firmware/acpi/interrupts/
- * See Documentation/ABI/testing/sysfs-firmware-acpi
+ * Detailed ACPI IRQ counters:
+ * /sys/firmware/acpi/interrupts/
  */
 
+u32 acpi_irq_handled;
+u32 acpi_irq_not_handled;
+
 #define COUNT_GPE 0
-#define COUNT_SCI 1	/* acpi_irq_handled */
-#define COUNT_SCI_NOT 2	/* acpi_irq_not_handled */
-#define COUNT_ERROR 3	/* other */
+#define COUNT_SCI 1		/* acpi_irq_handled */
+#define COUNT_SCI_NOT 2		/* acpi_irq_not_handled */
+#define COUNT_ERROR 3		/* other */
 #define NUM_COUNTERS_EXTRA 4
 
 struct event_counter {
@@ -237,6 +407,7 @@ static u32 acpi_gpe_count;
 static struct attribute_group interrupt_stats_attr_group = {
 	.name = "interrupts",
 };
+
 static struct kobj_attribute *counter_attrs;
 
 static void delete_gpe_attr_array(void)
@@ -269,8 +440,8 @@ void acpi_os_gpe_count(u32 gpe_number)
 	if (gpe_number < num_gpes)
 		all_counters[gpe_number].count++;
 	else
-		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR].
-					count++;
+		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
+			     COUNT_ERROR].count++;
 
 	return;
 }
@@ -283,13 +454,14 @@ void acpi_os_fixed_event_count(u32 event_number)
 	if (event_number < ACPI_NUM_FIXED_EVENTS)
 		all_counters[num_gpes + event_number].count++;
 	else
-		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR].
-				count++;
+		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
+			     COUNT_ERROR].count++;
 
 	return;
 }
 
-static int get_status(u32 index, acpi_event_status *status, acpi_handle *handle)
+static int get_status(u32 index, acpi_event_status *status,
+		      acpi_handle *handle)
 {
 	int result = 0;
 
@@ -300,7 +472,7 @@ static int get_status(u32 index, acpi_event_status *status, acpi_handle *handle)
 		result = acpi_get_gpe_device(index, handle);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
-				"Invalid GPE 0x%x\n", index));
+					"Invalid GPE 0x%x\n", index));
 			goto end;
 		}
 		result = acpi_get_gpe_status(*handle, index, status);
@@ -312,7 +484,7 @@ end:
 }
 
 static ssize_t counter_show(struct kobject *kobj,
-	struct kobj_attribute *attr, char *buf)
+			    struct kobj_attribute *attr, char *buf)
 {
 	int index = attr - counter_attrs;
 	int size;
@@ -321,12 +493,11 @@ static ssize_t counter_show(struct kobject *kobj,
 	int result = 0;
 
 	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI].count =
-		acpi_irq_handled;
+	    acpi_irq_handled;
 	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI_NOT].count =
-		acpi_irq_not_handled;
+	    acpi_irq_not_handled;
 	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
-		acpi_gpe_count;
-
+	    acpi_gpe_count;
 	size = sprintf(buf, "%8d", all_counters[index].count);
 
 	/* "gpe_all" or "sci" */
@@ -338,13 +509,13 @@ static ssize_t counter_show(struct kobject *kobj,
 		goto end;
 
 	if (!(status & ACPI_EVENT_FLAG_HANDLE))
-		size += sprintf(buf + size, "	invalid");
+		size += sprintf(buf + size, "   invalid");
 	else if (status & ACPI_EVENT_FLAG_ENABLED)
-		size += sprintf(buf + size, "	enabled");
+		size += sprintf(buf + size, "   enabled");
 	else if (status & ACPI_EVENT_FLAG_WAKE_ENABLED)
-		size += sprintf(buf + size, "	wake_enabled");
+		size += sprintf(buf + size, "   wake_enabled");
 	else
-		size += sprintf(buf + size, "	disabled");
+		size += sprintf(buf + size, "   disabled");
 
 end:
 	size += sprintf(buf + size, "\n");
@@ -357,7 +528,8 @@ end:
  * enable/disable/clear a gpe/fixed event in user space.
  */
 static ssize_t counter_set(struct kobject *kobj,
-	struct kobj_attribute *attr, const char *buf, size_t size)
+			   struct kobj_attribute *attr, const char *buf,
+			   size_t size)
 {
 	int index = attr - counter_attrs;
 	acpi_event_status status;
@@ -381,32 +553,32 @@ static ssize_t counter_set(struct kobject *kobj,
 
 	if (!(status & ACPI_EVENT_FLAG_HANDLE)) {
 		printk(KERN_WARNING PREFIX
-			"Can not change Invalid GPE/Fixed Event status\n");
+		       "Can not change Invalid GPE/Fixed Event status\n");
 		return -EINVAL;
 	}
 
 	if (index < num_gpes) {
 		if (!strcmp(buf, "disable\n") &&
-				(status & ACPI_EVENT_FLAG_ENABLED))
+		    (status & ACPI_EVENT_FLAG_ENABLED))
 			result = acpi_disable_gpe(handle, index);
 		else if (!strcmp(buf, "enable\n") &&
-				!(status & ACPI_EVENT_FLAG_ENABLED))
+			 !(status & ACPI_EVENT_FLAG_ENABLED))
 			result = acpi_enable_gpe(handle, index);
 		else if (!strcmp(buf, "clear\n") &&
-				(status & ACPI_EVENT_FLAG_SET))
+			 (status & ACPI_EVENT_FLAG_SET))
 			result = acpi_clear_gpe(handle, index);
 		else
 			all_counters[index].count = strtoul(buf, NULL, 0);
 	} else if (index < num_gpes + ACPI_NUM_FIXED_EVENTS) {
 		int event = index - num_gpes;
 		if (!strcmp(buf, "disable\n") &&
-				(status & ACPI_EVENT_FLAG_ENABLED))
+		    (status & ACPI_EVENT_FLAG_ENABLED))
 			result = acpi_disable_event(event, ACPI_NOT_ISR);
 		else if (!strcmp(buf, "enable\n") &&
-				!(status & ACPI_EVENT_FLAG_ENABLED))
+			 !(status & ACPI_EVENT_FLAG_ENABLED))
 			result = acpi_enable_event(event, ACPI_NOT_ISR);
 		else if (!strcmp(buf, "clear\n") &&
-				(status & ACPI_EVENT_FLAG_SET))
+			 (status & ACPI_EVENT_FLAG_SET))
 			result = acpi_clear_event(event);
 		else
 			all_counters[index].count = strtoul(buf, NULL, 0);
@@ -430,17 +602,17 @@ void acpi_irq_stats_init(void)
 	num_counters = num_gpes + ACPI_NUM_FIXED_EVENTS + NUM_COUNTERS_EXTRA;
 
 	all_attrs = kzalloc(sizeof(struct attribute *) * (num_counters + 1),
-			GFP_KERNEL);
+			    GFP_KERNEL);
 	if (all_attrs == NULL)
 		return;
 
 	all_counters = kzalloc(sizeof(struct event_counter) * (num_counters),
-				GFP_KERNEL);
+			       GFP_KERNEL);
 	if (all_counters == NULL)
 		goto fail;
 
 	counter_attrs = kzalloc(sizeof(struct kobj_attribute) * (num_counters),
-			GFP_KERNEL);
+				GFP_KERNEL);
 	if (counter_attrs == NULL)
 		goto fail;
 
@@ -503,135 +675,11 @@ static void __exit interrupt_stats_exit(void)
 	return;
 }
 
-/* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-#ifdef CONFIG_ACPI_PROCFS
-#define ACPI_SYSTEM_FILE_INFO		"info"
-#define ACPI_SYSTEM_FILE_EVENT		"event"
-#define ACPI_SYSTEM_FILE_DSDT		"dsdt"
-#define ACPI_SYSTEM_FILE_FADT		"fadt"
-
-static int acpi_system_read_info(struct seq_file *seq, void *offset)
-{
-
-	seq_printf(seq, "version:                 %x\n", ACPI_CA_VERSION);
-	return 0;
-}
-
-static int acpi_system_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_system_read_info, PDE(inode)->data);
-}
-
-static const struct file_operations acpi_system_info_ops = {
-	.owner = THIS_MODULE,
-	.open = acpi_system_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static ssize_t acpi_system_read_dsdt(struct file *, char __user *, size_t,
-				     loff_t *);
-
-static const struct file_operations acpi_system_dsdt_ops = {
-	.owner = THIS_MODULE,
-	.read = acpi_system_read_dsdt,
-};
-
-static ssize_t
-acpi_system_read_dsdt(struct file *file,
-		      char __user * buffer, size_t count, loff_t * ppos)
-{
-	acpi_status status = AE_OK;
-	struct acpi_table_header *dsdt = NULL;
-	ssize_t res;
-
-	status = acpi_get_table(ACPI_SIG_DSDT, 1, &dsdt);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	res = simple_read_from_buffer(buffer, count, ppos, dsdt, dsdt->length);
-
-	return res;
-}
-
-static ssize_t acpi_system_read_fadt(struct file *, char __user *, size_t,
-				     loff_t *);
-
-static const struct file_operations acpi_system_fadt_ops = {
-	.owner = THIS_MODULE,
-	.read = acpi_system_read_fadt,
-};
-
-static ssize_t
-acpi_system_read_fadt(struct file *file,
-		      char __user * buffer, size_t count, loff_t * ppos)
-{
-	acpi_status status = AE_OK;
-	struct acpi_table_header *fadt = NULL;
-	ssize_t res;
-
-	status = acpi_get_table(ACPI_SIG_FADT, 1, &fadt);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	res = simple_read_from_buffer(buffer, count, ppos, fadt, fadt->length);
-
-	return res;
-}
-
-static int acpi_system_procfs_init(void)
-{
-	struct proc_dir_entry *entry;
-	int error = 0;
-
-	/* 'info' [R] */
-	entry = proc_create(ACPI_SYSTEM_FILE_INFO, S_IRUGO, acpi_root_dir,
-			    &acpi_system_info_ops);
-	if (!entry)
-		goto Error;
-
-	/* 'dsdt' [R] */
-	entry = proc_create(ACPI_SYSTEM_FILE_DSDT, S_IRUSR, acpi_root_dir,
-			    &acpi_system_dsdt_ops);
-	if (!entry)
-		goto Error;
-
-	/* 'fadt' [R] */
-	entry = proc_create(ACPI_SYSTEM_FILE_FADT, S_IRUSR, acpi_root_dir,
-			    &acpi_system_fadt_ops);
-	if (!entry)
-		goto Error;
-
-      Done:
-	return error;
-
-      Error:
-	remove_proc_entry(ACPI_SYSTEM_FILE_FADT, acpi_root_dir);
-	remove_proc_entry(ACPI_SYSTEM_FILE_DSDT, acpi_root_dir);
-	remove_proc_entry(ACPI_SYSTEM_FILE_INFO, acpi_root_dir);
-
-	error = -EFAULT;
-	goto Done;
-}
-#else
-static int acpi_system_procfs_init(void)
-{
-	return 0;
-}
-#endif
-
-int __init acpi_system_init(void)
+int __init acpi_sysfs_init(void)
 {
 	int result;
 
-	result = acpi_system_procfs_init();
-	if (result)
-		return result;
-
-	result = acpi_system_sysfs_init();
+	result = acpi_tables_sysfs_init();
 
 	return result;
 }
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
dissimilarity index 72%
index 5981bd0..d70481f 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -1,637 +1,170 @@
-/*
- *  acpi_system.c - ACPI System Driver ($Revision: 63 $)
- *
- *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
- *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or (at
- *  your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- */
-
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/string.h>
-#include <asm/uaccess.h>
-
-#include <acpi/acpi_drivers.h>
-
-#define PREFIX "ACPI: "
-
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("system");
-
-#define ACPI_SYSTEM_CLASS		"system"
-#define ACPI_SYSTEM_DEVICE_NAME		"System"
-
-u32 acpi_irq_handled;
-u32 acpi_irq_not_handled;
-
-/*
- * Make ACPICA version work as module param
- */
-static int param_get_acpica_version(char *buffer, struct kernel_param *kp)
-{
-	int result;
-
-	result = sprintf(buffer, "%x", ACPI_CA_VERSION);
-
-	return result;
-}
-
-module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, 0444);
-
-/* --------------------------------------------------------------------------
-                              FS Interface (/sys)
-   -------------------------------------------------------------------------- */
-static LIST_HEAD(acpi_table_attr_list);
-static struct kobject *tables_kobj;
-static struct kobject *dynamic_tables_kobj;
-
-struct acpi_table_attr {
-	struct bin_attribute attr;
-	char name[8];
-	int instance;
-	struct list_head node;
-};
-
-static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr, char *buf,
-			       loff_t offset, size_t count)
-{
-	struct acpi_table_attr *table_attr =
-	    container_of(bin_attr, struct acpi_table_attr, attr);
-	struct acpi_table_header *table_header = NULL;
-	acpi_status status;
-	char name[ACPI_NAME_SIZE];
-
-	if (strncmp(table_attr->name, "NULL", 4))
-		memcpy(name, table_attr->name, ACPI_NAME_SIZE);
-	else
-		memcpy(name, "\0\0\0\0", 4);
-
-	status =
-	    acpi_get_table(name, table_attr->instance,
-			   &table_header);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	return memory_read_from_buffer(buf, count, &offset,
-					table_header, table_header->length);
-}
-
-static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
-				 struct acpi_table_header *table_header)
-{
-	struct acpi_table_header *header = NULL;
-	struct acpi_table_attr *attr = NULL;
-
-	sysfs_attr_init(&table_attr->attr.attr);
-	if (table_header->signature[0] != '\0')
-		memcpy(table_attr->name, table_header->signature,
-			ACPI_NAME_SIZE);
-	else
-		memcpy(table_attr->name, "NULL", 4);
-
-	list_for_each_entry(attr, &acpi_table_attr_list, node) {
-		if (!memcmp(table_attr->name, attr->name, ACPI_NAME_SIZE))
-			if (table_attr->instance < attr->instance)
-				table_attr->instance = attr->instance;
-	}
-	table_attr->instance++;
-
-	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
-					!acpi_get_table
-					(table_header->signature, 2, &header)))
-		sprintf(table_attr->name + ACPI_NAME_SIZE, "%d",
-			table_attr->instance);
-
-	table_attr->attr.size = 0;
-	table_attr->attr.read = acpi_table_show;
-	table_attr->attr.attr.name = table_attr->name;
-	table_attr->attr.attr.mode = 0400;
-
-	return;
-}
-
-static acpi_status
-acpi_sysfs_table_handler(u32 event, void *table, void *context)
-{
-	struct acpi_table_attr *table_attr;
-
-	switch (event) {
-	case ACPI_TABLE_EVENT_LOAD:
-		table_attr =
-			kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
-		if (!table_attr)
-			return AE_NO_MEMORY;
-
-		acpi_table_attr_init(table_attr, table);
-		if (sysfs_create_bin_file(dynamic_tables_kobj,
-					&table_attr->attr)) {
-			kfree(table_attr);
-			return AE_ERROR;
-		} else
-			list_add_tail(&table_attr->node,
-					&acpi_table_attr_list);
-		break;
-	case ACPI_TABLE_EVENT_UNLOAD:
-		/*
-		 * we do not need to do anything right now
-		 * because the table is not deleted from the
-		 * global table list when unloading it.
-		 */
-		break;
-	default:
-		return AE_BAD_PARAMETER;
-	}
-	return AE_OK;
-}
-
-static int acpi_system_sysfs_init(void)
-{
-	struct acpi_table_attr *table_attr;
-	struct acpi_table_header *table_header = NULL;
-	int table_index = 0;
-	int result;
-
-	tables_kobj = kobject_create_and_add("tables", acpi_kobj);
-	if (!tables_kobj)
-		goto err;
-
-	dynamic_tables_kobj = kobject_create_and_add("dynamic", tables_kobj);
-	if (!dynamic_tables_kobj)
-		goto err_dynamic_tables;
-
-	do {
-		result = acpi_get_table_by_index(table_index, &table_header);
-		if (!result) {
-			table_index++;
-			table_attr = NULL;
-			table_attr =
-			    kzalloc(sizeof(struct acpi_table_attr), GFP_KERNEL);
-			if (!table_attr)
-				return -ENOMEM;
-
-			acpi_table_attr_init(table_attr, table_header);
-			result =
-			    sysfs_create_bin_file(tables_kobj,
-						  &table_attr->attr);
-			if (result) {
-				kfree(table_attr);
-				return result;
-			} else
-				list_add_tail(&table_attr->node,
-					      &acpi_table_attr_list);
-		}
-	} while (!result);
-	kobject_uevent(tables_kobj, KOBJ_ADD);
-	kobject_uevent(dynamic_tables_kobj, KOBJ_ADD);
-	result = acpi_install_table_handler(acpi_sysfs_table_handler, NULL);
-
-	return result == AE_OK ? 0 : -EINVAL;
-err_dynamic_tables:
-	kobject_put(tables_kobj);
-err:
-	return -ENOMEM;
-}
-
-/*
- * Detailed ACPI IRQ counters in /sys/firmware/acpi/interrupts/
- * See Documentation/ABI/testing/sysfs-firmware-acpi
- */
-
-#define COUNT_GPE 0
-#define COUNT_SCI 1	/* acpi_irq_handled */
-#define COUNT_SCI_NOT 2	/* acpi_irq_not_handled */
-#define COUNT_ERROR 3	/* other */
-#define NUM_COUNTERS_EXTRA 4
-
-struct event_counter {
-	u32 count;
-	u32 flags;
-};
-
-static struct event_counter *all_counters;
-static u32 num_gpes;
-static u32 num_counters;
-static struct attribute **all_attrs;
-static u32 acpi_gpe_count;
-
-static struct attribute_group interrupt_stats_attr_group = {
-	.name = "interrupts",
-};
-static struct kobj_attribute *counter_attrs;
-
-static void delete_gpe_attr_array(void)
-{
-	struct event_counter *tmp = all_counters;
-
-	all_counters = NULL;
-	kfree(tmp);
-
-	if (counter_attrs) {
-		int i;
-
-		for (i = 0; i < num_gpes; i++)
-			kfree(counter_attrs[i].attr.name);
-
-		kfree(counter_attrs);
-	}
-	kfree(all_attrs);
-
-	return;
-}
-
-void acpi_os_gpe_count(u32 gpe_number)
-{
-	acpi_gpe_count++;
-
-	if (!all_counters)
-		return;
-
-	if (gpe_number < num_gpes)
-		all_counters[gpe_number].count++;
-	else
-		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR].
-					count++;
-
-	return;
-}
-
-void acpi_os_fixed_event_count(u32 event_number)
-{
-	if (!all_counters)
-		return;
-
-	if (event_number < ACPI_NUM_FIXED_EVENTS)
-		all_counters[num_gpes + event_number].count++;
-	else
-		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR].
-				count++;
-
-	return;
-}
-
-static int get_status(u32 index, acpi_event_status *status, acpi_handle *handle)
-{
-	int result = 0;
-
-	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
-		goto end;
-
-	if (index < num_gpes) {
-		result = acpi_get_gpe_device(index, handle);
-		if (result) {
-			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
-				"Invalid GPE 0x%x\n", index));
-			goto end;
-		}
-		result = acpi_get_gpe_status(*handle, index, status);
-	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
-		result = acpi_get_event_status(index - num_gpes, status);
-
-end:
-	return result;
-}
-
-static ssize_t counter_show(struct kobject *kobj,
-	struct kobj_attribute *attr, char *buf)
-{
-	int index = attr - counter_attrs;
-	int size;
-	acpi_handle handle;
-	acpi_event_status status;
-	int result = 0;
-
-	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI].count =
-		acpi_irq_handled;
-	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI_NOT].count =
-		acpi_irq_not_handled;
-	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
-		acpi_gpe_count;
-
-	size = sprintf(buf, "%8d", all_counters[index].count);
-
-	/* "gpe_all" or "sci" */
-	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
-		goto end;
-
-	result = get_status(index, &status, &handle);
-	if (result)
-		goto end;
-
-	if (!(status & ACPI_EVENT_FLAG_HANDLE))
-		size += sprintf(buf + size, "	invalid");
-	else if (status & ACPI_EVENT_FLAG_ENABLED)
-		size += sprintf(buf + size, "	enabled");
-	else if (status & ACPI_EVENT_FLAG_WAKE_ENABLED)
-		size += sprintf(buf + size, "	wake_enabled");
-	else
-		size += sprintf(buf + size, "	disabled");
-
-end:
-	size += sprintf(buf + size, "\n");
-	return result ? result : size;
-}
-
-/*
- * counter_set() sets the specified counter.
- * setting the total "sci" file to any value clears all counters.
- * enable/disable/clear a gpe/fixed event in user space.
- */
-static ssize_t counter_set(struct kobject *kobj,
-	struct kobj_attribute *attr, const char *buf, size_t size)
-{
-	int index = attr - counter_attrs;
-	acpi_event_status status;
-	acpi_handle handle;
-	int result = 0;
-
-	if (index == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI) {
-		int i;
-		for (i = 0; i < num_counters; ++i)
-			all_counters[i].count = 0;
-		acpi_gpe_count = 0;
-		acpi_irq_handled = 0;
-		acpi_irq_not_handled = 0;
-		goto end;
-	}
-
-	/* show the event status for both GPEs and Fixed Events */
-	result = get_status(index, &status, &handle);
-	if (result)
-		goto end;
-
-	if (!(status & ACPI_EVENT_FLAG_HANDLE)) {
-		printk(KERN_WARNING PREFIX
-			"Can not change Invalid GPE/Fixed Event status\n");
-		return -EINVAL;
-	}
-
-	if (index < num_gpes) {
-		if (!strcmp(buf, "disable\n") &&
-				(status & ACPI_EVENT_FLAG_ENABLED))
-			result = acpi_disable_gpe(handle, index);
-		else if (!strcmp(buf, "enable\n") &&
-				!(status & ACPI_EVENT_FLAG_ENABLED))
-			result = acpi_enable_gpe(handle, index);
-		else if (!strcmp(buf, "clear\n") &&
-				(status & ACPI_EVENT_FLAG_SET))
-			result = acpi_clear_gpe(handle, index);
-		else
-			all_counters[index].count = strtoul(buf, NULL, 0);
-	} else if (index < num_gpes + ACPI_NUM_FIXED_EVENTS) {
-		int event = index - num_gpes;
-		if (!strcmp(buf, "disable\n") &&
-				(status & ACPI_EVENT_FLAG_ENABLED))
-			result = acpi_disable_event(event, ACPI_NOT_ISR);
-		else if (!strcmp(buf, "enable\n") &&
-				!(status & ACPI_EVENT_FLAG_ENABLED))
-			result = acpi_enable_event(event, ACPI_NOT_ISR);
-		else if (!strcmp(buf, "clear\n") &&
-				(status & ACPI_EVENT_FLAG_SET))
-			result = acpi_clear_event(event);
-		else
-			all_counters[index].count = strtoul(buf, NULL, 0);
-	} else
-		all_counters[index].count = strtoul(buf, NULL, 0);
-
-	if (ACPI_FAILURE(result))
-		result = -EINVAL;
-end:
-	return result ? result : size;
-}
-
-void acpi_irq_stats_init(void)
-{
-	int i;
-
-	if (all_counters)
-		return;
-
-	num_gpes = acpi_current_gpe_count;
-	num_counters = num_gpes + ACPI_NUM_FIXED_EVENTS + NUM_COUNTERS_EXTRA;
-
-	all_attrs = kzalloc(sizeof(struct attribute *) * (num_counters + 1),
-			GFP_KERNEL);
-	if (all_attrs == NULL)
-		return;
-
-	all_counters = kzalloc(sizeof(struct event_counter) * (num_counters),
-				GFP_KERNEL);
-	if (all_counters == NULL)
-		goto fail;
-
-	counter_attrs = kzalloc(sizeof(struct kobj_attribute) * (num_counters),
-			GFP_KERNEL);
-	if (counter_attrs == NULL)
-		goto fail;
-
-	for (i = 0; i < num_counters; ++i) {
-		char buffer[12];
-		char *name;
-
-		if (i < num_gpes)
-			sprintf(buffer, "gpe%02X", i);
-		else if (i == num_gpes + ACPI_EVENT_PMTIMER)
-			sprintf(buffer, "ff_pmtimer");
-		else if (i == num_gpes + ACPI_EVENT_GLOBAL)
-			sprintf(buffer, "ff_gbl_lock");
-		else if (i == num_gpes + ACPI_EVENT_POWER_BUTTON)
-			sprintf(buffer, "ff_pwr_btn");
-		else if (i == num_gpes + ACPI_EVENT_SLEEP_BUTTON)
-			sprintf(buffer, "ff_slp_btn");
-		else if (i == num_gpes + ACPI_EVENT_RTC)
-			sprintf(buffer, "ff_rt_clk");
-		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE)
-			sprintf(buffer, "gpe_all");
-		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI)
-			sprintf(buffer, "sci");
-		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI_NOT)
-			sprintf(buffer, "sci_not");
-		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR)
-			sprintf(buffer, "error");
-		else
-			sprintf(buffer, "bug%02X", i);
-
-		name = kzalloc(strlen(buffer) + 1, GFP_KERNEL);
-		if (name == NULL)
-			goto fail;
-		strncpy(name, buffer, strlen(buffer) + 1);
-
-		sysfs_attr_init(&counter_attrs[i].attr);
-		counter_attrs[i].attr.name = name;
-		counter_attrs[i].attr.mode = 0644;
-		counter_attrs[i].show = counter_show;
-		counter_attrs[i].store = counter_set;
-
-		all_attrs[i] = &counter_attrs[i].attr;
-	}
-
-	interrupt_stats_attr_group.attrs = all_attrs;
-	if (!sysfs_create_group(acpi_kobj, &interrupt_stats_attr_group))
-		return;
-
-fail:
-	delete_gpe_attr_array();
-	return;
-}
-
-static void __exit interrupt_stats_exit(void)
-{
-	sysfs_remove_group(acpi_kobj, &interrupt_stats_attr_group);
-
-	delete_gpe_attr_array();
-
-	return;
-}
-
-/* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-#ifdef CONFIG_ACPI_PROCFS
-#define ACPI_SYSTEM_FILE_INFO		"info"
-#define ACPI_SYSTEM_FILE_EVENT		"event"
-#define ACPI_SYSTEM_FILE_DSDT		"dsdt"
-#define ACPI_SYSTEM_FILE_FADT		"fadt"
-
-static int acpi_system_read_info(struct seq_file *seq, void *offset)
-{
-
-	seq_printf(seq, "version:                 %x\n", ACPI_CA_VERSION);
-	return 0;
-}
-
-static int acpi_system_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_system_read_info, PDE(inode)->data);
-}
-
-static const struct file_operations acpi_system_info_ops = {
-	.owner = THIS_MODULE,
-	.open = acpi_system_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static ssize_t acpi_system_read_dsdt(struct file *, char __user *, size_t,
-				     loff_t *);
-
-static const struct file_operations acpi_system_dsdt_ops = {
-	.owner = THIS_MODULE,
-	.read = acpi_system_read_dsdt,
-};
-
-static ssize_t
-acpi_system_read_dsdt(struct file *file,
-		      char __user * buffer, size_t count, loff_t * ppos)
-{
-	acpi_status status = AE_OK;
-	struct acpi_table_header *dsdt = NULL;
-	ssize_t res;
-
-	status = acpi_get_table(ACPI_SIG_DSDT, 1, &dsdt);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	res = simple_read_from_buffer(buffer, count, ppos, dsdt, dsdt->length);
-
-	return res;
-}
-
-static ssize_t acpi_system_read_fadt(struct file *, char __user *, size_t,
-				     loff_t *);
-
-static const struct file_operations acpi_system_fadt_ops = {
-	.owner = THIS_MODULE,
-	.read = acpi_system_read_fadt,
-};
-
-static ssize_t
-acpi_system_read_fadt(struct file *file,
-		      char __user * buffer, size_t count, loff_t * ppos)
-{
-	acpi_status status = AE_OK;
-	struct acpi_table_header *fadt = NULL;
-	ssize_t res;
-
-	status = acpi_get_table(ACPI_SIG_FADT, 1, &fadt);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	res = simple_read_from_buffer(buffer, count, ppos, fadt, fadt->length);
-
-	return res;
-}
-
-static int acpi_system_procfs_init(void)
-{
-	struct proc_dir_entry *entry;
-	int error = 0;
-
-	/* 'info' [R] */
-	entry = proc_create(ACPI_SYSTEM_FILE_INFO, S_IRUGO, acpi_root_dir,
-			    &acpi_system_info_ops);
-	if (!entry)
-		goto Error;
-
-	/* 'dsdt' [R] */
-	entry = proc_create(ACPI_SYSTEM_FILE_DSDT, S_IRUSR, acpi_root_dir,
-			    &acpi_system_dsdt_ops);
-	if (!entry)
-		goto Error;
-
-	/* 'fadt' [R] */
-	entry = proc_create(ACPI_SYSTEM_FILE_FADT, S_IRUSR, acpi_root_dir,
-			    &acpi_system_fadt_ops);
-	if (!entry)
-		goto Error;
-
-      Done:
-	return error;
-
-      Error:
-	remove_proc_entry(ACPI_SYSTEM_FILE_FADT, acpi_root_dir);
-	remove_proc_entry(ACPI_SYSTEM_FILE_DSDT, acpi_root_dir);
-	remove_proc_entry(ACPI_SYSTEM_FILE_INFO, acpi_root_dir);
-
-	error = -EFAULT;
-	goto Done;
-}
-#else
-static int acpi_system_procfs_init(void)
-{
-	return 0;
-}
-#endif
-
-int __init acpi_system_init(void)
-{
-	int result;
-
-	result = acpi_system_procfs_init();
-	if (result)
-		return result;
-
-	result = acpi_system_sysfs_init();
-
-	return result;
-}
+/*
+ *  acpi_system.c - ACPI System Driver ($Revision: 63 $)
+ *
+ *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
+ *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <asm/uaccess.h>
+
+#include <acpi/acpi_drivers.h>
+
+#define PREFIX "ACPI: "
+
+#define _COMPONENT		ACPI_SYSTEM_COMPONENT
+ACPI_MODULE_NAME("system");
+
+#define ACPI_SYSTEM_CLASS		"system"
+#define ACPI_SYSTEM_DEVICE_NAME		"System"
+
+/* --------------------------------------------------------------------------
+                              FS Interface (/proc)
+   -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
+#define ACPI_SYSTEM_FILE_INFO		"info"
+#define ACPI_SYSTEM_FILE_EVENT		"event"
+#define ACPI_SYSTEM_FILE_DSDT		"dsdt"
+#define ACPI_SYSTEM_FILE_FADT		"fadt"
+
+static int acpi_system_read_info(struct seq_file *seq, void *offset)
+{
+
+	seq_printf(seq, "version:                 %x\n", ACPI_CA_VERSION);
+	return 0;
+}
+
+static int acpi_system_info_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpi_system_read_info, PDE(inode)->data);
+}
+
+static const struct file_operations acpi_system_info_ops = {
+	.owner = THIS_MODULE,
+	.open = acpi_system_info_open_fs,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static ssize_t acpi_system_read_dsdt(struct file *, char __user *, size_t,
+				     loff_t *);
+
+static const struct file_operations acpi_system_dsdt_ops = {
+	.owner = THIS_MODULE,
+	.read = acpi_system_read_dsdt,
+};
+
+static ssize_t
+acpi_system_read_dsdt(struct file *file,
+		      char __user * buffer, size_t count, loff_t * ppos)
+{
+	acpi_status status = AE_OK;
+	struct acpi_table_header *dsdt = NULL;
+	ssize_t res;
+
+	status = acpi_get_table(ACPI_SIG_DSDT, 1, &dsdt);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	res = simple_read_from_buffer(buffer, count, ppos, dsdt, dsdt->length);
+
+	return res;
+}
+
+static ssize_t acpi_system_read_fadt(struct file *, char __user *, size_t,
+				     loff_t *);
+
+static const struct file_operations acpi_system_fadt_ops = {
+	.owner = THIS_MODULE,
+	.read = acpi_system_read_fadt,
+};
+
+static ssize_t
+acpi_system_read_fadt(struct file *file,
+		      char __user * buffer, size_t count, loff_t * ppos)
+{
+	acpi_status status = AE_OK;
+	struct acpi_table_header *fadt = NULL;
+	ssize_t res;
+
+	status = acpi_get_table(ACPI_SIG_FADT, 1, &fadt);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	res = simple_read_from_buffer(buffer, count, ppos, fadt, fadt->length);
+
+	return res;
+}
+
+static int acpi_system_procfs_init(void)
+{
+	struct proc_dir_entry *entry;
+	int error = 0;
+
+	/* 'info' [R] */
+	entry = proc_create(ACPI_SYSTEM_FILE_INFO, S_IRUGO, acpi_root_dir,
+			    &acpi_system_info_ops);
+	if (!entry)
+		goto Error;
+
+	/* 'dsdt' [R] */
+	entry = proc_create(ACPI_SYSTEM_FILE_DSDT, S_IRUSR, acpi_root_dir,
+			    &acpi_system_dsdt_ops);
+	if (!entry)
+		goto Error;
+
+	/* 'fadt' [R] */
+	entry = proc_create(ACPI_SYSTEM_FILE_FADT, S_IRUSR, acpi_root_dir,
+			    &acpi_system_fadt_ops);
+	if (!entry)
+		goto Error;
+
+      Done:
+	return error;
+
+      Error:
+	remove_proc_entry(ACPI_SYSTEM_FILE_FADT, acpi_root_dir);
+	remove_proc_entry(ACPI_SYSTEM_FILE_DSDT, acpi_root_dir);
+	remove_proc_entry(ACPI_SYSTEM_FILE_INFO, acpi_root_dir);
+
+	error = -EFAULT;
+	goto Done;
+}
+#else
+static int acpi_system_procfs_init(void)
+{
+	return 0;
+}
+#endif
+
+int __init acpi_system_init(void)
+{
+	int result;
+
+	result = acpi_system_procfs_init();
+
+	return result;
+}
-- 
1.7.2.1.95.g3d045

