From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/6] ACPI / osi: Cleanup _OSI("Linux") related code before introducing new support
Date: Wed, 27 Apr 2016 16:54:30 +0800
Message-ID: <da78d2f1c482bc239e48912df30cb22621b91efa.1461736123.git.lv.zheng@intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com> <cover.1461736123.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461736123.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch cleans up OSI code in osl.c to make osi_linux work for OSI
strings other than "Linux", so it can be re-used for other purposes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/osl.c |   42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index d7d84a8..cd9667f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -131,12 +131,12 @@ static void __init acpi_osi_setup_late(void);
  * or boot with "acpi_osi=Linux"
  */
 
-static struct osi_linux {
-	unsigned int	enable:1;
-	unsigned int	dmi:1;
-	unsigned int	cmdline:1;
+static struct acpi_osi_config {
+	unsigned int	linux_enable:1;
+	unsigned int	linux_dmi:1;
+	unsigned int	linux_cmdline:1;
 	u8		default_disabling;
-} osi_linux = {0, 0, 0, 0};
+} osi_config = {0, 0, 0, 0};
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 {
@@ -144,9 +144,9 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 
 		printk_once(KERN_NOTICE FW_BUG PREFIX
 			"BIOS _OSI(Linux) query %s%s\n",
-			osi_linux.enable ? "honored" : "ignored",
-			osi_linux.cmdline ? " via cmdline" :
-			osi_linux.dmi ? " via DMI" : "");
+			osi_config.linux_enable ? "honored" : "ignored",
+			osi_config.linux_cmdline ? " via cmdline" :
+			osi_config.linux_dmi ? " via DMI" : "");
 	}
 
 	if (!strcmp("Darwin", interface)) {
@@ -1478,12 +1478,12 @@ void __init acpi_osi_setup(char *str)
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
@@ -1508,10 +1508,10 @@ void __init acpi_osi_setup(char *str)
 
 static void __init set_osi_linux(unsigned int enable)
 {
-	if (osi_linux.enable != enable)
-		osi_linux.enable = enable;
+	if (osi_config.linux_enable != enable)
+		osi_config.linux_enable = enable;
 
-	if (osi_linux.enable)
+	if (osi_config.linux_enable)
 		acpi_osi_setup("Linux");
 	else
 		acpi_osi_setup("!Linux");
@@ -1521,8 +1521,9 @@ static void __init set_osi_linux(unsigned int enable)
 
 static void __init acpi_cmdline_osi_linux(unsigned int enable)
 {
-	osi_linux.cmdline = 1;	/* cmdline set the default and override DMI */
-	osi_linux.dmi = 0;
+	/* cmdline set the default and override DMI */
+	osi_config.linux_cmdline = 1;
+	osi_config.linux_dmi = 0;
 	set_osi_linux(enable);
 
 	return;
@@ -1535,7 +1536,8 @@ void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
 	if (enable == -1)
 		return;
 
-	osi_linux.dmi = 1;	/* DMI knows that this box asks OSI(Linux) */
+	/* DMI knows that this box asks OSI(Linux) */
+	osi_config.linux_dmi = 1;
 	set_osi_linux(enable);
 
 	return;
@@ -1555,12 +1557,12 @@ static void __init acpi_osi_setup_late(void)
 	int i;
 	acpi_status status;
 
-	if (osi_linux.default_disabling) {
-		status = acpi_update_interfaces(osi_linux.default_disabling);
+	if (osi_config.default_disabling) {
+		status = acpi_update_interfaces(osi_config.default_disabling);
 
 		if (ACPI_SUCCESS(status))
 			printk(KERN_INFO PREFIX "Disabled all _OSI OS vendors%s\n",
-				osi_linux.default_disabling ==
+				osi_config.default_disabling ==
 				ACPI_DISABLE_ALL_STRINGS ?
 				" and feature groups" : "");
 	}
-- 
1.7.10
