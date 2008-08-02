From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] ACPI: Provide a OSI interface that does not return true for Windows
Date: Sat,  2 Aug 2008 18:57:58 +0200
Message-ID: <1217696279-23848-2-git-send-email-trenn@suse.de>
References: <1217632817.4610.6.camel@hidalgo>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:60411 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755673AbYHBQ6D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Aug 2008 12:58:03 -0400
In-Reply-To: <1217632817.4610.6.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corsac@debian.org
Cc: ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, hmh@debian.org, Thomas Renninger <trenn@suse.de>

Introduce acpi_osi=windows_false boot parameter
This will return false to _OSI("Windows XY") calls.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 Documentation/kernel-parameters.txt |    1 +
 drivers/acpi/osl.c                  |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 0fea7c2..c1e397e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -182,6 +182,7 @@ and is between 256 and 4096 characters. It is defined in the file
 	acpi_osi=	[HW,ACPI] Modify list of supported OS interface strings
 			acpi_osi="string1"	# add string1 -- only one string
 			acpi_osi="!string2"	# remove built-in string2
+			acpi_osi="windows_false"# remove all Windows strings
 			acpi_osi=		# disable all strings
 
 	acpi_serialize	[HW,ACPI] force serialization of AML methods
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 235a138..bf42ef1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -943,7 +943,7 @@ static void __init set_osi_linux(unsigned int enable)
 	if (osi_linux.enable != enable) {
 		osi_linux.enable = enable;
 		printk(KERN_NOTICE PREFIX "%sed _OSI(Linux)\n",
-			enable ? "Add": "Delet");
+			enable ? "Add": "Delete");
 	}
 	return;
 }
@@ -972,6 +972,17 @@ void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
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
 /*
  * Modify the list of "OS Interfaces" reported to BIOS via _OSI
  *
@@ -984,6 +995,8 @@ int __init acpi_osi_setup(char *str)
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

