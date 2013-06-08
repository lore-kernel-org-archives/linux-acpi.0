From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/16] ACPICA: 20130517 release
Date: Sat,  8 Jun 2013 08:57:36 +0800
Message-ID: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36786 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab3FHA56 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 20:57:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The 20130517 ACPICA kernel resident system updates is linuxized based on
the pm/linux-next branch.
The patch set has passed a build/boot test on the following machines:
Dell Inspiron Mini 1010 (i386)
HP Compaq 8200 Elite SFF PC (x86-64)
With the following kernel configuration items enabled:
  CONFIG_ACPI_AC
  CONFIG_ACPI_BATTERY
  CONFIG_ACPI_NUMA
  CONFIG_ACPI_PROCESSOR
  CONFIG_ACPI_THERMAL
  CONFIG_ACPI_VIDEO
  CONFIG_CPU_FREQ
  CONFIG_I2C_SCMI
  CONFIG_SENSORS_ACPI_POWER
  CONFIG_PANASONIC_LAPTOP
  CONFIG_XO15_EBOOK
No new divergences are introduced in this release.
Please review.

Bob Moore (7):
  ACPICA: Split buffer dump routines into separate file
  ACPICA: Split internal error msg routines to a separate file
  ACPICA: Split table print utilities to a new a separate file
  ACPICA: New: Portable acpidump utility (get system ACPI tables)
  ACPICA: Update interface to AcpiUtValidAcpiName
  ACPICA: Support Mac OS X in Makefile
  ACPICA: Update version to 20130517

Chao Guan (1):
  ACPICA: Standardize all switch() blocks

Lv Zheng (5):
  ACPICA: Add option to disable loading of SSDTs from the RSDT/XSDT
  ACPICA: Do not use extended sleep registers unless HW-reduced bit is
    set
  ACPICA: Move _PRT repair into the standard complex repair module
  ACPICA: Add several repairs for _CST predefined name
  ACPICA: _CST repair: Handle null package entries

