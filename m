From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 0/1] gpio: add Lynxpoint chipset gpio driver
Date: Fri,  7 Dec 2012 16:01:38 +0200
Message-ID: <1354888899-21907-1-git-send-email-mathias.nyman@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: grant.likely@secretlab.ca, mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mathias Nyman <mathias.nyman@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

This gpio controller driver for the Intel Lynxpoint LP PCH chipset is
designed to work with the new ACPI 5 enumeration model and ACPI 5 GpioIo/GpioInt 
resource translation recently added to linux-acpi.

Mathias Nyman (1):
  gpio: add Lynxpoint chipset gpio driver.

 drivers/gpio/Kconfig          |    7 +
 drivers/gpio/Makefile         |    1 +
 drivers/gpio/gpio-lynxpoint.c |  406 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 414 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpio/gpio-lynxpoint.c

-- 
1.7.4.1
