From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] ACPI: Provide an OSI interface not returning true for Windows to the BIOS
Date: Thu, 10 Jul 2008 17:10:12 +0200
Message-ID: <200807101710.12748.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:60743 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbYGJPKP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jul 2008 11:10:15 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org

Compile tested only.
No functional change without explicitly setting a boot param or a .config 
option.
---

ACPI: Provide a spec conform OSI interface not returning true for Windows to 
the BIOS

Introduce acpi_osi=windows_false boot parameter
Introduce CONFIG_ACPI_OSI_SPEC_CONFORM config option

This will return false to _OSI("Windows XY") calls.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 Documentation/kernel-parameters.txt |    1 +
 drivers/acpi/Kconfig                |   12 ++++++++++++
 drivers/acpi/osl.c                  |   28 ++++++++++++++++++++++------
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/kernel-parameters.txt 
b/Documentation/kernel-parameters.txt
index c657339..6acfe8e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -178,6 +178,7 @@ and is between 256 and 4096 characters. It is defined in 
the file
 	acpi_osi=	[HW,ACPI] Modify list of supported OS interface strings
 			acpi_osi="string1"	# add string1 -- only one string
 			acpi_osi="!string2"	# remove built-in string2
+			acpi_osi="windows_false"# remove all Windows strings
 			acpi_osi=		# disable all strings
 
 	acpi_serialize	[HW,ACPI] force serialization of AML methods
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c52fca8..5fac9c9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -314,6 +314,18 @@ config ACPI_BLACKLIST_YEAR
 	  Enter 0 to disable this mechanism and allow ACPI to
 	  run by default no matter what the year.  (default)
 
+config ACPI_OSI_WINDOWS_FALSE
+	bool "Return false for Window strings for OSI(\"string\") BIOS calls"
+	default n
+	help
+	  By default Linux tries to stay transparent to Windows OSes to the
+	  BIOS and returns true for all currently known Windows OS strings and
+	  false for Linux.
+	  With this option set, OSI will return false for Windows strings.
+	  The kernel will still return false for _OSI("Linux") BIOS calls
+	  by default, but eventually return true for _OSI("Linux"), depending
+	  on a blacklist.
+
 config ACPI_DEBUG
 	bool "Debug Statements"
 	default n
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 235a138..bf951f6 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -194,11 +194,6 @@ static int __init acpi_reserve_resources(void)
 }
 device_initcall(acpi_reserve_resources);
 
-acpi_status __init acpi_os_initialize(void)
-{
-	return AE_OK;
-}
-
 acpi_status acpi_os_initialize1(void)
 {
 	kacpid_wq = create_singlethread_workqueue("kacpid");
@@ -943,7 +938,7 @@ static void __init set_osi_linux(unsigned int enable)
 	if (osi_linux.enable != enable) {
 		osi_linux.enable = enable;
 		printk(KERN_NOTICE PREFIX "%sed _OSI(Linux)\n",
-			enable ? "Add": "Delet");
+			enable ? "Add": "Delete");
 	}
 	return;
 }
@@ -972,6 +967,25 @@ void __init acpi_dmi_osi_linux(int enable, const struct 
dmi_system_id *d)
 	return;
 }
 
+static void __init acpi_osi_windows_false(void) {
+
+	acpi_osi_invalidate("Windows 2000");
+	acpi_osi_invalidate("Windows 2001");
+	acpi_osi_invalidate("Windows 2001 SP1");
+	acpi_osi_invalidate("Windows 2001 SP2");
+	acpi_osi_invalidate("Windows 2001.1");
+	acpi_osi_invalidate("Windows 2001.1 SP1");
+	acpi_osi_invalidate("Windows 2006");
+}
+
+acpi_status __init acpi_os_initialize(void)
+{
+#ifdef CONFIG_ACPI_OSI_WINDOWS_FALSE
+	acpi_osi_windows_false();
+#endif
+	return AE_OK;
+}
+
 /*
  * Modify the list of "OS Interfaces" reported to BIOS via _OSI
  *
@@ -984,6 +998,8 @@ int __init acpi_osi_setup(char *str)
 	if (str == NULL || *str == '\0') {
 		printk(KERN_INFO PREFIX "_OSI method disabled\n");
 		acpi_gbl_create_osi_method = FALSE;
+	} else if (strcmp("windows_false", str)) {
+		acpi_osi_windows_false();
 	} else if (!strcmp("!Linux", str)) {
 		acpi_cmdline_osi_linux(0);	/* !enable */
 	} else if (*str == '!') {
-- 
1.5.4.5

