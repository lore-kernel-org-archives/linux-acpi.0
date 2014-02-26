From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/18] ACPICA: Add global option to disable method auto-serialization.
Date: Wed, 26 Feb 2014 10:31:45 +0800
Message-ID: <b7bc76511ab62b7d06a71792bf0fe6857a414e13.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37309 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbaBZCcA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:32:00 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change adds an option to disable the auto-serialization of
methods that create named objects.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=52191
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    9 +++++++++
 drivers/acpi/acpica/dsinit.c   |   18 +++++++++++-------
 include/acpi/acpixf.h          |    1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 203b2dc..7da6573 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -87,6 +87,15 @@
 u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_interpreter_slack, FALSE);
 
 /*
+ * Automatically serialize all methods that create named objects? Default
+ * is TRUE, meaning that all non_serialized methods are scanned once at
+ * table load time to determine those that create named objects. Methods
+ * that create named objects are marked Serialized in order to prevent
+ * possible run-time problems if they are entered by more than one thread.
+ */
+u8 ACPI_INIT_GLOBAL(acpi_gbl_auto_serialize_methods, TRUE);
+
+/*
  * Automatically serialize ALL control methods? Default is FALSE, meaning
  * to use the Serialized/not_serialized method flags on a per method basis.
  * Only change this if the ASL code is poorly written and cannot handle
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index eb46874..aee5e45 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -136,16 +136,20 @@ acpi_ds_init_one_object(acpi_handle obj_handle,
 			break;
 		}
 
-		/* Parse/scan method and serialize it if necessary */
+		if (acpi_gbl_auto_serialize_methods) {
 
-		acpi_ds_auto_serialize_method(node, obj_desc);
-		if (obj_desc->method.info_flags & ACPI_METHOD_SERIALIZED) {
+			/* Parse/scan method and serialize it if necessary */
 
-			/* Method was just converted to Serialized */
+			acpi_ds_auto_serialize_method(node, obj_desc);
+			if (obj_desc->method.
+			    info_flags & ACPI_METHOD_SERIALIZED) {
 
-			info->serial_method_count++;
-			info->serialized_method_count++;
-			break;
+				/* Method was just converted to Serialized */
+
+				info->serial_method_count++;
+				info->serialized_method_count++;
+				break;
+			}
 		}
 
 		info->non_serial_method_count++;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index bf2c274..3587768 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -73,6 +73,7 @@ extern u32 acpi_dbg_layer;
 
 /* ACPICA runtime options */
 
+extern u8 acpi_gbl_auto_serialize_methods;
 extern u8 acpi_gbl_all_methods_serialized;
 extern u8 acpi_gbl_copy_dsdt_locally;
 extern u8 acpi_gbl_create_osi_method;
-- 
1.7.10

