From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/15] ACPICA 20170303 Release
Date: Wed, 26 Apr 2017 16:17:37 +0800
Message-ID: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:14950 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1433957AbdDZIRq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:17:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The 20170303 ACPICA kernel-resident subsystem updates are linuxized based
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
Before applying (20170119 Release):
  369 lines
After applying (20170303 Release):
  369 lines

Bob Moore (9):
  ACPICA: Disassembler: Enhance resource descriptor detection
  ACPICA: Update some function headers, no funtional change
  ACPICA: Fix a module for excessive debug output
  ACPICA: Fix several incorrect invocations of ACPICA return macro
  ACPICA: Update for automatic repair code for objects returned by
    evaluate_object
  ACPICA: Cleanup AML opcode definitions, no functional change
  ACPICA: iasl: add ASL conversion tool
  ACPICA: Local cache support: Allow small cache objects
  ACPICA: Update version to 20170303

Colin Ian King (1):
  ACPICA: debugger: fix memory leak on Pathname

David E. Box (1):
  ACPICA: Disassembler: Do not unconditionally remove temporary names

Jung-uk Kim (1):
  ACPICA: Fix build for FreeBSD kernel.

Lv Zheng (2):
  ACPICA: Debugger: Add interpreter blocking mark for single-step mode
  ACPICA: iasl: Fix IORT SMMU GSI disassembling

Seunghun Han (1):
  ACPICA: Namespace: fix operand cache leak

 drivers/acpi/acpica/acconvert.h | 144 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/acglobal.h  |  53 +++++++++++++++
 drivers/acpi/acpica/aclocal.h   | 106 ++++++++++++++++++++++++-----
 drivers/acpi/acpica/acmacros.h  |  35 ++++++++++
 drivers/acpi/acpica/acopcode.h  |   2 +
 drivers/acpi/acpica/amlcode.h   |  99 +++++++++++++--------------
 drivers/acpi/acpica/dbmethod.c  |   1 +
 drivers/acpi/acpica/dbxface.c   |   5 +-
 drivers/acpi/acpica/dscontrol.c |   2 +-
 drivers/acpi/acpica/dsmthdat.c  |   3 +-
 drivers/acpi/acpica/dsobject.c  |  15 +++--
 drivers/acpi/acpica/dsopcode.c  |   4 +-
 drivers/acpi/acpica/dsutils.c   |   8 +--
 drivers/acpi/acpica/dswexec.c   |   2 +-
 drivers/acpi/acpica/dswload2.c  |   2 +-
 drivers/acpi/acpica/exmisc.c    |  16 ++---
 drivers/acpi/acpica/exnames.c   |   4 +-
 drivers/acpi/acpica/exoparg1.c  |  17 +++--
 drivers/acpi/acpica/exoparg2.c  |   4 +-
 drivers/acpi/acpica/exoparg6.c  |  16 ++---
 drivers/acpi/acpica/exresolv.c  |   3 +-
 drivers/acpi/acpica/exstore.c   |   5 +-
 drivers/acpi/acpica/exstoren.c  |   2 +-
 drivers/acpi/acpica/hwvalid.c   |  18 ++---
 drivers/acpi/acpica/nsaccess.c  |   2 +-
 drivers/acpi/acpica/nsrepair.c  |  16 +----
 drivers/acpi/acpica/nsrepair2.c |   6 +-
 drivers/acpi/acpica/nsutils.c   |  29 ++++----
 drivers/acpi/acpica/psargs.c    |  29 +++++++-
 drivers/acpi/acpica/psloop.c    |  34 +++++++++-
 drivers/acpi/acpica/psobject.c  |  38 +++++++++++
 drivers/acpi/acpica/psopcode.c  |  15 +++--
 drivers/acpi/acpica/psopinfo.c  |   2 +-
 drivers/acpi/acpica/psparse.c   |   6 +-
 drivers/acpi/acpica/pstree.c    |   9 ++-
 drivers/acpi/acpica/psutils.c   |  11 +++
 drivers/acpi/acpica/utalloc.c   |  50 ++++++++++++++
 drivers/acpi/acpica/utcache.c   |   2 +-
 drivers/acpi/acpica/utdebug.c   |   1 +
 drivers/acpi/acpica/utresrc.c   |   9 +++
 drivers/acpi/acpica/utxferror.c |  16 ++---
 include/acpi/acconfig.h         |   1 +
 include/acpi/acpixf.h           |   2 +-
 include/acpi/actbl2.h           |  10 +++
 44 files changed, 659 insertions(+), 195 deletions(-)
 create mode 100644 drivers/acpi/acpica/acconvert.h

-- 
2.7.4

