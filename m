From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/15] acpi: fix _OSI string setup regression
Date: Sat, 11 Dec 2010 02:06:31 -0500
Message-ID: <d90aa92c0c1625d7f02050e4d2924805840cda3d.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:61801 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab0LKHHC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:07:02 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900MWV53O19J0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:07:01 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.3.3.480.g2f76a

