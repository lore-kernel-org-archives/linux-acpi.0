From: Len Brown <len.brown@intel.com>
Subject: [PATCH 4/8] ACPI: Make _OSI(Linux) a special case
Date: Sat,  2 Jun 2007 01:15:40 -0400
Message-ID: <11807613471928-git-send-email-len.brown@intel.com>
References: <1180761344795-git-send-email-len.brown@intel.com>
 <11807613453368-git-send-email-len.brown@intel.com>
 <11807613463371-git-send-email-len.brown@intel.com>
 <1180761346136-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48596 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317AbXFBFPs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Jun 2007 01:15:48 -0400
In-Reply-To: <1180761346136-git-send-email-len.brown@intel.com>
Message-Id: <f507654d450d329c81a70eec0096d5dfe67802ec.1180761191.git.len.brown@intel.com>
In-Reply-To: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
References: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

_OSI("Linux") is like _OS("Linux"), it is ill-defined and
virtually no BIOS vendors test interaction with it.
As a result, it can do more damage than good because
it causes the BIOS to follow un-tested paths.

Recently, several machines have turned up that erroneously
test this string in a way which causes them to _not_ test other
compatibility strings, including the ZI9 and Toshiba.
So it appears that this bad code has made it into
a BIOS vendor's reference BIOS.

Linux has no choice but to stop advertising compatibility
with _OSI string "Linux" - as there are an unbounded
number of possible incompatibilities going forward.

But some BIOSes have already shipped which do use it
for things like conditionally re-enabling video on resume
from S3.  (Too bad they didn't do that unconditionally)

Add special case code for _OSI(Linux)
Squawk to dmesg if _OSI(Linux) is requested
Add DMI list both to enable and disable _OSI(Linux)
But for now, keep the default enabled via
#define OSI_LINUX_ENABLED.

http://bugzilla.kernel.org/show_bug.cgi?id=7787

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c              |   91 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/utilities/uteval.c |    1 -
 2 files changed, 91 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f4760cf..e349879 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -33,6 +33,7 @@
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/workqueue.h>
 #include <linux/nmi.h>
 #include <linux/acpi.h>
@@ -76,6 +77,18 @@ static struct workqueue_struct *kacpi_notify_wq;
 #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
 static char osi_additional_string[OSI_STRING_LENGTH_MAX];
 
+#define OSI_LINUX_ENABLED
+#ifdef	OSI_LINUX_ENABLED
+int osi_linux = 1;	/* enable _OSI(Linux) by default */
+#else
+int osi_linux;		/* disable _OSI(Linux) by default */
+#endif
+
+
+#ifdef CONFIG_DMI
+static struct dmi_system_id acpi_osl_dmi_table[];
+#endif
+
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
 {
@@ -126,6 +139,7 @@ device_initcall(acpi_reserve_resources);
 
 acpi_status acpi_os_initialize(void)
 {
+	dmi_check_system(acpi_osl_dmi_table);
 	return AE_OK;
 }
 
@@ -963,6 +977,16 @@ static int __init acpi_os_name_setup(char *str)
 
 __setup("acpi_os_name=", acpi_os_name_setup);
 
+static void enable_osi_linux(int enable) {
+
+	if (osi_linux != enable)
+		printk(KERN_INFO PREFIX "%sabled _OSI(Linux)\n",
+			enable ? "En": "Dis");
+
+	osi_linux = enable;
+	return;
+}
+
 /*
  * Modify the list of "OS Interfaces" reported to BIOS via _OSI
  *
@@ -978,6 +1002,10 @@ static int __init acpi_osi_setup(char *str)
 	} else if (*str == '!') {
 		if (acpi_osi_invalidate(++str) == AE_OK)
 			printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
+	} else if (!strcmp("!Linux", str)) {
+		enable_osi_linux(0);
+	} else if (!strcmp("Linux", str)) {
+		enable_osi_linux(1);
 	} else if (*osi_additional_string == '\0') {
 		strncpy(osi_additional_string, str, OSI_STRING_LENGTH_MAX);
 		printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
@@ -1152,6 +1180,23 @@ acpi_os_validate_interface (char *interface)
 {
 	if (!strncmp(osi_additional_string, interface, OSI_STRING_LENGTH_MAX))
 		return AE_OK;
+	if (!strcmp("Linux", interface)) {
+		printk(KERN_WARNING PREFIX
+			"System BIOS is requesting _OSI(Linux)\n");
+#ifdef	OSI_LINUX_ENABLED
+		printk(KERN_WARNING PREFIX
+			"Please test with \"acpi_osi=!Linux\"\n"
+			"Please send dmidecode "
+			"to linux-acpi@vger.kernel.org\n");
+#else
+		printk(KERN_WARNING PREFIX
+			"If \"acpi_osi=Linux\" works better,\n"
+			"Please send dmidecode "
+			"to linux-acpi@vger.kernel.org\n");
+#endif
+		if(osi_linux)
+			return AE_OK;
+	}
 	return AE_SUPPORT;
 }
 
@@ -1181,5 +1226,51 @@ acpi_os_validate_address (
     return AE_OK;
 }
 
+#ifdef CONFIG_DMI
+#ifdef	OSI_LINUX_ENABLED
+static int dmi_osi_not_linux(struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE "%s detected: requires not _OSI(Linux)\n", d->ident);
+	enable_osi_linux(0);
+	return 0;
+}
+#else
+static int dmi_osi_linux(struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE "%s detected: requires _OSI(Linux)\n", d->ident);
+	enable_osi_linux(1);
+	return 0;
+}
+#endif
+
+static struct dmi_system_id acpi_osl_dmi_table[] = {
+#ifdef	OSI_LINUX_ENABLED
+	/*
+	 * Boxes that need NOT _OSI(Linux)
+	 */
+	{
+	 .callback = dmi_osi_not_linux,
+	 .ident = "Toshiba Satellite P100",
+	 .matches = {
+		     DMI_MATCH(DMI_BOARD_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_BOARD_NAME, "Satellite P100"),
+		     },
+	 },
+#else
+	/*
+	 * Boxes that need _OSI(Linux)
+	 */
+	{
+	 .callback = dmi_osi_linux,
+	 .ident = "Intel Napa CRB",
+	 .matches = {
+		     DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+		     DMI_MATCH(DMI_BOARD_NAME, "MPAD-MSAE Customer Reference Boards"),
+		     },
+	 },
+#endif
+	{}
+};
+#endif /* CONFIG_DMI */
 
 #endif
diff --git a/drivers/acpi/utilities/uteval.c b/drivers/acpi/utilities/uteval.c
index a10120a..8ec6f8e 100644
--- a/drivers/acpi/utilities/uteval.c
+++ b/drivers/acpi/utilities/uteval.c
@@ -62,7 +62,6 @@ acpi_ut_translate_one_cid(union acpi_operand_object *obj_desc,
 static char *acpi_interfaces_supported[] = {
 	/* Operating System Vendor Strings */
 
-	"Linux",
 	"Windows 2000",
 	"Windows 2001",
 	"Windows 2001 SP0",
-- 
1.5.2.146.gb75c6
