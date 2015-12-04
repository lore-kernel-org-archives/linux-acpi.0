From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 7/9] dmaengine: dw: platform: power on device on shutdown
Date: Fri,  4 Dec 2015 23:49:23 +0200
Message-ID: <1449265765-9393-8-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

We have to call dw_dma_disable() to stop any ongoing transfer. On some
platforms we can't do that since DMA device is powered off. Moreover we have no
possibility at that point to check if the platform is affected or not. That's
why we call pm_runtime_get_sync() / pm_runtime_put() unconditionally. On the
other hand we can't use pm_runtime_suspended() because runtime PM framework is
not fully used by the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/platform.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 68a4815..d0734e9 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -239,7 +239,19 @@ static void dw_shutdown(struct platform_device *pdev)
 {
 	struct dw_dma_chip *chip = platform_get_drvdata(pdev);
 
+	/*
+	 * We have to call dw_dma_disable() to stop any ongoing transfer. On
+	 * some platforms we can't do that since DMA device is powered off.
+	 * Moreover we have no possibility to check if the platform is affected
+	 * or not. That's why we call pm_runtime_get_sync() / pm_runtime_put()
+	 * unconditionally. On the other hand we can't use
+	 * pm_runtime_suspended() because runtime PM framework is not fully
+	 * used by the driver.
+	 */
+	pm_runtime_get_sync(chip->dev);
 	dw_dma_disable(chip);
+	pm_runtime_put_sync_suspend(chip->dev);
+
 	clk_disable_unprepare(chip->clk);
 }
 
-- 
2.6.2
