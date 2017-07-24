From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 5/7] gpio: sysfs: Fixup kerneldoc
Date: Mon, 24 Jul 2017 16:57:26 +0200
Message-ID: <20170724145728.7662-5-thierry.reding@gmail.com>
References: <20170724145728.7662-1-thierry.reding@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33606 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756361AbdGXO5h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2017 10:57:37 -0400
In-Reply-To: <20170724145728.7662-1-thierry.reding@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Fix up some references to parameters to match the code.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpiolib-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 16fe9742597b..45b8c0679fee 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -534,8 +534,8 @@ static struct class gpio_class = {
 
 /**
  * gpiod_export - export a GPIO through sysfs
- * @gpio: gpio to make available, already requested
- * @direction_may_change: true if userspace may change gpio direction
+ * @desc: GPIO to make available, already requested
+ * @direction_may_change: true if userspace may change GPIO direction
  * Context: arch_initcall or later
  *
  * When drivers want to make a GPIO accessible to userspace after they
@@ -643,7 +643,7 @@ static int match_export(struct device *dev, const void *desc)
  * gpiod_export_link - create a sysfs link to an exported GPIO node
  * @dev: device under which to create symlink
  * @name: name of the symlink
- * @gpio: gpio to create symlink to, already exported
+ * @desc: GPIO to create symlink to, already exported
  *
  * Set up a symlink from /sys/.../dev/name to /sys/class/gpio/gpioN
  * node. Caller is responsible for unlinking.
@@ -674,7 +674,7 @@ EXPORT_SYMBOL_GPL(gpiod_export_link);
 
 /**
  * gpiod_unexport - reverse effect of gpiod_export()
- * @gpio: gpio to make unavailable
+ * @desc: GPIO to make unavailable
  *
  * This is implicit on gpiod_free().
  */
-- 
2.13.3

