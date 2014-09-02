From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/6] ACPICA: Headers: Add GTDT flag definitions for the timer subtable.
Date: Tue,  2 Sep 2014 08:27:19 +0800
Message-ID: <c956f63dfac832377831339b85d6a40dabfd40bf.1409617516.git.lv.zheng@intel.com>
References: <cover.1409617516.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1409617516.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Mostly by Hanjun Guo <hanjun.guo@linaro.org>

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 787bcc8..5480cb2 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -310,10 +310,15 @@ struct acpi_gtdt_timer_entry {
 	u32 common_flags;
 };
 
+/* Flag Definitions: timer_flags and virtual_timer_flags above */
+
+#define ACPI_GTDT_GT_IRQ_MODE               (1)
+#define ACPI_GTDT_GT_IRQ_POLARITY           (1<<1)
+
 /* Flag Definitions: common_flags above */
 
-#define ACPI_GTDT_GT_IS_SECURE_TIMER    (1)
-#define ACPI_GTDT_GT_ALWAYS_ON          (1<<1)
+#define ACPI_GTDT_GT_IS_SECURE_TIMER        (1)
+#define ACPI_GTDT_GT_ALWAYS_ON              (1<<1)
 
 /* 1: SBSA Generic Watchdog Structure */
 
-- 
1.7.10
