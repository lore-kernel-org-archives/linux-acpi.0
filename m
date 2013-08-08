From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/9] ACPICA 20130725 Release
Date: Thu,  8 Aug 2013 15:29:16 +0800
Message-ID: <cover.1375946725.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14895 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933531Ab3HHH3x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 03:29:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The 20130725 ACPICA kernel resident system updates is linuxized based on
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

Bob Moore (8):
  ACPICA: Export acpi_tb_validate_rsdp().
  ACPICA: Emit all unresolved method externals in a text block
  ACPICA: DeRefOf operator: Update to fully resolve FieldUnit and
    BufferField refs.
  ACPICA: Fix possible fault for methods that optionally have no return
    value.
  ACPICA: Make ACPI Power Management Timer (PM Timer) optional.
  ACPICA: Return error if DerefOf resolves to a null package element.
  ACPICA: Update names for walk_namespace callbacks to clarify usage.
  ACPICA: Update version to 20130725.

Lv Zheng (1):
  ACPICA: Fix divergences of the commit - ACPICA: Expose OSI version.

 drivers/acpi/acpica/acglobal.h |    7 +++++-
 drivers/acpi/acpica/aclocal.h  |    1 +
 drivers/acpi/acpica/acnamesp.h |    4 ++--
 drivers/acpi/acpica/actables.h |    2 ++
 drivers/acpi/acpica/exoparg1.c |   48 +++++++++++++++++++++++++++++++++++-----
 drivers/acpi/acpica/hwtimer.c  |   13 ++++++++++-
 drivers/acpi/acpica/nspredef.c |   16 +++++++++++++-
 drivers/acpi/acpica/nswalk.c   |   26 +++++++++++-----------
 drivers/acpi/acpica/nsxfeval.c |   16 +++++++-------
 drivers/acpi/acpica/tbfadt.c   |    4 ++--
 drivers/acpi/acpica/tbxfroot.c |    8 ++-----
 drivers/acpi/acpica/utglobal.c |    1 -
 include/acpi/acpixf.h          |    6 ++---
 include/acpi/actypes.h         |   28 +++++++++++------------
 14 files changed, 121 insertions(+), 59 deletions(-)

-- 
1.7.10

