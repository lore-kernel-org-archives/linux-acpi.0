From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/140] ACPI: add ACPI debug attribute in sysfs
Date: Wed,  7 Feb 2007 13:50:42 -0500
Message-ID: <1170874412494-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:46195 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422737AbXBGSxf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:35 -0500
In-Reply-To: <11708744101300-git-send-email-lenb@kernel.org>
Message-Id: <219c3c8e268b9307eae9fae4c765a0c589b98338.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Add ACPI debug attributes in sysfs.
/proc/acpi/debug_layer && debug_level are deprecated by
/sys/module/acpi/parameters/debug_layer && debug_level.

NOTE: The operations to them are quite the same.
E.g. if you want to enable ACPI_DB_INFO, ACPI_DB_WARN,
 ACPI_DB_ERROR and disable the others,
#echo 0x13 >/sys/module/acpi/parameters/debug_level is OK,
and a boot option "acpi.debug_level = 0x13" also works.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |    2 +
 drivers/acpi/debug.c |   62 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1f82ceb..a3a1073 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -86,6 +86,8 @@ config ACPI_PROCFS
 	  As the same functions are duplicated in sysfs interface
 	  and this proc interface will be removed some time later,
 	  it's marked as deprecated.
+	  ( /proc/acpi/debug_layer && debug_level are deprecated by
+	    /sys/module/acpi/parameters/debug_layer && debug_level. )
 
 config ACPI_AC
 	tristate "AC Adapter"
diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index 35c6af8..d48f65a 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
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
@@ -86,6 +83,60 @@ static const struct acpi_dlevel acpi_debug_levels[] = {
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
-- 
1.5.0.rc3.39.gec804
