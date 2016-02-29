From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v4 2/2] gpio: designware: add gpio-signaled acpi event support
Date: Mon, 29 Feb 2016 21:13:16 +0800
Message-ID: <1456751596-98963-3-git-send-email-qiujiang@huawei.com>
References: <1456751596-98963-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:8234 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbcB2NDR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Feb 2016 08:03:17 -0500
In-Reply-To: <1456751596-98963-1-git-send-email-qiujiang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

This patch adds the support for the gpio-signaled acpi event.
This is used for power button on hisilicon D02 board, which
is an arm64 platform.

To support this function, _AEI and _Exx objects must be
defined in the corresponding GPIO device as follows:

    Name (_AEI, ResourceTemplate () {
            GpioInt(Edge, ActiveLow, ExclusiveAndWake, PullUp,
			, " \\_SB.GPI0") {8}
    })
    Method (_E08, 0x0, NotSerialized) {
        Notify (\_SB.PWRB, 0x80)
    }

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: qiujiang <qiujiang@huawei.com>
---
 drivers/gpio/gpio-dwapb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 7a37c65..4955112 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -27,6 +27,8 @@
 #include <linux/platform_data/gpio-dwapb.h>
 #include <linux/slab.h>
 
+#include "gpiolib.h"
+
 #define GPIO_SWPORTA_DR		0x00
 #define GPIO_SWPORTA_DDR	0x04
 #define GPIO_SWPORTB_DR		0x0c
@@ -436,6 +438,10 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	else
 		port->is_registered = true;
 
+	/* Add GPIO-signaled ACPI event support */
+	if (pp->irq)
+		acpi_gpiochip_request_interrupts(&(port->gc));
+
 	return err;
 }
 
-- 
1.9.1

