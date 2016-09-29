From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 0/4] ACPI / gpio: Updates to properties
Date: Thu, 29 Sep 2016 16:39:40 +0300
Message-ID: <20160929133944.158596-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:45657 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755137AbcI2Nj4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Sep 2016 09:39:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

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

The previous version can be found here:

  http://www.spinics.net/lists/linux-acpi/msg69385.html

Changes from v1:
  - Drop patch [1/5] as it has been applied already.
  - Move patch [4/5] to be the first.
  - Rename acpi_data_get_property_reference() to __acpi_node_get_property_reference().
  - Drop acpi_node_get_property_reference() as it is not necessary anymore.
  - Add static inline wrapper acpi_node_get_property_reference() that
    calls the previous passing MAX_ACPI_REFERENCE_ARGS to support existing
    drivers.

Mika Westerberg (4):
  ACPI / property: Allow holes in reference properties
  ACPI / gpio: Add support for naming GPIOs
  ACPI / gpio: Add hogging support
  ACPI / gpio: Allow holes in list of GPIOs for a device

 Documentation/acpi/gpio-properties.txt |  62 ++++++++++++++
 drivers/acpi/property.c                | 117 +++++++++++++++-----------
 drivers/gpio/gpiolib-acpi.c            | 147 ++++++++++++++++++++++++++++++---
 include/linux/acpi.h                   |  22 ++++-
 4 files changed, 285 insertions(+), 63 deletions(-)

-- 
2.9.3

