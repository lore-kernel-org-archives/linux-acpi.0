From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] gpiolib-acpi: remove unused variable 'err', cleans up build warning
Date: Tue, 18 Dec 2018 12:28:02 +0000
Message-ID: <20181218122802.28157-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable err is defined but never used. Remove it. Cleans up warning:

warning: unused variable ‘err’ [-Wunused-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpio/gpiolib-acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fb0496e20ff8..259cf6ab969b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -908,7 +908,6 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		if (!found) {
 			enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio);
 			const char *label = "ACPI:OpRegion";
-			int err;
 
 			desc = gpiochip_request_own_desc(chip, pin, label,
 							 flags);
-- 
2.19.1
