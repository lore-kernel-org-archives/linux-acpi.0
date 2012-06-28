From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 00/12] ACPI: add module_acpi_driver() and convert drivers to it
Date: Thu, 28 Jun 2012 13:59:19 +0300
Message-ID: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

This is similar than what is done for other busses before (PCI, I2C, SPI,
platform). It reduces a lot of unnecessary boilerplate code from modules.

We also remove following redundant check on few drivers:

	if (acpi_disabled)
		return -ENODEV;

as this same check is already done at the beginning of
acpi_bus_register_driver().

I think these should all go via ACPI tree because they all depend on the
first patch which adds the macro to the ACPI subsystem.

Mika Westerberg (12):
  ACPI: introduce module_acpi_driver() helper macro
  ACPI/button: convert to module_acpi_driver()
  ACPI/fan: convert to module_acpi_driver()
  ACPI/hed: convert to module_acpi_driver()
  ACPI/sbshc: convert to module_acpi_driver()
  i2c-scmi: convert to module_acpi_driver()
  Input: atlas_btns - convert to module_acpi_driver()
  hp_accel: convert to module_acpi_driver()
  ideapad: convert to module_acpi_driver()
  topstar-laptop: convert to module_acpi_driver()
  toshiba_bluetooth: convert to module_acpi_driver()
  xo15-ebook: convert to module_acpi_driver()

 drivers/acpi/button.c                    |   13 +------------
 drivers/acpi/fan.c                       |   22 +---------------------
 drivers/acpi/hed.c                       |   20 +-------------------
 drivers/acpi/sbshc.c                     |   18 +-----------------
 drivers/i2c/busses/i2c-scmi.c            |   14 +-------------
 drivers/input/misc/atlas_btns.c          |   17 +----------------
 drivers/platform/x86/hp_accel.c          |   25 +------------------------
 drivers/platform/x86/ideapad-laptop.c    |   14 +-------------
 drivers/platform/x86/topstar-laptop.c    |   22 +---------------------
 drivers/platform/x86/toshiba_bluetooth.c |   22 +---------------------
 drivers/platform/x86/xo15-ebook.c        |   14 +-------------
 include/acpi/acpi_bus.h                  |   13 +++++++++++++
 12 files changed, 24 insertions(+), 190 deletions(-)

-- 
1.7.10
