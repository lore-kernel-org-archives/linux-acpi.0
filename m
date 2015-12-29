From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 25/42] ACPICA: Add new exception code, AE_IO_ERROR
Date: Tue, 29 Dec 2015 13:59:34 +0800
Message-ID: <cefbbee399a756e5e42e1dfaace23ba5a8793f90.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit dcaeaddfc11544f03e6323be4ac8ff8a1e014956

The intent for this exception is for low-level I/O operations,
especially Clib functions.

Link: https://github.com/acpica/acpica/commit/dcaeaddf
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acexcep.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 204f581..cd84b12 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -126,8 +126,9 @@ struct acpi_exception_info {
 #define AE_OWNER_ID_LIMIT               EXCEP_ENV (0x001B)
 #define AE_NOT_CONFIGURED               EXCEP_ENV (0x001C)
 #define AE_ACCESS                       EXCEP_ENV (0x001D)
+#define AE_IO_ERROR                     EXCEP_ENV (0x001E)
 
-#define AE_CODE_ENV_MAX                 0x001D
+#define AE_CODE_ENV_MAX                 0x001E
 
 /*
  * Programmer exceptions
@@ -263,7 +264,8 @@ static const struct acpi_exception_info acpi_gbl_exception_names_env[] = {
 		  "There are no more Owner IDs available for ACPI tables or control methods"),
 	EXCEP_TXT("AE_NOT_CONFIGURED",
 		  "The interface is not part of the current subsystem configuration"),
-	EXCEP_TXT("AE_ACCESS", "Permission denied for the requested operation")
+	EXCEP_TXT("AE_ACCESS", "Permission denied for the requested operation"),
+	EXCEP_TXT("AE_IO_ERROR", "An I/O error occurred")
 };
 
 static const struct acpi_exception_info acpi_gbl_exception_names_pgm[] = {
-- 
1.7.10
