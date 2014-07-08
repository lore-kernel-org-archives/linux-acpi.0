From: Lv Zheng <lv.zheng@intel.com>
Subject: [RE-SEND PATCH 00/25] ACPICA: 20140627 Release
Date: Tue,  8 Jul 2014 12:12:32 +0800
Message-ID: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:53281 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbaGHEMu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2014 00:12:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The previous cover letter contains a wrong message ID, this cover is
re-sent to make a thread top of the 20140627 release patches.

The 20140627 ACPICA kernel-resident subsystem updates are linuxized based
on the pm/linux-next branch to form this patchset.

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

Bob Moore (2):
  ACPICA: utprint/oslibcfs: cleanup - no functional change.
  ACPICA: Update version to 20140627.

David E. Box (3):
  ACPICA: Utilities: Fix memory leak in acpi_ut_copy_iobject_to_iobject
  ACPICA: Utilities: Validate full RSDP header
  ACPICA: Namespace: Properly null terminate objects detached from a
    namespace node

Lv Zheng (20):
  ACPICA: acpidump: Add support for ACPI 1.0 GUID in Linux
  ACPICA: Utilities: Fix an issue with non-native ACPI_IS_PRINT()
  ACPICA: Utilities: Add support to read table from files.
  ACPICA: OSL: Update environments to improve portability.
  ACPICA: Utilities: Cleanup DEFINE_ACPI_GLOBALS by moving
    acpi_ut_init_global() from utglobal.c to utinit.c.
  ACPICA: OSL: Cleanup acpi_os_printf()/acpi_os_vprintf() stubs.
  ACPICA: OSL: Add portable file IO to improve portability.
  ACPICA: Utilities: Add formatted printing APIs.
  ACPICA: Utilities: Introduce acpi_log_error() to improve portability.
  ACPICA: Application: Enhance ACPI_USAGE_xxx/ACPI_OPTION with
    acpi_os_printf() to improve portability.
  ACPICA: Common: Enhance cm_get_file_size() to improve portability.
  ACPICA: Common: Enhance acpi_getopt() to improve portability.
  ACPICA: acpidump: Add memory/string OSL usage to improve portability.
  ACPICA: acpidump: Remove exit() from generic layer to improve
    portability.
  ACPICA: acpidump: Replace file IOs with new APIs to improve
    portability.
  ACPICA: acpidump: Reduce freopen() invocations to improve
    portability.
  ACPICA: OSL: Update acpidump to reduce source code differences.
  ACPICA: Executer: Fix trivial issues in
    acpi_get_serial_access_bytes().
  ACPICA: Hardware: back port of a recursive locking fix.
  ACPICA: Tables: Merge DMAR table structure updates.

 drivers/acpi/acpica/Makefile                       |    2 +-
 drivers/acpi/acpica/acapps.h                       |    9 +-
 drivers/acpi/acpica/acdebug.h                      |    3 -
 drivers/acpi/acpica/acglobal.h                     |    8 +-
 drivers/acpi/acpica/acutils.h                      |   39 +-
 drivers/acpi/acpica/exfield.c                      |    4 +-
 drivers/acpi/acpica/hwregs.c                       |    3 +-
 drivers/acpi/acpica/nsobject.c                     |   11 +
 drivers/acpi/acpica/utbuffer.c                     |  128 ++
 drivers/acpi/acpica/utcopy.c                       |    6 +
 drivers/acpi/acpica/utdebug.c                      |   26 +
 drivers/acpi/acpica/utfileio.c                     |  332 +++++
 drivers/acpi/acpica/utglobal.c                     |  146 ---
 drivers/acpi/acpica/utinit.c                       |  145 +++
 drivers/acpi/acpica/utprint.c                      |  661 ++++++++++
 include/acpi/acpiosxf.h                            |   31 +
 include/acpi/acpixf.h                              |   22 +-
 include/acpi/actbl2.h                              |    2 +-
 include/acpi/actypes.h                             |   14 +
 include/acpi/platform/acenv.h                      |   53 +-
 tools/power/acpi/Makefile                          |    5 +
 tools/power/acpi/common/cmfsize.c                  |   20 +-
 tools/power/acpi/common/getopt.c                   |   14 +-
 .../acpi/os_specific/service_layers/oslibcfs.c     |  214 ++++
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   48 +-
 .../acpi/os_specific/service_layers/osunixxf.c     | 1311 ++++++++++++++++++++
 tools/power/acpi/tools/acpidump/acpidump.h         |    3 +-
 tools/power/acpi/tools/acpidump/apdump.c           |  108 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   92 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   96 +-
 30 files changed, 3216 insertions(+), 340 deletions(-)
 create mode 100644 drivers/acpi/acpica/utfileio.c
 create mode 100644 drivers/acpi/acpica/utprint.c
 create mode 100644 tools/power/acpi/os_specific/service_layers/oslibcfs.c
 create mode 100644 tools/power/acpi/os_specific/service_layers/osunixxf.c

-- 
1.7.10

