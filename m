From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/5] ACPI / gpio: Updates to properties
Date: Fri, 23 Sep 2016 17:57:05 +0300
Message-ID: <20160923145710.105489-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35244 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754046AbcIWO5p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Sep 2016 10:57:45 -0400
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

Mika Westerberg (5):
  ACPI / documentation: Use recommended name in GPIO property names
  ACPI / gpio: Add support for naming GPIOs
  ACPI / gpio: Add hogging support
  ACPI / property: Allow holes in reference properties
  ACPI / gpio: Allow holes in list of GPIOs for a device

 Documentation/acpi/gpio-properties.txt |  72 ++++++++++++++--
 drivers/acpi/property.c                | 116 +++++++++++++++++++-------
 drivers/gpio/gpiolib-acpi.c            | 147 ++++++++++++++++++++++++++++++---
 include/linux/acpi.h                   |   3 +
 4 files changed, 292 insertions(+), 46 deletions(-)

-- 
2.9.3

