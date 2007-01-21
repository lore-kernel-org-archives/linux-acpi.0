From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/3] [-mm]: ACPI: duplicate ACPI "debug" attribute in sysfs
Date: Sun, 21 Jan 2007 13:49:24 +0800
Message-ID: <1169358564.5691.5.camel@localhost.localdomain>
References: <1168083314.5619.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41425 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbXAUFsn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jan 2007 00:48:43 -0500
In-Reply-To: <1168083314.5619.36.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

From: Zhang Rui <rui.zhang@intel.com>

Add ACPI debug attributes in sysfs.
/proc/acpi/debug_layer && debug_level are deprecated by
/sys/module/acpi/parameters/debug_layer && debug_level.

NOTE: The operations to them are quite the same.
E.g. if you want to enable ACPI_DB_INFO, ACPI_DB_WARN, ACPI_DB_ERROR and disable the others,
#echo 0x13 >/sys/module/acpi/parameters/debug_level is OK,
and a boot option "acpi.debug_level = 0x13" also works.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig |    2 +
 drivers/acpi/debug.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 5 deletions(-)

Index: linux-2.6.20-rc4-mm1/drivers/acpi/debug.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/acpi/debug.c	2007-01-21 12:47:23.000000000 +0800
+++ linux-2.6.20-rc4-mm1/drivers/acpi/debug.c	2007-01-21 12:59:01.000000000 +0800
@@ -13,14 +13,11 @@
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("debug")
-#define ACPI_SYSTEM_FILE_DEBUG_LAYER	"debug_layer"
-#define ACPI_SYSTEM_FILE_DEBUG_LEVEL	"debug_level"
+
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
-#define MODULE_PARAM_PREFIX
-    module_param(acpi_dbg_layer, uint, 0400);
-module_param(acpi_dbg_level, uint, 0400);
+#define MODULE_PARAM_PREFIX "acpi."
 
 struct acpi_dlayer {
 	const char *name;
@@ -86,6 +83,60 @@ static const struct acpi_dlevel acpi_deb
 	ACPI_DEBUG_INIT(ACPI_LV_EVENTS),
 };
 
+/* --------------------------------------------------------------------------
+                              FS Interface (/sys)
+   -------------------------------------------------------------------------- */
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
+/* --------------------------------------------------------------------------
+                              FS Interface (/proc)
+   -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
+#define ACPI_SYSTEM_FILE_DEBUG_LAYER	"debug_layer"
+#define ACPI_SYSTEM_FILE_DEBUG_LEVEL		"debug_level"
+
 static int
 acpi_system_read_debug(char *page,
 		       char **start, off_t off, int count, int *eof, void *data)
@@ -221,3 +272,4 @@ static int __init acpi_debug_init(void)
 }
 
 subsys_initcall(acpi_debug_init);
+#endif
Index: linux-2.6.20-rc4-mm1/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.20-rc4-mm1.orig/drivers/acpi/Kconfig	2007-01-21 12:47:23.000000000 +0800
+++ linux-2.6.20-rc4-mm1/drivers/acpi/Kconfig	2007-01-21 12:58:31.000000000 +0800
@@ -86,6 +86,8 @@ config ACPI_PROCFS
 	  As the same functions are duplicated in sysfs interface
 	  and this proc interface will be removed some time later,
 	  it's marked as deprecated.
+	  ( /proc/acpi/debug_layer && debug_level are deprecated by
+	    /sys/module/acpi/parameters/debug_layer && debug_level. )
 
 config ACPI_AC
 	tristate "AC Adapter"
