From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/27] ACPICA: Back port of _PRP update.
Date: Wed, 30 Apr 2014 10:05:27 +0800
Message-ID: <650910a9331f3996e18f49af429fcbceda017504.1398817612.git.lv.zheng@intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1398817612.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This patch is the linuxize result of the following commit:
  Subject: ACPICA: Add check for _PRP/_HID dependency, with error message.
  _PRP requires that a _HID appears in the same scope.

The iASL changes are not in this patch as iASL currently is not
shipped in the kernel.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acnames.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 3dd6e83..f0e713f 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -55,6 +55,7 @@
 #define METHOD_NAME__HID        "_HID"
 #define METHOD_NAME__INI        "_INI"
 #define METHOD_NAME__PLD        "_PLD"
+#define METHOD_NAME__PRP        "_PRP"
 #define METHOD_NAME__PRS        "_PRS"
 #define METHOD_NAME__PRT        "_PRT"
 #define METHOD_NAME__PRW        "_PRW"
-- 
1.7.10
