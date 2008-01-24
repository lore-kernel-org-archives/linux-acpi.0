From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/8] ACPI: make _OSI(Linux) console messages smarter
Date: Wed, 23 Jan 2008 21:32:45 -0500
Message-ID: <d4b7dc499daae909e62dc260b95cd618f2970ded.1201141721.git.len.brown@intel.com>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:60148 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752353AbYAXCdk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 21:33:40 -0500
In-Reply-To: <1201141967-28134-1-git-send-email-lenb@kernel.org>
In-Reply-To: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
References: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

If BIOS invokes _OSI(Linux), the kernel response
depends on what the ACPI DMI list knows about the system,
and that is reflectd in dmesg:

1) System unknown to DMI:

ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: LENOVO
ACPI: DMI Product Name: 7661W1P
ACPI: DMI Product Version: ThinkPad T61
ACPI: DMI Board Name: 7661W1P
ACPI: DMI BIOS Vendor: LENOVO
ACPI: DMI BIOS Date: 10/18/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org

2) System known to DMI, but effect of OSI(Linux) unknown:

ACPI: DMI detected: Lenovo ThinkPad T61
...
ACPI: BIOS _OSI(Linux) query ignored via DMI
ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org

3) System known to DMI, which disables _OSI(Linux):

ACPI: DMI detected: Lenovo ThinkPad T61
...
ACPI: BIOS _OSI(Linux) query ignored via DMI

4) System known to DMI, which enable _OSI(Linux):

ACPI: DMI detected: Lenovo ThinkPad T61
ACPI: Added _OSI(Linux)
...
ACPI: BIOS _OSI(Linux) query honored via DMI

cmdline overrides take precidence over the built-in
default and the DMI prescribed default.
cmdline "acpi_osi=Linux" results in:

ACPI: BIOS _OSI(Linux) query honored via cmdline

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |   11 ++++
 drivers/acpi/osl.c       |  122 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/acpi.h     |    7 ++-
 3 files changed, 118 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 3ec110c..018fc16 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -3,6 +3,7 @@
  *
  *  Check to see if the given machine has a known bad ACPI BIOS
  *  or if the BIOS is too old.
+ *  Check given machine against acpi_osi_dmi_table[].
  *
  *  Copyright (C) 2004 Len Brown <len.brown@intel.com>
  *  Copyright (C) 2002 Andy Grover <andrew.grover@intel.com>
@@ -50,6 +51,8 @@ struct acpi_blacklist_item {
 	u32 is_critical_error;
 };
 
+static struct dmi_system_id acpi_osi_dmi_table[] __initdata;
+
 /*
  * POLICY: If *anything* doesn't work, put it on the blacklist.
  *	   If they are critical errors, mark it critical, and abort driver load.
@@ -165,5 +168,13 @@ int __init acpi_blacklisted(void)
 
 	blacklisted += blacklist_by_year();
 
+	dmi_check_system(acpi_osi_dmi_table);
+
 	return blacklisted;
 }
+#ifdef CONFIG_DMI
+static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
+	{}
+};
+
+#endif /* CONFIG_DMI */
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 15f095e..e53fb51 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,7 +77,55 @@ static struct workqueue_struct *kacpi_notify_wq;
 #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
 static char osi_additional_string[OSI_STRING_LENGTH_MAX];
 
-static int osi_linux;		/* disable _OSI(Linux) by default */
+/*
+ * "Ode to _OSI(Linux)"
+ *
+ * osi_linux -- Control response to BIOS _OSI(Linux) query.
+ *
+ * As Linux evolves, the features that it supports change.
+ * So an OSI string such as "Linux" is not specific enough
+ * to be useful across multiple versions of Linux.  It
+ * doesn't identify any particular feature, interface,
+ * or even any particular version of Linux...
+ *
+ * Unfortunately, Linux-2.6.22 and earlier responded "yes"
+ * to a BIOS _OSI(Linux) query.  When
+ * a reference mobile BIOS started using it, its use
+ * started to spread to many vendor platforms.
+ * As it is not supportable, we need to halt that spread.
+ *
+ * Today, most BIOS references to _OSI(Linux) are noise --
+ * they have no functional effect and are just dead code
+ * carried over from the reference BIOS.
+ *
+ * The next most common case is that _OSI(Linux) harms Linux,
+ * usually by causing the BIOS to follow paths that are
+ * not tested during Windows validation.
+ *
+ * Finally, there is a short list of platforms
+ * where OSI(Linux) benefits Linux.
+ *
+ * In Linux-2.6.23, OSI(Linux) is first disabled by default.
+ * DMI is used to disable the dmesg warning about OSI(Linux)
+ * on platforms where it is known to have no effect.
+ * But a dmesg warning remains for systems where
+ * we do not know if OSI(Linux) is good or bad for the system.
+ * DMI is also used to enable OSI(Linux) for the machines
+ * that are known to need it.
+ *
+ * BIOS writers should NOT query _OSI(Linux) on future systems.
+ * It will be ignored by default, and to get Linux to
+ * not ignore it will require a kernel source update to
+ * add a DMI entry, or a boot-time "acpi_osi=Linux" invocation.
+ */
+#define OSI_LINUX_ENABLE 0
+
+struct osi_linux {
+	unsigned int	enable:1;
+	unsigned int	dmi:1;
+	unsigned int	cmdline:1;
+	unsigned int	known:1;
+} osi_linux = { OSI_LINUX_ENABLE, 0, 0, 0};
 
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
@@ -959,13 +1007,37 @@ static int __init acpi_os_name_setup(char *str)
 
 __setup("acpi_os_name=", acpi_os_name_setup);
 
