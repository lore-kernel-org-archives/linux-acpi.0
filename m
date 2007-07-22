From: Len Brown <len.brown@intel.com>
Subject: [PATCH 18/77] ACPI: disable _OSI(Linux) by default
Date: Sun, 22 Jul 2007 05:14:03 -0400
Message-ID: <1185095721166-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5737 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762620AbXGVJPW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:22 -0400
In-Reply-To: <11850957192175-git-send-email-len.brown@intel.com>
Message-Id: <072971d7d3e70ddac5c5be3436d929470cc2b3fb.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

In Linux-2.6.22 we expanded the boot parameter osi=
so that it can enable and !enable an OSI string.

_OSI(Linux) is a special case because we know that there
are both systems that require it set, and systems
require that it _not_ to be set.  In the long term it can't
be set, for the same reason _OS(Linux) can't be enabled --
it tends to confuse BIOS that are not properly
validated with Linux.  Further, the semantics and version
information of _OSI(Linux) were never actually defined.

The kernel prints out a message if it sees _OSI(Linux)
requested, and there is a DMI workaround to invoke
"osi=Linux" automatically for existing systems that need it.

http://bugzilla.kernel.org/show_bug.cgi?id=7787

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   38 +-------------------------------------
 1 files changed, 1 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 58ceb18..3f244eb 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,13 +77,7 @@ static struct workqueue_struct *kacpi_notify_wq;
 #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
 static char osi_additional_string[OSI_STRING_LENGTH_MAX];
 
-#define OSI_LINUX_ENABLED
-#ifdef	OSI_LINUX_ENABLED
-int osi_linux = 1;	/* enable _OSI(Linux) by default */
-#else
 int osi_linux;		/* disable _OSI(Linux) by default */
-#endif
-
 
 #ifdef CONFIG_DMI
 static struct __initdata dmi_system_id acpi_osl_dmi_table[];
@@ -1183,17 +1177,10 @@ acpi_os_validate_interface (char *interface)
 	if (!strcmp("Linux", interface)) {
 		printk(KERN_WARNING PREFIX
 			"System BIOS is requesting _OSI(Linux)\n");
-#ifdef	OSI_LINUX_ENABLED
-		printk(KERN_WARNING PREFIX
-			"Please test with \"acpi_osi=!Linux\"\n"
-			"Please send dmidecode "
-			"to linux-acpi@vger.kernel.org\n");
-#else
 		printk(KERN_WARNING PREFIX
 			"If \"acpi_osi=Linux\" works better,\n"
 			"Please send dmidecode "
 			"to linux-acpi@vger.kernel.org\n");
-#endif
 		if(osi_linux)
 			return AE_OK;
 	}
@@ -1227,36 +1214,14 @@ acpi_os_validate_address (
 }
 
 #ifdef CONFIG_DMI
-#ifdef	OSI_LINUX_ENABLED
-static int dmi_osi_not_linux(struct dmi_system_id *d)
-{
-	printk(KERN_NOTICE "%s detected: requires not _OSI(Linux)\n", d->ident);
-	enable_osi_linux(0);
-	return 0;
-}
-#else
 static int dmi_osi_linux(struct dmi_system_id *d)
 {
-	printk(KERN_NOTICE "%s detected: requires _OSI(Linux)\n", d->ident);
+	printk(KERN_NOTICE "%s detected: enabling _OSI(Linux)\n", d->ident);
 	enable_osi_linux(1);
 	return 0;
 }
-#endif
 
 static struct dmi_system_id acpi_osl_dmi_table[] __initdata = {
-#ifdef	OSI_LINUX_ENABLED
-	/*
-	 * Boxes that need NOT _OSI(Linux)
-	 */
-	{
-	 .callback = dmi_osi_not_linux,
-	 .ident = "Toshiba Satellite P100",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "TOSHIBA"),
-		     DMI_MATCH(DMI_BOARD_NAME, "Satellite P100"),
-		     },
-	 },
-#else
 	/*
 	 * Boxes that need _OSI(Linux)
 	 */
@@ -1268,7 +1233,6 @@ static struct dmi_system_id acpi_osl_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_BOARD_NAME, "MPAD-MSAE Customer Reference Boards"),
 		     },
 	 },
-#endif
 	{}
 };
 #endif /* CONFIG_DMI */
-- 
1.5.3.rc2.22.g69a9b
