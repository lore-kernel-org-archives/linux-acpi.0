From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 5/7] ACPI / osi: Cleanup OSI handling code to use bool
Date: Tue,  3 May 2016 16:48:46 +0800
Message-ID: <c256aba425ef80d1c6ce4eb59fbcafadbde35ab9.1462263979.git.lv.zheng@intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com> <cover.1462263979.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38053 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500AbcECIsx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 May 2016 04:48:53 -0400
In-Reply-To: <cover.1462263979.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch changes "int/unsigned int" to "bool" to simplify the code.

Tested-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/blacklist.c |    4 ++--
 drivers/acpi/osl.c       |   36 +++++++++++++-----------------------
 include/linux/acpi.h     |    4 ++--
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 45390a9..d7d498a 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -135,12 +135,12 @@ int __init acpi_blacklisted(void)
 #ifdef CONFIG_DMI
 static int __init dmi_enable_osi_darwin(const struct dmi_system_id *d)
 {
-	acpi_dmi_osi_darwin(1, d);	/* enable */
+	acpi_dmi_osi_darwin(true, d);	/* enable */
 	return 0;
 }
 static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
 {
-	acpi_dmi_osi_linux(1, d);	/* enable */
+	acpi_dmi_osi_linux(true, d);	/* enable */
 	return 0;
 }
 static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5dd2a79..105f473 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1511,11 +1511,9 @@ void __init acpi_osi_setup(char *str)
 	}
 }
 
-static void __init set_osi_darwin(unsigned int enable)
+static void __init set_osi_darwin(bool enable)
 {
-	if (osi_config.darwin_enable != enable)
-		osi_config.darwin_enable = enable;
-
+	osi_config.darwin_enable = !!enable;
 	if (enable) {
 		acpi_osi_setup("!");
 		acpi_osi_setup("Darwin");
@@ -1525,7 +1523,7 @@ static void __init set_osi_darwin(unsigned int enable)
 	}
 }
 
-static void __init acpi_cmdline_osi_darwin(unsigned int enable)
+static void __init acpi_cmdline_osi_darwin(bool enable)
 {
 	/* cmdline set the default and override DMI */
 	osi_config.darwin_cmdline = 1;
@@ -1535,13 +1533,10 @@ static void __init acpi_cmdline_osi_darwin(unsigned int enable)
 	return;
 }
 
-void __init acpi_dmi_osi_darwin(int enable, const struct dmi_system_id *d)
+void __init acpi_dmi_osi_darwin(bool enable, const struct dmi_system_id *d)
 {
 	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
 
-	if (enable == -1)
-		return;
-
 	/* DMI knows that this box asks OSI(Darwin) */
 	osi_config.darwin_dmi = 1;
 	set_osi_darwin(enable);
@@ -1549,12 +1544,10 @@ void __init acpi_dmi_osi_darwin(int enable, const struct dmi_system_id *d)
 	return;
 }
 
-static void __init set_osi_linux(unsigned int enable)
+static void __init set_osi_linux(bool enable)
 {
-	if (osi_config.linux_enable != enable)
-		osi_config.linux_enable = enable;
-
-	if (osi_config.linux_enable)
+	osi_config.linux_enable = !!enable;
+	if (enable)
 		acpi_osi_setup("Linux");
 	else
 		acpi_osi_setup("!Linux");
@@ -1562,7 +1555,7 @@ static void __init set_osi_linux(unsigned int enable)
 	return;
 }
 
-static void __init acpi_cmdline_osi_linux(unsigned int enable)
+static void __init acpi_cmdline_osi_linux(bool enable)
 {
 	/* cmdline set the default and override DMI */
 	osi_config.linux_cmdline = 1;
@@ -1572,13 +1565,10 @@ static void __init acpi_cmdline_osi_linux(unsigned int enable)
 	return;
 }
 
-void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
+void __init acpi_dmi_osi_linux(bool enable, const struct dmi_system_id *d)
 {
 	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
 
-	if (enable == -1)
-		return;
-
 	/* DMI knows that this box asks OSI(Linux) */
 	osi_config.linux_dmi = 1;
 	set_osi_linux(enable);
@@ -1633,13 +1623,13 @@ static void __init acpi_osi_setup_late(void)
 static int __init osi_setup(char *str)
 {
 	if (str && !strcmp("Linux", str))
-		acpi_cmdline_osi_linux(1);
+		acpi_cmdline_osi_linux(true);
 	else if (str && !strcmp("!Linux", str))
-		acpi_cmdline_osi_linux(0);
+		acpi_cmdline_osi_linux(false);
 	else if (str && !strcmp("Darwin", str))
-		acpi_cmdline_osi_darwin(1);
+		acpi_cmdline_osi_darwin(true);
 	else if (str && !strcmp("!Darwin", str))
-		acpi_cmdline_osi_darwin(0);
+		acpi_cmdline_osi_darwin(false);
 	else
 		acpi_osi_setup(str);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8fd3a82..1455919 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -353,8 +353,8 @@ extern bool wmi_has_guid(const char *guid);
 extern char acpi_video_backlight_string[];
 extern long acpi_is_video_device(acpi_handle handle);
 extern int acpi_blacklisted(void);
-extern void acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d);
-extern void acpi_dmi_osi_darwin(int enable, const struct dmi_system_id *d);
+extern void acpi_dmi_osi_linux(bool enable, const struct dmi_system_id *d);
+extern void acpi_dmi_osi_darwin(bool enable, const struct dmi_system_id *d);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
-- 
1.7.10

