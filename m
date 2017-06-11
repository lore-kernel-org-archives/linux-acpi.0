From: Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH v2 0/3] TPS68470 PMIC drivers
Date: Sat, 10 Jun 2017 23:09:52 -0700
Message-ID: <1497161395-36504-1-git-send-email-rajmohan.mani@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Rajmohan Mani <rajmohan.mani@intel.com>
List-Id: linux-acpi@vger.kernel.org

This is the patch series for TPS68470 PMIC that works as a camera PMIC.

The patch series provide the following 3 drivers, to help configure
the voltage regulators, clocks and GPIOs provided by the TPS68470
PMIC, to be able to use the camera sensors connected to this PMIC.

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
Changes in v2:
	- MFD driver:
	- Removed tps68470_* wrappers around regmap_* calls
	- Removed "struct tps68470"
	- used devm_mfd_add_devices and removed mutex in mfd driver
	- Added reasoning about the need of having mfd driver
	  as bool/builtin

	- Opregion driver:
	- renamed opregion driver file / internal symbol names
	  with tps68470_pmic*
	- Made opregion driver tables as const
	- Removed unused *handler_context in common handler
	- Replaced "int" with "unsigned int"
	- Changed to WARN macro to dev_warn()
	- Destroyed mutex on error
	- Added reasoning about the need of having Opregion driver
	  as bool/builtin
	
	- GPIO driver:
	- Implemented get_direction() in the GPIO driver
	- Setup gpio_chip.names
	- Moved the GPIO lookup table code inside mfd driver
	- Added reasoning about the need of having GPIO driver
	  as bool/builtin

---

Rajmohan Mani (3):
  mfd: Add new mfd device TPS68470
  gpio: Add support for TPS68470 GPIOs
  ACPI / PMIC: Add TI PMIC TPS68470 operation region driver

 drivers/acpi/Kconfig              |  15 ++
 drivers/acpi/Makefile             |   2 +
 drivers/acpi/pmic/tps68470_pmic.c | 456 ++++++++++++++++++++++++++++++++++++++
 drivers/gpio/Kconfig              |  14 ++
 drivers/gpio/Makefile             |   1 +
 drivers/gpio/gpio-tps68470.c      | 186 ++++++++++++++++
 drivers/mfd/Kconfig               |  18 ++
 drivers/mfd/Makefile              |   1 +
 drivers/mfd/tps68470.c            | 192 ++++++++++++++++
 include/linux/mfd/tps68470.h      | 144 ++++++++++++
 10 files changed, 1029 insertions(+)
 create mode 100644 drivers/acpi/pmic/tps68470_pmic.c
 create mode 100644 drivers/gpio/gpio-tps68470.c
 create mode 100644 drivers/mfd/tps68470.c
 create mode 100644 include/linux/mfd/tps68470.h

-- 
1.9.1
