From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/4] ACPI / sysfs: Add ACPI_LV_REPAIR debug level.
Date: Thu, 23 Jul 2015 13:06:46 +0800
Message-ID: <78ebeac0d1dfc138192fc104dba2f7f13d842745.1437627661.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com> <cover.1437627661.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:45958 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbbGWFGw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 01:06:52 -0400
In-Reply-To: <cover.1437627661.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

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

