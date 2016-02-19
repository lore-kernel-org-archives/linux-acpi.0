From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/15] ACPICA: aclocal: Put parens around some definitions.
Date: Fri, 19 Feb 2016 14:16:03 +0800
Message-ID: <5b2fc97674b5a674c9c6da4dbd9f4f09753ba81d.1455857579.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, waddlesplash <waddlesplash@gmail.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: waddlesplash <waddlesplash@gmail.com>

ACPICA commit 7100a109f7d6523330d29f4d088cf1ffb756025f

Looking at where these are used, this shouldn't result in any behavioral changes, but it's best practices to have them.

Link: https://github.com/acpica/acpica/commit/7100a109
Signed-off-by: waddlesplash <waddlesplash@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index e4977fa..9562a10 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -85,7 +85,7 @@ union acpi_parse_object;
 #define ACPI_MTX_MEMORY                 5	/* Debug memory tracking lists */
 
 #define ACPI_MAX_MUTEX                  5
-#define ACPI_NUM_MUTEX                  ACPI_MAX_MUTEX+1
+#define ACPI_NUM_MUTEX                  (ACPI_MAX_MUTEX+1)
 
 /* Lock structure for reader/writer interfaces */
 
@@ -103,11 +103,11 @@ struct acpi_rw_lock {
 #define ACPI_LOCK_HARDWARE              1
 
 #define ACPI_MAX_LOCK                   1
-#define ACPI_NUM_LOCK                   ACPI_MAX_LOCK+1
+#define ACPI_NUM_LOCK                   (ACPI_MAX_LOCK+1)
 
 /* This Thread ID means that the mutex is not in use (unlocked) */
 
-#define ACPI_MUTEX_NOT_ACQUIRED         (acpi_thread_id) 0
+#define ACPI_MUTEX_NOT_ACQUIRED         ((acpi_thread_id) 0)
 
 /* This Thread ID means an invalid thread ID */
 
-- 
1.7.10
