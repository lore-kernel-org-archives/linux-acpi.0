From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 7/7] gpio: Use unsigned int for of_gpio_n_cells
Date: Mon, 24 Jul 2017 16:57:28 +0200
Message-ID: <20170724145728.7662-7-thierry.reding@gmail.com>
References: <20170724145728.7662-1-thierry.reding@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33618 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932380AbdGXO5l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2017 10:57:41 -0400
In-Reply-To: <20170724145728.7662-1-thierry.reding@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The cell count for GPIO specifiers can never be negative, so make the
field unsigned.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/gpio/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index fe66c9306caf..c97f8325e8bf 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -193,7 +193,7 @@ struct gpio_chip {
 	 *
 	 * Number of cells used to form the GPIO specifier.
 	 */
-	int of_gpio_n_cells;
+	unsigned int of_gpio_n_cells;
 
 	/**
 	 * @of_xlate:
-- 
2.13.3

