From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 0/4] ACPI / gpio: Updates to properties
Date: Fri, 21 Oct 2016 17:21:28 +0300
Message-ID: <20161021142132.80539-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31222 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754883AbcJUOVh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Oct 2016 10:21:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org

Hi,

This series brings couple of useful GPIO related properties from Device
Tree to ACPI _DSD device properties:

  - Names for GPIO lines
  - GPIO hogging
  - Holes in GPIO property lists

We are using these to get Intel Galileo better supported in the mainline
kernel (but these may be useful for other boards as well). For example SPI
chip select on Galileo is connected to a GPIO line so we need to be able to
describe it in ACPI, and at the same time allow native chip selects.

GPIO hogging can be used to set initial state of certain GPIOs available on
the headers regardless of the BIOS settings (which may be wrong as it knows
nothing about which devices have been connected).

The previous versions can be found here:

  v2: http://www.spinics.net/lists/linux-acpi/msg69469.html
  v1: http://www.spinics.net/lists/linux-acpi/msg69385.html

Changes from v2:
  - Rebased on top of v4.9-rc1 and dropped the already applied patches.
  - Reordered the series so that GPIO names which touches DT code is moved
    to be last one.
  - Renamed acpi_gpiochip_set_names() to devprop_gpiochip_set_names() and
    moved it to a new file: gpiolib-devprop.c.
  - Changed of_gpiochip_add() to call devprop_gpiochip_set_names() and
    removed of_gpiochip_set_names().
  - Added ACKs from Rafael to patches 1 and 2. I did not add ACK for
    patches 3 and 4 because they are changed from the previous version.

The DT part is compile tested only so it would be nice if someone with ARM
board could try if the GPIO names still work as expected.

Changes from v1:
  - Drop patch [1/5] as it has been applied already.
  - Move patch [4/5] to be the first.
  - Rename acpi_data_get_property_reference() to __acpi_node_get_property_reference().
  - Drop acpi_node_get_property_reference() as it is not necessary anymore.
  - Add static inline wrapper acpi_node_get_property_reference() that
    calls the previous passing MAX_ACPI_REFERENCE_ARGS to support existing
    drivers.

Mika Westerberg (4):
  ACPI / gpio: Allow holes in list of GPIOs for a device
  ACPI / gpio: Add hogging support
  gpio: Rework of_gpiochip_set_names() to use device property accessors
  ACPI / gpio: Add support for naming GPIOs

 Documentation/acpi/gpio-properties.txt |  62 +++++++++++++++++++
 drivers/gpio/Makefile                  |   1 +
 drivers/gpio/gpiolib-acpi.c            | 106 +++++++++++++++++++++++++++++----
 drivers/gpio/gpiolib-devprop.c         |  62 +++++++++++++++++++
 drivers/gpio/gpiolib-of.c              |  47 +--------------
 drivers/gpio/gpiolib.h                 |   2 +
 6 files changed, 223 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpio/gpiolib-devprop.c

-- 
2.9.3

