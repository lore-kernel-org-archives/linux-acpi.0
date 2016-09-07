From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/14] ACPICA: 20160831 Release
Date: Wed,  7 Sep 2016 14:05:34 +0800
Message-ID: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40813 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbcIGGFk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:05:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The 20160831 ACPICA kernel-resident subsystem updates are linuxized based
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
2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
3. default: kernel configuration with following items enabled:
   All hardware drivers related to the machines of i386/x86_64
   All "drivers/acpi" configurations
   All "drivers/platform" drivers
   All other drivers that link the APIs provided by ACPICA subsystem

The divergences checking result:
Before applying (20160629 Release):
  508 lines
After applying (20160831 Release):
  508 lines

Bob Moore (5):
  ACPICA: Debugger: Add subcommand for predefined name execution
  ACPICA: Cleanup for all string-to-integer conversions
  ACPICA: Add a couple of casts to uthex.c
  ACPICA: Update return value for intenal _OSI method
  ACPICA: Update version to 20160831

Lv Zheng (9):
  ACPICA: Tables: Remove acpi_tb_install_fixed_table()
  ACPICA: Tables: Remove wrong table event macros
  ACPICA: Tables: Add new table events indicating table
    installation/uninstallation
  ACPICA: Tables: Override all 64-bit GAS fields when
    acpi_gbl_use32_bit_fadt_addresses is TRUE
  ACPICA: Interpreter: Fix MLC issues by switching to new term_list
    grammar for table loading
  ACPICA: Namespace: Add acpi_ns_get_node_unlocked()
  ACPICA: Namespace: Fix dynamic table loading issues by tuning
    namespace/interpreter locks
  ACPICA: Dispatcher: Fix a mutex issue for method auto serialization
  ACPICA: Tables: Tune table mutex to be a leaf lock

 drivers/acpi/acpica/Makefile             |    1 +
 drivers/acpi/acpica/acdebug.h            |    2 +-
 drivers/acpi/acpica/acnamesp.h           |    8 +
 drivers/acpi/acpica/acparser.h           |    2 +
 drivers/acpi/acpica/actables.h           |   15 +-
 drivers/acpi/acpica/acutils.h            |   17 +-
 drivers/acpi/acpica/dbconvert.c          |    7 +-
 drivers/acpi/acpica/dbexec.c             |   62 +++---
 drivers/acpi/acpica/dbinput.c            |    2 +
 drivers/acpi/acpica/dbmethod.c           |  132 +++++++++++
 drivers/acpi/acpica/dsmethod.c           |   14 +-
 drivers/acpi/acpica/dswexec.c            |    3 +-
 drivers/acpi/acpica/dswload2.c           |    7 +-
 drivers/acpi/acpica/evgpeinit.c          |    7 +-
 drivers/acpi/acpica/evrgnini.c           |    3 +-
 drivers/acpi/acpica/exconcat.c           |    2 +-
 drivers/acpi/acpica/exconfig.c           |  118 +++-------
 drivers/acpi/acpica/exconvrt.c           |    8 +-
 drivers/acpi/acpica/exmisc.c             |    4 +-
 drivers/acpi/acpica/exoparg1.c           |   23 +-
 drivers/acpi/acpica/exresop.c            |   11 +-
 drivers/acpi/acpica/extrace.c            |   25 ---
 drivers/acpi/acpica/exutils.c            |    8 +
 drivers/acpi/acpica/nsconvert.c          |    1 -
 drivers/acpi/acpica/nsload.c             |   30 +--
 drivers/acpi/acpica/nsparse.c            |  165 +++++++++++---
 drivers/acpi/acpica/nsutils.c            |   66 ++++--
 drivers/acpi/acpica/psparse.c            |    6 +-
 drivers/acpi/acpica/psxface.c            |   73 ++++++
 drivers/acpi/acpica/tbdata.c             |  140 ++++++++++++
 drivers/acpi/acpica/tbfadt.c             |  126 +++++------
 drivers/acpi/acpica/tbfind.c             |   10 +-
 drivers/acpi/acpica/tbinstal.c           |   73 +-----
 drivers/acpi/acpica/tbxfload.c           |   53 +----
 drivers/acpi/acpica/utaddress.c          |    8 -
 drivers/acpi/acpica/uthex.c              |   46 +++-
 drivers/acpi/acpica/utnonansi.c          |  357 +-----------------------------
 drivers/acpi/acpica/utosi.c              |   22 +-
 drivers/acpi/acpica/utstrtoul64.c        |  348 +++++++++++++++++++++++++++++
 drivers/acpi/acpica/utxfinit.c           |    3 +-
 include/acpi/acpixf.h                    |    9 +-
 include/acpi/actypes.h                   |   16 +-
 tools/power/acpi/tools/acpidump/Makefile |    2 +
 tools/power/acpi/tools/acpidump/apdump.c |    4 +-
 tools/power/acpi/tools/acpidump/apmain.c |    4 +-
 45 files changed, 1222 insertions(+), 821 deletions(-)
 create mode 100644 drivers/acpi/acpica/utstrtoul64.c

-- 
1.7.10

