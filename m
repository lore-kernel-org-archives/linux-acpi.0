From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/21] ACPICA: Add helper macros to extract bus/segment numbers from HEST table.
Date: Wed,  8 Jan 2014 13:44:04 +0800
Message-ID: <5923949581b1e62cf6f4c865ca6ce1026df6c2fe.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39909 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbaAHFoO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:14 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Betty Dall <betty.dall@hp.com>

From: Betty Dall <betty.dall@hp.com>

This change adds two macros to extract the encoded bus and segment
numbers from the HEST Bus field.

Signed-off-by: Betty Dall <betty.dall@hp.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl1.h |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 556c83ee..4ec8c19 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -457,7 +457,7 @@ struct acpi_hest_aer_common {
 	u8 enabled;
 	u32 records_to_preallocate;
 	u32 max_sections_per_record;
-	u32 bus;
+	u32 bus;		/* Bus and Segment numbers */
 	u16 device;
 	u16 function;
 	u16 device_control;
@@ -473,6 +473,14 @@ struct acpi_hest_aer_common {
 #define ACPI_HEST_FIRMWARE_FIRST        (1)
 #define ACPI_HEST_GLOBAL                (1<<1)
 
+/*
+ * Macros to access the bus/segment numbers in Bus field above:
+ *  Bus number is encoded in bits 7:0
+ *  Segment number is encoded in bits 23:8
+ */
+#define ACPI_HEST_BUS(bus)              ((bus) & 0xFF)
+#define ACPI_HEST_SEGMENT(bus)          (((bus) >> 8) & 0xFFFF)
+
 /* Hardware Error Notification */
 
 struct acpi_hest_notify {
-- 
1.7.10

