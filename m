From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPI: Rename kernel parameter "acpi_serialize" to "acpi_no_auto_serialize" to avoid confusions.
Date: Wed,  5 Mar 2014 08:46:58 +0800
Message-ID: <cbb0f3a67357b1ecdae4ee679b3bb36d940787b7.1393980325.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17889 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754490AbaCEArc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Mar 2014 19:47:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The new method auto-serialization feature has re-used old "acpi_serialize"
kernel parameter to complete the story of upgrading the original
implementation.  While these 2 features actually have slight differences.
In order not to confuse the users who are familiar with the behavior of the
old feature, this patch changes the name of the kernel parameter that is
used for the new feature into "acpi_no_auto_serialize".

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/kernel-parameters.txt |   18 ++++++++----------
 drivers/acpi/osl.c                  |   16 +++++-----------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 3ca3167..91f0be8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -229,6 +229,14 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			use by PCI
 			Format: <irq>,<irq>...
 
+	acpi_no_auto_serialize	[HW,ACPI]
+			Disable auto-serialization of AML methods
+			AML control methods that contain the opcodes to create
+			named objects will be marked as "Serialized" by the
+			auto-serialization feature.
+			This feature is enabled by default.
+			This option allows to turn off the feature.
+
 	acpi_no_auto_ssdt	[HW,ACPI] Disable automatic loading of SSDT
 
 	acpica_no_return_repair [HW, ACPI]
@@ -306,16 +314,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
 
-	acpi_serialize=	[HW,ACPI] configure auto-serialization of AML methods
-			Format: { on | off }
-			on -- enable auto-serialization of AML methods
-			off -- disable auto-serialization of AML methods
-			AML control methods that contain the opcodes to create
-			named objects will be marked as "Serialized" by the
-			auto-serialization feature.
-			This feature is enabled by default.
-			This option allows to turn on/off the feature.
-
 	acpi_skip_timer_override [HW,ACPI]
 			Recognize and ignore IRQ0/pin2 Interrupt Override.
 			For broken nForce2 BIOS resulting in XT-PIC timer.
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index a35928f..a3109ff 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1540,26 +1540,20 @@ static int __init osi_setup(char *str)
 __setup("acpi_osi=", osi_setup);
 
 /*
- * Configure the auto-serialization of named objects creation methods.
+ * Disable the auto-serialization of named objects creation methods.
  *
  * This feature is enabled by default.  It marks the AML control methods
  * that contain the opcodes to create named objects as "Serialized".
  */
-static int __init acpi_serialize_setup(char *str)
+static int __init acpi_no_auto_serialize_setup(char *str)
 {
-
-	if (str && !strcmp("on", str)) {
-		acpi_gbl_auto_serialize_methods = TRUE;
-		pr_info("ACPI: auto-serialization enabled\n");
-	} else if (str && !strcmp("off", str)) {
-		acpi_gbl_auto_serialize_methods = FALSE;
-		pr_info("ACPI: auto-serialization disabled\n");
-	}
+	acpi_gbl_auto_serialize_methods = FALSE;
+	pr_info("ACPI: auto-serialization disabled\n");
 
 	return 1;
 }
 
-__setup("acpi_serialize=", acpi_serialize_setup);
+__setup("acpi_no_auto_serialize", acpi_no_auto_serialize_setup);
 
 /* Check of resource interference between native drivers and ACPI
  * OperationRegions (SystemIO and System Memory only).
-- 
1.7.10

