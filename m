From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 00/12] gpio: acpi: Make it working
Date: Tue, 23 May 2017 20:03:15 +0300
Message-ID: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

This is second iteration of the fix of GPIO ACPI library to make it
robust against different ACPI specification generations and thus
firmwares.

Currently GPIO ACPI library provides an API to get a GPIO resources
(IO or interrupt) from ACPI tables for the individual drivers.

This library has few flaws which makes some devices not working:
- the library allows to abuse ACPI by using a _CRS fallback mechanism
- the library neglects flags of the resource
- the PNP ACPI is not ready for GpioInt() resources for interrupts

In this series:
- the _CRS fallback is forbidden
- the pin configuration follows what firmware wants to
- the documentation is updated in order to clarify corner cases
- the PNP ACPI is extended to support GpioInt() for interrupts

After this series it's possible to use GPIO pins for input (interrupt)
which were set as output due to HW reset default is input buffer
disabled and BIOS didn't touch that pin at all. It's a crucial
functionality for Internet of Things (IoT) open connected boards where
user may choose any of available pin for almost any of available
function, including GPIO input (interrupt).

Current bad behaviour was first reported by Jarkko Nikula few months ago.

Jagadish, it would be nice if you can re-test entire series in your
environment and give a Tested-by tag.

In v2:
- add 4 patches to fix an issue with device that takes GpioInt resource
- amend documentation
- fix several spelling typos
- add Mika's and Jarkko's tags
- rebase on top of recent linux-next

Andy Shevchenko (11):
  gpiolib: Export gpiod_configure_flags() to internal users
  gpio: acpi: Align acpi_find_gpio() with DT version
  gpio: acpi: Do sanity check for GpioInt in acpi_find_gpio()
  gpio: acpi: Even more tighten up ACPI GPIO lookups
  gpio: acpi: Synchronize acpi_find_gpio() and acpi_gpio_count()
  gpio: acpi: Explain how to get GPIO descriptors in ACPI case
  gpio: acpi: Factor out acpi_gpio_to_gpiod_flags() helper
  gpio: acpi: Override GPIO initialization flags
  gpio: acpi: Split out acpi_gpio_get_irq_resource() helper
  PNP / ACPI: join strings back for better maintenance
  PNP / ACPI: remove FSF address

Jagadish Krishnamoorthy (1):
  PNP / ACPI: add support for GpioInt resource type

 Documentation/acpi/gpio-properties.txt |  65 ++++++++++++
 drivers/gpio/gpiolib-acpi.c            | 185 ++++++++++++++++++++-------------
 drivers/gpio/gpiolib.c                 |  10 +-
 drivers/gpio/gpiolib.h                 |  17 ++-
 drivers/pnp/pnpacpi/rsparser.c         |  37 ++++---
 include/linux/acpi.h                   |   7 ++
 6 files changed, 230 insertions(+), 91 deletions(-)

-- 
2.11.0
