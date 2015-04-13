From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/31] ACPICA: 20150410 Release
Date: Mon, 13 Apr 2015 11:48:05 +0800
Message-ID: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The 20150410 ACPICA kernel-resident subsystem updates are linuxized based
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
   All drivers/acpi configurations
   All platform drivers

The divergences checking result:
Before applying (20150204 Release):
  517 lines
After applying (20150410 Release):
  531 lines

Bob Moore (15):
  ACPICA: Casting changes around acpi_physical_address/acpi_size.
  ACPICA: Fix a sscanf format string.
  ACPICA: Update Resource descriptor dump module.
  ACPICA: Update AML Debugger global variables.
  ACPICA: iASL/Disassembler: Add option to assume table contains valid
    AML.
  ACPICA: iASL: Enhancement for constant folding.
  ACPICA: Add infrastructure for External() opcode.
  ACPICA: Add "Windows 2015" string to _OSI support.
  ACPICA: Permanently set _REV to the value '2'.
  ACPICA: Remove unused internal AML opcode.
  ACPICA: Add "//" before ascii output of buffers.
  ACPICA: Update for SLIC ACPI table.
  ACPICA: iASL: Add support for MSDM ACPI table.
  ACPICA: Disassembler: Some cleanup of the table dump module.
  ACPICA: Update version to 20150410.

Lv Zheng (13):
  ACPICA: Linuxize: Reduce divergences for 20150410 release.
  ACPICA: Tables: Change acpi_find_root_pointer() to use
    acpi_physical_address.
  ACPICA: Unix: Cleanup to use ACPI_TO_INTEGER() to calc page offset.
  ACPICA: Executer: Cleanup to remove an unnecessary conversion.
  ACPICA: Utilities: Cleanup to enforce
    ACPI_PHYSADDR_TO_PTR()/ACPI_PTR_TO_PHYSADDR().
  ACPICA: Utilities: Cleanup to convert physical address printing
    formats.
  ACPICA: Utilities: Cleanup to remove useless ACPI_PRINTF/FORMAT_xxx
    helpers.
  ACPICA: Utilities: split IO address types from data type models.
  ACPICA: Events: Add support to return both enable/status register
    values for GPE and fixed event.
  ACPICA: Tables: Move an iasl specific table function to iasl source
    file.
  ACPICA: Utilities: Correct conditional compilation definitions.
  ACPICA: Resources: Correct conditional compilation definitions.
  ACPICA: Fix a couple issues with the local printf module.

Octavian Purdila (1):
  ACPICA: Tables: Don't release ACPI_MTX_TABLES in
    acpi_tb_install_standard_table().

Rasmus Villemoes (1):
  ACPICA: Applications: Remove use of __DATE__ macro.

Rickard Strandqvist (1):
  ACPICA: Utilities: Remove unused acpi_ut_create_pkg_state_and_push().

 drivers/acpi/acpica/acapps.h                       |    8 +-
 drivers/acpi/acpica/acglobal.h                     |    5 +-
 drivers/acpi/acpica/aclocal.h                      |    2 +-
 drivers/acpi/acpica/acmacros.h                     |   13 +-
 drivers/acpi/acpica/acopcode.h                     |    2 +
 drivers/acpi/acpica/acresrc.h                      |    6 +-
 drivers/acpi/acpica/acstruct.h                     |    5 -
 drivers/acpi/acpica/actables.h                     |    9 +-
 drivers/acpi/acpica/acutils.h                      |   22 +-
 drivers/acpi/acpica/amlcode.h                      |    2 +-
 drivers/acpi/acpica/dsopcode.c                     |    7 +-
 drivers/acpi/acpica/dsutils.c                      |   11 +
 drivers/acpi/acpica/evregion.c                     |    2 +-
 drivers/acpi/acpica/evxfevnt.c                     |    5 +-
 drivers/acpi/acpica/exdump.c                       |    4 +-
 drivers/acpi/acpica/exfldio.c                      |   10 +-
 drivers/acpi/acpica/exoparg3.c                     |   13 +-
 drivers/acpi/acpica/exregion.c                     |   17 +-
 drivers/acpi/acpica/hwgpe.c                        |   13 +-
 drivers/acpi/acpica/hwvalid.c                      |   16 +-
 drivers/acpi/acpica/nsdump.c                       |   12 +-
 drivers/acpi/acpica/psopcode.c                     |    8 +-
 drivers/acpi/acpica/psopinfo.c                     |    2 +-
 drivers/acpi/acpica/rsdump.c                       |  227 ++++++++++----------
 drivers/acpi/acpica/tbdata.c                       |   35 ++-
 drivers/acpi/acpica/tbinstal.c                     |   67 ++----
 drivers/acpi/acpica/tbprint.c                      |   19 +-
 drivers/acpi/acpica/tbxfroot.c                     |    7 +-
 drivers/acpi/acpica/utaddress.c                    |   34 ++-
 drivers/acpi/acpica/utbuffer.c                     |    8 +
 drivers/acpi/acpica/utglobal.c                     |   13 +-
 drivers/acpi/acpica/utmisc.c                       |    2 +
 drivers/acpi/acpica/utosi.c                        |    1 +
 drivers/acpi/acpica/utprint.c                      |   13 +-
 drivers/acpi/acpica/utstate.c                      |   34 ---
 drivers/acpi/acpica/utuuid.c                       |    2 +
 include/acpi/acpixf.h                              |   14 +-
 include/acpi/actbl2.h                              |   70 ++----
 include/acpi/actypes.h                             |   46 +++-
 include/acpi/platform/acenv.h                      |    1 +
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |    2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |    2 +-
 42 files changed, 384 insertions(+), 407 deletions(-)

-- 
1.7.10
