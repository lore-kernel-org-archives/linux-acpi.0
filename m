From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 6/7] ACPI / osi: Cleanup coding style issues before creating a separate OSI source file
Date: Tue,  3 May 2016 16:48:53 +0800
Message-ID: <d6e84d7252ed603135854aa61e5730676795271e.1462263979.git.lv.zheng@intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com> <cover.1462263979.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32222 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755740AbcECIt1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 May 2016 04:49:27 -0400
In-Reply-To: <cover.1462263979.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch performs necessary cleanups before moving OSI support to
another file.
1. Change printk into pr_xxx
2. Do not initialize values to 0
3. Do not append additional "return" at the end of the function
4. Remove useless comments which may easily break line breaking rule
After fixing the coding style issues, rename functions to make them looking
like acpi_osi_xxx.
No functional changes.

Tested-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/blacklist.c |   10 +++---
 drivers/acpi/osl.c       |   76 +++++++++++++++++++---------------------------
 include/linux/acpi.h     |    4 +--
 3 files changed, 38 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index d7d498a..ba1601d 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -135,17 +135,17 @@ int __init acpi_blacklisted(void)
 #ifdef CONFIG_DMI
 static int __init dmi_enable_osi_darwin(const struct dmi_system_id *d)
 {
-	acpi_dmi_osi_darwin(true, d);	/* enable */
+	acpi_osi_dmi_darwin(true, d);
 	return 0;
 }
 static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
 {
-	acpi_dmi_osi_linux(true, d);	/* enable */
+	acpi_osi_dmi_linux(true, d);
 	return 0;
 }
 static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
 {
-	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
+	pr_notice(PREFIX "DMI detected: %s\n", d->ident);
 	acpi_osi_setup("!Windows 2006");
 	acpi_osi_setup("!Windows 2006 SP1");
 	acpi_osi_setup("!Windows 2006 SP2");
@@ -153,13 +153,13 @@ static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
 }
 static int __init dmi_disable_osi_win7(const struct dmi_system_id *d)
 {
-	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
+	pr_notice(PREFIX "DMI detected: %s\n", d->ident);
 	acpi_osi_setup("!Windows 2009");
 	return 0;
 }
 static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
 {
-	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
+	pr_notice(PREFIX "DMI detected: %s\n", d->ident);
 	acpi_osi_setup("!Windows 2012");
 	return 0;
 }
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 105f473..9b45f5c 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -139,13 +139,13 @@ static struct acpi_osi_config {
 	unsigned int	darwin_dmi:1;
 	unsigned int	darwin_cmdline:1;
 	u8		default_disabling;
-} osi_config = {0, 0, 0, 0};
+} osi_config;
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 {
 	if (!strcmp("Linux", interface)) {
 
-		printk_once(KERN_NOTICE FW_BUG PREFIX
+		pr_notice_once(FW_BUG PREFIX
 			"BIOS _OSI(Linux) query %s%s\n",
 			osi_config.linux_enable ? "honored" : "ignored",
 			osi_config.linux_cmdline ? " via cmdline" :
@@ -154,7 +154,7 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 
 	if (!strcmp("Darwin", interface)) {
 
-		printk_once(KERN_NOTICE PREFIX
+		pr_notice_once(PREFIX
 			"BIOS _OSI(Darwin) query %s%s\n",
 			osi_config.darwin_enable ? "honored" : "ignored",
 			osi_config.darwin_cmdline ? " via cmdline" :
@@ -1445,15 +1445,15 @@ static int __init acpi_os_name_setup(char *str)
 
 __setup("acpi_os_name=", acpi_os_name_setup);
 
-#define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
-#define	OSI_STRING_ENTRIES_MAX 16	/* arbitrary */
+#define	OSI_STRING_LENGTH_MAX 64
+#define	OSI_STRING_ENTRIES_MAX 16
 
-struct osi_setup_entry {
+struct acpi_osi_entry {
 	char string[OSI_STRING_LENGTH_MAX];
 	bool enable;
 };
 
-static struct osi_setup_entry
+static struct acpi_osi_entry
 		osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Module Device", true},
 	{"Processor Device", true},
@@ -1463,7 +1463,7 @@ static struct osi_setup_entry
 
 void __init acpi_osi_setup(char *str)
 {
-	struct osi_setup_entry *osi;
+	struct acpi_osi_entry *osi;
 	bool enable = true;
 	int i;
 
@@ -1471,7 +1471,7 @@ void __init acpi_osi_setup(char *str)
 		return;
 
 	if (str == NULL || *str == '\0') {
-		printk(KERN_INFO PREFIX "_OSI method disabled\n");
+		pr_info(PREFIX "_OSI method disabled\n");
 		acpi_gbl_create_osi_method = FALSE;
 		return;
 	}
@@ -1511,7 +1511,7 @@ void __init acpi_osi_setup(char *str)
 	}
 }
 
-static void __init set_osi_darwin(bool enable)
+static void __init __acpi_osi_setup_darwin(bool enable)
 {
 	osi_config.darwin_enable = !!enable;
 	if (enable) {
@@ -1523,57 +1523,43 @@ static void __init set_osi_darwin(bool enable)
 	}
 }
 
-static void __init acpi_cmdline_osi_darwin(bool enable)
+static void __init acpi_osi_setup_darwin(bool enable)
 {
-	/* cmdline set the default and override DMI */
 	osi_config.darwin_cmdline = 1;
 	osi_config.darwin_dmi = 0;
-	set_osi_darwin(enable);
-
-	return;
+	__acpi_osi_setup_darwin(enable);
 }
 
-void __init acpi_dmi_osi_darwin(bool enable, const struct dmi_system_id *d)
+void __init acpi_osi_dmi_darwin(bool enable, const struct dmi_system_id *d)
 {
-	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
-
-	/* DMI knows that this box asks OSI(Darwin) */
+	pr_notice(PREFIX "DMI detected to setup _OSI(\"Darwin\"): %s\n",
+		  d->ident);
 	osi_config.darwin_dmi = 1;
-	set_osi_darwin(enable);
-
-	return;
+	__acpi_osi_setup_darwin(enable);
 }
 
-static void __init set_osi_linux(bool enable)
+static void __init __acpi_osi_setup_linux(bool enable)
 {
 	osi_config.linux_enable = !!enable;
 	if (enable)
 		acpi_osi_setup("Linux");
 	else
 		acpi_osi_setup("!Linux");
-
-	return;
 }
 
-static void __init acpi_cmdline_osi_linux(bool enable)
+static void __init acpi_osi_setup_linux(bool enable)
 {
-	/* cmdline set the default and override DMI */
 	osi_config.linux_cmdline = 1;
 	osi_config.linux_dmi = 0;
-	set_osi_linux(enable);
-
-	return;
+	__acpi_osi_setup_linux(enable);
 }
 
-void __init acpi_dmi_osi_linux(bool enable, const struct dmi_system_id *d)
+void __init acpi_osi_dmi_linux(bool enable, const struct dmi_system_id *d)
 {
-	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
-
-	/* DMI knows that this box asks OSI(Linux) */
+	pr_notice(PREFIX "DMI detected to setup _OSI(\"Linux\"): %s\n",
+		  d->ident);
 	osi_config.linux_dmi = 1;
-	set_osi_linux(enable);
-
-	return;
+	__acpi_osi_setup_linux(enable);
 }
 
 /*
@@ -1585,7 +1571,7 @@ void __init acpi_dmi_osi_linux(bool enable, const struct dmi_system_id *d)
  */
 static void __init acpi_osi_setup_late(void)
 {
-	struct osi_setup_entry *osi;
+	struct acpi_osi_entry *osi;
 	char *str;
 	int i;
 	acpi_status status;
@@ -1594,7 +1580,7 @@ static void __init acpi_osi_setup_late(void)
 		status = acpi_update_interfaces(osi_config.default_disabling);
 
 		if (ACPI_SUCCESS(status))
-			printk(KERN_INFO PREFIX "Disabled all _OSI OS vendors%s\n",
+			pr_info(PREFIX "Disabled all _OSI OS vendors%s\n",
 				osi_config.default_disabling ==
 				ACPI_DISABLE_ALL_STRINGS ?
 				" and feature groups" : "");
@@ -1610,12 +1596,12 @@ static void __init acpi_osi_setup_late(void)
 			status = acpi_install_interface(str);
 
 			if (ACPI_SUCCESS(status))
-				printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
+				pr_info(PREFIX "Added _OSI(%s)\n", str);
 		} else {
 			status = acpi_remove_interface(str);
 
 			if (ACPI_SUCCESS(status))
-				printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
+				pr_info(PREFIX "Deleted _OSI(%s)\n", str);
 		}
 	}
 }
@@ -1623,13 +1609,13 @@ static void __init acpi_osi_setup_late(void)
 static int __init osi_setup(char *str)
 {
 	if (str && !strcmp("Linux", str))
-		acpi_cmdline_osi_linux(true);
+		acpi_osi_setup_linux(true);
 	else if (str && !strcmp("!Linux", str))
-		acpi_cmdline_osi_linux(false);
+		acpi_osi_setup_linux(false);
 	else if (str && !strcmp("Darwin", str))
-		acpi_cmdline_osi_darwin(true);
+		acpi_osi_setup_darwin(true);
 	else if (str && !strcmp("!Darwin", str))
-		acpi_cmdline_osi_darwin(false);
+		acpi_osi_setup_darwin(false);
 	else
 		acpi_osi_setup(str);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1455919..f0137bf 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -353,8 +353,8 @@ extern bool wmi_has_guid(const char *guid);
 extern char acpi_video_backlight_string[];
 extern long acpi_is_video_device(acpi_handle handle);
 extern int acpi_blacklisted(void);
-extern void acpi_dmi_osi_linux(bool enable, const struct dmi_system_id *d);
-extern void acpi_dmi_osi_darwin(bool enable, const struct dmi_system_id *d);
+extern void acpi_osi_dmi_linux(bool enable, const struct dmi_system_id *d);
+extern void acpi_osi_dmi_darwin(bool enable, const struct dmi_system_id *d);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
-- 
1.7.10

