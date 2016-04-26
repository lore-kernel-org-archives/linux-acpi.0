From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/4] ACPI / osi: Cleanup _OSI("Linux") related code before introducing new support
Date: Tue, 26 Apr 2016 15:40:13 +0800
Message-ID: <413d8029309310091c6506773d602ed5a2adfdab.1461656216.git.lv.zheng@intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461656216.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch cleans up OSI code in osl.c in order to make osi_linux not
_OSI("Linux") specific to allow new features to reuse this structure.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/blacklist.c |    2 +-
 drivers/acpi/osl.c       |   83 +++++++++++++++++++---------------------------
 include/linux/acpi.h     |    2 +-
 3 files changed, 36 insertions(+), 51 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 96809cd..675a941 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -135,7 +135,7 @@ int __init acpi_blacklisted(void)
 #ifdef CONFIG_DMI
 static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
 {
-	acpi_dmi_osi_linux(1, d);	/* enable */
+	acpi_dmi_osi_linux(true, d);	/* enable */
 	return 0;
 }
 static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index d7d84a8..df1101e 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -131,24 +131,22 @@ static void __init acpi_osi_setup_late(void);
  * or boot with "acpi_osi=Linux"
  */
 
-static struct osi_linux {
-	unsigned int	enable:1;
-	unsigned int	dmi:1;
-	unsigned int	cmdline:1;
+static struct acpi_osi_config {
 	u8		default_disabling;
-} osi_linux = {0, 0, 0, 0};
+	unsigned int	linux_enable:1;
+	unsigned int	linux_dmi:1;
+	unsigned int	linux_cmdline:1;
+} osi_config;
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 {
 	if (!strcmp("Linux", interface)) {
-
-		printk_once(KERN_NOTICE FW_BUG PREFIX
+		pr_notice_once(FW_BUG
 			"BIOS _OSI(Linux) query %s%s\n",
-			osi_linux.enable ? "honored" : "ignored",
-			osi_linux.cmdline ? " via cmdline" :
-			osi_linux.dmi ? " via DMI" : "");
+			osi_config.linux_enable ? "honored" : "ignored",
+			osi_config.linux_cmdline ? " via cmdline" :
+			osi_config.linux_dmi ? " via DMI" : "");
 	}
-
 	if (!strcmp("Darwin", interface)) {
 		/*
 		 * Apple firmware will behave poorly if it receives positive
@@ -264,8 +262,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 		else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
 			return efi.acpi;
 		else {
-			printk(KERN_ERR PREFIX
-			       "System description tables not found\n");
+			pr_err("System description tables not found\n");
 			return 0;
 		}
 	} else if (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
@@ -1469,7 +1466,7 @@ void __init acpi_osi_setup(char *str)
 		return;
 
 	if (str == NULL || *str == '\0') {
-		printk(KERN_INFO PREFIX "_OSI method disabled\n");
+		pr_info("_OSI method disabled\n");
 		acpi_gbl_create_osi_method = FALSE;
 		return;
 	}
@@ -1478,12 +1475,12 @@ void __init acpi_osi_setup(char *str)
 		str++;
 		if (*str == '\0') {
 			/* Do not override acpi_osi=!* */
-			if (!osi_linux.default_disabling)
-				osi_linux.default_disabling =
+			if (!osi_config.default_disabling)
+				osi_config.default_disabling =
 					ACPI_DISABLE_ALL_VENDOR_STRINGS;
 			return;
 		} else if (*str == '*') {
-			osi_linux.default_disabling = ACPI_DISABLE_ALL_STRINGS;
+			osi_config.default_disabling = ACPI_DISABLE_ALL_STRINGS;
 			for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
 				osi = &osi_setup_entries[i];
 				osi->enable = false;
@@ -1506,39 +1503,28 @@ void __init acpi_osi_setup(char *str)
 	}
 }
 
-static void __init set_osi_linux(unsigned int enable)
+static void __init __acpi_osi_setup_linux(bool enable)
 {
-	if (osi_linux.enable != enable)
-		osi_linux.enable = enable;
-
-	if (osi_linux.enable)
+	osi_config.linux_enable = !!enable;
+	if (enable)
 		acpi_osi_setup("Linux");
 	else
 		acpi_osi_setup("!Linux");
-
-	return;
 }
 
-static void __init acpi_cmdline_osi_linux(unsigned int enable)
+static void __init acpi_osi_setup_linux(bool enable)
 {
-	osi_linux.cmdline = 1;	/* cmdline set the default and override DMI */
-	osi_linux.dmi = 0;
-	set_osi_linux(enable);
-
-	return;
+	osi_config.linux_cmdline = 1;
+	/* Override acpi_blacklisted() */
+	osi_config.linux_dmi = 0;
+	__acpi_osi_setup_linux(enable);
 }
 
-void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
+void __init acpi_dmi_osi_linux(bool enable, const struct dmi_system_id *d)
 {
-	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
-
-	if (enable == -1)
-		return;
-
-	osi_linux.dmi = 1;	/* DMI knows that this box asks OSI(Linux) */
-	set_osi_linux(enable);
-
-	return;
+	pr_notice("DMI detected to setup _OSI(\"Linux\"): %s\n", d->ident);
+	osi_config.linux_dmi = 1;
+	__acpi_osi_setup_linux(enable);
 }
 
 /*
@@ -1555,12 +1541,11 @@ static void __init acpi_osi_setup_late(void)
 	int i;
 	acpi_status status;
 
-	if (osi_linux.default_disabling) {
-		status = acpi_update_interfaces(osi_linux.default_disabling);
-
+	if (osi_config.default_disabling) {
+		status = acpi_update_interfaces(osi_config.default_disabling);
 		if (ACPI_SUCCESS(status))
-			printk(KERN_INFO PREFIX "Disabled all _OSI OS vendors%s\n",
-				osi_linux.default_disabling ==
+			pr_info("Disabled all _OSI OS vendors%s\n",
+				osi_config.default_disabling ==
 				ACPI_DISABLE_ALL_STRINGS ?
 				" and feature groups" : "");
 	}
@@ -1575,12 +1560,12 @@ static void __init acpi_osi_setup_late(void)
 			status = acpi_install_interface(str);
 
 			if (ACPI_SUCCESS(status))
-				printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
+				pr_info("Added _OSI(%s)\n", str);
 		} else {
 			status = acpi_remove_interface(str);
 
 			if (ACPI_SUCCESS(status))
-				printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
+				pr_info("Deleted _OSI(%s)\n", str);
 		}
 	}
 }
@@ -1588,9 +1573,9 @@ static void __init acpi_osi_setup_late(void)
 static int __init osi_setup(char *str)
 {
 	if (str && !strcmp("Linux", str))
-		acpi_cmdline_osi_linux(1);
+		acpi_osi_setup_linux(true);
 	else if (str && !strcmp("!Linux", str))
-		acpi_cmdline_osi_linux(0);
+		acpi_osi_setup_linux(false);
 	else
 		acpi_osi_setup(str);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index be5d206..fceea1e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -353,7 +353,7 @@ extern bool wmi_has_guid(const char *guid);
 extern char acpi_video_backlight_string[];
 extern long acpi_is_video_device(acpi_handle handle);
 extern int acpi_blacklisted(void);
-extern void acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d);
+extern void acpi_dmi_osi_linux(bool enable, const struct dmi_system_id *d);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
-- 
1.7.10
