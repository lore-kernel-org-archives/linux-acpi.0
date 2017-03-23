From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/8] gpio: acpi: Make it working
Date: Thu, 23 Mar 2017 21:46:10 +0200
Message-ID: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Currently GPIO ACPI library provides an API to get a GPIO resources
(IO or interrupt) from ACPI tables for the individual drivers.

This library has few flaws which makes some devices not working:
 - the library allows to abuse ACPI by using a _CRS fallback mechanism
 - the library neglects flags of the resource

In this series:
 - the _CRS fallback is forbidden
 - the pin configuration follows what firmware wants to
 - the documentation is updated in order to clarify corner cases

After this series it's possible to use GPIO pins for input (interrupt)
which were configured as output by BIOS by some reason. It's a crucial
functionality for IoT open connected boards where user may choose any of
available pin for almost any of available function, including GPIO input
(interrupt).

Current bad behaviour was first reported by Jarkko Nikula few months ago.

Andy Shevchenko (8):
  gpiolib: Export gpiod_configure_flags() to internal users
  gpio: acpi: Align acpi_find_gpio() with DT version
  gpio: acpi: Do sanity check for GpioInt in acpi_find_gpio()
  gpio: acpi: Even more tighten up ACPI GPIO lookups
  gpio: acpi: Synchronize acpi_find_gpio() and acpi_gpio_count()
  gpio: acpi: Explain how to get GPIO descriptors in ACPI case
  gpio: acpi: Factor out acpi_gpio_to_gpiod_flags() helper
  gpio: acpi: Override GPIO initialization flags

 Documentation/acpi/gpio-properties.txt |  60 ++++++++++++
 drivers/gpio/gpiolib-acpi.c            | 162 +++++++++++++++++++--------------
 drivers/gpio/gpiolib.c                 |  10 +-
 drivers/gpio/gpiolib.h                 |  17 +++-
 4 files changed, 176 insertions(+), 73 deletions(-)

-- 
2.11.0
