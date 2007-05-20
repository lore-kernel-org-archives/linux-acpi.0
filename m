From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] ACPI: disable _OSI(Linux) by default
Date: Sun, 20 May 2007 16:57:49 -0400
Message-ID: <200705201657.49058.lenb@kernel.org>
References: <200705201653.52199.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53288 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756325AbXETU7H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 May 2007 16:59:07 -0400
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l4KKvsu3011403
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sun, 20 May 2007 20:59:04 GMT
In-Reply-To: <200705201653.52199.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

_OSI("Linux") is like _OS("Linux"), it is ill-defined and
virtually no BIOS vendors test interaction with it.
As a result, it can do more damage than good because
it causes the BIOS to follow un-tested paths.

Recently, several machines have turned up that erroneously
test this string in a way which causes them to not test other
compatibility strings, including the ZI9 and Toshiba.
So it appears that this bad code has made it into
a BIOS vendor's reference BIOS.

Linux has no choice but to stop advertising compatibility
with _OSI string "Linux" - as there are an unbounded
number of possible incompatibilities going forward.

But some BIOSes have already shipped which do use it
for things like conditionally re-enabling video on resume
from S3.  (They should have done it unconditionally)
To avoid breaking these boxes, add a DMI list, and
squawk when we see others which may need to be on the list.

http://bugzilla.kernel.org/show_bug.cgi?id=7787

Signed-off-by: Len Brown <len.brown@intel.com>
---
 osl.c              |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 utilities/uteval.c |    1 -
 2 files changed, 49 insertions(+), 1 deletion(-)

Index: linus/drivers/acpi/osl.c
===================================================================
--- linus.orig/drivers/acpi/osl.c
+++ linus/drivers/acpi/osl.c
@@ -33,6 +33,7 @@
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/workqueue.h>
 #include <linux/nmi.h>
 #include <linux/acpi.h>
@@ -75,6 +76,11 @@ static struct workqueue_struct *kacpi_no
 
 #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
 static char osi_additional_string[OSI_STRING_LENGTH_MAX];
+int osi_linux;	/* set to match on _OSI(Linux)*/
+
+#ifdef CONFIG_DMI
+static struct dmi_system_id __initdata acpi_osl_dmi_table[];
+#endif
 
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
@@ -126,6 +132,7 @@ device_initcall(acpi_reserve_resources);
 
 acpi_status acpi_os_initialize(void)
 {
+	dmi_check_system(acpi_osl_dmi_table);
 	return AE_OK;
 }
 
@@ -963,6 +970,12 @@ static int __init acpi_os_name_setup(cha
 
 __setup("acpi_os_name=", acpi_os_name_setup);
 
+static void enable_osi_linux(void) {
+	osi_linux = 1;
+	printk(KERN_INFO PREFIX "Enabled _OSI(Linux)\n");
+	return;
+}
+
 /*
  * Modify the list of "OS Interfaces" reported to BIOS via _OSI
  *
@@ -978,6 +991,8 @@ static int __init acpi_osi_setup(char *s
 	} else if (*str == '!') {
 		if (acpi_osi_invalidate(++str) == AE_OK)
 			printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
+	} else if (!strcmp("Linux", str)) {
+		enable_osi_linux();
 	} else if (*osi_additional_string == '\0') {
 		strncpy(osi_additional_string, str, OSI_STRING_LENGTH_MAX);
 		printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
@@ -1152,6 +1167,16 @@ acpi_os_validate_interface (char *interf
 {
 	if (!strncmp(osi_additional_string, interface, OSI_STRING_LENGTH_MAX))
 		return AE_OK;
+	if (!strcmp("Linux", interface)) {
+		if(osi_linux)
+			return AE_OK;
+		else
+			printk(KERN_WARNING PREFIX
+				"System is requesting _OSI(Linux)\n");
+			printk(KERN_WARNING PREFIX
+				"If \"acpi_osi=Linux\" helps, send dmidecode "
+				"to linux-acpi@vger.kernel.org\n");
+	}
 	return AE_SUPPORT;
 }
 
@@ -1181,5 +1206,29 @@ acpi_os_validate_address (
     return AE_OK;
 }
 
+#ifdef CONFIG_DMI
+static int __init dmi_osi_linux(struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE "%s detected: requires _OSI(Linux)\n",
+	       d->ident);
+	enable_osi_linux();
+	return 0;
+}
+
+static struct dmi_system_id __initdata acpi_osl_dmi_table[] = {
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
+	{}
+};
+#endif /* CONFIG_DMI */
 
 #endif
Index: linus/drivers/acpi/utilities/uteval.c
===================================================================
--- linus.orig/drivers/acpi/utilities/uteval.c
+++ linus/drivers/acpi/utilities/uteval.c
@@ -62,7 +62,6 @@ acpi_ut_translate_one_cid(union acpi_ope
 static char *acpi_interfaces_supported[] = {
 	/* Operating System Vendor Strings */
 
-	"Linux",
 	"Windows 2000",
 	"Windows 2001",
 	"Windows 2001 SP0",
