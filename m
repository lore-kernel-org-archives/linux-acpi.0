From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/4] ACPI / sysfs: Add ACPI_LV_REPAIR debug level.
Date: Wed,  5 Aug 2015 16:23:43 +0800
Message-ID: <6e093db2f06d88ef14a67e72339b39492ec22683.1438762804.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com> <cover.1438762804.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438762804.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch updates debug_level file, adding ACPI_LV_REPAIR.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sysfs.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 0876d77b..7ab6ba4 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -69,6 +69,7 @@ static const struct acpi_dlevel acpi_debug_levels[] = {
 	ACPI_DEBUG_INIT(ACPI_LV_INIT),
 	ACPI_DEBUG_INIT(ACPI_LV_DEBUG_OBJECT),
 	ACPI_DEBUG_INIT(ACPI_LV_INFO),
+	ACPI_DEBUG_INIT(ACPI_LV_REPAIR),
 
 	ACPI_DEBUG_INIT(ACPI_LV_INIT_NAMES),
 	ACPI_DEBUG_INIT(ACPI_LV_PARSE),
-- 
1.7.10
