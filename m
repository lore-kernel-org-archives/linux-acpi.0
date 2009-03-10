From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Add the dmi check to make acpi_enforce_resources
	strict
Date: Tue, 10 Mar 2009 11:34:26 +0800
Message-ID: <1236656066.7060.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12484 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbZCJDdX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Mar 2009 23:33:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: Add the dmi check to make acpi_enforce_resources strict
From: Zhao Yakui <yakui.zhao@intel.com>

   On some boxes the SMBus PCI controller is not hidden. The SMbus I/O port
will be accessed in AML code. If the i2c driver is still loaded for the SMbus
PCI device, there is no synchronization between OS and BIOS. And the conflict
will happen.
   So the dmi check is added so that the acpi_enforce_resources is strict when
the box falls into the dmi check table. In such case the i2c driver won't be
loaded for the SMbus pci device.

http://bugzilla.kernel.org/show_bug.cgi?id=12376
  
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Jean  Delvare <khali@linux-fr.org>
---
 drivers/acpi/osl.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c	2009-03-10 09:38:33.000000000 +0800
+++ linux-2.6/drivers/acpi/osl.c	2009-03-10 11:30:45.000000000 +0800
@@ -135,6 +135,19 @@
 	unsigned int	known:1;
 } osi_linux = { 0, 0, 0, 0};
 
+#define ENFORCE_RESOURCES_STRICT 2
+#define ENFORCE_RESOURCES_LAX    1
+#define ENFORCE_RESOURCES_NO     0
+
+static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
+static struct dmi_system_id __initdata acpi_resources_dmi_table[] = {
+	{
+	NULL, "Asus EEEPC-901", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer INC."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "901") }, NULL},
+	{},
+};
+
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
 {
@@ -179,6 +192,14 @@
 		acpi_request_region(&acpi_gbl_FADT.xgpe1_block,
 			       acpi_gbl_FADT.gpe1_block_length, "ACPI GPE1_BLK");
 
+	/*
+	 * Only when the ACPI is enabled, the dmi table will be checked. If
+	 * the system falls into the dmi check table, the strict resource
+	 * check will be used.
+	 */
+	if (!acpi_disabled && dmi_check_system(acpi_resources_dmi_table))
+		acpi_enforce_resources = ENFORCE_RESOURCES_STRICT;
+
 	return 0;
 }
 device_initcall(acpi_reserve_resources);
@@ -1073,11 +1094,6 @@
  *     -> ACPI Operation Region resources will not be registered
  *
  */
-#define ENFORCE_RESOURCES_STRICT 2
-#define ENFORCE_RESOURCES_LAX    1
-#define ENFORCE_RESOURCES_NO     0
-
-static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
 
 static int __init acpi_enforce_resources_setup(char *str)
 {


