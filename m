From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] ACPI: extend acpi_osi= boot option
Date: Sun, 20 May 2007 16:53:52 -0400
Message-ID: <200705201653.52199.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60595 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756748AbXETUzJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 May 2007 16:55:09 -0400
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l4KKrvXL010391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sun, 20 May 2007 20:55:07 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Previously, "acpi_osi=" would completely disable the OS Interface strings
advertised by Linux to the BIOS.  This is unchanged, and now
acpi_osi="string" adds the interface string, and
acpi_osi="!string" invalidates the pre-defined interface string

eg. acpi_osi="!Windows 2006"
will disable our claim to be compatible with Vista.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    5 ++++-
 drivers/acpi/osl.c                  |   25 ++++++++++++++++---------
 drivers/acpi/utilities/uteval.c     |   27 ++++++++++++++++++++++++++-
 include/acpi/acpiosxf.h             |    1 +
 4 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 09220a1..1dd4fc1 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -170,7 +170,10 @@ and is between 256 and 4096 characters. It is defined in the file
 	acpi_os_name=	[HW,ACPI] Tell ACPI BIOS the name of the OS
 			Format: To spoof as Windows 98: ="Microsoft Windows"
 
-	acpi_osi=	[HW,ACPI] empty param disables _OSI
+	acpi_osi=	[HW,ACPI] Modify list of supported OS interface strings
+			acpi_osi="string1"	# add string1 -- only one string
+			acpi_osi="!string2"	# remove built-in string2
+			acpi_osi=		# disable all strings
 
 	acpi_serialize	[HW,ACPI] force serialization of AML methods
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index b998340..f4760cf 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -73,6 +73,9 @@ static void *acpi_irq_context;
 static struct workqueue_struct *kacpid_wq;
 static struct workqueue_struct *kacpi_notify_wq;
 
+#define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
+static char osi_additional_string[OSI_STRING_LENGTH_MAX];
+
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
 {
@@ -961,19 +964,23 @@ static int __init acpi_os_name_setup(char *str)
 __setup("acpi_os_name=", acpi_os_name_setup);
 
 /*
- * _OSI control
+ * Modify the list of "OS Interfaces" reported to BIOS via _OSI
+ *
  * empty string disables _OSI
- * TBD additional string adds to _OSI
+ * string starting with '!' disables that string
+ * otherwise string is added to list, augmenting built-in strings
  */
 static int __init acpi_osi_setup(char *str)
 {
 	if (str == NULL || *str == '\0') {
 		printk(KERN_INFO PREFIX "_OSI method disabled\n");
 		acpi_gbl_create_osi_method = FALSE;
-	} else {
-		/* TBD */
-		printk(KERN_ERR PREFIX "_OSI additional string ignored -- %s\n",
-		       str);
+	} else if (*str == '!') {
+		if (acpi_osi_invalidate(++str) == AE_OK)
+			printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
+	} else if (*osi_additional_string == '\0') {
+		strncpy(osi_additional_string, str, OSI_STRING_LENGTH_MAX);
+		printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
 	}
 
 	return 1;
@@ -1143,11 +1150,11 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 acpi_status
 acpi_os_validate_interface (char *interface)
 {
-
-    return AE_SUPPORT;
+	if (!strncmp(osi_additional_string, interface, OSI_STRING_LENGTH_MAX))
+		return AE_OK;
+	return AE_SUPPORT;
 }
 
-
 /******************************************************************************
  *
  * FUNCTION:    acpi_os_validate_address
diff --git a/drivers/acpi/utilities/uteval.c b/drivers/acpi/utilities/uteval.c
index 13d5879..a10120a 100644
--- a/drivers/acpi/utilities/uteval.c
+++ b/drivers/acpi/utilities/uteval.c
@@ -59,7 +59,7 @@ acpi_ut_translate_one_cid(union acpi_operand_object *obj_desc,
 /*
  * Strings supported by the _OSI predefined (internal) method.
  */
-static const char *acpi_interfaces_supported[] = {
+static char *acpi_interfaces_supported[] = {
 	/* Operating System Vendor Strings */
 
 	"Linux",
@@ -158,6 +158,31 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_osi_invalidate
+ *
+ * PARAMETERS:  interface_string
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: invalidate string in pre-defiend _OSI string list
+ *
+ ******************************************************************************/
+
+acpi_status acpi_osi_invalidate(char *interface)
+{
+	int i;
+
+	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
+		if (!ACPI_STRCMP(interface, acpi_interfaces_supported[i])) {
+			*acpi_interfaces_supported[i] = '\0';
+			return AE_OK;
+		}
+	}
+	return AE_NOT_FOUND;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ut_evaluate_object
  *
  * PARAMETERS:  prefix_node         - Starting node
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 5e07db0..de26ee1 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -236,6 +236,7 @@ acpi_os_derive_pci_id(acpi_handle rhandle,
  * Miscellaneous
  */
 acpi_status acpi_os_validate_interface(char *interface);
+acpi_status acpi_osi_invalidate(char* interface);
 
 acpi_status
 acpi_os_validate_address(u8 space_id,
