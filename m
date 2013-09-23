From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 00/14] ACPICA 20130823 Release
Date: Mon, 23 Sep 2013 09:50:40 +0800
Message-ID: <cover.1379900697.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21493 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061Ab3IWBvL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Sep 2013 21:51:11 -0400
In-Reply-To: <cover.1377844863.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The 20130823 ACPICA kernel resident system updates is linuxized based on
the pm/linux-next branch.

The patch set has passed a build/boot test on the following machines:
Dell Inspiron Mini 1010 (i386)
HP Compaq 8200 Elite SFF PC (x86-64)
With the following kernel configuration items enabled:
  CONFIG_ACPI_AC
  CONFIG_ACPI_BATTERY
  CONFIG_ACPI_NUMA
  CONFIG_ACPI_PROCESSOR
  CONFIG_ACPI_THERMAL
  CONFIG_ACPI_VIDEO
  CONFIG_CPU_FREQ
  CONFIG_I2C_SCMI
  CONFIG_SENSORS_ACPI_POWER
  CONFIG_PANASONIC_LAPTOP
  CONFIG_XO15_EBOOK
  CONFIG_DMAR_TABLE
  CONFIG_INTEL_IOMMU
  CONFIG_IRQ_REMAP

Bjorn Helgaas (1):
  ACPICA: acpi_read: On error, do not modify the return value target
    location.

Bob Moore (7):
  ACPICA: Improve error message for "too many parent prefixes"
    condition.
  ACPICA: Debug output: small formatting update, no functional change.
  ACPICA: Debugger: Prevent possible command line buffer overflow,
    kernel behavior is not affected.
  ACPICA: Validate start object for acpi_walk_namespace.
  ACPICA: Debugger: Add new command to display full namespace
    pathnames.
  ACPICA: SCI Handlers: Update handler interface, eliminate unnecessary
    argument.
  ACPICA: Update version to 20130823.

David E. Box (1):
  ACPICA: Operation region support: Never free the handler "context"
    pointer.

Lv Zheng (4):
  ACPICA: Add support for host-installed SCI handlers.
  ACPICA: Tables: Cleanup table checksum verification code.
  ACPICA: Tables: Cleanup RSDP signature codes.
  ACPICA: Cleanup exception codes.

Naresh Bhat (1):
  ACPICA: Linux-specific header: enable "aarch64" 64-bit build.

 drivers/acpi/acpica/acdebug.h   |    5 +-
 drivers/acpi/acpica/acevents.h  |    6 +-
 drivers/acpi/acpica/acglobal.h  |   18 +++--
 drivers/acpi/acpica/aclocal.h   |    8 +++
 drivers/acpi/acpica/acnamesp.h  |    6 ++
 drivers/acpi/acpica/evgpeutil.c |    2 +-
 drivers/acpi/acpica/evmisc.c    |   14 ++--
 drivers/acpi/acpica/evregion.c  |   23 ++++---
 drivers/acpi/acpica/evsci.c     |   78 ++++++++++++++++++++--
 drivers/acpi/acpica/evxface.c   |  139 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/hwxface.c   |   26 ++++----
 drivers/acpi/acpica/nsaccess.c  |    5 +-
 drivers/acpi/acpica/nsdump.c    |  134 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nsxfeval.c  |    8 +++
 drivers/acpi/acpica/tbinstal.c  |   12 +---
 drivers/acpi/acpica/tbprint.c   |   12 +++-
 drivers/acpi/acpica/tbxfroot.c  |    3 +-
 drivers/acpi/acpica/utdebug.c   |    2 +-
 drivers/acpi/acpica/utglobal.c  |    3 +-
 include/acpi/acexcep.h          |    8 ++-
 include/acpi/acpixf.h           |   15 +++--
 include/acpi/actypes.h          |    8 +++
 include/acpi/platform/aclinux.h |    2 +-
 23 files changed, 465 insertions(+), 72 deletions(-)

-- 
1.7.10

