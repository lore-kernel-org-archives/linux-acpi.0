From: yakui_zhao <yakui.zhao@intel.com>
Subject: [Resend] [PATCH]: ACPI: Add the dmi check to make
	acpi_enforce_resources strict
Date: Fri, 13 Mar 2009 15:11:23 +0800
Message-ID: <1236928283.3640.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57092 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbZCMHKi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Mar 2009 03:10:38 -0400
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
   Now the following are added in the dmi check table:
    a. Asus EEEPC 702/900/901
    b. Asus P6T Delux
    c. Dell 1537

http://bugzilla.kernel.org/show_bug.cgi?id=12376
http://bugzilla.kernel.org/show_bug.cgi?id=12541
  
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Jean  Delvare <khali@linux-fr.org>
---
 drivers/acpi/osl.c |   92 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 22 deletions(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c	2009-03-12 15:27:19.000000000 +0800
+++ linux-2.6/drivers/acpi/osl.c	2009-03-13 14:52:08.000000000 +0800
@@ -134,6 +134,68 @@
 	unsigned int	cmdline:1;
 	unsigned int	known:1;
 } osi_linux = { 0, 0, 0, 0};
+/* Check of resource interference between native drivers and ACPI
+ * OperationRegions (SystemIO and System Memory only).
+ * IO ports and memory declared in ACPI might be used by the ACPI subsystem
+ * in arbitrary AML code and can interfere with legacy drivers.
+ * acpi_enforce_resources= can be set to:
+ *
+ *   - strict           (2)
+ *     -> further driver trying to access the resources will not load
+ *   - lax (default)    (1)
+ *     -> further driver trying to access the resources will load, but you
+ *     get a system message that something might go wrong...
+ *
+ *   - no               (0)
+ *     -> ACPI Operation Region resources will not be registered
+ *
+ */
+
+#define ENFORCE_RESOURCES_STRICT 2
+#define ENFORCE_RESOURCES_LAX    1
+#define ENFORCE_RESOURCES_NO     0
+
+static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
+static struct dmi_system_id __initdata acpi_resources_dmi_table[] = {
+	{
+	.ident = "Asus EEEPC-901",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+		DMI_MATCH(DMI_BOARD_NAME, "901"),
+		},
+	},
+	{
+	.ident = "Asus P6T DELUXE",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+		DMI_MATCH(DMI_BOARD_NAME, "P6T DELUXE"),
+		},
+	},
+	{
+	.ident = "Asus EEEPC-702",
+	.matches = {
+		DMI_MATCH(DMI_PRODUCT_NAME, "Eee PC"),
+		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+		DMI_MATCH(DMI_BOARD_NAME, "702"),
+		},
+	},
+	{
+	.ident = "Dell 1537",
+	.matches = {
+		DMI_MATCH(DMI_PRODUCT_NAME, "Studio 1537"),
+		DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_BOARD_NAME, "0P132H"),
+		},
+	},
+	{
+	.ident = "Asus EEEPC-900",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+		DMI_MATCH(DMI_BOARD_NAME, "900"),
+		},
+	},
+	{},
+};
 
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
@@ -179,6 +241,14 @@
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
@@ -1057,28 +1127,6 @@
 
 __setup("acpi_wake_gpes_always_on", acpi_wake_gpes_always_on_setup);
 
-/* Check of resource interference between native drivers and ACPI
- * OperationRegions (SystemIO and System Memory only).
- * IO ports and memory declared in ACPI might be used by the ACPI subsystem
- * in arbitrary AML code and can interfere with legacy drivers.
- * acpi_enforce_resources= can be set to:
- *
- *   - strict           (2)
- *     -> further driver trying to access the resources will not load
- *   - lax (default)    (1)
- *     -> further driver trying to access the resources will load, but you
- *     get a system message that something might go wrong...
- *
- *   - no               (0)
- *     -> ACPI Operation Region resources will not be registered
- *
- */
-#define ENFORCE_RESOURCES_STRICT 2
-#define ENFORCE_RESOURCES_LAX    1
-#define ENFORCE_RESOURCES_NO     0
-
-static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
-
 static int __init acpi_enforce_resources_setup(char *str)
 {
 	if (str == NULL || *str == '\0')


