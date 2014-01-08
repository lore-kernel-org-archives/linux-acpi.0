From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/21] ACPICA: Linux Header: Remove unused OSL prototypes.
Date: Wed,  8 Jan 2014 13:43:29 +0800
Message-ID: <2319bd09c7c8bfae723b534f3422dd7e76dde337.1387505702.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59461 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754350AbaAHFnh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:43:37 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch removes 2 useless OSL prototypes as they are not used by Linux now.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/aclinux.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 28f4f4d..008aa28 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -239,10 +239,6 @@ void acpi_os_unmap_memory(void __iomem * logical_address, acpi_size size);
  */
 void early_acpi_os_unmap_memory(void __iomem * virt, acpi_size size);
 
-void acpi_os_gpe_count(u32 gpe_number);
-
-void acpi_os_fixed_event_count(u32 fixed_event_number);
-
 #endif				/* __KERNEL__ */
 
 #endif				/* __ACLINUX_H__ */
-- 
1.7.10

