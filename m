From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v4 0/3] ACPI 5 support for GPIO, SPI and I2C
Date: Tue, 20 Nov 2012 20:13:29 +0200
Message-ID: <1353435212-15325-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1353407384-26880-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353407384-26880-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, linus.walleij@linaro.org, w.sang@pengutronix.de, rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, broonie@opensource.wolfsonmicro.com, khali@linux-fr.org, ben-linux@fluff.org, bhelgaas@google.com, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

This is fourth version of the series. I've based these on top of Rafael's
"simplify glueing ACPI handles to physical nodes" available from here:

	https://lkml.org/lkml/2012/11/19/588

There is a dependency to linux-pm tree and to the above patches so I
propose to merge these via that same tree. Subsystem maintainers, can you
ack these if you think that they are a suitable shape?

Changes to v3:
	- simplify acpi_gpiochip_find()
	- acpi_spi/i2c_add_resource() uses acpi_dev_resource_interrupt()
	  directly instead of first checking the resource type
	- acpi_spi/i2c_add_device() calls acpi_dev_free_resource_list()
	  immediately after walking the resources and get rid of
	  fail_put_dev label.

Changes to v2:
	- drop the ACPI ->find_device() glue magic in preference of the new
	  simplified mechanism where we just assign the ACPI handle
	- correct the IRQ resource handling to take the first resource and
	  skip the rest
	- moved declaration of acpi_i2c_register_devices() to i2c.h instead
	  of having a separate header for a single function

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

Thanks.

Mathias Nyman (1):
  gpio / ACPI: add ACPI support

Mika Westerberg (2):
  spi / ACPI: add ACPI enumeration support
  i2c / ACPI: add ACPI enumeration support

 drivers/acpi/Kconfig        |    6 +++
 drivers/acpi/Makefile       |    1 +
 drivers/acpi/acpi_i2c.c     |  103 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/Kconfig        |    4 ++
 drivers/gpio/Makefile       |    1 +
 drivers/gpio/gpiolib-acpi.c |   54 +++++++++++++++++++++++
 drivers/i2c/i2c-core.c      |    6 +++
 drivers/spi/spi.c           |  103 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/acpi_gpio.h   |   19 ++++++++
 include/linux/i2c.h         |    9 ++++
 10 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/acpi_i2c.c
 create mode 100644 drivers/gpio/gpiolib-acpi.c
 create mode 100644 include/linux/acpi_gpio.h

-- 
1.7.10.4
