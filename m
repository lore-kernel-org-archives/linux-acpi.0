From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/2] ACPI: Translate Linux IRQ number directly from GpioInt
Date: Tue, 28 Apr 2015 18:05:05 +0300
Message-ID: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Currently drivers for ACPI enumerated devices that have their interrupt
line connected to a GPIO controller instead of IO-APIC are required to do
complete gpiod_get()/gpiod_to_irq() etc. dance themselves. This adds
unnecessary lines of code to these drivers.

It turned out that DT solved the problem already with introduction of
of_irq_get() which is able to handle GPIO based interrupts as well through
irqchip API [1].

Following two patches does the same for ACPI by introducing new function
acpi_dev_gpio_irq_get() that is then used in I2C core to automatically
translate ACPI GpioInt resource to Linux IRQ number.

This requires that the boot firmware (BIOS/coreboot) configures these pins
correctly (input, etc) before handing over to OS. I've tested this on Intel
Baytrail, Braswell and Skylake based machines where this is true.

[1] https://lkml.org/lkml/2015/3/25/103

Mika Westerberg (2):
  gpio / ACPI: Add support for retrieving GpioInt resources from a device
  i2c / ACPI: Assign IRQ for devices that have GpioInt automatically

 drivers/gpio/gpiolib-acpi.c | 29 +++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c      |  9 +++++++--
 include/linux/acpi.h        |  7 +++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.1.4

