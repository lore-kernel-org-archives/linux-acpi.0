From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 6/6] gpiolib: acpi: Introduce NO_RESTRICTION quirk
Date: Mon, 13 Nov 2017 15:10:48 +0200
Message-ID: <1510578648.25007.166.camel@linux.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
         <20171110134033.85461-6-andriy.shevchenko@linux.intel.com>
         <20171113115554.GY18997@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38099 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbdKMNK7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Nov 2017 08:10:59 -0500
In-Reply-To: <20171113115554.GY18997@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Mon, 2017-11-13 at 13:55 +0200, Mika Westerberg wrote:
> On Fri, Nov 10, 2017 at 03:40:33PM +0200, Andy Shevchenko wrote:
> > Allow to relax IoRestriction for certain cases.
> > 
> > One of the use case is incorrectly cooked ACPI table where interrupt
> > pin is
> > defined with GpioIo() macro with IoRestrictionOutputOnly.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I think you should include user of this quirk in the patch series as
> well. Otherwise it is pretty pointless to add random quirks without
> real issues they are supposed to solve ;-)

Something like below?

--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -50,7 +50,7 @@ static const struct acpi_gpio_params vbus_gpios = {
INT3496_GPIO_VBUS_EN, 0, fal
 static const struct acpi_gpio_params mux_gpios = {
INT3496_GPIO_USB_MUX, 0, false };
 
 static const struct acpi_gpio_mapping acpi_int3496_default_gpios[] = {
-       { "id-gpios", &id_gpios, 1 },
+       { "id-gpios", &id_gpios, 1, ACPI_GPIO_QUIRK_NO_IO_RESTRICTION },
        { "vbus-gpios", &vbus_gpios, 1 },
        { "mux-gpios", &mux_gpios, 1 },
        { },
@@ -112,9 +112,6 @@ static int int3496_probe(struct platform_device
*pdev)
                ret = PTR_ERR(data->gpio_usb_id);
                dev_err(dev, "can't request USB ID GPIO: %d\n", ret);
                return ret;
-       } else if (gpiod_get_direction(data->gpio_usb_id) !=
GPIOF_DIR_IN) {
-               dev_warn(dev, FW_BUG "USB ID GPIO not in input mode,
fixing\n");
-               gpiod_direction_input(data->gpio_usb_id);
        }

> 
> Anyway looks good to me,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
