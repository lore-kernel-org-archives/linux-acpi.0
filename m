From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/54] ACPICA 20170531 Release
Date: Mon,  5 Jun 2017 16:15:07 +0800
Message-ID: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47865 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751511AbdFEIPS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:15:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The 20170531 ACPICA kernel-resident subsystem updates are linuxized based
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
Before applying (20170303 Release):
  369 lines
After applying (20170531 Release):
  369 lines

Bob Moore (26):
  ACPICA: Add new notify value for memory attributes update
  ACPICA: Added two new UUID values
  ACPICA: Utilities: Make a notify value reserved
  ACPICA: Update Status field for BGRT table
  ACPICA: Add new notify value for HEST table
  ACPICA: Add new flags to HEST subtables
  ACPICA: Add support for new HEST subtable
  ACPICA: Add support for new SRAT subtable
  ACPICA: Add header support for TPM2 table changes
  ACPICA: Fix a type value overlap in the AML support file
  ACPICA: Update error message for field beyond buffer case
  ACPICA: Debugger/acpiexec: Cleanup error messages
  ACPICA: Disassembler: Abort on an invalid/unknown AML opcode
  ACPICA: Export the public mutex interfaces
  ACPICA: Remove extraneous status check
  ACPICA: Update resource descriptor handling
  ACPICA: Split resource descriptor decode strings to a new file
  ACPICA: Comment update: spelling/format. No functional change
  ACPICA: Fix for Device/Thermal objects with ObjectType and DerefOf
  ACPICA: Update two error messages to emit control method name
  ACPICA: Improvements for debug output only
  ACPICA: Unix application OSL: Correctly handle control-c (EINTR)
  ACPICA: Simplify output for the ACPI Debug Object
  ACPICA: acpiexec: enhance local signal handler
  ACPICA: Update a couple of debug output messages
  ACPICA: Update version to 20170531

Cao Jin (1):
  ACPICA: Update comments, no functional change

David E. Box (2):
  ACPICA: disassembler: improve Switch support
  ACPICA: Add support for new PCCT subtables

Erik Schmauss (11):
  ACPICA: Change path's type from u8* to char*
  ACPICA: Add support for _LSI as a predefined method
  ACPICA: Add support for _LSR as a predefined method
  ACPICA: Add support for _LSW as a predefined method
  ACPICA: Add support for _HMA as a predefined method
  ACPICA: Explicitly cast 1 to u32
  ACPICA: Changing External to a named object
  ACPICA: Changed Gbl_disasm_flag to acpi_gbl_disasm_flag
  ACPICA: Disassembler: prevent external op's from opening a new scope
  ACPICA: Disassembler: add external op to namespace on first pass
  ACPICA: Disassembler: allow conflicting external declarations to be
    emitted.

Janosch Hildebrand (1):
  ACPICA: Tables: Fix defined values for MADT PCAT_COMPAT flag

Lv Zheng (6):
  ACPICA: Tables: Add WSMT support
  ACPICA: Tables: Add HMAT table definitions
  ACPICA: Tables: Add PPTT table definitions
  ACPICA: OSL: Add support to exclude stdarg.h
  ACPICA: Events: Add runtime stub support for event APIs
  ACPICA: Dispatcher: Remove unnecessary call to debugger

