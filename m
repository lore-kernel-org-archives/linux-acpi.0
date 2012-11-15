From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 0/3] ACPI 5 support for GPIO, SPI and I2C
Date: Thu, 15 Nov 2012 13:03:14 +0200
Message-ID: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, bhelgaas@google.com, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

This is a second revision of the ACPI 5 patches originally introduced here:

	https://lkml.org/lkml/2012/11/3/17

The series enables ACPI 5 enumeration of SPI and I2C devices and adds GPIO
translation support for the GPIO resources.

One can then enable ACPI support in a SPI or I2C driver adding something
like:

	#ifdef CONFIG_ACPI
	static struct acpi_device_id mydrv_acpi_match[] = {
		{ "SPI0001", 0 },
		...
		{ }
	};
	MODULE_DEVICE_TABLE(acpi, mydrv_acpi_match);
	#endif

	static struct spi_driver mydrv = {
		...
		.driver = {
			.acpi_match_table = ACPI_PTR(mydrv_acpi_match),
		},
	};

to the existing driver. If more complex configuration is needed, like
getting GPIOs, calling some method, etc. there is dev->acpi_handle for
that.

Changes to the original version:
	[gpio]
	- CONFIG_GPIO_ACPI instead of CONFIG_ACPI_GPIO
	- removed redundant test in acpi_gpiochip_find()

	[spi and i2c]
	- switched to use ACPI centralized _CRS evaluation framework
	  introduced by Rafael 
	- dropped request_module() call
	- dropped the acpi_enumerate_spi/i2c_device()
	- added required includes and dropped <linux/acpi.h> from
	  acpi_i2c.h

The series applies on top of Rafael's
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

There is a dependency to linux-pm.git/linux-next so I think it would be
better if these will be merged via that tree.

Mathias Nyman (1):
  gpio / ACPI: add ACPI support

Mika Westerberg (2):
  spi / ACPI: add ACPI enumeration support
  i2c / ACPI: add ACPI enumeration support

 drivers/acpi/Kconfig        |    6 ++
 drivers/acpi/Makefile       |    1 +
 drivers/acpi/acpi_i2c.c     |  212 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/Kconfig        |    4 +
 drivers/gpio/Makefile       |    1 +
 drivers/gpio/gpiolib-acpi.c |   56 ++++++++++++
 drivers/i2c/i2c-core.c      |   10 ++
 drivers/spi/spi.c           |  201 +++++++++++++++++++++++++++++++++++++++-
 include/linux/acpi_gpio.h   |   19 ++++
 include/linux/acpi_i2c.h    |   27 ++++++
 10 files changed, 536 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/acpi_i2c.c
 create mode 100644 drivers/gpio/gpiolib-acpi.c
 create mode 100644 include/linux/acpi_gpio.h
 create mode 100644 include/linux/acpi_i2c.h

-- 
1.7.10.4
