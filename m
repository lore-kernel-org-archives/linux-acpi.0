From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/5] ACPI: OSI(Linux) cmdline and DMI BIOS workarounds
Date: Thu, 17 Jan 2008 05:24:49 -0500
Message-ID: <42fa52ccafcaee9d6ee480c4c81ab2896b031158.1200565331.git.len.brown@intel.com>
References: <1200565490-29619-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:4525 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754548AbYAQKZB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 05:25:01 -0500
In-Reply-To: <1200565490-29619-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Allow "acpi_osi=Linux" and "acpi_osi=!Linux" cmdline to override DMI.

If DMI for the system known already, don't ask for it again.

If DMI known, but proper default not known, request just test results.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |  136 +++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 114 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3c767e7..5204731 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,7 +77,37 @@ static struct workqueue_struct *kacpi_notify_wq;
 #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
 static char osi_additional_string[OSI_STRING_LENGTH_MAX];
 
-static int osi_linux;		/* disable _OSI(Linux) by default */
+/*
+ * osi_linux -- Control response to BIOS _OSI(Linux) query.
+ *
+ * The OS Interface string "Linux" is ill-defined,
+ * as it specifies no particuar feature, and the
+ * features of Linux evolve from release to release.
+ *
+ * It was an error when Linux-2.6.22 and earlier
+ * responded "yes" to a BIOS _OSI(Linux) query.
+ * A reference BIOS started using it and opened Pandora's box:
+ *
+ * OSI(Linux) may:
+ * 1. help
+ * 2. hurt
+ * 3. be a NOP
+ * and only DMI can tell which is which...
+ *
+ * Today, there seems to be more exposure for "hurt" and "NOP"
+ * than "help".  So starting with Linux-2.6.23, OSI(Linux)
+ * is disablbed by default.  #define OSI_LINUX_ENABLE 1 to enable it.
+ *
+ * BIOS writers are asked to NOT query _OSI(Linux) going forward.
+ */
+#define OSI_LINUX_ENABLE 0
+
+struct osi_linux {
+	unsigned int	enable:1;
+	unsigned int	dmi:1;
+	unsigned int	cmdline:1;
+	unsigned int	known:1;
+} osi_linux = { OSI_LINUX_ENABLE, 0, 0, 0};
 
 #ifdef CONFIG_DMI
 static struct __initdata dmi_system_id acpi_osl_dmi_table[];
@@ -964,13 +994,39 @@ static int __init acpi_os_name_setup(char *str)
 
 __setup("acpi_os_name=", acpi_os_name_setup);
 
