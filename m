From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 4/4] ACPI / EC: Enable noirq stage GPE polling
Date: Fri, 11 Aug 2017 14:36:45 +0800
Message-ID: <9b7588f051ab52a5b19ce600fc90dd8f6bb3c576.1502432974.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1502432974.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502432974.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch enables noirq stage GPE polling for the EC driver.

EC is a very special driver, required to work throughout the entire
suspend/resume process. Thus this patch enables IRQ polling for EC during
noirq stages to avoid all kinds of possible issues.

If this commit is bisected to be a regression culprit, please report this
to bugzilla.kernel.org for further investigation.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=196129
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
---
 drivers/acpi/ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 396e81d..8bba317 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -164,7 +164,7 @@ module_param(ec_polling_guard, uint, 0644);
 MODULE_PARM_DESC(ec_polling_guard, "Guard time(us) between EC accesses in polling modes");
 
 static unsigned int ec_event_clearing __read_mostly = ACPI_EC_EVT_TIMING_QUERY;
-static unsigned int ec_gpe_polling __read_mostly = ACPI_EC_GPE_POLL_NONE;
+static unsigned int ec_gpe_polling __read_mostly = ACPI_EC_GPE_POLL_RESUME;
 
 /*
  * If the number of false interrupts per one transaction exceeds
-- 
2.7.4
