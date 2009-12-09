From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/14] ACPICA: Reduce severity of predefined repair messages,
 Warning to Info
Date: Wed, 09 Dec 2009 12:22:07 -0500
Message-ID: <7df200cd980442868f5579c0880a9221da628d17.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:48205 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbZLIRW3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:22:29 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUE00F8IAX7MMZN@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:22:25 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
In-reply-to: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Since the object was successfully repaired, a Warning is too
severe.  Reduced to Info for now. We may eventually change these
messages to debug-only. ACPICA BZ 812.

http://www.acpica.org/bugzilla/show_bug.cgi?id=812

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    3 ++
 drivers/acpi/acpica/acutils.h  |    5 ++++
 drivers/acpi/acpica/nsrepair.c |    8 +++---
 drivers/acpi/acpica/utmisc.c   |   42 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 3acd9c6..7d9ba6e 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -341,6 +341,7 @@
 #define ACPI_ERROR_NAMESPACE(s, e)      acpi_ns_report_error (AE_INFO, s, e);
 #define ACPI_ERROR_METHOD(s, n, p, e)   acpi_ns_report_method_error (AE_INFO, s, n, p, e);
 #define ACPI_WARN_PREDEFINED(plist)     acpi_ut_predefined_warning plist
+#define ACPI_INFO_PREDEFINED(plist)     acpi_ut_predefined_info plist
 
 #else
 
@@ -349,6 +350,8 @@
 #define ACPI_ERROR_NAMESPACE(s, e)
 #define ACPI_ERROR_METHOD(s, n, p, e)
 #define ACPI_WARN_PREDEFINED(plist)
+#define ACPI_INFO_PREDEFINED(plist)
+
 #endif		/* ACPI_NO_ERROR_MESSAGES */
 
 /*
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 863a264..f920d89 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -481,6 +481,11 @@ acpi_ut_predefined_warning(const char *module_name,
 			   char *pathname,
 			   u8 node_flags, const char *format, ...);
 
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_info(const char *module_name,
+			u32 line_number,
+			char *pathname, u8 node_flags, const char *format, ...);
+
 /* Values for Base above (16=Hex, 10=Decimal) */
 
 #define ACPI_ANY_BASE        0
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index f2f5269..d563f1a 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -185,14 +185,14 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 			return_object->common.reference_count--;
 		}
 
-		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
 				      "Converted %s to expected %s at index %u",
 				      acpi_ut_get_object_type_name
 				      (return_object),
 				      acpi_ut_get_object_type_name(new_object),
 				      package_index));
 	} else {
-		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
 				      "Converted %s to expected %s",
 				      acpi_ut_get_object_type_name
 				      (return_object),
@@ -254,8 +254,8 @@ acpi_ns_repair_package_list(struct acpi_predefined_data *data,
 	*obj_desc_ptr = pkg_obj_desc;
 	data->flags |= ACPI_OBJECT_REPAIRED;
 
-	ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
-			      "Incorrectly formed Package, attempting repair"));
+	ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+			      "Repaired Incorrectly formed Package"));
 
 	return (AE_OK);
 }
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 61f6315..6c6a513 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -1161,3 +1161,45 @@ acpi_ut_predefined_warning(const char *module_name,
 	ACPI_COMMON_MSG_SUFFIX;
 	va_end(args);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_predefined_info
+ *
+ * PARAMETERS:  module_name     - Caller's module name (for error output)
+ *              line_number     - Caller's line number (for error output)
+ *              Pathname        - Full pathname to the node
+ *              node_flags      - From Namespace node for the method/object
+ *              Format          - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Info messages for the predefined validation module. Messages
+ *              are only emitted the first time a problem with a particular
+ *              method/object is detected. This prevents a flood of
+ *              messages for methods that are repeatedly evaluated.
+ *
+ ******************************************************************************/
+
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_info(const char *module_name,
+			u32 line_number,
+			char *pathname, u8 node_flags, const char *format, ...)
+{
+	va_list args;
+
+	/*
+	 * Warning messages for this method/object will be disabled after the
+	 * first time a validation fails or an object is successfully repaired.
+	 */
+	if (node_flags & ANOBJ_EVALUATED) {
+		return;
+	}
+
+	acpi_os_printf("ACPI Info for %s: ", pathname);
+
+	va_start(args, format);
+	acpi_os_vprintf(format, args);
+	ACPI_COMMON_MSG_SUFFIX;
+	va_end(args);
+}
-- 
1.6.0.6

