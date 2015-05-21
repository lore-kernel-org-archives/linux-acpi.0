From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/19] ACPICA: 20150515 Release
Date: Thu, 21 May 2015 10:29:57 +0800
Message-ID: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The 20150515 ACPICA kernel-resident subsystem updates are linuxized based
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
Before applying (20150410 Release):
  531 lines
After applying (20150515 Release):
  565 lines
(Increased due to _REV reversion).

Bob Moore (14):
  ACPICA: Additional dragon_fly BSD support.
  ACPICA: ACPI 6.0: Add support for STAO table.
  ACPICA: ACPI 6.0: Add support for new predefined names.
  ACPICA: ACPI 6.0: Add support for XENV table.
  ACPICA: Parser: Move a couple externals to the proper header.
  ACPICA: iASL: Enhance detection of non-ascii or corrupted input
    files.
  ACPICA: ACPI 6.0: Add support for WPBT table.
  ACPICA: ACPI 6.0: Add changes for FADT table.
  ACPICA: ACPI 6.0: Add changes for LPIT table.
  ACPICA: ACPI 6.0: Add changes for MADT table.
  ACPICA: iASL/disassembler - fix possible fault for -e option.
  ACPICA: acpi_help: Add option to display all known/supported ACPI
    tables.
  ACPICA: ACPI 6.0: Add support for NFIT table.
  ACPICA: Update version to 20150515.

Lv Zheng (5):
  ACPICA: Dispatcher: Fix a resource leak issue in
    acpi_ds_auto_serialize_method().
  ACPICA: Hardware: Fix a resource leak issue in
    acpi_hw_build_pci_list().
  ACPICA: ACPI 6.0: Add ACPI_SUB_PTR().
  ACPICA: ACPI 6.0: Add support for IORT table.
  ACPICA: ACPI 6.0: Add changes for DRTM table.

 drivers/acpi/acpica/acdebug.h   |    4 +-
 drivers/acpi/acpica/aclocal.h   |   15 ++++
 drivers/acpi/acpica/acparser.h  |    3 +
 drivers/acpi/acpica/acpredef.h  |   45 +++++++++-
 drivers/acpi/acpica/acutils.h   |    2 +-
 drivers/acpi/acpica/dsmethod.c  |    5 +-
 drivers/acpi/acpica/hwpci.c     |    9 +-
 drivers/acpi/acpica/nsprepkg.c  |   13 +++
 drivers/acpi/acpica/nsrepair.c  |    2 +-
 drivers/acpi/acpica/psopinfo.c  |    3 -
 drivers/acpi/acpica/utfileio.c  |    9 +-
 drivers/acpi/acpica/uthex.c     |    4 +-
 drivers/acpi/acpica/utxferror.c |   11 ++-
 include/acpi/acpixf.h           |    2 +-
 include/acpi/actbl.h            |   17 ++--
 include/acpi/actbl1.h           |  176 ++++++++++++++++++++++++++++++++++++++-
 include/acpi/actbl2.h           |  146 ++++++++++++++++++++++++++++----
 include/acpi/actbl3.h           |   88 ++++++++++++++++++--
 include/acpi/actypes.h          |    1 +
 include/acpi/acuuid.h           |   64 ++++++++++++++
 include/acpi/platform/acenv.h   |    3 +
 include/acpi/platform/acenvex.h |    3 +
 22 files changed, 560 insertions(+), 65 deletions(-)
 create mode 100644 include/acpi/acuuid.h

-- 
1.7.10
