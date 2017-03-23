From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/8] gpiolib: Export gpiod_configure_flags() to internal users
Date: Thu, 23 Mar 2017 21:46:11 +0200
Message-ID: <20170323194618.26548-2-andriy.shevchenko@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

This is preparatory patch for enabling GPIO ACPI to configure a pin
accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 drivers/gpio/gpiolib.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4aa1e78f0f0b..3752785d31ab 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3212,7 +3212,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_optional);
  * requested function and/or index, or another IS_ERR() code if an error
  * occurred while trying to acquire the GPIO.
  */
-static int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
+int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags)
 {
 	int status;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 2495b7ee1b42..e36a0bdc7740 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -199,6 +199,8 @@ struct gpio_desc {
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
 void gpiod_free(struct gpio_desc *desc);
+int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
+		unsigned long lflags, enum gpiod_flags dflags);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 		unsigned long lflags, enum gpiod_flags dflags);
 
-- 
2.11.0
