From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/6] ACPICA 20130626 Release
Date: Wed, 17 Jul 2013 09:47:58 +0800
Message-ID: <cover.1374025121.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42921 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab3GQBsO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jul 2013 21:48:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The 20130626 ACPICA kernel resident system updates is linuxized based on
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
No new divergences are introduced in this release.

Please review.

Bob Moore (5):
  ACPICA: Comment update
  ACPICA: TableManager: Export acpi_tb_scan_memory_for_rsdp()
  ACPICA: Disassembler: Expand maximum output string length to 64K
  ACPICA: Remove restriction of 256 maximum GPEs in any GPE block
  ACPICA: Update version to 20130626

Jung-uk Kim (1):
  ACPICA: Fix compiler warnings for casting issues (only some
    compilers)

 drivers/acpi/acpica/actables.h  |    5 +++++
 drivers/acpi/acpica/acutils.h   |    2 +-
 drivers/acpi/acpica/evgpeinit.c |   11 -----------
 drivers/acpi/acpica/exdump.c    |    6 +++---
 drivers/acpi/acpica/nsxfname.c  |   11 +++++++++--
 drivers/acpi/acpica/tbxfroot.c  |    4 +---
 drivers/acpi/acpica/uteval.c    |    8 +++++++-
 drivers/acpi/acpica/utstring.c  |    5 +++--
 include/acpi/acpixf.h           |    2 +-
 include/acpi/actypes.h          |    7 -------
 10 files changed, 30 insertions(+), 31 deletions(-)

-- 
1.7.10

