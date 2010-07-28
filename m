From: Lin Ming <ming.m.lin@intel.com>
Subject: [RFC][PATCH 4/4] ACPI: acpi_osi_setup uses the new interfaces
Date: Wed, 28 Jul 2010 14:28:27 +0800
Message-ID: <1280298507.20797.71.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40900 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab0G1G2S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jul 2010 02:28:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

acpi_os_validate_interface was removed from ACPICA core code.
Replace it with acpi_osi_handler.

acpi_osi_setup can't call acpi_install/remove_interface because ACPICA
is not initialized yet at this early time.
So we just save the osi string in acpi_osi_setup and will handle it
later in a new function acpi_osi_setup_late.

Signed-off-by: Lin Ming <ming.m.lin@intel.com> 
---
 drivers/acpi/acpica/utosi.c |   26 -------------
 drivers/acpi/osl.c          |   86 ++++++++++++++++++++++---------------------
 include/acpi/acpiosxf.h     |    3 -
 3 files changed, 44 insertions(+), 71 deletions(-)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 85bdcd7..fc7f2bd 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -362,29 +362,3 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 	walk_state->return_desc = return_desc;
 	return_ACPI_STATUS(AE_OK);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_osi_invalidate
- *
- * PARAMETERS:  interface_string
- *
- * RETURN:      Status
- *
- * DESCRIPTION: invalidate string in pre-defiend _OSI string list
- *
- ******************************************************************************/
-
-acpi_status acpi_osi_invalidate(char *interface)
-{
-	int i;
-
-	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_default_supported_interfaces); i++) {
-		if (!ACPI_STRCMP(interface, acpi_default_supported_interfaces[i].name)) {
-			*acpi_default_supported_interfaces[i].name = '\0';
-			return AE_OK;
-		}
-	}
-	return AE_NOT_FOUND;
-}
-
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 78418ce..aba7b1b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -96,7 +96,9 @@ static LIST_HEAD(resource_list_head);
 static DEFINE_SPINLOCK(acpi_res_lock);
 
 #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
-static char osi_additional_string[OSI_STRING_LENGTH_MAX];
+static char osi_setup_string[OSI_STRING_LENGTH_MAX];
+
+static void __init acpi_osi_setup_late(void);
 
 /*
  * The story of _OSI(Linux)
@@ -138,6 +140,18 @@ static struct osi_linux {
 	unsigned int	known:1;
 } osi_linux = { 0, 0, 0, 0};
 
+static void acpi_osi_handler(acpi_string interface)
+{
+	if (!strcmp("Linux", interface)) {
+
+		printk(KERN_NOTICE PREFIX
+			"BIOS _OSI(Linux) query %s%s\n",
+			osi_linux.enable ? "honored" : "ignored",
+			osi_linux.cmdline ? " via cmdline" :
+			osi_linux.dmi ? " via DMI" : "");
+	}
+}
+
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
 {
@@ -224,6 +238,8 @@ acpi_status acpi_os_initialize1(void)
 	BUG_ON(!kacpid_wq);
 	BUG_ON(!kacpi_notify_wq);
 	BUG_ON(!kacpi_hotplug_wq);
+	acpi_install_interface_handler(acpi_osi_handler);
+	acpi_osi_setup_late();
 	return AE_OK;
 }
 
@@ -996,6 +1012,12 @@ static void __init set_osi_linux(unsigned int enable)
 		printk(KERN_NOTICE PREFIX "%sed _OSI(Linux)\n",
 			enable ? "Add": "Delet");
 	}
+
+	if (osi_linux.enable)
+		acpi_install_interface("Linux");
+	else
+		acpi_remove_interface("Linux");
+
 	return;
 }
 
@@ -1030,21 +1052,33 @@ void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
  * string starting with '!' disables that string
  * otherwise string is added to list, augmenting built-in strings
  */
-int __init acpi_osi_setup(char *str)
+static void __init acpi_osi_setup_late(void)
 {
-	if (str == NULL || *str == '\0') {
-		printk(KERN_INFO PREFIX "_OSI method disabled\n");
-		acpi_gbl_create_osi_method = FALSE;
-	} else if (!strcmp("!Linux", str)) {
+	char *str = osi_setup_string;
+
+	if (*str == '\0')
+		return;
+
+	if (!strcmp("!Linux", str)) {
 		acpi_cmdline_osi_linux(0);	/* !enable */
 	} else if (*str == '!') {
-		if (acpi_osi_invalidate(++str) == AE_OK)
+		if (acpi_remove_interface(++str) == AE_OK)
 			printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
 	} else if (!strcmp("Linux", str)) {
 		acpi_cmdline_osi_linux(1);	/* enable */
-	} else if (*osi_additional_string == '\0') {
-		strncpy(osi_additional_string, str, OSI_STRING_LENGTH_MAX);
-		printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
+	} else {
+		if (acpi_install_interface(str) == AE_OK)
+			printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
+	}
+}
+
+int __init acpi_osi_setup(char *str)
+{
+	if (str == NULL || *str == '\0') {
+		printk(KERN_INFO PREFIX "_OSI method disabled\n");
+		acpi_gbl_create_osi_method = FALSE;
+	} else {
+		strncpy(osi_setup_string, str, OSI_STRING_LENGTH_MAX);
 	}
 
 	return 1;
@@ -1321,38 +1355,6 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 	return (AE_OK);
 }
 
-/******************************************************************************
- *
- * FUNCTION:    acpi_os_validate_interface
- *
- * PARAMETERS:  interface           - Requested interface to be validated
- *
- * RETURN:      AE_OK if interface is supported, AE_SUPPORT otherwise
- *
- * DESCRIPTION: Match an interface string to the interfaces supported by the
- *              host. Strings originate from an AML call to the _OSI method.
- *
- *****************************************************************************/
-
-acpi_status
-acpi_os_validate_interface (char *interface)
-{
-	if (!strncmp(osi_additional_string, interface, OSI_STRING_LENGTH_MAX))
-		return AE_OK;
-	if (!strcmp("Linux", interface)) {
-
-		printk(KERN_NOTICE PREFIX
-			"BIOS _OSI(Linux) query %s%s\n",
-			osi_linux.enable ? "honored" : "ignored",
-			osi_linux.cmdline ? " via cmdline" :
-			osi_linux.dmi ? " via DMI" : "");
-
-		if (osi_linux.enable)
-			return AE_OK;
-	}
-	return AE_SUPPORT;
-}
-
 static inline int acpi_res_list_add(struct acpi_res_list *res)
 {
 	struct acpi_res_list *res_list_elem;
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 29bf945..17d4f61 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -239,9 +239,6 @@ acpi_os_derive_pci_id(acpi_handle device,
 /*
  * Miscellaneous
  */
-acpi_status acpi_os_validate_interface(char *interface);
-acpi_status acpi_osi_invalidate(char* interface);
-
 acpi_status
 acpi_os_validate_address(u8 space_id, acpi_physical_address address,
 			 acpi_size length, char *name);




