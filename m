From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 24/25] ACPICA: Tables: Merge DMAR table structure updates.
Date: Tue,  8 Jul 2014 10:08:25 +0800
Message-ID: <22ea945255a53876e305a43c26255837c8e024e9.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60392 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbaGHCI3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:08:29 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, David Woodhouse <David.Woodhouse@intel.com>

This patch is a back port result of the following Linux commit:
  Author: David Woodhouse <David.Woodhouse@intel.com>
  Subject: iommu/vt-d: Add ACPI namespace device reporting structures
ACPICA need to handle old compilers where u8 object_name[] is only allowed
for an initialized variable. This patch reduces back port source code
differences between Linux and ACPICA upstream.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: David Woodhouse <David.Woodhouse@intel.com>
---
 include/acpi/actbl2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 860e5c8..21314d3 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -516,7 +516,7 @@ struct acpi_dmar_andd {
 	struct acpi_dmar_header header;
 	u8 reserved[3];
 	u8 device_number;
-	u8 object_name[];
+	char object_name[1];
 };
 
 /*******************************************************************************
-- 
1.7.10

