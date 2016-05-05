From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 00/13] ACPICA: 20160422 Release
Date: Thu,  5 May 2016 12:57:47 +0800
Message-ID: <cover.1462418912.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36105 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbcEEE5z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 May 2016 00:57:55 -0400
In-Reply-To: <cover.1462331120.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The 20160422 ACPICA kernel-resident subsystem updates are linuxized based
on the linux-pm/linux-next branch.

NOTE:
1. Indentation improvement
The [PATCH 01] is a result of an ACPICA release process fix. It requires
much of human intervention, and many linuxized patches in the developers'
local working repositories that are not upstreamed to the ACPICA will be
burnt by this commit, and may take weeks or months for the developers to
recover. So hope we can do it correctly and rapidly.

2. AcessSize/BitOffset support
ACPICA implements ACPI hardware register accesses using ACPI 1.0 style,
which contains only BLK/LEN fields. ACPI 2.0 starts to use Generic Address
Structure to define hardware registers, the ACPI 1.0 fields can be
translated into Address/BitWidth fields and ACPI 2.0 defines new
AccessSize/BitOffset fields as an extension. While the ACPICA code of the
GAS support is still Address/BitWidth aware only. This becomes one of the
significant ACPI 2.0 gaps in ACPICA.
But as we have already switched the address favor to 64-bit (aka., favor
GAS descriptors) and there is almost no regression report, enabling
AccessSize/BitOffset awareness seems to be just a theoretical issue because
there is no existing users requiring this, and enabling it might just be an
ecosystem enabling work for the future users.
So the most important thing of this improvement is to ensure regression
safer by keeping old behavior working. [PATCH 08] is thus generated for
this purpose. After ensuring this, we need this improvement to appear in
the upstream to have more users to test it so that we can learn unknown
cases from the feedback.

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
Before applying (20160318 Release):
  494 lines
After applying (20160422 Release):
  485 lines
The reduction is caused by recently merged module level improvement.

Bob Moore (7):
  ACPICA: Refactor evaluate_object to reduce nesting
  ACPICA: ACPI 6.1: Support for new PCCT subtable
  ACPICA: ACPI 6.0: Update _BIX support for new package element
  ACPICA: ACPI 6.0, tools/iasl: Add support for new resource
    descriptors
  ACPICA: Renamed some #defined flag constants for clarity
  ACPICA: Move all ASCII utilities to a common file
  ACPICA: Update version to 20160422

