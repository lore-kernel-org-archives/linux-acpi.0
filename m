From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 10/15] leds: leds-gpio: Add ACPI probing support
Date: Wed, 01 Oct 2014 04:17:02 +0200
Message-ID: <4835699.XutTNxriDg@vostro.rjw.lan>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <1852462.V1jlbi8OPt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1852462.V1jlbi8OPt@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Max Eliaser <max@meliaserlow.dyndns.tv>

This allows the driver to probe from ACPI namespace.

Signed-off-by: Max Eliaser <max.eliaser@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Bryan Wu <cooloney@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/leds/leds-gpio.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/drivers/leds/leds-gpio.c
===================================================================
--- linux-pm.orig/drivers/leds/leds-gpio.c
+++ linux-pm/drivers/leds/leds-gpio.c
@@ -231,6 +231,13 @@ static const struct of_device_id of_gpio
 
 MODULE_DEVICE_TABLE(of, of_gpio_leds_match);
 
+static const struct acpi_device_id acpi_gpio_leds_match[] = {
+	{ "PRP0001" }, /* Device Tree shoehorned into ACPI */
+	{},
+};
+
+MODULE_DEVICE_TABLE(acpi, acpi_gpio_leds_match);
+
 static int gpio_led_probe(struct platform_device *pdev)
 {
 	struct gpio_led_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -286,6 +293,7 @@ static struct platform_driver gpio_led_d
 		.name	= "leds-gpio",
 		.owner	= THIS_MODULE,
 		.of_match_table = of_gpio_leds_match,
+		.acpi_match_table = acpi_gpio_leds_match,
 	},
 };
 
