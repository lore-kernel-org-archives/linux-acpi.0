From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/20] ACPICA: 20150818 Release
Date: Tue, 25 Aug 2015 10:28:18 +0800
Message-ID: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55006 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbbHYC2Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Aug 2015 22:28:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The 20150818 ACPICA kernel-resident subsystem updates are linuxized based
on the linux-pm/linux-next branch.

The patchset has passed the following build/boot tests.
Build tests are performed as follows:
1. i386 + default + COFNIG_ACPI=y
2. i386 + allyes + CONFIG_ACPI=y
3. i386 + default + COFNIG_ACPI=n
4. i386 + allyes + CONFIG_ACPI=n
5. x86_64 + default + COFNIG_ACPI=y
6. x86_64 + allyes + CONFIG_ACPI=y
7. x86_64 + default + COFNIG_ACPI=n
8. x86_64 + allyes + CONFIG_ACPI=n
Boot tests are performed as follows:
1. i386 + default + COFNIG_ACPI=y
2. x86_64 + default + COFNIG_ACPI=y
Where:
1. i386: machine named as "Dell Inspiron Mini 1010"
2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
3. default: kernel configuration with following items enabled:
   All hardware drivers related to the machines of i386/x86_64
   All "drivers/acpi" configurations
   All "drivers/platform" drivers
   All other drivers that link the APIs provided by ACPICA subsystem

The divergences checking result:
Before applying (20150717 Release):
  518 lines
After applying (20150818 Release):
  517 lines

Bob Moore (14):
  ACPICA: Correctly cleanup after a ACPI table load failure.
  ACPICA: Disassembler: Remove duplicate code in _PLD processing.
  ACPICA: Update parameter validation for data_table_region and
    load_table.
  ACPICA: Disassembler: Update for new listing mode.
  ACPICA: Update info messages during ACPICA init.
  ACPICA: Headers: Fix some comments, no functional change.
  ACPICA: acpinames: Add new options and wildcard support.
  ACPICA: acpiexec/acpinames: Support very large number of ACPI tables.
  ACPICA: Table handling: Cleanup and update debug output for tools.
  ACPICA: Add additional debug info/statements.
  ACPICA: Debugger: Add option to display namespace summary/counts.
  ACPICA: Make the max-number-of-loops runtime configurable.
  ACPICA: Header support to improve compatibility with MSVC.
  ACPICA: Update version to 20150818.

Lv Zheng (6):
  ACPICA: Tables: Fix global table list issues by removing fixed table
    indexes.
  ACPICA: Tables: Cleanup to reduce FACS globals.
  ACPICA: Debugger: Split debugger initialization/termination APIs.
  ACPICA: Disassembler: Cleanup acpi_gbl_db_opt_disasm.
  ACPICA: Disassembler: Cleanup acpi_gbl_db_opt_verbose acpiexec usage.
  ACPICA: Debugger: Cleanup debugging outputs to dump name path without
    trailing underscores.

 drivers/acpi/acpica/acdebug.h   |    7 ---
 drivers/acpi/acpica/acglobal.h  |   19 +++++---
 drivers/acpi/acpica/aclocal.h   |   17 +++++--
 drivers/acpi/acpica/actables.h  |   14 ++++--
 drivers/acpi/acpica/acutils.h   |    2 +-
 drivers/acpi/acpica/dscontrol.c |    2 +-
 drivers/acpi/acpica/dsdebug.c   |    2 +-
 drivers/acpi/acpica/dsinit.c    |   20 ++++++---
 drivers/acpi/acpica/dsopcode.c  |   31 ++++++++-----
 drivers/acpi/acpica/evregion.c  |   22 +++++++--
 drivers/acpi/acpica/exconfig.c  |    8 ----
 drivers/acpi/acpica/exdump.c    |    2 +-
 drivers/acpi/acpica/exresnte.c  |    2 +-
 drivers/acpi/acpica/exresolv.c  |   16 ++++---
 drivers/acpi/acpica/hwxfsleep.c |   15 +------
 drivers/acpi/acpica/nseval.c    |    4 +-
 drivers/acpi/acpica/nsload.c    |   16 ++++++-
 drivers/acpi/acpica/nsutils.c   |   19 +++++++-
 drivers/acpi/acpica/psloop.c    |   14 +++++-
 drivers/acpi/acpica/tbfadt.c    |    6 +--
 drivers/acpi/acpica/tbfind.c    |   15 ++++++-
 drivers/acpi/acpica/tbinstal.c  |   40 +++++++++--------
 drivers/acpi/acpica/tbutils.c   |   73 ++++++++++++++++++++----------
 drivers/acpi/acpica/tbxfload.c  |   93 +++++++++++++++++++++++++--------------
 drivers/acpi/acpica/utfileio.c  |    2 +-
 drivers/acpi/acpica/utinit.c    |    1 +
 drivers/acpi/acpica/utmisc.c    |    4 +-
 drivers/acpi/acpica/utxface.c   |   12 ++---
 drivers/acpi/acpica/utxfinit.c  |   11 -----
 include/acpi/acbuffer.h         |    1 +
 include/acpi/acconfig.h         |    4 --
 include/acpi/acexcep.h          |    7 ++-
 include/acpi/acpixf.h           |    5 ++-
 include/acpi/actypes.h          |    2 +
 include/acpi/platform/acenv.h   |   19 ++++----
 35 files changed, 330 insertions(+), 197 deletions(-)

-- 
1.7.10

