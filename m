From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/1] acpi: struct acpi_device_id as parameter of acpi_opt_add()
Date: Thu, 30 Aug 2012 16:11:14 +0300
Message-ID: <1346332275-12366-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:14719 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635Ab2H3NLJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Aug 2012 09:11:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi,

We are preparing acpi enumeration for various drivers (uart, i2c, spi,
etc.) and many of these drivers will require device specific quirks.
The identification of the specific device can be done with the help of
the device id table like it's done in their pci driver counterparts,
but now the drivers would need to dig the correct struct
acpi_device_id by looping through their id arrays. This patch will
deliver the correct struct acpi_device_id as a parameter of
acpi_opt_add.


Heikki Krogerus (1):
  acpi: deliver acpi_device_id with acpi_op_add

 arch/ia64/hp/common/aml_nfw.c            |    3 ++-
 arch/ia64/hp/common/sba_iommu.c          |    2 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c   |    3 ++-
 drivers/acpi/ac.c                        |    6 ++++--
 drivers/acpi/acpi_memhotplug.c           |    6 ++++--
 drivers/acpi/acpi_pad.c                  |    3 ++-
 drivers/acpi/battery.c                   |    3 ++-
 drivers/acpi/button.c                    |    6 ++++--
 drivers/acpi/container.c                 |    6 ++++--
 drivers/acpi/ec.c                        |    3 ++-
 drivers/acpi/fan.c                       |    6 ++++--
 drivers/acpi/hed.c                       |    3 ++-
 drivers/acpi/pci_link.c                  |    6 ++++--
 drivers/acpi/pci_root.c                  |    6 ++++--
 drivers/acpi/power.c                     |    6 ++++--
 drivers/acpi/processor_driver.c          |    6 ++++--
 drivers/acpi/sbs.c                       |    3 ++-
 drivers/acpi/sbshc.c                     |    6 ++++--
 drivers/acpi/scan.c                      |   32 +++++++++++++++++++++---------
 drivers/acpi/thermal.c                   |    6 ++++--
 drivers/acpi/video.c                     |    6 ++++--
 drivers/char/hpet.c                      |    3 ++-
 drivers/char/sonypi.c                    |    3 ++-
 drivers/hv/vmbus_drv.c                   |    3 ++-
 drivers/hwmon/acpi_power_meter.c         |    3 ++-
 drivers/hwmon/asus_atk0110.c             |    5 +++--
 drivers/i2c/busses/i2c-scmi.c            |    3 ++-
 drivers/input/misc/atlas_btns.c          |    3 ++-
 drivers/platform/x86/asus-laptop.c       |    3 ++-
 drivers/platform/x86/classmate-laptop.c  |   15 +++++++++-----
 drivers/platform/x86/eeepc-laptop.c      |    3 ++-
 drivers/platform/x86/fujitsu-laptop.c    |    6 ++++--
 drivers/platform/x86/fujitsu-tablet.c    |    3 ++-
 drivers/platform/x86/hp_accel.c          |    3 ++-
 drivers/platform/x86/ideapad-laptop.c    |    3 ++-
 drivers/platform/x86/intel_menlow.c      |    3 ++-
 drivers/platform/x86/panasonic-laptop.c  |    6 ++++--
 drivers/platform/x86/sony-laptop.c       |    6 ++++--
 drivers/platform/x86/thinkpad_acpi.c     |    3 ++-
 drivers/platform/x86/topstar-laptop.c    |    3 ++-
 drivers/platform/x86/toshiba_acpi.c      |    3 ++-
 drivers/platform/x86/toshiba_bluetooth.c |    6 ++++--
 drivers/platform/x86/wmi.c               |    6 ++++--
 drivers/platform/x86/xo15-ebook.c        |    3 ++-
 drivers/staging/quickstart/quickstart.c  |    3 ++-
 drivers/video/backlight/apple_bl.c       |    3 ++-
 include/acpi/acpi_bus.h                  |    4 +++-
 47 files changed, 158 insertions(+), 77 deletions(-)

-- 
1.7.10.4

