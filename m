From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/4] ACPI / osi: Change default _OSI(Darwin) support
Date: Tue, 26 Apr 2016 15:40:26 +0800
Message-ID: <721499bcaa3559f71023c6ab960481564f58f22a.1461656216.git.lv.zheng@intel.com>
References: <cover.1461656216.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461656216.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

Commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly") always
reports positive value when Apple hardware queries _OSI("Darwin"). However
since this implementation places the judgement in runtime, it breaks
acpi_osi=!Darwin and cannot return unsupported for _OSI("WinXXX") invoked
before invoking _OSI("Darwin").

This patch fixes the issues by reverting the wrong support and implementing
the default behavior of _OSI("Darwin")/_OSI("WinXXX") on Apple hardware via
DMI matching.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=92111
Reported-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/kernel-parameters.txt |    2 ++
 drivers/acpi/blacklist.c            |   23 ++++++++++++++++
 drivers/acpi/osl.c                  |   49 ++++++++++++++++++++++++++++++-----
 include/linux/acpi.h                |    1 +
 4 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 0b3de80..c48f387 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -312,6 +312,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			acpi_osi=!*		# remove all strings
 			acpi_osi=!		# disable all built-in OS vendor
 						  strings
+			acpi_osi=!!		# enable all built-in OS vendor
+						  strings
 			acpi_osi=		# disable all strings
 
 			'acpi_osi=!' can be used in combination with single or
diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 675a941..8fc1afe 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -133,6 +133,11 @@ int __init acpi_blacklisted(void)
 	return blacklisted;
 }
 #ifdef CONFIG_DMI
+static int __init dmi_enable_osi_darwin(const struct dmi_system_id *d)
+{
+	acpi_dmi_osi_darwin(true, d);	/* enable */
+	return 0;
+}
 static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
 {
 	acpi_dmi_osi_linux(true, d);	/* enable */
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
+
 #ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
 	/*
 	 * DELL XPS 13 (2015) switches sound between HDA and I2S
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index df1101e..b00657b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -136,6 +136,9 @@ static struct acpi_osi_config {
 	unsigned int	linux_enable:1;
 	unsigned int	linux_dmi:1;
 	unsigned int	linux_cmdline:1;
+	unsigned int	darwin_enable:1;
+	unsigned int	darwin_dmi:1;
+	unsigned int	darwin_cmdline:1;
 } osi_config;
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
@@ -148,13 +151,11 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 			osi_config.linux_dmi ? " via DMI" : "");
 	}
 	if (!strcmp("Darwin", interface)) {
-		/*
-		 * Apple firmware will behave poorly if it receives positive
-		 * answers to "Darwin" and any other OS. Respond positively
-		 * to Darwin and then disable all other vendor strings.
-		 */
-		acpi_update_interfaces(ACPI_DISABLE_ALL_VENDOR_STRINGS);
-		supported = ACPI_UINT32_MAX;
+		pr_notice_once(
+			"BIOS _OSI(Darwin) query %s%s\n",
+			osi_config.darwin_enable ? "honored" : "ignored",
+			osi_config.darwin_cmdline ? " via cmdline" :
+			osi_config.darwin_dmi ? " via DMI" : "");
 	}
 
 	return supported;
@@ -1486,6 +1487,9 @@ void __init acpi_osi_setup(char *str)
 				osi->enable = false;
 			}
 			return;
+		} else if (*str == '!') {
+			osi_config.default_disabling = 0;
+			return;
 		}
 		enable = false;
 	}
@@ -1503,6 +1507,33 @@ void __init acpi_osi_setup(char *str)
 	}
 }
 
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
+	osi_config.darwin_cmdline = 1;
+	/* Override acpi_blacklisted() */
+	osi_config.darwin_dmi = 0;
+	__acpi_osi_setup_darwin(enable);
+}
+
+void __init acpi_dmi_osi_darwin(bool enable, const struct dmi_system_id *d)
+{
+	pr_notice("DMI detected to setup _OSI(\"Darwin\"): %s\n", d->ident);
+	osi_config.darwin_dmi = 1;
+	__acpi_osi_setup_darwin(enable);
+}
+
 static void __init __acpi_osi_setup_linux(bool enable)
 {
 	osi_config.linux_enable = !!enable;
@@ -1576,6 +1607,10 @@ static int __init osi_setup(char *str)
 		acpi_osi_setup_linux(true);
 	else if (str && !strcmp("!Linux", str))
 		acpi_osi_setup_linux(false);
+	else if (str && !strcmp("Darwin", str))
+		acpi_osi_setup_darwin(true);
+	else if (str && !strcmp("!Darwin", str))
+		acpi_osi_setup_darwin(false);
 	else
 		acpi_osi_setup(str);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fceea1e..1455919 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -354,6 +354,7 @@ extern char acpi_video_backlight_string[];
 extern long acpi_is_video_device(acpi_handle handle);
 extern int acpi_blacklisted(void);
 extern void acpi_dmi_osi_linux(bool enable, const struct dmi_system_id *d);
+extern void acpi_dmi_osi_darwin(bool enable, const struct dmi_system_id *d);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
-- 
1.7.10
