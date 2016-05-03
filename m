From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 4/7] ACPI / osi: Fix default _OSI(Darwin) support
Date: Tue,  3 May 2016 16:48:39 +0800
Message-ID: <c5c9ddd4a2251cdc8eebea9e4fb63dfd821d639f.1462263979.git.lv.zheng@intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com> <cover.1462263979.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462263979.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

The following commit always reports positive value when Apple hardware
queries _OSI("Darwin"):
 Commit: 7bc5a2bad0b8d9d1ac9f7b8b33150e4ddf197334
 Subject: ACPI: Support _OSI("Darwin") correctly
However since this implementation places the judgement in runtime, it
breaks acpi_osi=!Darwin and cannot return unsupported for _OSI("WinXXX")
invoked before invoking _OSI("Darwin").

This patch fixes the issues by reverting the wrong support and implementing
the default behavior of _OSI("Darwin")/_OSI("WinXXX") on Apple hardware via
DMI matching.

Fixes: 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
Cc: <stable@vger.kernel.org> # 3.18+
Link: https://bugzilla.kernel.org/show_bug.cgi?id=92111
Reported-and-tested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/blacklist.c |   23 ++++++++++++++++++
 drivers/acpi/osl.c       |   58 ++++++++++++++++++++++++++++++++++++++++------
 include/linux/acpi.h     |    1 +
 3 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 96809cd..45390a9 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -133,6 +133,11 @@ int __init acpi_blacklisted(void)
 	return blacklisted;
 }
 #ifdef CONFIG_DMI
+static int __init dmi_enable_osi_darwin(const struct dmi_system_id *d)
+{
+	acpi_dmi_osi_darwin(1, d);	/* enable */
+	return 0;
+}
 static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
 {
 	acpi_dmi_osi_linux(1, d);	/* enable */
@@ -331,6 +336,24 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		},
 	},
 
+	/*
+	 * Enable _OSI("Darwin") for all apple platforms.
+	 */
+	{
+	.callback = dmi_enable_osi_darwin,
+	.ident = "Apple hardware",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_darwin,
+	.ident = "Apple hardware",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		},
+	},
+
 #ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
 	/*
 	 * DELL XPS 13 (2015) switches sound between HDA and I2S
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index fbedea7..5dd2a79 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -135,6 +135,9 @@ static struct acpi_osi_config {
 	unsigned int	linux_enable:1;
 	unsigned int	linux_dmi:1;
 	unsigned int	linux_cmdline:1;
+	unsigned int	darwin_enable:1;
+	unsigned int	darwin_dmi:1;
+	unsigned int	darwin_cmdline:1;
 	u8		default_disabling;
 } osi_config = {0, 0, 0, 0};
 
@@ -150,13 +153,12 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 	}
 
 	if (!strcmp("Darwin", interface)) {
-		/*
-		 * Apple firmware will behave poorly if it receives positive
-		 * answers to "Darwin" and any other OS. Respond positively
-		 * to Darwin and then disable all other vendor strings.
-		 */
-		acpi_update_interfaces(ACPI_DISABLE_ALL_VENDOR_STRINGS);
-		supported = ACPI_UINT32_MAX;
+
+		printk_once(KERN_NOTICE PREFIX
+			"BIOS _OSI(Darwin) query %s%s\n",
+			osi_config.darwin_enable ? "honored" : "ignored",
+			osi_config.darwin_cmdline ? " via cmdline" :
+			osi_config.darwin_dmi ? " via DMI" : "");
 	}
 
 	return supported;
@@ -1509,6 +1511,44 @@ void __init acpi_osi_setup(char *str)
 	}
 }
 
+static void __init set_osi_darwin(unsigned int enable)
+{
+	if (osi_config.darwin_enable != enable)
+		osi_config.darwin_enable = enable;
+
+	if (enable) {
+		acpi_osi_setup("!");
+		acpi_osi_setup("Darwin");
+	} else {
+		acpi_osi_setup("!!");
+		acpi_osi_setup("!Darwin");
+	}
+}
+
+static void __init acpi_cmdline_osi_darwin(unsigned int enable)
+{
+	/* cmdline set the default and override DMI */
+	osi_config.darwin_cmdline = 1;
+	osi_config.darwin_dmi = 0;
+	set_osi_darwin(enable);
+
+	return;
+}
+
+void __init acpi_dmi_osi_darwin(int enable, const struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
+
+	if (enable == -1)
+		return;
+
+	/* DMI knows that this box asks OSI(Darwin) */
+	osi_config.darwin_dmi = 1;
+	set_osi_darwin(enable);
+
+	return;
+}
+
 static void __init set_osi_linux(unsigned int enable)
 {
 	if (osi_config.linux_enable != enable)
@@ -1596,6 +1636,10 @@ static int __init osi_setup(char *str)
 		acpi_cmdline_osi_linux(1);
 	else if (str && !strcmp("!Linux", str))
 		acpi_cmdline_osi_linux(0);
+	else if (str && !strcmp("Darwin", str))
+		acpi_cmdline_osi_darwin(1);
+	else if (str && !strcmp("!Darwin", str))
+		acpi_cmdline_osi_darwin(0);
 	else
 		acpi_osi_setup(str);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index be5d206..8fd3a82 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -354,6 +354,7 @@ extern char acpi_video_backlight_string[];
 extern long acpi_is_video_device(acpi_handle handle);
 extern int acpi_blacklisted(void);
 extern void acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d);
+extern void acpi_dmi_osi_darwin(int enable, const struct dmi_system_id *d);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
-- 
1.7.10
