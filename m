From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 6/6] ACPI / osi: Collect _OSI handling into one single file
Date: Wed, 27 Apr 2016 16:54:56 +0800
Message-ID: <5989d8ced933f819b34b2f16e3fad40a9f9d732a.1461736123.git.lv.zheng@intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com> <cover.1461736123.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461736123.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

_OSI handling code grows giant and it's time to move them into one file.

This patch collects all _OSI handling code into one single file.
So that we only have the following functions to be used externally:
 early_acpi_osi_init(): Used by DMI detections;
 acpi_osi_init(): Used to initialize OSI command line settings and install
                  Linux specific _OSI handler;
 acpi_osi_setup(): The API that should be used by the external quirks.
 acpi_osi_is_win8(): The API is used by the external drivers to determine
                     if BIOS supports Win8.

CONFIG_DMI is not useful as stub dmi_check_system() can make everything
stub because of strip.

No functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/Makefile    |    2 +-
 drivers/acpi/blacklist.c |  219 +-------------------
 drivers/acpi/internal.h  |    2 +
 drivers/acpi/osi.c       |  518 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/osl.c       |  254 +----------------------
 include/linux/acpi.h     |    2 -
 6 files changed, 527 insertions(+), 470 deletions(-)
 create mode 100644 drivers/acpi/osi.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5a65f85..251ce85 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_ACPI)		+= acpi.o \
 					acpica/
 
 # All the builtin files are in the "acpi." module_param namespace.
-acpi-y				+= osl.o utils.o reboot.o
+acpi-y				+= osi.o osl.o utils.o reboot.o
 acpi-y				+= nvs.o
 
 # Power management related files
diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 45199dc..bdc67ba 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -3,7 +3,7 @@
  *
  *  Check to see if the given machine has a known bad ACPI BIOS
  *  or if the BIOS is too old.
- *  Check given machine against acpi_osi_dmi_table[].
+ *  Check given machine against acpi_rev_dmi_table[].
  *
  *  Copyright (C) 2004 Len Brown <len.brown@intel.com>
  *  Copyright (C) 2002 Andy Grover <andrew.grover@intel.com>
@@ -47,7 +47,7 @@ struct acpi_blacklist_item {
 	u32 is_critical_error;
 };
 
