From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 3/7] gpio: devres: Improve kerneldoc
Date: Mon, 24 Jul 2017 16:57:24 +0200
Message-ID: <20170724145728.7662-3-thierry.reding@gmail.com>
References: <20170724145728.7662-1-thierry.reding@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38390 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756300AbdGXO5e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2017 10:57:34 -0400
In-Reply-To: <20170724145728.7662-1-thierry.reding@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add missing descriptions for some parameters to match the code.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/devres.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/devres.c b/drivers/gpio/devres.c
index a75511d1ea5d..afbff155a0ba 100644
--- a/drivers/gpio/devres.c
+++ b/drivers/gpio/devres.c
@@ -132,6 +132,7 @@ EXPORT_SYMBOL(devm_gpiod_get_index);
  * @index:	index of the GPIO to obtain in the consumer
  * @child:	firmware node (child of @dev)
  * @flags:	GPIO initialization flags
+ * @label:	label to attach to the requested GPIO
  *
  * GPIO descriptors returned from this function are automatically disposed on
  * driver detach.
@@ -271,6 +272,7 @@ EXPORT_SYMBOL(devm_gpiod_get_array_optional);
 
 /**
  * devm_gpiod_put - Resource-managed gpiod_put()
+ * @dev:	GPIO consumer
  * @desc:	GPIO descriptor to dispose of
  *
  * Dispose of a GPIO descriptor obtained with devm_gpiod_get() or
@@ -286,6 +288,7 @@ EXPORT_SYMBOL(devm_gpiod_put);
 
 /**
  * devm_gpiod_put_array - Resource-managed gpiod_put_array()
+ * @dev:	GPIO consumer
  * @descs:	GPIO descriptor array to dispose of
  *
  * Dispose of an array of GPIO descriptors obtained with devm_gpiod_get_array().
-- 
2.13.3

