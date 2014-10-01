From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 13/15] input: gpio_keys_polled - Add ACPI probing support
Date: Wed, 01 Oct 2014 04:20:43 +0200
Message-ID: <17237242.r7oKCjnQJM@vostro.rjw.lan>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Allow the driver to probe from ACPI namespace.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/input/keyboard/gpio_keys_polled.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-pm/drivers/input/keyboard/gpio_keys_polled.c
===================================================================
--- linux-pm.orig/drivers/input/keyboard/gpio_keys_polled.c
+++ linux-pm/drivers/input/keyboard/gpio_keys_polled.c
@@ -181,6 +181,12 @@ static const struct of_device_id gpio_ke
 };
 MODULE_DEVICE_TABLE(of, gpio_keys_polled_of_match);
 
+static const struct acpi_device_id gpio_keys_polled_acpi_match[] = {
+	{ "PRP0001" }, /* Device Tree shoehorned into ACPI */
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, gpio_keys_polled_acpi_match);
+
 static int gpio_keys_polled_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -309,6 +315,7 @@ static struct platform_driver gpio_keys_
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
 		.of_match_table = gpio_keys_polled_of_match,
+		.acpi_match_table = gpio_keys_polled_acpi_match,
 	},
 };
 module_platform_driver(gpio_keys_polled_driver);
