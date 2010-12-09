From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 1/2] acpi: fix _OSI string setup regression
Date: Thu, 09 Dec 2010 16:50:52 +0800
Message-ID: <1291884652.10384.46.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21081 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704Ab0LIIrH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 03:47:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>, Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

commit b0ed7a91(ACPICA/ACPI: Add new host interfaces for _OSI suppor)
introduced a regression that _OSI string setup fails.

There are 2 paths to setup _OSI string.

DMI:
acpi_dmi_osi_linux -> set_osi_linux -> acpi_osi_setup -> copy _OSI
string to osi_setup_string

Boot command line:
acpi_osi_setup -> copy _OSI string to osi_setup_string

Later, acpi_osi_setup_late will be called to handle osi_setup_string.
If _OSI string is "Linux" or "!Linux", then the call path is,

acpi_osi_setup_late -> acpi_cmdline_osi_linux -> set_osi_linux ->
acpi_osi_setup -> copy _OSI string to osi_setup_string

This actually never installs _OSI string(acpi_install_interface not
called), but just copy the _OSI string to osi_setup_string.

This patch fixes the regression.

Reported-and-tested-by: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/osl.c   |   59 ++++++++++++++++++++++++++++----------------------
 include/linux/acpi.h |    2 +-
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 966fedd..6867443 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -152,8 +152,7 @@ static struct osi_linux {
 	unsigned int	enable:1;
 	unsigned int	dmi:1;
 	unsigned int	cmdline:1;
-	unsigned int	known:1;
-} osi_linux = { 0, 0, 0, 0};
+} osi_linux = {0, 0, 0};
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 {
@@ -1055,13 +1054,22 @@ static int __init acpi_os_name_setup(char *str)
 
 __setup("acpi_os_name=", acpi_os_name_setup);
 
+void __init acpi_osi_setup(char *str)
+{
+	if (!acpi_gbl_create_osi_method)
+		return;
+
+	if (str == NULL || *str == '\0') {
+		printk(KERN_INFO PREFIX "_OSI method disabled\n");
+		acpi_gbl_create_osi_method = FALSE;
+	} else
+		strncpy(osi_setup_string, str, OSI_STRING_LENGTH_MAX);
+}
+
 static void __init set_osi_linux(unsigned int enable)
 {
-	if (osi_linux.enable != enable) {
+	if (osi_linux.enable != enable)
 		osi_linux.enable = enable;
-		printk(KERN_NOTICE PREFIX "%sed _OSI(Linux)\n",
-			enable ? "Add": "Delet");
-	}
 
 	if (osi_linux.enable)
 		acpi_osi_setup("Linux");
@@ -1073,7 +1081,8 @@ static void __init set_osi_linux(unsigned int enable)
 
 static void __init acpi_cmdline_osi_linux(unsigned int enable)
 {
-	osi_linux.cmdline = 1;	/* cmdline set the default */
+	osi_linux.cmdline = 1;	/* cmdline set the default and override DMI */
+	osi_linux.dmi = 0;
 	set_osi_linux(enable);
 
 	return;
@@ -1081,15 +1090,12 @@ static void __init acpi_cmdline_osi_linux(unsigned int enable)
 
 void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
 {
-	osi_linux.dmi = 1;	/* DMI knows that this box asks OSI(Linux) */
-
 	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
 
 	if (enable == -1)
 		return;
 
-	osi_linux.known = 1;	/* DMI knows which OSI(Linux) default needed */
-
+	osi_linux.dmi = 1;	/* DMI knows that this box asks OSI(Linux) */
 	set_osi_linux(enable);
 
 	return;
@@ -1105,36 +1111,37 @@ void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
 static void __init acpi_osi_setup_late(void)
 {
 	char *str = osi_setup_string;
+	acpi_status status;
 
 	if (*str == '\0')
 		return;
 
-	if (!strcmp("!Linux", str)) {
-		acpi_cmdline_osi_linux(0);	/* !enable */
-	} else if (*str == '!') {
-		if (acpi_remove_interface(++str) == AE_OK)
+	if (*str == '!') {
+		status = acpi_remove_interface(++str);
+
+		if (ACPI_SUCCESS(status))
 			printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
-	} else if (!strcmp("Linux", str)) {
-		acpi_cmdline_osi_linux(1);	/* enable */
 	} else {
-		if (acpi_install_interface(str) == AE_OK)
+		status = acpi_install_interface(str);
+
+		if (ACPI_SUCCESS(status))
 			printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
 	}
 }
 
-int __init acpi_osi_setup(char *str)
+static int __init osi_setup(char *str)
 {
-	if (str == NULL || *str == '\0') {
-		printk(KERN_INFO PREFIX "_OSI method disabled\n");
-		acpi_gbl_create_osi_method = FALSE;
-	} else {
-		strncpy(osi_setup_string, str, OSI_STRING_LENGTH_MAX);
-	}
+	if (str && !strcmp("Linux", str))
+		acpi_cmdline_osi_linux(1);
+	else if (str && !strcmp("!Linux", str))
+		acpi_cmdline_osi_linux(0);
+	else
+		acpi_osi_setup(str);
 
 	return 1;
 }
 
-__setup("acpi_osi=", acpi_osi_setup);
+__setup("acpi_osi=", osi_setup);
 
 /* enable serialization to combat AE_ALREADY_EXISTS errors */
 static int __init acpi_serialize_setup(char *str)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 050a7bc..67c91b4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -219,7 +219,7 @@ static inline int acpi_video_display_switch_support(void)
 
 extern int acpi_blacklisted(void);
 extern void acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d);
-extern int acpi_osi_setup(char *str);
+extern void acpi_osi_setup(char *str);
 
 #ifdef CONFIG_ACPI_NUMA
 int acpi_get_pxm(acpi_handle handle);
-- 
1.5.3



