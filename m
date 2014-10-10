From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/10] ACPICA: Add string for _DDN method name.
Date: Fri, 10 Oct 2014 10:39:24 +0800
Message-ID: <646ac2fc2c4f63afe6b655ebb52baca31924969b.1412907188.git.lv.zheng@intel.com>
References: <cover.1412907188.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:26546 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaJJCja (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2014 22:39:30 -0400
In-Reply-To: <cover.1412907188.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

The _DDN method will be used internally.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acnames.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index f97804b..7461327 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -52,6 +52,7 @@
 #define METHOD_NAME__CBA        "_CBA"
 #define METHOD_NAME__CID        "_CID"
 #define METHOD_NAME__CRS        "_CRS"
+#define METHOD_NAME__DDN        "_DDN"
 #define METHOD_NAME__HID        "_HID"
 #define METHOD_NAME__INI        "_INI"
 #define METHOD_NAME__PLD        "_PLD"
-- 
1.7.10

