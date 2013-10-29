From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/20] ACPICA: Predefine name macros: Sort list.
Date: Tue, 29 Oct 2013 09:29:34 +0800
Message-ID: <3593c35f747283d27621c2dccd47f48875b9fde7.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1916 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J2B3o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:29:44 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Sort the method names.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acnames.h |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index ce08ef7..1f36777 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -46,25 +46,25 @@
 
 /* Method names - these methods can appear anywhere in the namespace */
 
-#define METHOD_NAME__SB_        "_SB_"
-#define METHOD_NAME__HID        "_HID"
-#define METHOD_NAME__CID        "_CID"
-#define METHOD_NAME__UID        "_UID"
-#define METHOD_NAME__SUB        "_SUB"
 #define METHOD_NAME__ADR        "_ADR"
-#define METHOD_NAME__INI        "_INI"
-#define METHOD_NAME__STA        "_STA"
-#define METHOD_NAME__REG        "_REG"
-#define METHOD_NAME__SEG        "_SEG"
+#define METHOD_NAME__AEI        "_AEI"
 #define METHOD_NAME__BBN        "_BBN"
-#define METHOD_NAME__PRT        "_PRT"
+#define METHOD_NAME__CBA        "_CBA"
+#define METHOD_NAME__CID        "_CID"
 #define METHOD_NAME__CRS        "_CRS"
+#define METHOD_NAME__HID        "_HID"
+#define METHOD_NAME__INI        "_INI"
+#define METHOD_NAME__PLD        "_PLD"
 #define METHOD_NAME__PRS        "_PRS"
-#define METHOD_NAME__AEI        "_AEI"
+#define METHOD_NAME__PRT        "_PRT"
 #define METHOD_NAME__PRW        "_PRW"
+#define METHOD_NAME__REG        "_REG"
+#define METHOD_NAME__SB_        "_SB_"
+#define METHOD_NAME__SEG        "_SEG"
 #define METHOD_NAME__SRS        "_SRS"
-#define METHOD_NAME__CBA        "_CBA"
-#define METHOD_NAME__PLD        "_PLD"
+#define METHOD_NAME__STA        "_STA"
+#define METHOD_NAME__SUB        "_SUB"
+#define METHOD_NAME__UID        "_UID"
 
 /* Method names - these methods must appear at the namespace root */
 
-- 
1.7.10