-static struct dmi_system_id acpi_osi_dmi_table[] __initdata;
+static struct dmi_system_id acpi_rev_dmi_table[] __initdata;
 
 /*
  * POLICY: If *anything* doesn't work, put it on the blacklist.
@@ -128,41 +128,12 @@ int __init acpi_blacklisted(void)
 		}
 	}
 
-	dmi_check_system(acpi_osi_dmi_table);
+	(void)early_acpi_osi_init();
+	dmi_check_system(acpi_rev_dmi_table);
 
 	return blacklisted;
 }
 #ifdef CONFIG_DMI
-static int __init dmi_enable_osi_darwin(const struct dmi_system_id *d)
-{
-	acpi_osi_dmi_darwin(true, d);
-	return 0;
-}
-static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
-{
-	acpi_osi_dmi_linux(true, d);
-	return 0;
-}
-static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
-{
-	pr_notice("DMI detected: %s\n", d->ident);
-	acpi_osi_setup("!Windows 2006");
-	acpi_osi_setup("!Windows 2006 SP1");
-	acpi_osi_setup("!Windows 2006 SP2");
-	return 0;
-}
-static int __init dmi_disable_osi_win7(const struct dmi_system_id *d)
-{
-	pr_notice("DMI detected: %s\n", d->ident);
-	acpi_osi_setup("!Windows 2009");
-	return 0;
-}
-static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
-{
-	pr_notice("DMI detected: %s\n", d->ident);
-	acpi_osi_setup("!Windows 2012");
-	return 0;
-}
 #ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
 static int __init dmi_enable_rev_override(const struct dmi_system_id *d)
 {
@@ -173,187 +144,7 @@ static int __init dmi_enable_rev_override(const struct dmi_system_id *d)
 }
 #endif
 
-static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
-	{
-	.callback = dmi_disable_osi_vista,
-	.ident = "Fujitsu Siemens",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
-		},
-	},
-	{
-	/*
-	 * There have a NVIF method in MSI GX723 DSDT need call by Nvidia
-	 * driver (e.g. nouveau) when user press brightness hotkey.
-	 * Currently, nouveau driver didn't do the job and it causes there
-	 * have a infinite while loop in DSDT when user press hotkey.
-	 * We add MSI GX723's dmi information to this table for workaround
-	 * this issue.
-	 * Will remove MSI GX723 from the table after nouveau grows support.
-	 */
-	.callback = dmi_disable_osi_vista,
-	.ident = "MSI GX723",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "GX723"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_vista,
-	.ident = "Sony VGN-NS10J_S",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NS10J_S"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_vista,
-	.ident = "Sony VGN-SR290J",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SR290J"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_vista,
-	.ident = "VGN-NS50B_L",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NS50B_L"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_vista,
-	.ident = "VGN-SR19XN",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SR19XN"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_vista,
-	.ident = "Toshiba Satellite L355",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-		     DMI_MATCH(DMI_PRODUCT_VERSION, "Satellite L355"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win7,
-	.ident = "ASUS K50IJ",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "K50IJ"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_vista,
-	.ident = "Toshiba P305D",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P305D"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_vista,
-	.ident = "Toshiba NB100",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "NB100"),
-		},
-	},
-
-	/*
-	 * The wireless hotkey does not work on those machines when
-	 * returning true for _OSI("Windows 2012")
-	 */
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "Dell Inspiron 7737",
-	.matches = {
-		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7737"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "Dell Inspiron 7537",
-	.matches = {
-		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7537"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "Dell Inspiron 5437",
-	.matches = {
-		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5437"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "Dell Inspiron 3437",
-	.matches = {
-		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 3437"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "Dell Vostro 3446",
-	.matches = {
-		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3446"),
-		},
-	},
-	{
-	.callback = dmi_disable_osi_win8,
-	.ident = "Dell Vostro 3546",
-	.matches = {
-		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3546"),
-		},
-	},
-
-	/*
-	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-	 * Linux ignores it, except for the machines enumerated below.
-	 */
-
-	/*
-	 * Without this this EEEpc exports a non working WMI interface, with
-	 * this it exports a working "good old" eeepc_laptop interface, fixing
-	 * both brightness control, and rfkill not working.
-	 */
-	{
-	.callback = dmi_enable_osi_linux,
-	.ident = "Asus EEE PC 1015PX",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer INC."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "1015PX"),
-		},
-	},
-
-	/*
-	 * Enable _OSI("Darwin") for all apple platforms.
-	 */
-	{
-	.callback = dmi_enable_osi_darwin,
-	.ident = "Apple hardware",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Apple INC."),
-		},
-	},
-	{
-	.callback = dmi_enable_osi_darwin,
-	.ident = "Apple hardware",
-	.matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, INC."),
-		},
-	},
-
+static struct dmi_system_id acpi_rev_dmi_table[] __initdata = {
 #ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
 	/*
 	 * DELL XPS 13 (2015) switches sound between HDA and I2S
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 1b0e6fd..9bb0773 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -20,6 +20,8 @@
 
 #define PREFIX "ACPI: "
 
+int early_acpi_osi_init(void);
+int acpi_osi_init(void);
 acpi_status acpi_os_initialize1(void);
 void init_acpi_device_notify(void);
 int acpi_scan_init(void);
diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
new file mode 100644
index 0000000..b147907
--- /dev/null
+++ b/drivers/acpi/osi.c
@@ -0,0 +1,518 @@
+/*
+ *  osi.c - _OSI implementation
+ *
+ *  Copyright (C) 2016 Intel Corporation
+ *    Author: Lv Zheng <lv.zheng@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+
+#include "internal.h"
+
+
+#define OSI_STRING_LENGTH_MAX	64
+#define OSI_STRING_ENTRIES_MAX	16
+
+struct acpi_osi_entry {
+	char string[OSI_STRING_LENGTH_MAX];
+	bool enable;
+};
+
+static struct acpi_osi_config {
+	u8		default_disabling;
+	unsigned int	linux_enable:1;
+	unsigned int	linux_dmi:1;
+	unsigned int	linux_cmdline:1;
+	unsigned int	darwin_enable:1;
+	unsigned int	darwin_dmi:1;
+	unsigned int	darwin_cmdline:1;
+} osi_config;
+
+static struct acpi_osi_config osi_config;
+static struct acpi_osi_entry
+osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
+	{"Module Device", true},
+	{"Processor Device", true},
+	{"3.0 _SCP Extensions", true},
+	{"Processor Aggregator Device", true},
+};
+
+static u32 acpi_osi_handler(acpi_string interface, u32 supported)
+{
+	if (!strcmp("Linux", interface)) {
+		pr_notice_once(FW_BUG
+			"BIOS _OSI(Linux) query %s%s\n",
+			osi_config.linux_enable ? "honored" : "ignored",
+			osi_config.linux_cmdline ? " via cmdline" :
+			osi_config.linux_dmi ? " via DMI" : "");
+	}
+	if (!strcmp("Darwin", interface)) {
+		pr_notice_once(
+			"BIOS _OSI(Darwin) query %s%s\n",
+			osi_config.darwin_enable ? "honored" : "ignored",
+			osi_config.darwin_cmdline ? " via cmdline" :
+			osi_config.darwin_dmi ? " via DMI" : "");
+	}
+
+	return supported;
+}
+
+void __init acpi_osi_setup(char *str)
+{
+	struct acpi_osi_entry *osi;
+	bool enable = true;
+	int i;
+
+	if (!acpi_gbl_create_osi_method)
+		return;
+
+	if (str == NULL || *str == '\0') {
+		pr_info("_OSI method disabled\n");
+		acpi_gbl_create_osi_method = FALSE;
+		return;
+	}
+
+	if (*str == '!') {
+		str++;
+		if (*str == '\0') {
+			/* Do not override acpi_osi=!* */
+			if (!osi_config.default_disabling)
+				osi_config.default_disabling =
+					ACPI_DISABLE_ALL_VENDOR_STRINGS;
+			return;
+		} else if (*str == '*') {
+			osi_config.default_disabling = ACPI_DISABLE_ALL_STRINGS;
+			for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
+				osi = &osi_setup_entries[i];
+				osi->enable = false;
+			}
+			return;
+		} else if (*str == '!') {
+			osi_config.default_disabling = 0;
+			return;
+		}
+		enable = false;
+	}
+
+	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
+		osi = &osi_setup_entries[i];
+		if (!strcmp(osi->string, str)) {
+			osi->enable = enable;
+			break;
+		} else if (osi->string[0] == '\0') {
+			osi->enable = enable;
+			strncpy(osi->string, str, OSI_STRING_LENGTH_MAX);
+			break;
+		}
+	}
+}
+
+static void __init __acpi_osi_setup_darwin(bool enable)
+{
+	osi_config.darwin_enable = !!enable;
+	if (enable) {
+		acpi_osi_setup("!");
+		acpi_osi_setup("Darwin");
+	} else {
+		acpi_osi_setup("!!");
+		acpi_osi_setup("!Darwin");
+	}
+}
+
+static void __init acpi_osi_setup_darwin(bool enable)
+{
+	/* Override acpi_osi_dmi_blacklisted() */
+	osi_config.darwin_dmi = 0;
+	osi_config.darwin_cmdline = 1;
+	__acpi_osi_setup_darwin(enable);
+}
+
+/*
+ * The story of _OSI(Linux)
+ *
+ * From pre-history through Linux-2.6.22, Linux responded TRUE upon a BIOS
+ * OSI(Linux) query.
+ *
+ * Unfortunately, reference BIOS writers got wind of this and put
+ * OSI(Linux) in their example code, quickly exposing this string as
+ * ill-conceived and opening the door to an un-bounded number of BIOS
+ * incompatibilities.
+ *
+ * For example, OSI(Linux) was used on resume to re-POST a video card on
+ * one system, because Linux at that time could not do a speedy restore in
+ * its native driver. But then upon gaining quick native restore
+ * capability, Linux has no way to tell the BIOS to skip the time-consuming
+ * POST -- putting Linux at a permanent performance disadvantage. On
+ * another system, the BIOS writer used OSI(Linux) to infer native OS
+ * support for IPMI!  On other systems, OSI(Linux) simply got in the way of
+ * Linux claiming to be compatible with other operating systems, exposing
+ * BIOS issues such as skipped device initialization.
+ *
+ * So "Linux" turned out to be a really poor chose of OSI string, and from
+ * Linux-2.6.23 onward we respond FALSE.
+ *
+ * BIOS writers should NOT query _OSI(Linux) on future systems. Linux will
+ * complain on the console when it sees it, and return FALSE. To get Linux
+ * to return TRUE for your system  will require a kernel source update to
+ * add a DMI entry, or boot with "acpi_osi=Linux"
+ */
+static void __init __acpi_osi_setup_linux(bool enable)
+{
+	osi_config.linux_enable = !!enable;
+	if (enable)
+		acpi_osi_setup("Linux");
+	else
+		acpi_osi_setup("!Linux");
+}
+
+static void __init acpi_osi_setup_linux(bool enable)
+{
+	/* Override acpi_osi_dmi_blacklisted() */
+	osi_config.linux_dmi = 0;
+	osi_config.linux_cmdline = 1;
+	__acpi_osi_setup_linux(enable);
+}
+
+/*
+ * Modify the list of "OS Interfaces" reported to BIOS via _OSI
+ *
+ * empty string disables _OSI
+ * string starting with '!' disables that string
+ * otherwise string is added to list, augmenting built-in strings
+ */
+static void __init acpi_osi_setup_late(void)
+{
+	struct acpi_osi_entry *osi;
+	char *str;
+	int i;
+	acpi_status status;
+
+	if (osi_config.default_disabling) {
+		status = acpi_update_interfaces(osi_config.default_disabling);
+		if (ACPI_SUCCESS(status))
+			pr_info("Disabled all _OSI OS vendors%s\n",
+				osi_config.default_disabling ==
+				ACPI_DISABLE_ALL_STRINGS ?
+				" and feature groups" : "");
+	}
+
+	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
+		osi = &osi_setup_entries[i];
+		str = osi->string;
+		if (*str == '\0')
+			break;
+		if (osi->enable) {
+			status = acpi_install_interface(str);
+			if (ACPI_SUCCESS(status))
+				pr_info("Added _OSI(%s)\n", str);
+		} else {
+			status = acpi_remove_interface(str);
+			if (ACPI_SUCCESS(status))
+				pr_info("Deleted _OSI(%s)\n", str);
+		}
+	}
+}
+
+static int __init osi_setup(char *str)
+{
+	if (str && !strcmp("Linux", str))
+		acpi_osi_setup_linux(true);
+	else if (str && !strcmp("!Linux", str))
+		acpi_osi_setup_linux(false);
+	else if (str && !strcmp("Darwin", str))
+		acpi_osi_setup_darwin(true);
+	else if (str && !strcmp("!Darwin", str))
+		acpi_osi_setup_darwin(false);
+	else
+		acpi_osi_setup(str);
+
+	return 1;
+}
+__setup("acpi_osi=", osi_setup);
+
+bool acpi_osi_is_win8(void)
+{
+	return acpi_gbl_osi_data >= ACPI_OSI_WIN_8;
+}
+EXPORT_SYMBOL(acpi_osi_is_win8);
+
+static void __init acpi_osi_dmi_darwin(bool enable,
+				       const struct dmi_system_id *d)
+{
+	pr_notice("DMI detected to setup _OSI(\"Darwin\"): %s\n", d->ident);
+	osi_config.darwin_dmi = 1;
+	__acpi_osi_setup_darwin(enable);
+}
+
+void __init acpi_osi_dmi_linux(bool enable, const struct dmi_system_id *d)
+{
+	pr_notice("DMI detected to setup _OSI(\"Linux\"): %s\n", d->ident);
+	osi_config.linux_dmi = 1;
+	__acpi_osi_setup_linux(enable);
+}
+
+static int __init dmi_enable_osi_darwin(const struct dmi_system_id *d)
+{
+	acpi_osi_dmi_darwin(true, d);
+
+	return 0;
+}
+
+static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
+{
+	acpi_osi_dmi_linux(true, d);
+
+	return 0;
+}
+
+static int __init dmi_disable_osi_vista(const struct dmi_system_id *d)
+{
+	pr_notice("DMI detected: %s\n", d->ident);
+	acpi_osi_setup("!Windows 2006");
+	acpi_osi_setup("!Windows 2006 SP1");
+	acpi_osi_setup("!Windows 2006 SP2");
+
+	return 0;
+}
+
+static int __init dmi_disable_osi_win7(const struct dmi_system_id *d)
+{
+	pr_notice("DMI detected: %s\n", d->ident);
+	acpi_osi_setup("!Windows 2009");
+
+	return 0;
+}
+
+static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
+{
+	pr_notice("DMI detected: %s\n", d->ident);
+	acpi_osi_setup("!Windows 2012");
+
+	return 0;
+}
+
+/*
+ * Linux default _OSI response behavior is determined by this DMI table.
+ *
+ * Note that _OSI("Linux")/_OSI("Darwin") determined here can be overridden
+ * by acpi_osi=!Linux/acpi_osi=!Darwin command line options.
+ */
+static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Fujitsu Siemens",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile V5505"),
+		},
+	},
+	{
+	/*
+	 * There have a NVIF method in MSI GX723 DSDT need call by Nvidia
+	 * driver (e.g. nouveau) when user press brightness hotkey.
+	 * Currently, nouveau driver didn't do the job and it causes there
+	 * have a infinite while loop in DSDT when user press hotkey.
+	 * We add MSI GX723's dmi information to this table for workaround
+	 * this issue.
+	 * Will remove MSI GX723 from the table after nouveau grows support.
+	 */
+	.callback = dmi_disable_osi_vista,
+	.ident = "MSI GX723",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "GX723"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Sony VGN-NS10J_S",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NS10J_S"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Sony VGN-SR290J",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SR290J"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "VGN-NS50B_L",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NS50B_L"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "VGN-SR19XN",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SR19XN"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Toshiba Satellite L355",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "Satellite L355"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win7,
+	.ident = "ASUS K50IJ",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "K50IJ"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Toshiba P305D",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P305D"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Toshiba NB100",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "NB100"),
+		},
+	},
+
+	/*
+	 * The wireless hotkey does not work on those machines when
+	 * returning true for _OSI("Windows 2012")
+	 */
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Inspiron 7737",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7737"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Inspiron 7537",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7537"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Inspiron 5437",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5437"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Inspiron 3437",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 3437"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Vostro 3446",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3446"),
+		},
+	},
+	{
+	.callback = dmi_disable_osi_win8,
+	.ident = "Dell Vostro 3546",
+	.matches = {
+		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		    DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3546"),
+		},
+	},
+
+	/*
+	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
+	 * Linux ignores it, except for the machines enumerated below.
+	 */
+
+	/*
+	 * Without this this EEEpc exports a non working WMI interface, with
+	 * this it exports a working "good old" eeepc_laptop interface, fixing
+	 * both brightness control, and rfkill not working.
+	 */
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Asus EEE PC 1015PX",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer INC."),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "1015PX"),
+		},
+	},
+
+	/*
+	 * Enable _OSI("Darwin") for all apple platforms.
+	 */
+	{
+	.callback = dmi_enable_osi_darwin,
+	.ident = "Apple hardware",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple INC."),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_darwin,
+	.ident = "Apple hardware",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, INC."),
+		},
+	},
+	{}
+};
+
+static __init void acpi_osi_dmi_blacklisted(void)
+{
+	dmi_check_system(acpi_osi_dmi_table);
+}
+
+int __init early_acpi_osi_init(void)
+{
+	acpi_osi_dmi_blacklisted();
+
+	return 0;
+}
+
+int __init acpi_osi_init(void)
+{
+	acpi_install_interface_handler(acpi_osi_handler);
+	acpi_osi_setup_late();
+
+	return 0;
+}
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index d9eef7e..45cab33 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -96,74 +96,6 @@ struct acpi_ioremap {
 static LIST_HEAD(acpi_ioremaps);
 static DEFINE_MUTEX(acpi_ioremap_lock);
 
-static void __init acpi_osi_setup_late(void);
-
-/*
- * The story of _OSI(Linux)
- *
- * From pre-history through Linux-2.6.22,
- * Linux responded TRUE upon a BIOS OSI(Linux) query.
- *
- * Unfortunately, reference BIOS writers got wind of this
- * and put OSI(Linux) in their example code, quickly exposing
- * this string as ill-conceived and opening the door to
- * an un-bounded number of BIOS incompatibilities.
- *
- * For example, OSI(Linux) was used on resume to re-POST a
- * video card on one system, because Linux at that time
- * could not do a speedy restore in its native driver.
- * But then upon gaining quick native restore capability,
- * Linux has no way to tell the BIOS to skip the time-consuming
- * POST -- putting Linux at a permanent performance disadvantage.
- * On another system, the BIOS writer used OSI(Linux)
- * to infer native OS support for IPMI!  On other systems,
- * OSI(Linux) simply got in the way of Linux claiming to
- * be compatible with other operating systems, exposing
- * BIOS issues such as skipped device initialization.
- *
- * So "Linux" turned out to be a really poor chose of
- * OSI string, and from Linux-2.6.23 onward we respond FALSE.
- *
- * BIOS writers should NOT query _OSI(Linux) on future systems.
- * Linux will complain on the console when it sees it, and return FALSE.
- * To get Linux to return TRUE for your system  will require
- * a kernel source update to add a DMI entry,
- * or boot with "acpi_osi=Linux"
- */
-
-static struct acpi_osi_config {
-	unsigned int	linux_enable:1;
-	unsigned int	linux_dmi:1;
-	unsigned int	linux_cmdline:1;
-	unsigned int	darwin_enable:1;
-	unsigned int	darwin_dmi:1;
-	unsigned int	darwin_cmdline:1;
-	u8		default_disabling;
-} osi_config;
-
-static u32 acpi_osi_handler(acpi_string interface, u32 supported)
-{
-	if (!strcmp("Linux", interface)) {
-
-		pr_notice_once(FW_BUG
-			"BIOS _OSI(Linux) query %s%s\n",
-			osi_config.linux_enable ? "honored" : "ignored",
-			osi_config.linux_cmdline ? " via cmdline" :
-			osi_config.linux_dmi ? " via DMI" : "");
-	}
-
-	if (!strcmp("Darwin", interface)) {
-
-		pr_notice_once(
-			"BIOS _OSI(Darwin) query %s%s\n",
-			osi_config.darwin_enable ? "honored" : "ignored",
-			osi_config.darwin_cmdline ? " via cmdline" :
-			osi_config.darwin_dmi ? " via DMI" : "");
-	}
-
-	return supported;
-}
-
 static void __init acpi_request_region (struct acpi_generic_address *gas,
 	unsigned int length, char *desc)
 {
@@ -1444,183 +1376,6 @@ static int __init acpi_os_name_setup(char *str)
 
 __setup("acpi_os_name=", acpi_os_name_setup);
 
-#define	OSI_STRING_LENGTH_MAX 64
-#define	OSI_STRING_ENTRIES_MAX 16
-
-struct acpi_osi_entry {
-	char string[OSI_STRING_LENGTH_MAX];
-	bool enable;
-};
-
-static struct acpi_osi_entry
-		osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
-	{"Module Device", true},
-	{"Processor Device", true},
-	{"3.0 _SCP Extensions", true},
-	{"Processor Aggregator Device", true},
-};
-
-void __init acpi_osi_setup(char *str)
-{
-	struct acpi_osi_entry *osi;
-	bool enable = true;
-	int i;
-
-	if (!acpi_gbl_create_osi_method)
-		return;
-
-	if (str == NULL || *str == '\0') {
-		pr_info("_OSI method disabled\n");
-		acpi_gbl_create_osi_method = FALSE;
-		return;
-	}
-
-	if (*str == '!') {
-		str++;
-		if (*str == '\0') {
-			/* Do not override acpi_osi=!* */
-			if (!osi_config.default_disabling)
-				osi_config.default_disabling =
-					ACPI_DISABLE_ALL_VENDOR_STRINGS;
-			return;
-		} else if (*str == '*') {
-			osi_config.default_disabling = ACPI_DISABLE_ALL_STRINGS;
-			for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
-				osi = &osi_setup_entries[i];
-				osi->enable = false;
-			}
-			return;
-		} else if (*str == '!') {
-			osi_config.default_disabling = 0;
-			return;
-		}
-		enable = false;
-	}
-
-	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
-		osi = &osi_setup_entries[i];
-		if (!strcmp(osi->string, str)) {
-			osi->enable = enable;
-			break;
-		} else if (osi->string[0] == '\0') {
-			osi->enable = enable;
-			strncpy(osi->string, str, OSI_STRING_LENGTH_MAX);
-			break;
-		}
-	}
-}
-
-static void __init __acpi_osi_setup_darwin(bool enable)
-{
-	osi_config.darwin_enable = !!enable;
-	if (enable) {
-		acpi_osi_setup("!");
-		acpi_osi_setup("Darwin");
-	} else {
-		acpi_osi_setup("!!");
-		acpi_osi_setup("!Darwin");
-	}
-}
-
-static void __init acpi_osi_setup_darwin(bool enable)
-{
-	osi_config.darwin_cmdline = 1;
-	osi_config.darwin_dmi = 0;
-	__acpi_osi_setup_darwin(enable);
-}
-
-void __init acpi_osi_dmi_darwin(bool enable, const struct dmi_system_id *d)
-{
-	pr_notice("DMI detected to setup _OSI(\"Darwin\"): %s\n", d->ident);
-	osi_config.darwin_dmi = 1;
-	__acpi_osi_setup_darwin(enable);
-}
-
-static void __init __acpi_osi_setup_linux(bool enable)
-{
-	osi_config.linux_enable = !!enable;
-	if (enable)
-		acpi_osi_setup("Linux");
-	else
-		acpi_osi_setup("!Linux");
-}
-
-static void __init acpi_osi_setup_linux(bool enable)
-{
-	osi_config.linux_cmdline = 1;
-	osi_config.linux_dmi = 0;
-	__acpi_osi_setup_linux(enable);
-}
-
-void __init acpi_osi_dmi_linux(bool enable, const struct dmi_system_id *d)
-{
-	pr_notice("DMI detected to setup _OSI(\"Linux\"): %s\n", d->ident);
-	osi_config.linux_dmi = 1;
-	__acpi_osi_setup_linux(enable);
-}
-
-/*
- * Modify the list of "OS Interfaces" reported to BIOS via _OSI
- *
- * empty string disables _OSI
- * string starting with '!' disables that string
- * otherwise string is added to list, augmenting built-in strings
- */
-static void __init acpi_osi_setup_late(void)
-{
-	struct acpi_osi_entry *osi;
-	char *str;
-	int i;
-	acpi_status status;
-
-	if (osi_config.default_disabling) {
-		status = acpi_update_interfaces(osi_config.default_disabling);
-
-		if (ACPI_SUCCESS(status))
-			pr_info("Disabled all _OSI OS vendors%s\n",
-				osi_config.default_disabling ==
-				ACPI_DISABLE_ALL_STRINGS ?
-				" and feature groups" : "");
-	}
-
-	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
-		osi = &osi_setup_entries[i];
-		str = osi->string;
-
-		if (*str == '\0')
-			break;
-		if (osi->enable) {
-			status = acpi_install_interface(str);
-
-			if (ACPI_SUCCESS(status))
-				pr_info("Added _OSI(%s)\n", str);
-		} else {
-			status = acpi_remove_interface(str);
-
-			if (ACPI_SUCCESS(status))
-				pr_info("Deleted _OSI(%s)\n", str);
-		}
-	}
-}
-
-static int __init osi_setup(char *str)
-{
-	if (str && !strcmp("Linux", str))
-		acpi_osi_setup_linux(true);
-	else if (str && !strcmp("!Linux", str))
-		acpi_osi_setup_linux(false);
-	else if (str && !strcmp("Darwin", str))
-		acpi_osi_setup_darwin(true);
-	else if (str && !strcmp("!Darwin", str))
-		acpi_osi_setup_darwin(false);
-	else
-		acpi_osi_setup(str);
-
-	return 1;
-}
-
-__setup("acpi_osi=", osi_setup);
-
 /*
  * Disable the auto-serialization of named objects creation methods.
  *
@@ -1740,12 +1495,6 @@ int acpi_resources_are_enforced(void)
 }
 EXPORT_SYMBOL(acpi_resources_are_enforced);
 
-bool acpi_osi_is_win8(void)
-{
-	return acpi_gbl_osi_data >= ACPI_OSI_WIN_8;
-}
-EXPORT_SYMBOL(acpi_osi_is_win8);
-
 /*
  * Deallocate the memory for a spinlock.
  */
@@ -1911,8 +1660,7 @@ acpi_status __init acpi_os_initialize1(void)
 	BUG_ON(!kacpid_wq);
 	BUG_ON(!kacpi_notify_wq);
 	BUG_ON(!kacpi_hotplug_wq);
-	acpi_install_interface_handler(acpi_osi_handler);
-	acpi_osi_setup_late();
+	acpi_osi_init();
 	return AE_OK;
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f0137bf..b25690b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -353,8 +353,6 @@ extern bool wmi_has_guid(const char *guid);
 extern char acpi_video_backlight_string[];
 extern long acpi_is_video_device(acpi_handle handle);
 extern int acpi_blacklisted(void);
-extern void acpi_osi_dmi_linux(bool enable, const struct dmi_system_id *d);
-extern void acpi_osi_dmi_darwin(bool enable, const struct dmi_system_id *d);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
-- 
1.7.10
