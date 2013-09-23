From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 12/14] ACPICA: Cleanup exception codes.
Date: Mon, 23 Sep 2013 09:52:40 +0800
Message-ID: <608e5c20faa6202d445fd0c1fffe371d2c40a87e.1379900697.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com> <cover.1379900697.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45038 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186Ab3IWBwo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Sep 2013 21:52:44 -0400
In-Reply-To: <cover.1379900697.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch adds AE_ACCESS for EACCES or EPERM.  Some error prompts are
also cleaned up in this patch.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acexcep.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index cf051e0..4e280bd 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -125,8 +125,9 @@ struct acpi_exception_info {
 #define AE_NO_HANDLER                   EXCEP_ENV (0x001A)
 #define AE_OWNER_ID_LIMIT               EXCEP_ENV (0x001B)
 #define AE_NOT_CONFIGURED               EXCEP_ENV (0x001C)
+#define AE_ACCESS                       EXCEP_ENV (0x001D)
 
-#define AE_CODE_ENV_MAX                 0x001C
+#define AE_CODE_ENV_MAX                 0x001D
 
 /*
  * Programmer exceptions
@@ -227,7 +228,7 @@ static const struct acpi_exception_info acpi_gbl_exception_names_env[] = {
 	EXCEP_TXT("AE_NO_ACPI_TABLES", "ACPI tables could not be found"),
 	EXCEP_TXT("AE_NO_NAMESPACE", "A namespace has not been loaded"),
 	EXCEP_TXT("AE_NO_MEMORY", "Insufficient dynamic memory"),
-	EXCEP_TXT("AE_NOT_FOUND", "The name was not found in the namespace"),
+	EXCEP_TXT("AE_NOT_FOUND", "A requested entity is not found"),
 	EXCEP_TXT("AE_NOT_EXIST", "A required entity does not exist"),
 	EXCEP_TXT("AE_ALREADY_EXISTS", "An entity already exists"),
 	EXCEP_TXT("AE_TYPE", "The object type is incorrect"),
@@ -259,7 +260,8 @@ static const struct acpi_exception_info acpi_gbl_exception_names_env[] = {
 	EXCEP_TXT("AE_OWNER_ID_LIMIT",
 		  "There are no more Owner IDs available for ACPI tables or control methods"),
 	EXCEP_TXT("AE_NOT_CONFIGURED",
-		  "The interface is not part of the current subsystem configuration")
+		  "The interface is not part of the current subsystem configuration"),
+	EXCEP_TXT("AE_ACCESS", "Permission denied for the requested operation")
 };
 
 static const struct acpi_exception_info acpi_gbl_exception_names_pgm[] = {
-- 
1.7.10

