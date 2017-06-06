From: Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH v1 0/3] TPS68470 PMIC drivers
Date: Tue,  6 Jun 2017 04:55:15 -0700
Message-ID: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Rajmohan Mani <rajmohan.mani@intel.com>
List-Id: linux-acpi@vger.kernel.org

This is the patch series for TPS68470 PMIC that works as a camera PMIC.

The patch series provide the following 3 drivers.

TPS68470 MFD driver:
This is the multi function driver that initializes the TPS68470
PMIC and supports the GPIO and Op Region functions.

TPS68470 GPIO driver:
This is the PMIC GPIO driver that will be used by the OS GPIO layer,
when the BIOS / firmware triggered GPIO access is done.

TPS68470 Op Region driver:
This is the driver that will be invoked, when the BIOS / firmware
configures the voltage / clock for the sensors / vcm devices
connected to the PMIC.

---

Rajmohan Mani (3):
  mfd: Add new mfd device TPS68470
  gpio: Add support for TPS68470 GPIOs
  ACPI / PMIC: Add TI PMIC TPS68470 operation region driver

 drivers/acpi/Kconfig              |  12 +
 drivers/acpi/Makefile             |   2 +
 drivers/acpi/pmic/pmic_tps68470.c | 454 ++++++++++++++++++++++++++++++++++++++
 drivers/gpio/Kconfig              |  10 +
 drivers/gpio/Makefile             |   1 +
 drivers/gpio/gpio-tps68470.c      | 185 ++++++++++++++++
 drivers/mfd/Kconfig               |  12 +
 drivers/mfd/Makefile              |   1 +
 drivers/mfd/tps68470.c            | 227 +++++++++++++++++++
 include/linux/mfd/tps68470.h      | 167 ++++++++++++++
 10 files changed, 1071 insertions(+)
 create mode 100644 drivers/acpi/pmic/pmic_tps68470.c
 create mode 100644 drivers/gpio/gpio-tps68470.c
 create mode 100644 drivers/mfd/tps68470.c
 create mode 100644 include/linux/mfd/tps68470.h

-- 
1.9.1