Mika Westerberg (6):
  ACPICA: ACPI 6.2: Add support for PinFunction() resource
  ACPICA: ACPI 6.2: Add support for PinConfig() resource
  ACPICA: ACPI 6.2: Add support for PinGroup() resource
  ACPICA: ACPI 6.2: Add support for PinGroupFunction() resource
  ACPICA: ACPI 6.2: Add support for PinGroupConfig() resource
  ACPICA: Core: Always set GPIO VendorOffset

 drivers/acpi/acpica/Makefile                       |   1 +
 drivers/acpi/acpica/acapps.h                       |   4 +-
 drivers/acpi/acpica/acglobal.h                     |   3 +
 drivers/acpi/acpica/aclocal.h                      |  15 +-
 drivers/acpi/acpica/acopcode.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |  16 +
 drivers/acpi/acpica/acresrc.h                      |  15 +-
 drivers/acpi/acpica/acutils.h                      |   1 +
 drivers/acpi/acpica/amlcode.h                      |  61 ++--
 drivers/acpi/acpica/amlresrc.h                     | 104 ++++++
 drivers/acpi/acpica/dbexec.c                       |  12 +
 drivers/acpi/acpica/dbobject.c                     |   6 +-
 drivers/acpi/acpica/dbxface.c                      |   2 +-
 drivers/acpi/acpica/dsargs.c                       |   5 +-
 drivers/acpi/acpica/dsdebug.c                      |   1 +
 drivers/acpi/acpica/dsmethod.c                     |  12 +-
 drivers/acpi/acpica/dsopcode.c                     |  11 +-
 drivers/acpi/acpica/dsutils.c                      |   9 -
 drivers/acpi/acpica/dswexec.c                      |   4 +-
 drivers/acpi/acpica/dswload.c                      |  42 ++-
 drivers/acpi/acpica/dswload2.c                     |  16 +
 drivers/acpi/acpica/evxfevnt.c                     |  18 +
 drivers/acpi/acpica/exdebug.c                      |   4 +-
 drivers/acpi/acpica/exdump.c                       |  30 +-
 drivers/acpi/acpica/exoparg1.c                     |  25 +-
 drivers/acpi/acpica/exresolv.c                     |  23 +-
 drivers/acpi/acpica/nsaccess.c                     |  27 ++
 drivers/acpi/acpica/nsnames.c                      |   3 -
 drivers/acpi/acpica/nsutils.c                      |   2 +-
 drivers/acpi/acpica/nsxfeval.c                     |  39 ++-
 drivers/acpi/acpica/psobject.c                     |  14 +
 drivers/acpi/acpica/psopcode.c                     |   8 +-
 drivers/acpi/acpica/psparse.c                      |  14 +-
 drivers/acpi/acpica/rscalc.c                       | 139 ++++++++
 drivers/acpi/acpica/rsdump.c                       |  48 +++
 drivers/acpi/acpica/rsdumpinfo.c                   | 114 +++++++
 drivers/acpi/acpica/rsinfo.c                       |  28 +-
 drivers/acpi/acpica/rsmisc.c                       |   4 +-
 drivers/acpi/acpica/rsserial.c                     | 373 +++++++++++++++++++++
 drivers/acpi/acpica/tbfadt.c                       |   4 +-
 drivers/acpi/acpica/tbutils.c                      |   6 +-
 drivers/acpi/acpica/utdecode.c                     |   8 +-
 drivers/acpi/acpica/utownerid.c                    |  12 +-
 drivers/acpi/acpica/utresdecode.c                  | 315 +++++++++++++++++
 drivers/acpi/acpica/utresrc.c                      | 273 ++-------------
 drivers/acpi/acpica/utxfmutex.c                    |   5 +-
 drivers/char/tpm/tpm_crb.c                         |   4 +-
 drivers/mailbox/pcc.c                              |  10 +-
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/acrestyp.h                            |  92 ++++-
 include/acpi/actbl1.h                              | 238 ++++++++++++-
 include/acpi/actbl2.h                              |  59 +++-
 include/acpi/actbl3.h                              |  82 ++++-
 include/acpi/actypes.h                             |  67 ++--
 include/acpi/acuuid.h                              |   5 +
 include/acpi/platform/acgcc.h                      |  10 +
 include/acpi/platform/acintel.h                    |   2 +
 .../acpi/os_specific/service_layers/osunixxf.c     |  10 +-
 58 files changed, 2025 insertions(+), 434 deletions(-)
 create mode 100644 drivers/acpi/acpica/utresdecode.c

-- 
2.7.4