-static void enable_osi_linux(int enable) {
+static void __init set_osi_linux(unsigned int enable)
+{
+	if (osi_linux.enable != enable) {
+		osi_linux.enable = enable;
+		printk(KERN_NOTICE PREFIX "%sed _OSI(Linux)\n",
+			enable ? "Add": "Delet");
+	}
+	return;
+}
+
+static void __init acpi_cmdline_osi_linux(unsigned int enable)
+{
+	osi_linux.cmdline = 1;	/* cmdline set the default */
+	set_osi_linux(enable);
+
+	return;
+}
+
+void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
+{
+	osi_linux.dmi = 1;	/* DMI knows that this box asks OSI(Linux) */
+
+	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
+
+	if (enable == -1)
+		return;
+
+	osi_linux.known = 1;	/* DMI knows which OSI(Linux) default needed */
 
-	if (osi_linux != enable)
-		printk(KERN_INFO PREFIX "%sabled _OSI(Linux)\n",
-			enable ? "En": "Dis");
+	set_osi_linux(enable);
 
-	osi_linux = enable;
 	return;
 }
 
@@ -982,12 +1054,12 @@ static int __init acpi_osi_setup(char *str)
 		printk(KERN_INFO PREFIX "_OSI method disabled\n");
 		acpi_gbl_create_osi_method = FALSE;
 	} else if (!strcmp("!Linux", str)) {
-		enable_osi_linux(0);
+		acpi_cmdline_osi_linux(0);	/* !enable */
 	} else if (*str == '!') {
 		if (acpi_osi_invalidate(++str) == AE_OK)
 			printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
 	} else if (!strcmp("Linux", str)) {
-		enable_osi_linux(1);
+		acpi_cmdline_osi_linux(1);	/* enable */
 	} else if (*osi_additional_string == '\0') {
 		strncpy(osi_additional_string, str, OSI_STRING_LENGTH_MAX);
 		printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
@@ -1183,19 +1255,29 @@ acpi_os_validate_interface (char *interface)
 	if (!strncmp(osi_additional_string, interface, OSI_STRING_LENGTH_MAX))
 		return AE_OK;
 	if (!strcmp("Linux", interface)) {
-		printk(KERN_WARNING PREFIX
-			"System BIOS is requesting _OSI(Linux)\n");
-		if (acpi_dmi_dump())
-			printk(KERN_NOTICE PREFIX
-				"[please extract dmidecode output]\n");
-		printk(KERN_NOTICE PREFIX
-			"Please send DMI info above to "
-			"linux-acpi@vger.kernel.org\n");
+
 		printk(KERN_NOTICE PREFIX
-			"If \"acpi_osi=%sLinux\" works better, "
-			"please notify linux-acpi@vger.kernel.org\n",
-			osi_linux ? "!" : "");
-		if(osi_linux)
+			"BIOS _OSI(Linux) query %s%s\n",
+			osi_linux.enable ? "honored" : "ignored",
+			osi_linux.cmdline ? " via cmdline" :
+			osi_linux.dmi ? " via DMI" : "");
+
+		if (!osi_linux.dmi) {
+			if (acpi_dmi_dump())
+				printk(KERN_NOTICE PREFIX
+					"[please extract dmidecode output]\n");
+			printk(KERN_NOTICE PREFIX
+				"Please send DMI info above to "
+				"linux-acpi@vger.kernel.org\n");
+		}
+		if (!osi_linux.known && !osi_linux.cmdline) {
+			printk(KERN_NOTICE PREFIX
+				"If \"acpi_osi=%sLinux\" works better, "
+				"please notify linux-acpi@vger.kernel.org\n",
+				osi_linux.enable ? "!" : "");
+		}
+
+		if (osi_linux.enable)
 			return AE_OK;
 	}
 	return AE_SUPPORT;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e3c16c9..63f2e6e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -40,6 +40,7 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_numa.h>
 #include <asm/acpi.h>
+#include <linux/dmi.h>
 
 
 #ifdef CONFIG_ACPI
@@ -192,7 +193,9 @@ extern int ec_transaction(u8 command,
 #endif /*CONFIG_ACPI_EC*/
 
 extern int acpi_blacklisted(void);
-extern void acpi_bios_year(char *s);
+#ifdef CONFIG_DMI
+extern void acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d);
+#endif
 
 #ifdef CONFIG_ACPI_NUMA
 int acpi_get_pxm(acpi_handle handle);
@@ -226,5 +229,5 @@ static inline int acpi_boot_table_init(void)
 	return 0;
 }
 
-#endif	/* CONFIG_ACPI */
+#endif	/* !CONFIG_ACPI */
 #endif	/*_LINUX_ACPI_H*/
-- 
1.5.4.rc4.14.g6fc74

