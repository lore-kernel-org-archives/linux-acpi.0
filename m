From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 23/31] ACPICA: Add "Windows 2015" string to _OSI support.
Date: Mon, 13 Apr 2015 11:50:37 +0800
Message-ID: <4dc66c69d1f9ab3190c358702d02cc3a2c595026.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit b293f602a67da478ae0bec129e68bd99787d9908

This change adds this string for Windows 10.

Link: https://github.com/acpica/acpica/commit/b293f602
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utosi.c |    1 +
 include/acpi/actypes.h      |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 574cd31..44035ab 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -100,6 +100,7 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Windows 2009", NULL, 0, ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
 	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and Server 2012 - Added 08/2012 */
 	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and Server 2012 R2 - Added 01/2014 */
+	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10 - Added 03/2015 */
 
 	/* Feature Group Strings */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index f18b7a8..ace520f 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1274,6 +1274,7 @@ struct acpi_memory_list {
 #define ACPI_OSI_WIN_VISTA_SP2          0x0A
 #define ACPI_OSI_WIN_7                  0x0B
 #define ACPI_OSI_WIN_8                  0x0C
+#define ACPI_OSI_WIN_10                 0x0D
 
 /* Definitions of file IO */
 
-- 
1.7.10