-static void enable_osi_linux(int enable) {
+static void set_osi_linux(unsigned int enable)
+{
+	if (osi_linux.enable != enable) {
+		osi_linux.enable = enable;
+		printk(KERN_INFO PREFIX "%sed _OSI(Linux)\n",
+			enable ? "Add": "Delet");
+	}
+	return;
+}
 
-	if (osi_linux != enable)
-		printk(KERN_INFO PREFIX "%sabled _OSI(Linux)\n",
-			enable ? "En": "Dis");
+static void cmdline_osi_linux(unsigned int enable)
+{
+	osi_linux.cmdline = 1;	/* cmdline set the default */
+	set_osi_linux(enable);
+
+	return;
+}
+
+static void dmi_osi_linux(int enable, const struct dmi_system_id *d)
+{
+	osi_linux.dmi = 1;	/* DMI knows that this box asks OSI(Linux) */
+
+	printk(KERN_NOTICE PREFIX "%s detected\n", d->ident);
+
+	if (enable == -1)
+		return;
+
+	osi_linux.known = 1;	/* DMI knows hich OSI(Linux) default needed */
+
+	/* Set default via DMI only if no cmdline override */
+	if (!osi_linux.cmdline)
+		set_osi_linux(enable);
 
-	osi_linux = enable;
 	return;
 }
 
@@ -987,12 +1043,12 @@ static int __init acpi_osi_setup(char *str)
 		printk(KERN_INFO PREFIX "_OSI method disabled\n");
 		acpi_gbl_create_osi_method = FALSE;
 	} else if (!strcmp("!Linux", str)) {
-		enable_osi_linux(0);
+		cmdline_osi_linux(0);	/* !enable */
 	} else if (*str == '!') {
 		if (acpi_osi_invalidate(++str) == AE_OK)
 			printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
 	} else if (!strcmp("Linux", str)) {
-		enable_osi_linux(1);
+		cmdline_osi_linux(1);	/* enable */
 	} else if (*osi_additional_string == '\0') {
 		strncpy(osi_additional_string, str, OSI_STRING_LENGTH_MAX);
 		printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
@@ -1172,16 +1228,32 @@ acpi_os_validate_interface (char *interface)
 	if (!strncmp(osi_additional_string, interface, OSI_STRING_LENGTH_MAX))
 		return AE_OK;
 	if (!strcmp("Linux", interface)) {
-		printk(KERN_WARNING PREFIX
-			"System BIOS is requesting _OSI(Linux)\n");
-		if (dmi_dump_entries(DMI_INTERESTING_ENTRIES))
-			printk(KERN_WARNING
-			"[please extract dmidecode output]\n");
-		printk(KERN_WARNING PREFIX
-			"If \"acpi_osi=Linux\" works better,\n"
-			"Please send DMI info above to "
-			"linux-acpi@vger.kernel.org\n");
-		if(osi_linux)
+
+		if (!osi_linux.dmi) {
+			printk(KERN_WARNING PREFIX
+				"_OSI(Linux) requested "
+				"by unknown system BIOS\n");
+			if (dmi_dump_entries(DMI_INTERESTING_ENTRIES))
+				printk(KERN_WARNING
+					"[please extract dmidecode output]\n");
+			printk(KERN_WARNING PREFIX
+				"Please send DMI info above to "
+				"linux-acpi@vger.kernel.org\n");
+		} else {
+			printk(KERN_WARNING PREFIX
+				"_OSI(Linux) %sabled %s\n",
+				osi_linux.enable ? "En" : "Dis",
+				osi_linux.cmdline ? "via cmdline" :
+					"for known system BIOS");
+		}
+		if (!osi_linux.known) {
+			printk(KERN_WARNING PREFIX
+				"If \"acpi_osi=%sLinux\" works better,"
+				"please notify linux-acpi@vger.kernel.org\n",
+				osi_linux.enable ? "!" : "");
+		}
+
+		if (osi_linux.enable)
 			return AE_OK;
 	}
 	return AE_SUPPORT;
@@ -1214,25 +1286,45 @@ acpi_os_validate_address (
 }
 
 #ifdef CONFIG_DMI
-static int dmi_osi_linux(const struct dmi_system_id *d)
+
+static int dmi_enable_osi_linux(const struct dmi_system_id *d)
+{
+	dmi_osi_linux(1, d);	/* enable */
+	return 0;
+}
+#ifdef	ACPI_FUTURE_USAGE
+static int dmi_disable_osi_linux(const struct dmi_system_id *d)
 {
-	printk(KERN_NOTICE "%s detected: enabling _OSI(Linux)\n", d->ident);
-	enable_osi_linux(1);
+	dmi_osi_linux(0, d);	/* disable */
 	return 0;
 }
+static int dmi_unknown_osi_linux(const struct dmi_system_id *d)
+{
+	dmi_osi_linux(-1, d);	/* unknown */
+	return 0;
+}
+#endif
 
 static struct dmi_system_id acpi_osl_dmi_table[] __initdata = {
 	/*
 	 * Boxes that need _OSI(Linux)
 	 */
 	{
-	 .callback = dmi_osi_linux,
+	 .callback = dmi_enable_osi_linux,
 	 .ident = "Intel Napa CRB",
 	 .matches = {
 		     DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
 		     DMI_MATCH(DMI_BOARD_NAME, "MPAD-MSAE Customer Reference Boards"),
 		     },
 	 },
+
+	/*
+	 * Boxes that need _OSI(Linux) NOT set
+	 */
+
+	/*
+	 * Boxes that request _OSI(Linux), but proper default is unknown
+	 */
 	{}
 };
 #endif /* CONFIG_DMI */
-- 
1.5.4.rc3.14.g44397

