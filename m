From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 5/5] ACPICA: Enable auto-serialization as a default kernel behavior.
Date: Mon, 24 Mar 2014 14:49:22 +0800
Message-ID: <554d73c74bcae14ceef09bc88f68c91cda34e126.1395638745.git.lv.zheng@intel.com>
References: <cover.1395638745.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4965 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbaCXGtZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Mar 2014 02:49:25 -0400
In-Reply-To: <cover.1395638745.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The following commit introduces the auto-serialization facility as a
workaround that can be enabled by "acpi_auto_serialize":
   Subject: ACPICA: Add auto-serialization support for ill-behaved control
            methods.
This feature marks control methods that create named objects as
"Serialized" to avoid unwanted AE_ALREADY_EXISTS control method evaluation
failures.

The feature is extended or completed by the following commits:
1. An extension to fix a kernel bugzilla bug (Reference 1):
   Subject: ACPICA: Add additional named objects for the auto-serialize
            method scan.
2. A completion to fix a community reported bug (Reference 2):
   Subject: ACPICA: Ignore sync_level for methods that have been
            auto-serialized.

This patch enables auto-serialization as a default kernel behavior to
encourage people to use it.  The kernel parameter is also changed from
"acpi_auto_serialize" to "acpi_no_auto_serialize" to allow it to be
disabled at runtime.

For new issues are detected and fixed, please:
1. Before fixing it:
   1.1. Revert only this commit to restore this feature as a workaround;
2. Afeter fixing it:
   2.1. Merge new fixes;
   2.2. Add Subjects/Reference URLs of the new fixes into the description
        of this commit;
   2.3. Merge the description updated this commit to re-enable this feature
        as a default kernel behavior.

Reference 1: https://bugzilla.kernel.org/show_bug.cgi?id=52191
Reference 2: http://www.spinics.net/lists/linux-acpi/msg49496.html
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/kernel-parameters.txt |    8 ++++----
 drivers/acpi/acpica/acglobal.h      |    2 +-
 drivers/acpi/osl.c                  |   12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a159537..91f0be8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -229,13 +229,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			use by PCI
 			Format: <irq>,<irq>...
 
-	acpi_auto_serialize	[HW,ACPI]
-			Enable auto-serialization of AML methods
+	acpi_no_auto_serialize	[HW,ACPI]
+			Disable auto-serialization of AML methods
 			AML control methods that contain the opcodes to create
 			named objects will be marked as "Serialized" by the
 			auto-serialization feature.
-			This feature is disabled by default.
-			This option allows to turn on the feature.
+			This feature is enabled by default.
+			This option allows to turn off the feature.
 
 	acpi_no_auto_ssdt	[HW,ACPI] Disable automatic loading of SSDT
 
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index ea0f838..49bbc71 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -99,7 +99,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_enable_interpreter_slack, FALSE);
  * that create named objects are marked Serialized in order to prevent
  * possible run-time problems if they are entered by more than one thread.
  */
-ACPI_INIT_GLOBAL(u8, acpi_gbl_auto_serialize_methods, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_auto_serialize_methods, TRUE);
 
 /*
  * Create the predefined _OSI method in the namespace? Default is TRUE
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 928f0c2..d40d6dc 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1538,20 +1538,20 @@ static int __init osi_setup(char *str)
 __setup("acpi_osi=", osi_setup);
 
 /*
- * Enable the auto-serialization of named objects creation methods.
+ * Disable the auto-serialization of named objects creation methods.
  *
- * This feature is disabled by default.  It marks the AML control methods
+ * This feature is enabled by default.  It marks the AML control methods
  * that contain the opcodes to create named objects as "Serialized".
  */
-static int __init acpi_auto_serialize_setup(char *str)
+static int __init acpi_no_auto_serialize_setup(char *str)
 {
-	acpi_gbl_auto_serialize_methods = TRUE;
-	pr_info("ACPI: auto-serialization enabled\n");
+	acpi_gbl_auto_serialize_methods = FALSE;
+	pr_info("ACPI: auto-serialization disabled\n");
 
 	return 1;
 }
 
-__setup("acpi_auto_serialize", acpi_auto_serialize_setup);
+__setup("acpi_no_auto_serialize", acpi_no_auto_serialize_setup);
 
 /* Check of resource interference between native drivers and ACPI
  * OperationRegions (SystemIO and System Memory only).
-- 
1.7.10

