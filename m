From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/30] ACPICA: 20160318 Release
Date: Thu, 24 Mar 2016 09:38:20 +0800
Message-ID: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22974 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbcCXBiY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2016 21:38:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The 20160318 ACPICA kernel-resident subsystem updates are linuxized based
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
Before applying (20160212 Release):
  506 lines
After applying (20160318 Release):
  494 lines

Al Stone (1):
  ACPICA: IORT: Add in support for the SMMUv3 subtable

Aleksey Makarov (1):
  ACPICA: Headers: Add new constants for the DBG2 ACPI table

Bob Moore (16):
  ACPICA: Headers: Minor update for SPCR ACPI table
  ACPICA: ACPI 6.1: Updates for the HEST ACPI table
  ACPICA: ACPI 6.1: Update NFIT table for additional new fields
  ACPICA: Headers: Update DMAR table for October 2014 I/O spec
  ACPICA: Tables: Update FADT handling
  ACPICA: ACPI 6.1: Add full support for this version of ACPI spec
  ACPICA: iASL/Headers: Fix incorrect definition of FPDT table
  ACPICA: Intepreter: Add object extensions to Concatenate operand
  ACPICA: Interpreter: Update some function headers, no functional
    change
  ACPICA: iASL: Cleanup/optimization for ToPLD macro support
  ACPICA: Cleanup some invocation indentations, no functional change
  ACPICA: Headers: Update generation of the ACPICA library
  ACPICA: Utilities: Update for strtoul64 merger
  ACPICA: All: const keyword changes across the ACPICA source
  ACPICA: iASL/Disassembler: Improve handling of unresolved methods
  ACPICA: Update version to 20160318

Lv Zheng (11):
  ACPICA: Linuxize: reduce divergences for 20160212 release
  ACPICA: Linuxize: Remove useless platform headers
  ACPICA: Utilities: Add ACPI_IS_POWER_OF_TWO()
  Utilities: Fix missing parentheses in ACPI_GET_BITS()/ACPI_SET_BITS()
  ACPICA: Hardware: Enhance acpi_hw_validate_register() with
    access_width/bit_offset awareness
  ACPICA: Hardware: Add access_width/bit_offset support in
    acpi_hw_read()
  ACPICA: Hardware: Add access_width/bit_offset support for
    acpi_hw_write()
  ACPICA: Interpreter: Fix wrong conditions for
    acpi_ev_install_region_handlers() invocation
  ACPICA: Tables: Fix wrong MLC condition for dynamic table loading
  ACPICA: Events: Fix an issue that _REG association can happen before
    namespace is initialized
  ACPICA: Namespace: Reorder \_SB._INI to make sure it is evaluated
    before _REG evaluations

Will Miles (1):
  ACPICA: Add support for QNX 6.6 platform

 drivers/acpi/acpica/Makefile                       |    1 +
 drivers/acpi/acpica/acdebug.h                      |    4 +-
 drivers/acpi/acpica/acevents.h                     |    2 -
 drivers/acpi/acpica/acglobal.h                     |   11 +
 drivers/acpi/acpica/acinterp.h                     |    2 +-
 drivers/acpi/acpica/aclocal.h                      |    1 +
 drivers/acpi/acpica/acmacros.h                     |    8 +-
 drivers/acpi/acpica/acnamesp.h                     |    5 +-
 drivers/acpi/acpica/acparser.h                     |    2 +-
 drivers/acpi/acpica/acpredef.h                     |    9 +
 drivers/acpi/acpica/acresrc.h                      |    4 +-
 drivers/acpi/acpica/acstruct.h                     |    2 +-
 drivers/acpi/acpica/acutils.h                      |   23 +-
 drivers/acpi/acpica/dbconvert.c                    |    4 +-
 drivers/acpi/acpica/dbinput.c                      |   13 +-
 drivers/acpi/acpica/dbutils.c                      |    9 +-
 drivers/acpi/acpica/evregion.c                     |   74 ++--
 drivers/acpi/acpica/evrgnini.c                     |    1 -
 drivers/acpi/acpica/exconcat.c                     |  439 ++++++++++++++++++++
 drivers/acpi/acpica/exconfig.c                     |    4 +-
 drivers/acpi/acpica/exconvrt.c                     |    4 +-
 drivers/acpi/acpica/exdump.c                       |   15 +-
 drivers/acpi/acpica/exmisc.c                       |  290 -------------
 drivers/acpi/acpica/exutils.c                      |   12 +-
 drivers/acpi/acpica/hwregs.c                       |  217 ++++++++--
 drivers/acpi/acpica/hwxface.c                      |    4 +-
 drivers/acpi/acpica/nsaccess.c                     |    7 +-
 drivers/acpi/acpica/nsconvert.c                    |    3 +-
 drivers/acpi/acpica/nsdump.c                       |    9 +-
 drivers/acpi/acpica/nsinit.c                       |   76 +++-
 drivers/acpi/acpica/nsload.c                       |    2 +-
 drivers/acpi/acpica/nsprepkg.c                     |    6 +
 drivers/acpi/acpica/psopinfo.c                     |    2 +-
 drivers/acpi/acpica/rsdump.c                       |   50 +--
 drivers/acpi/acpica/rsutils.c                      |    2 +-
 drivers/acpi/acpica/tbfadt.c                       |   26 +-
 drivers/acpi/acpica/tbxfload.c                     |    2 +-
 drivers/acpi/acpica/utdebug.c                      |   47 +--
 drivers/acpi/acpica/utdecode.c                     |   30 +-
 drivers/acpi/acpica/uteval.c                       |    4 +-
 drivers/acpi/acpica/utglobal.c                     |   48 +++
 drivers/acpi/acpica/utmisc.c                       |    2 +-
 drivers/acpi/acpica/utnonansi.c                    |   67 +--
 drivers/acpi/acpica/utprint.c                      |    5 -
 drivers/acpi/acpica/uttrack.c                      |    2 +-
 drivers/acpi/osl.c                                 |    2 +-
 include/acpi/acpiosxf.h                            |    2 +-
 include/acpi/acpixf.h                              |    2 +-
 include/acpi/actbl.h                               |    4 +-
 include/acpi/actbl1.h                              |   74 +++-
 include/acpi/actbl2.h                              |   39 +-
 include/acpi/actbl3.h                              |   43 +-
 include/acpi/actypes.h                             |    7 +-
 include/acpi/platform/acenv.h                      |   44 +-
 include/acpi/platform/acmsvcex.h                   |   54 ---
 include/acpi/platform/acwinex.h                    |   49 ---
 .../acpi/os_specific/service_layers/osunixmap.c    |    2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |    3 +-
 tools/power/acpi/tools/acpidump/apmain.c           |    3 +-
 59 files changed, 1142 insertions(+), 736 deletions(-)
 create mode 100644 drivers/acpi/acpica/exconcat.c
 delete mode 100644 include/acpi/platform/acmsvcex.h
 delete mode 100644 include/acpi/platform/acwinex.h

-- 
1.7.10

