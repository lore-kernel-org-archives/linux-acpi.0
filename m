From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/7] dmaengine: dw: platform: power on device on shutdown
Date: Thu, 26 Nov 2015 17:19:11 +0200
Message-ID: <1448551153-84719-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
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