Lv Zheng (6):
  ACPICA: Divergence: remove unwanted spaces for typedef
  ACPICA: Utilities: Add ACPI_IS_ALIGNED() macro
  ACPICA: Hardware: Add optimized access bit width support
  ACPICA: Executer: Introduce a set of macros to handle bit width mask
    generation
  ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support in
    acpi_hw_read()
  ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support for
    acpi_hw_write()

 drivers/acpi/acpica/Makefile                       |    1 +
 drivers/acpi/acpica/acdebug.h                      |    6 +-
 drivers/acpi/acpica/acevents.h                     |    1 +
 drivers/acpi/acpica/acinterp.h                     |    2 +-
 drivers/acpi/acpica/aclocal.h                      |   61 ++---
 drivers/acpi/acpica/acmacros.h                     |   15 +-
 drivers/acpi/acpica/acpredef.h                     |    5 +-
 drivers/acpi/acpica/acresrc.h                      |    8 +-
 drivers/acpi/acpica/actables.h                     |    2 -
 drivers/acpi/acpica/acutils.h                      |   35 +--
 drivers/acpi/acpica/dbcmds.c                       |    4 +-
 drivers/acpi/acpica/dbconvert.c                    |    4 +-
 drivers/acpi/acpica/dbexec.c                       |    2 +-
 drivers/acpi/acpica/dbinput.c                      |    6 +-
 drivers/acpi/acpica/dbnames.c                      |    4 +-
 drivers/acpi/acpica/dbxface.c                      |    4 +-
 drivers/acpi/acpica/dscontrol.c                    |    4 +-
 drivers/acpi/acpica/dsinit.c                       |    2 +-
 drivers/acpi/acpica/dsmethod.c                     |    2 +-
 drivers/acpi/acpica/dsutils.c                      |    2 +-
 drivers/acpi/acpica/dswload.c                      |    4 +-
 drivers/acpi/acpica/dswload2.c                     |    4 +-
 drivers/acpi/acpica/dswstate.c                     |   10 +-
 drivers/acpi/acpica/evgpe.c                        |    4 +-
 drivers/acpi/acpica/evgpeblk.c                     |    4 +-
 drivers/acpi/acpica/evgpeutil.c                    |    4 +-
 drivers/acpi/acpica/evhandler.c                    |    2 +-
 drivers/acpi/acpica/evmisc.c                       |    3 +-
 drivers/acpi/acpica/evrgnini.c                     |    2 +-
 drivers/acpi/acpica/evxfgpe.c                      |    2 +-
 drivers/acpi/acpica/exconcat.c                     |    4 +-
 drivers/acpi/acpica/exconvrt.c                     |    4 +-
 drivers/acpi/acpica/excreate.c                     |    2 +-
 drivers/acpi/acpica/exfield.c                      |    4 +-
 drivers/acpi/acpica/exfldio.c                      |   14 +-
 drivers/acpi/acpica/exnames.c                      |    2 +-
 drivers/acpi/acpica/exoparg3.c                     |    8 +-
 drivers/acpi/acpica/exoparg6.c                     |    2 +-
 drivers/acpi/acpica/exregion.c                     |    6 +-
 drivers/acpi/acpica/exresnte.c                     |    4 +-
 drivers/acpi/acpica/exresolv.c                     |    2 +-
 drivers/acpi/acpica/exresop.c                      |    4 +-
 drivers/acpi/acpica/exstorob.c                     |    4 +-
 drivers/acpi/acpica/hwgpe.c                        |    6 +-
 drivers/acpi/acpica/hwregs.c                       |  270 ++++++++++++++++++--
 drivers/acpi/acpica/hwxface.c                      |    7 +-
 drivers/acpi/acpica/nsconvert.c                    |    6 +-
 drivers/acpi/acpica/nsnames.c                      |    2 +-
 drivers/acpi/acpica/nsobject.c                     |    4 +-
 drivers/acpi/acpica/nsprepkg.c                     |   86 +++++++
 drivers/acpi/acpica/nsrepair.c                     |    2 +-
 drivers/acpi/acpica/nsrepair2.c                    |    6 +-
 drivers/acpi/acpica/nsutils.c                      |    8 +-
 drivers/acpi/acpica/nsxfeval.c                     |  113 ++++----
 drivers/acpi/acpica/nsxfname.c                     |    6 +-
 drivers/acpi/acpica/nsxfobj.c                      |    6 +-
 drivers/acpi/acpica/psargs.c                       |    2 +-
 drivers/acpi/acpica/psparse.c                      |    4 +-
 drivers/acpi/acpica/psutils.c                      |    2 +-
 drivers/acpi/acpica/psxface.c                      |    2 +-
 drivers/acpi/acpica/rscalc.c                       |   90 +++----
 drivers/acpi/acpica/rscreate.c                     |    2 +-
 drivers/acpi/acpica/rsdumpinfo.c                   |    9 +-
 drivers/acpi/acpica/rsmisc.c                       |    2 +-
 drivers/acpi/acpica/rsserial.c                     |   21 +-
 drivers/acpi/acpica/rsutils.c                      |   12 +-
 drivers/acpi/acpica/rsxface.c                      |    6 +-
 drivers/acpi/acpica/tbdata.c                       |   15 +-
 drivers/acpi/acpica/tbfadt.c                       |    2 +-
 drivers/acpi/acpica/tbfind.c                       |    2 +-
 drivers/acpi/acpica/tbinstal.c                     |    6 +-
 drivers/acpi/acpica/tbutils.c                      |   33 +--
 drivers/acpi/acpica/tbxface.c                      |    6 +-
 drivers/acpi/acpica/tbxfroot.c                     |    8 +-
 drivers/acpi/acpica/utalloc.c                      |    5 +-
 drivers/acpi/acpica/utascii.c                      |  140 ++++++++++
 drivers/acpi/acpica/utbuffer.c                     |   24 +-
 drivers/acpi/acpica/utcache.c                      |    7 +-
 drivers/acpi/acpica/utcopy.c                       |   16 +-
 drivers/acpi/acpica/utids.c                        |    8 +-
 drivers/acpi/acpica/utmath.c                       |    4 +-
 drivers/acpi/acpica/utobject.c                     |   18 +-
 drivers/acpi/acpica/utosi.c                        |    4 +-
 drivers/acpi/acpica/utownerid.c                    |    6 +-
 drivers/acpi/acpica/utprint.c                      |   14 +-
 drivers/acpi/acpica/utstring.c                     |   71 +----
 drivers/acpi/acpica/utxface.c                      |    4 +-
 include/acpi/acpiosxf.h                            |    8 +-
 include/acpi/acpixf.h                              |   23 +-
 include/acpi/acrestyp.h                            |    1 +
 include/acpi/actbl3.h                              |   23 +-
 include/acpi/actypes.h                             |   41 +--
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   47 ++--
 .../acpi/os_specific/service_layers/osunixxf.c     |   24 +-
 tools/power/acpi/tools/acpidump/Makefile           |    1 +
 tools/power/acpi/tools/acpidump/apdump.c           |   10 +-
 96 files changed, 961 insertions(+), 553 deletions(-)
 create mode 100644 drivers/acpi/acpica/utascii.c

-- 
1.7.10

