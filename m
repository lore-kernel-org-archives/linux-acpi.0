From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/11] ACPICA: 20161117 Release
Date: Wed, 30 Nov 2016 15:20:44 +0800
Message-ID: <cover.1480490191.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18816 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752603AbcK3HUu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 02:20:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The 20161117 ACPICA kernel-resident subsystem updates are linuxized based
on the linux-pm/linux-next branch.

The patchset has passed the following build/boot tests.
Build tests are performed as follows:
1. i386 + allyes
2. i386 + allno
3. i386 + default + ACPI_DEBUGGER=y
4. i386 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
5. i386 + default + ACPI_DEBUG=n + ACPI=y
6. i386 + default + ACPI=n
7. x86_64 + allyes
8. x86_64 + allno
9. x86_64 + default + ACPI_DEBUGGER=y
10.x86_64 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
11.x86_64 + default + ACPI_DEBUG=n + ACPI=y
12.x86_64 + default + ACPI=n
Boot tests are performed as follows:
1. i386 + default + ACPI_DEBUGGER=y
2. x86_64 + default + ACPI_DEBUGGER=y
Where:
1. i386: machine named as "Dell Inspiron Mini 1010"
2. x86_64: machine named as "Microsoft Surface Pro 3"
3. default: kernel configuration with following items enabled:
   All hardware drivers related to the machines of i386/x86_64
   All "drivers/acpi" configurations
   All "drivers/platform" drivers
   All other drivers that link the APIs provided by ACPICA subsystem

The divergences checking result:
Before applying (20160930 Release):
  508 lines
After applying (20161117 Release):
  467 lines

Bob Moore (3):
  ACPICA: Fix for implicit result conversion for the ToXXXX functions
  ACPICA: Utilities: Add new decode function for parser values
  ACPICA: Update version to 20161117

Lv Zheng (8):
  ACPICA: Namespace: Add acpi_ns_handle_to_name()
  ACPICA: Back port of "ACPICA: Dispatcher: Tune interpreter lock
    around AcpiEvInitializeRegion()"
  ACPICA: Events: Fix acpi_ev_initialize_region() return value
  ACPICA: Tables: Cleanup acpi_tb_install_and_load_table()
  ACPICA: Tables: Add acpi_tb_unload_table()
  ACPICA: Tables: Add an error message complaining driver bugs
  ACPICA: Tables: Back port acpi_get_table_with_size() and
    early_acpi_os_unmap_memory() from Linux kernel
  ACPICA: Tables: Allow FADT to be customized with virtual address

 drivers/acpi/acpica/acevents.h    |    4 +-
 drivers/acpi/acpica/acnamesp.h    |    3 +
 drivers/acpi/acpica/acopcode.h    |   14 ++--
 drivers/acpi/acpica/actables.h    |   11 ++-
 drivers/acpi/acpica/acutils.h     |    2 +
 drivers/acpi/acpica/amlcode.h     |   21 +++++-
 drivers/acpi/acpica/dsinit.c      |    4 +-
 drivers/acpi/acpica/dsopcode.c    |    2 +-
 drivers/acpi/acpica/dswload2.c    |   13 +---
 drivers/acpi/acpica/evrgnini.c    |   59 ++++++---------
 drivers/acpi/acpica/exconfig.c    |   42 +----------
 drivers/acpi/acpica/exconvrt.c    |    1 -
 drivers/acpi/acpica/exresop.c     |    1 -
 drivers/acpi/acpica/nsnames.c     |   45 ++++++++++++
 drivers/acpi/acpica/nsxfname.c    |   43 +++--------
 drivers/acpi/acpica/tbdata.c      |   81 +++++++++++---------
 drivers/acpi/acpica/tbfadt.c      |   14 ++--
 drivers/acpi/acpica/tbutils.c     |   85 +++++++++++++++++++++
 drivers/acpi/acpica/tbxface.c     |  146 +++++++++++++++++++++++++------------
 drivers/acpi/acpica/tbxfload.c    |   38 +---------
 drivers/acpi/acpica/utdecode.c    |   49 +++++++++++++
 drivers/acpi/osl.c                |   31 +++++++-
 include/acpi/acpixf.h             |   14 +++-
 include/acpi/actbl.h              |    1 +
 include/acpi/platform/aclinuxex.h |    1 -
 25 files changed, 458 insertions(+), 267 deletions(-)

-- 
1.7.10

