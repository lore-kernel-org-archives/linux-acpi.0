From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/15] ACPICA 20170728 Release
Date: Thu,  3 Aug 2017 14:26:02 +0800
Message-ID: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24442 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbdHCG0R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:26:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The 20170728 ACPICA kernel-resident subsystem updates are linuxized based
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
Before applying (20170629 Release):
  390 lines
After applying (20170728 Release):
  390 lines

Bob Moore (8):
  ACPICA: Namespace: Update/fix an error message
  ACPICA: Add a comment, no functional change
  ACPICA: Interpreter: Update handling for Alias operator
  ACPICA: Debugger: Improve support for Alias objects
  ACPICA: Implement deferred resolution of reference package elements
  ACPICA: Ensure all instances of AE_AML_INTERNAL have error messages
  ACPICA: Resources: Allow _DMA method in walk resources
  ACPICA: Update version to 20170728

Erik Schmauss (1):
  ACPICA: Revert "Update resource descriptor handling"

James Morse (1):
  ACPICA: iASL: Add support for the SDEI table

Lv Zheng (4):
  ACPICA: Divergences: reduce access size definitions
  ACPICA: CLib: Add short multiply/shift support
  ACPICA: acpidump: Add DSDT/FACS instance support for Linux and EFI
  ACPICA: EFI/EDK2: Cleanup to enable /WX for MSVC builds

Shao Ming (1):
  ACPICA: EFI/EDK2: Sort acpi.h inclusion order

 drivers/acpi/acpica/Makefile                       |   1 +
 drivers/acpi/acpica/acdispat.h                     |  13 +
 drivers/acpi/acpica/aclocal.h                      |   2 +-
 drivers/acpi/acpica/acobject.h                     |   3 +-
 drivers/acpi/acpica/acutils.h                      |   9 +-
 drivers/acpi/acpica/dbdisply.c                     |  37 +-
 drivers/acpi/acpica/dsfield.c                      |   2 +
 drivers/acpi/acpica/dsobject.c                     | 398 +++--------------
 drivers/acpi/acpica/dsopcode.c                     |   9 +
 drivers/acpi/acpica/dspkginit.c                    | 496 +++++++++++++++++++++
 drivers/acpi/acpica/excreate.c                     |  61 +--
 drivers/acpi/acpica/exdump.c                       |  34 +-
 drivers/acpi/acpica/exmisc.c                       |   9 +
 drivers/acpi/acpica/exoparg2.c                     |   3 +
 drivers/acpi/acpica/hwregs.c                       |   2 +-
 drivers/acpi/acpica/nsaccess.c                     |  22 +-
 drivers/acpi/acpica/nsarguments.c                  |  21 +-
 drivers/acpi/acpica/nsinit.c                       |  14 +
 drivers/acpi/acpica/nsnames.c                      |   9 +-
 drivers/acpi/acpica/nsprepkg.c                     |   2 +
 drivers/acpi/acpica/psloop.c                       |  14 +
 drivers/acpi/acpica/rsxface.c                      |   7 +-
 drivers/acpi/acpica/uthex.c                        |   4 +-
 drivers/acpi/acpica/utmath.c                       | 222 ++++++++-
 drivers/acpi/acpica/utmisc.c                       |  10 +-
 drivers/acpi/acpica/utobject.c                     |   5 +
 drivers/acpi/acpica/utprint.c                      |   8 +-
 drivers/acpi/acpica/utresrc.c                      |  21 +-
 drivers/acpi/acpica/utstate.c                      |   2 +-
 drivers/acpi/acpica/utstrtoul64.c                  |   9 +-
 drivers/acpi/acpica/uttrack.c                      |   9 +-
 drivers/acpi/spcr.c                                |   9 +-
 include/acpi/acnames.h                             |   1 +
 include/acpi/acpi.h                                |   4 +-
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/acrestyp.h                            |   7 -
 include/acpi/actbl2.h                              |  14 +
 include/acpi/actypes.h                             |   8 +
 include/acpi/platform/acgcc.h                      |   4 +
 include/acpi/platform/aclinux.h                    |   2 +
 .../acpi/os_specific/service_layers/oslinuxtbl.c   | 105 +++--
 tools/power/acpi/tools/acpidump/apfiles.c          |   2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   2 +-
 43 files changed, 1127 insertions(+), 491 deletions(-)
 create mode 100644 drivers/acpi/acpica/dspkginit.c

-- 
2.7.4

