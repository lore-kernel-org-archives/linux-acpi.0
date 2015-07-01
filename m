From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 00/26] ACPICA: 20150619 Release
Date: Wed,  1 Jul 2015 14:42:39 +0800
Message-ID: <cover.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28313 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbbGAGmv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 02:42:51 -0400
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The 20150619 ACPICA kernel-resident subsystem updates are linuxized based
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
Before applying (20150515 Release):
  565 lines
After applying (20150619 Release):
  539 lines

Bob Moore (8):
  ACPICA: Namespace: Add support of OSDT table.
  ACPICA: Namespace: Change namespace override to avoid node deletion.
  ACPICA: Cleanup output for the ASL Debug object.
  ACPICA: De-macroize calls to standard C library functions.
  ACPICA: Split C library prototypes to new header.
  ACPICA: Update definitions for the TCPA and TPM2 ACPI tables.
  ACPICA: Update TPM2 ACPI table.
  ACPICA: Update version to 20150619.

Hanjun Guo (1):
  ACPICA: ACPI 6.0: Add values for MADT GIC version field.

Lv Zheng (13):
  ACPICA: Linuxize: Reduce divergences for 20150619 release.
  ACPICA: Linuxize: Replace __FUNCTION__ with __func__.
  ACPICA: Hardware: Enable 64-bit firmware waking vector for selected
    FACS.
  ACPICA: Tables: Enable both 32-bit and 64-bit FACS.
  ACPICA: Hardware: Enable firmware waking vector for both 32-bit and
    64-bit FACS.
  ACPICA: Tables: Fix an issue that FACS initialization is performed
    twice.
  ACPICA: Tables: Enable default 64-bit FADT addresses favor.
  ACPICA: MSVC6: Fix build issue for variable argument macros.
  ACPICA: EFI: Add EFI interface definitions to eliminate dependency of
    GNU EFI.
  ACPICA: Namespace: Add support to allow overriding objects.
  ACPICA: acpidump: Allow customized tables to be dumped without
    accessing /dev/mem.
  ACPICA: acpidump: Convert the default behavior to dump from
    /sys/firmware/acpi/tables.
  ACPI / acpidump: Update acpidump manual.

Sascha Wildner (1):
  ACPICA: Add dragon_fly support to unix file mapping file.

Suravee Suthikulpanit (1):
  ACPICA: Utilities: Add _CLS processing

Zhang Rui (1):
  ACPICA: Update for acpi_install_table memory types.

