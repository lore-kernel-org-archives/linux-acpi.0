From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/15] ACPICA: Utilities: Update trace mechinism for acquire_object
Date: Fri, 19 Feb 2016 14:17:43 +0800
Message-ID: <d8588335d08ee7ea5d281766f8db41439f54fec3.1455857585.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 0824ab90e03c2e4239e890615f447e7962b1daa2

Was not using the correct macro. Updated a comment in
acoutput.h

Link: https://github.com/acpica/acpica/commit/0824ab90
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utcache.c |    2 +-
 include/acpi/acoutput.h       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index c9a720f..f8e9978 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -245,7 +245,7 @@ void *acpi_os_acquire_object(struct acpi_memory_list *cache)
 	acpi_status status;
 	void *object;
 
-	ACPI_FUNCTION_NAME(os_acquire_object);
+	ACPI_FUNCTION_TRACE(os_acquire_object);
 
 	if (!cache) {
 		return_PTR(NULL);
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 5bfc619..34f601e 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -262,7 +262,7 @@
 #define ACPI_GET_FUNCTION_NAME          _acpi_function_name
 
 /*
- * The Name parameter should be the procedure name as a quoted string.
+ * The Name parameter should be the procedure name as a non-quoted string.
  * The function name is also used by the function exit macros below.
  * Note: (const char) is used to be compatible with the debug interfaces
  * and macros such as __func__.
-- 
1.7.10
