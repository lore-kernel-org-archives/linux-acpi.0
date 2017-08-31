From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 3/3] ACPI / EC: Enable noirq stage event detection
Date: Thu, 31 Aug 2017 16:10:37 +0800
Message-ID: <64a875783cf29f651261ba7e881cc5ac5c5e0c4b.1504166863.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1504166863.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504166863.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch enables noirq stage event detection for the EC driver.

EC is a very special driver, required to detecting events throughout the
entire suspend/resume process. Thus this patch enables event detection for
EC during noirq stages to meet this requirement. This is done by making
sure that the EC sleep APIs:
  acpi_ec_block_transactions()
  acpi_ec_unblock_transactions()
rather than the EC driver suspend/resume hooks:
  acpi_ec_suspend()
  acpi_ec_resume()
are the boundary of the EC event handling during suspend/resume, so that
the ACPI sleep core can tune their invocation timing to handle special BIOS
requirements.

If this commit is bisected to be a regression culprit, please report this
to bugzilla.kernel.org for further investigation.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=196129
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
---
 drivers/acpi/ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9363656..36ce5e7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -157,7 +157,7 @@ static bool ec_no_wakeup __read_mostly;
 module_param(ec_no_wakeup, bool, 0644);
 MODULE_PARM_DESC(ec_no_wakeup, "Do not wake up from suspend-to-idle");
 
-static bool ec_detect_noirq_events __read_mostly;
+static bool ec_detect_noirq_events __read_mostly = true;
 module_param(ec_detect_noirq_events, bool, 0644);
 MODULE_PARM_DESC(ec_detect_noirq_events, "Enabling event detection during noirq stage");
 
-- 
2.7.4
