From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] pinctrl: baytrail: Register GPIO chip after chip->to_irq is set
Date: Thu, 15 May 2014 18:28:47 +0300
Message-ID: <1400167727-20233-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1400167727-20233-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400167727-20233-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jin Yao <yao.jin@intel.com>, Aubrey Li <aubrey.li@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Jin Yao <yao.jin@intel.com>

If chip->to_irq is NULL ACPI GPIO helpers don't register GPIO event
handlers thus preventing any ACPI GPIO triggered events. Solve this by
calling gpiochip_add() after we have set up drivers chip->to_irq hook.

Signed-off-by: Jin Yao <yao.jin@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/pinctrl-baytrail.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-baytrail.c b/drivers/pinctrl/pinctrl-baytrail.c
index 447f1dc25ea6..7c65c9dab215 100644
--- a/drivers/pinctrl/pinctrl-baytrail.c
+++ b/drivers/pinctrl/pinctrl-baytrail.c
@@ -527,12 +527,6 @@ static int byt_gpio_probe(struct platform_device *pdev)
 	gc->can_sleep = false;
 	gc->dev = dev;
 
-	ret = gpiochip_add(gc);
-	if (ret) {
-		dev_err(&pdev->dev, "failed adding byt-gpio chip\n");
-		return ret;
-	}
-
 	/* set up interrupts  */
 	irq_rc = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_rc && irq_rc->start) {
@@ -550,6 +544,12 @@ static int byt_gpio_probe(struct platform_device *pdev)
 		irq_set_chained_handler(hwirq, byt_gpio_irq_handler);
 	}
 
+	ret = gpiochip_add(gc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed adding byt-gpio chip\n");
+		return ret;
+	}
+
 	pm_runtime_enable(dev);
 
 	return 0;
-- 
2.0.0.rc2
