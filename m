From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/6] ACPICA: Add _PSx names to the METHOD_NAME list.
Date: Tue,  2 Sep 2014 08:27:05 +0800
Message-ID: <26e5b831a8416d5b1f5de35f8e8ea32892ed6d04.1409617516.git.lv.zheng@intel.com>
References: <cover.1409617516.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1409617516.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Will be used by iASL.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acnames.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index c728113..f97804b 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -59,6 +59,10 @@
 #define METHOD_NAME__PRS        "_PRS"
 #define METHOD_NAME__PRT        "_PRT"
 #define METHOD_NAME__PRW        "_PRW"
+#define METHOD_NAME__PS0        "_PS0"
+#define METHOD_NAME__PS1        "_PS1"
+#define METHOD_NAME__PS2        "_PS2"
+#define METHOD_NAME__PS3        "_PS3"
 #define METHOD_NAME__REG        "_REG"
 #define METHOD_NAME__SB_        "_SB_"
 #define METHOD_NAME__SEG        "_SEG"
-- 
1.7.10