Tomasz Nowicki (3):
  ACPICA: ACPICA Termination: Delete global lock pending lock
  ACPICA: Fix possible memory leak in GPE init error path
  ACPICA: Clear events initialized flag upon event component
    termination

 drivers/acpi/acpica/Makefile    |    3 +
 drivers/acpi/acpica/acglobal.h  |    6 +
 drivers/acpi/acpica/acutils.h   |   44 +++++-
 drivers/acpi/acpica/dscontrol.c |    4 +-
 drivers/acpi/acpica/dsfield.c   |    4 +
 drivers/acpi/acpica/dsinit.c    |    1 +
 drivers/acpi/acpica/dsmthdat.c  |    2 +-
 drivers/acpi/acpica/dsobject.c  |    3 +-
 drivers/acpi/acpica/dsopcode.c  |    1 +
 drivers/acpi/acpica/dsutils.c   |    5 +-
 drivers/acpi/acpica/dswexec.c   |    3 +-
 drivers/acpi/acpica/dswload.c   |    7 +-
 drivers/acpi/acpica/dswload2.c  |    4 +
 drivers/acpi/acpica/evglock.c   |    1 +
 drivers/acpi/acpica/evgpe.c     |    6 +-
 drivers/acpi/acpica/evgpeblk.c  |    2 +
 drivers/acpi/acpica/evgpeinit.c |    3 +
 drivers/acpi/acpica/evhandler.c |    7 +
 drivers/acpi/acpica/evmisc.c    |    3 +
 drivers/acpi/acpica/evrgnini.c  |    2 +
 drivers/acpi/acpica/evxfgpe.c   |    3 +
 drivers/acpi/acpica/evxfregn.c  |    1 +
 drivers/acpi/acpica/exconfig.c  |    1 +
 drivers/acpi/acpica/exconvrt.c  |   13 +-
 drivers/acpi/acpica/excreate.c  |    3 -
 drivers/acpi/acpica/exdebug.c   |    2 +
 drivers/acpi/acpica/exdump.c    |    2 +
 drivers/acpi/acpica/exfield.c   |    4 +
 drivers/acpi/acpica/exfldio.c   |    2 -
 drivers/acpi/acpica/exmisc.c    |   12 +-
 drivers/acpi/acpica/exoparg1.c  |   16 +--
 drivers/acpi/acpica/exoparg2.c  |    1 -
 drivers/acpi/acpica/exoparg3.c  |    1 -
 drivers/acpi/acpica/exoparg6.c  |    5 -
 drivers/acpi/acpica/exprep.c    |    7 +
 drivers/acpi/acpica/exregion.c  |   27 +++-
 drivers/acpi/acpica/exresnte.c  |    1 +
 drivers/acpi/acpica/exresolv.c  |    6 +-
 drivers/acpi/acpica/exresop.c   |    9 +-
 drivers/acpi/acpica/exstore.c   |    4 +-
 drivers/acpi/acpica/exstoren.c  |    4 -
 drivers/acpi/acpica/hwacpi.c    |    2 +-
 drivers/acpi/acpica/hwgpe.c     |    3 +
 drivers/acpi/acpica/hwregs.c    |    4 +-
 drivers/acpi/acpica/hwxface.c   |    3 +
 drivers/acpi/acpica/hwxfsleep.c |   12 +-
 drivers/acpi/acpica/nsaccess.c  |    1 +
 drivers/acpi/acpica/nsconvert.c |    3 +
 drivers/acpi/acpica/nsdump.c    |   10 ++
 drivers/acpi/acpica/nsinit.c    |    9 ++
 drivers/acpi/acpica/nspredef.c  |   14 +-
 drivers/acpi/acpica/nsprepkg.c  |    5 -
 drivers/acpi/acpica/nsrepair.c  |    1 +
 drivers/acpi/acpica/nsrepair2.c |  283 +++++++++++++++++++++++++++++++++-----
 drivers/acpi/acpica/nsutils.c   |    3 +
 drivers/acpi/acpica/nsxfeval.c  |    1 +
 drivers/acpi/acpica/psargs.c    |    4 +
 drivers/acpi/acpica/psloop.c    |    2 +-
 drivers/acpi/acpica/psobject.c  |    1 +
 drivers/acpi/acpica/psparse.c   |    3 +-
 drivers/acpi/acpica/pstree.c    |    2 +
 drivers/acpi/acpica/rscalc.c    |    7 +-
 drivers/acpi/acpica/rscreate.c  |   27 ----
 drivers/acpi/acpica/rsdump.c    |   10 ++
 drivers/acpi/acpica/rsmisc.c    |    3 +-
 drivers/acpi/acpica/rsutils.c   |    5 +
 drivers/acpi/acpica/rsxface.c   |    1 +
 drivers/acpi/acpica/tbinstal.c  |    7 +-
 drivers/acpi/acpica/tbprint.c   |  237 ++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/tbutils.c   |  191 +-------------------------
 drivers/acpi/acpica/tbxfload.c  |   25 ++--
 drivers/acpi/acpica/utbuffer.c  |  201 +++++++++++++++++++++++++++
 drivers/acpi/acpica/utcopy.c    |   11 +-
 drivers/acpi/acpica/utdebug.c   |  148 +-------------------
 drivers/acpi/acpica/utdelete.c  |    3 +-
 drivers/acpi/acpica/uterror.c   |  289 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/uteval.c    |    7 +-
 drivers/acpi/acpica/utexcep.c   |    1 +
 drivers/acpi/acpica/utids.c     |    3 +
 drivers/acpi/acpica/utmisc.c    |    2 +
 drivers/acpi/acpica/utobject.c  |    5 +-
 drivers/acpi/acpica/utstring.c  |   19 ++-
 drivers/acpi/acpica/uttrack.c   |    8 ++
 drivers/acpi/acpica/utxferror.c |  277 -------------------------------------
 drivers/acpi/osl.c              |   11 ++
 include/acpi/acpiosxf.h         |   18 +++
 include/acpi/acpixf.h           |    3 +-
 include/acpi/actypes.h          |    8 ++
 include/acpi/platform/acenv.h   |    8 +-
 89 files changed, 1353 insertions(+), 783 deletions(-)
 create mode 100644 drivers/acpi/acpica/tbprint.c
 create mode 100644 drivers/acpi/acpica/utbuffer.c
 create mode 100644 drivers/acpi/acpica/uterror.c

-- 
1.7.10

