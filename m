From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 3/3] ACPI / PM: Fix EC polling issue by implementing prepare_late/finish_early suspend_ops callbacks
Date: Tue, 28 Jun 2016 16:04:46 +0800
Message-ID: <48245fbc4b0510a7af281986ccc1a2a583766f73.1467100803.git.lv.zheng@intel.com>
References: <cover.1467100803.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1467100803.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

_PTS/_WAK may contain EC transactions, it is better to have them handled
with IRQ enabled. This patch moves the 2 suspend PM ops from noirq stage
to late/early stage.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sleep.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index d30fce7f..c5c374c9 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -595,9 +595,10 @@ static int acpi_suspend_state_valid(suspend_state_t pm_state)
 static const struct platform_suspend_ops acpi_suspend_ops = {
 	.valid = acpi_suspend_state_valid,
 	.begin = acpi_suspend_begin,
-	.prepare_noirq = acpi_pm_prepare,
+	.prepare_late = __acpi_pm_prepare,
+	.prepare_noirq = acpi_pm_pre_suspend,
 	.enter = acpi_suspend_enter,
-	.finish_noirq = acpi_pm_finish,
+	.finish_early = acpi_pm_finish,
 	.end = acpi_pm_end,
 };
 
-- 
1.7.10
