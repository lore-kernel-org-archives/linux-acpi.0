From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/8] ACPICA 20170831 Release
Date: Fri, 15 Sep 2017 12:43:49 +0800
Message-ID: <cover.1505377451.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:57028 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdIOEoF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Sep 2017 00:44:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The 20170831 ACPICA kernel-resident subsystem updates are linuxized based
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
1. x86_64 + default + ACPI_DEBUGGER=y
Where:
1. i386: machine named as "Dell Inspiron Mini 1010"
2. x86_64: machine named as "Microsoft Surface Pro 3"
3. default: kernel configuration with following items enabled:
   All hardware drivers related to the machines of i386/x86_64
   All "drivers/acpi" configurations
   All "drivers/platform" drivers
   All other drivers that link the APIs provided by ACPICA subsystem

The divergences checking result:
Before applying (20170728 Release):
  390 lines
After applying (20170831 Release):
  390 lines

Bob Moore (6):
  ACPICA: Header support for the PDTT ACPI table
  ACPICA: Restructure/cleanup all string-to-integer conversion functions
  ACPICA: String conversions: Cleanup/format comments. No functional
    changes
  ACPICA: String conversions: Update to add new behaviors
  ACPICA: Update acpi_get_timer for 64-bit interface to acpi_hw_read
  ACPICA: Update version to 20170831

Lv Zheng (2):
  ACPICA: Hardware: Enable 64-bit support of hardware accesses
  ACPICA: acpiexec: Add testability of deferred table verification

 drivers/acpi/acpica/Makefile             |   1 +
 drivers/acpi/acpica/achware.h            |   4 +-
 drivers/acpi/acpica/acinterp.h           |   6 +-
 drivers/acpi/acpica/acutils.h            |  33 ++-
 drivers/acpi/acpica/dbconvert.c          |   5 +-
 drivers/acpi/acpica/dswexec.c            |   2 +-
 drivers/acpi/acpica/evgpe.c              |   6 +-
 drivers/acpi/acpica/exconcat.c           |   2 +-
 drivers/acpi/acpica/exconvrt.c           |  30 ++-
 drivers/acpi/acpica/exmisc.c             |   2 +-
 drivers/acpi/acpica/exresop.c            |   2 +-
 drivers/acpi/acpica/hwgpe.c              |   4 +-
 drivers/acpi/acpica/hwregs.c             |  72 ++---
 drivers/acpi/acpica/hwtimer.c            |  10 +-
 drivers/acpi/acpica/hwxface.c            | 118 +--------
 drivers/acpi/acpica/nsconvert.c          |   4 +-
 drivers/acpi/acpica/tbxface.c            |   9 +-
 drivers/acpi/acpica/utstrsuppt.c         | 437 ++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utstrtoul64.c        | 442 ++++++++++++++++---------------
 include/acpi/acexcep.h                   |  16 +-
 include/acpi/acpixf.h                    |   2 +-
 include/acpi/actbl1.h                    |  30 +++
 tools/power/acpi/tools/acpidump/Makefile |   1 +
 tools/power/acpi/tools/acpidump/apdump.c |   3 +-
 tools/power/acpi/tools/acpidump/apmain.c |   4 +-
 25 files changed, 833 insertions(+), 412 deletions(-)
 create mode 100644 drivers/acpi/acpica/utstrsuppt.c

-- 
2.7.4