gongzg (1):
  ACPICA: Comment update, no functional change.

 drivers/acpi/acpica/accommon.h                     |    3 +
 drivers/acpi/acpica/acglobal.h                     |    2 +
 drivers/acpi/acpica/acinterp.h                     |    2 +
 drivers/acpi/acpica/aclocal.h                      |    1 +
 drivers/acpi/acpica/acnamesp.h                     |    1 +
 drivers/acpi/acpica/acobject.h                     |    1 +
 drivers/acpi/acpica/acstruct.h                     |    1 +
 drivers/acpi/acpica/acutils.h                      |   64 +---------
 drivers/acpi/acpica/dsfield.c                      |    2 +-
 drivers/acpi/acpica/dsinit.c                       |    2 +-
 drivers/acpi/acpica/dsobject.c                     |    7 +-
 drivers/acpi/acpica/dsutils.c                      |    4 +-
 drivers/acpi/acpica/dswload.c                      |   17 ++-
 drivers/acpi/acpica/evgpeinit.c                    |    2 +-
 drivers/acpi/acpica/exconfig.c                     |    2 +-
 drivers/acpi/acpica/exconvrt.c                     |    9 +-
 drivers/acpi/acpica/exdebug.c                      |   42 ++++++-
 drivers/acpi/acpica/exdump.c                       |    9 +-
 drivers/acpi/acpica/exfield.c                      |    2 +-
 drivers/acpi/acpica/exfldio.c                      |   52 ++++----
 drivers/acpi/acpica/exmisc.c                       |   36 +++---
 drivers/acpi/acpica/exnames.c                      |    2 +-
 drivers/acpi/acpica/exoparg2.c                     |    8 +-
 drivers/acpi/acpica/exoparg3.c                     |    4 +-
 drivers/acpi/acpica/exregion.c                     |    9 +-
 drivers/acpi/acpica/exstorob.c                     |   18 +--
 drivers/acpi/acpica/exutils.c                      |   32 +++++
 drivers/acpi/acpica/hwxfsleep.c                    |  126 ++++++++++++++++----
 drivers/acpi/acpica/nsaccess.c                     |   16 ++-
 drivers/acpi/acpica/nsconvert.c                    |   10 +-
 drivers/acpi/acpica/nsdump.c                       |    2 +-
 drivers/acpi/acpica/nseval.c                       |    7 +-
 drivers/acpi/acpica/nsinit.c                       |    4 +-
 drivers/acpi/acpica/nsparse.c                      |    7 ++
 drivers/acpi/acpica/nsrepair2.c                    |    2 +-
 drivers/acpi/acpica/nssearch.c                     |   37 +++++-
 drivers/acpi/acpica/nsutils.c                      |    3 +-
 drivers/acpi/acpica/nsxfeval.c                     |    5 +-
 drivers/acpi/acpica/nsxfname.c                     |   29 ++++-
 drivers/acpi/acpica/psutils.c                      |    7 +-
 drivers/acpi/acpica/rscreate.c                     |    6 +-
 drivers/acpi/acpica/rsmisc.c                       |    8 +-
 drivers/acpi/acpica/rsutils.c                      |   13 +-
 drivers/acpi/acpica/rsxface.c                      |    8 +-
 drivers/acpi/acpica/tbdata.c                       |    8 +-
 drivers/acpi/acpica/tbfadt.c                       |   27 +++--
 drivers/acpi/acpica/tbfind.c                       |   21 ++--
 drivers/acpi/acpica/tbinstal.c                     |    7 +-
 drivers/acpi/acpica/tbprint.c                      |   10 +-
 drivers/acpi/acpica/tbutils.c                      |   37 ++++--
 drivers/acpi/acpica/tbxface.c                      |   17 +--
 drivers/acpi/acpica/tbxfload.c                     |   17 ++-
 drivers/acpi/acpica/utalloc.c                      |    6 +-
 drivers/acpi/acpica/utbuffer.c                     |    4 +-
 drivers/acpi/acpica/utcache.c                      |    6 +-
 drivers/acpi/acpica/utcopy.c                       |   42 +++----
 drivers/acpi/acpica/utdebug.c                      |    4 +-
 drivers/acpi/acpica/utids.c                        |  100 +++++++++++++++-
 drivers/acpi/acpica/utmisc.c                       |    9 +-
 drivers/acpi/acpica/utosi.c                        |    9 +-
 drivers/acpi/acpica/utpredef.c                     |    4 +-
 drivers/acpi/acpica/utprint.c                      |    6 +-
 drivers/acpi/acpica/utstring.c                     |   33 +++--
 drivers/acpi/acpica/uttrack.c                      |    8 +-
 drivers/acpi/acpica/utxface.c                      |    8 +-
 drivers/acpi/acpica/utxfinit.c                     |   10 +-
 include/acpi/acnames.h                             |    1 +
 include/acpi/acoutput.h                            |   13 +-
 include/acpi/acpixf.h                              |   28 ++++-
 include/acpi/actbl.h                               |    1 +
 include/acpi/actbl1.h                              |   11 ++
 include/acpi/actbl2.h                              |   80 +++++++++++--
 include/acpi/actbl3.h                              |   34 +-----
 include/acpi/actypes.h                             |   33 +++--
 include/acpi/platform/acenv.h                      |   39 ------
 include/acpi/platform/acenvex.h                    |    6 +
 include/acpi/platform/acgcc.h                      |    4 +
 tools/power/acpi/common/getopt.c                   |    4 +-
 tools/power/acpi/man/acpidump.8                    |   17 ++-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   95 ++++++++-------
 .../acpi/os_specific/service_layers/osunixmap.c    |    2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |    2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |    8 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   12 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   15 ++-
 85 files changed, 893 insertions(+), 529 deletions(-)

-- 
1.7.10

