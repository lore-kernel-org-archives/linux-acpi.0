From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/4] ACPI: Add support for WDAT (Watchdog Action Table)
Date: Tue, 13 Sep 2016 18:23:32 +0300
Message-ID: <20160913152336.75405-1-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

The WDAT (Watchdog Action Table) is a special ACPI table introduced by
Microsoft [1] that abstracts the watchdog hardware from the OS. Windows
uses this table for its watchdog implementation instead of a native iTCO
driver.

Microsoft re-licensed the WDAT specification to be under Microsoft
Community Promise license [2] so it should be fine to use it in Linux.

This series brings WDAT table support to Linux.

When the driver is enabled and we find out that there is a WDAT table, the
driver will take over the native iTCO watchdog driver. Main advantage in
this is that we do not need to change the native iTCO driver whenever the
hardware changes. For example in Skylake iTCO moved to sit behind SMBus and
the NO_REBOOT bit was hidden behind P2SB (Primary to Sideband). In addition
we can expect this to be tested much better by OEMs who typically validate
that Windows works fine on their hardware/firmware.

Patch [1/4] adds ACPI enumeration support and the driver itself. It also
introduces acpi_has_watchdog() which can be used to check if we should use
ACPI watchdog or native one.

Patches [2-4/4] prevent creation of the native iTCO platform device if we
detect that the ACPI watchdog (WDAT) should be used instead.

[1] http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
[2] https://msdn.microsoft.com/en-us/openspecifications/dn646766.aspx

Mika Westerberg (4):
  ACPI / watchdog: Add support for WDAT hardware watchdog
  mfd: lpc_ich: Do not create iTCO watchdog when WDAT table exists
  i2c: i801: Do not create iTCO watchdog when WDAT table exists
  platform/x86: intel_pmc_ipc: Do not create iTCO watchdog when WDAT table exists

 drivers/acpi/Kconfig                 |  16 ++
 drivers/acpi/Makefile                |   2 +
 drivers/acpi/acpi_watchdog.c         | 123 ++++++++
 drivers/acpi/internal.h              |  10 +
 drivers/acpi/scan.c                  |   1 +
 drivers/acpi/wdat_wdt.c              | 524 +++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-i801.c        |   4 +-
 drivers/mfd/lpc_ich.c                |   4 +
 drivers/platform/x86/intel_pmc_ipc.c |  12 +-
 include/linux/acpi.h                 |   6 +
 10 files changed, 697 insertions(+), 5 deletions(-)
 create mode 100644 drivers/acpi/acpi_watchdog.c
 create mode 100644 drivers/acpi/wdat_wdt.c

-- 
2.9.3
