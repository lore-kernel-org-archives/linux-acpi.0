From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/21] ACPICA: Tables: Add full support for the DBG2 table.
Date: Wed,  8 Jan 2014 13:43:52 +0800
Message-ID: <e35db14aa1b900512c49c66222dcd4abcd624ee1.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:4878 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbaAHFoB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:01 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Updates the DBG2 (Debug Port 2) table definition in the actbl2.h header.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 40f7ed1..094a906 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -327,6 +327,11 @@ struct acpi_table_dbg2 {
 	u32 info_count;
 };
 
+struct acpi_dbg2_header {
+	u32 info_offset;
+	u32 info_count;
+};
+
 /* Debug Device Information Subtable */
 
 struct acpi_dbg2_device {
-- 
1.7.10

