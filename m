From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/5] gpiolib: convert ACPI GPIO helpers to gpiod_ interfaces
Date: Tue,  1 Oct 2013 17:58:52 +0300
Message-ID: <1380639537-23406-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: rjw@rjwysocki.net, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi all,

This series converts the ACPI GPIO helpers in gpiolib-acpi.c to use the new
and preferred GPIO descriptor based interface as suggested by the GPIO
subsystem maintainer.

The first patch is just a cosmetic fix to move acpi_gpiochip_free_interrupts()
closer to acpi_gpiochip_request_interrupts(). Patches [2-5/5] do the actual
conversion.

The series is based on the latest patches from Alexandre Courbot and I've
tested them on Intel Haswell based machine.

Please review.

Mika Westerberg (5):
  gpiolib / ACPI: move acpi_gpiochip_free_interrupts next to the request function
  gpiolib / ACPI: convert to gpiod interfaces
  gpiolib / ACPI: add ACPI support for gpiod_get_index()
  gpiolib / ACPI: allow passing GPIOF_ACTIVE_LOW for GpioInt resources
  gpiolib / ACPI: document the GPIO descriptor based interface

 Documentation/acpi/enumeration.txt |  22 +++++++
 drivers/gpio/gpiolib-acpi.c        | 129 ++++++++++++++++++-------------------
 drivers/gpio/gpiolib.c             |  20 ++++++
 include/linux/acpi_gpio.h          |  40 +++++++++---
 4 files changed, 138 insertions(+), 73 deletions(-)

-- 
1.8.4.rc3

