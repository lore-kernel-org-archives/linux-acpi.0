From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH 0/4] dln2: add support for ACPI
Date: Tue, 16 Dec 2014 18:12:29 +0200
Message-ID: <1418746353-3481-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, lee.jones@linaro.org, rjw@rjwysocki.net
Cc: johan@kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, heikki.krogerus@intel.com, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-acpi@vger.kernel.org

This patch sets adds support for ACPI enumeration for devices
connected to the DLN2 bridge via a custom ACPI table.

The first two patches fix a couple of issues with the ACPI load/unload
table APIs.

The 3rd patch adds ACPI support to the MFD driver and the last patch
configures pull-up/pull-down on GPIO pins based on the APCI
configuration.

Octavian Purdila (4):
  ACPICA: take ACPI_MTX_INTERPRETER in acpi_unload_table_id
  ACPICA: don't release ACPI_MTX_TABLES in
    acpi_tb_install_standard_table
  mfd: dln2: add support for ACPI
  gpio: dln2: add support for ACPI pin configuration

 Documentation/acpi/dln2-acpi.txt |  62 ++++++++++++++++++
 drivers/acpi/acpica/tbinstal.c   |   1 -
 drivers/acpi/acpica/tbxface.c    |   7 ++
 drivers/gpio/gpio-dln2.c         |  76 ++++++++++++++++++++++
 drivers/mfd/dln2.c               | 134 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 279 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/acpi/dln2-acpi.txt

-- 
1.9.1

