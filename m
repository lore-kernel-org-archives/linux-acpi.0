From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/20] ACPICA: 20130927 Release
Date: Tue, 29 Oct 2013 09:28:41 +0800
Message-ID: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26169 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756789Ab3J2B3F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:29:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The 20130927 ACPICA kernel resident system updates is linuxized based on
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
  CONFIG_DMAR_TABLE
  CONFIG_INTEL_IOMMU
  CONFIG_IRQ_REMAP

Some divergences are reduced by the new software mechanisms introduced in
this release cycle.  The divergences result is as follows:
  Before applying: 68.8 Kbytes, 1984 Lines
  After applying: 54.1 Kbytes, 1558 Lines

Please review.

Bob Moore (10):
  ACPICA: Table print header function: Increase default width for table
    length.
  ACPICA: Add a check for a null node during namespace walk.
  ACPICA: Add history/line-editing for Unix/Linux systems.
  ACPICA: Fix a macro for the hardware-reduced case
  ACPICA: Add safe versions of common string functions.
  ACPICA: Predefine name macros: Sort list.
  ACPICA: Hardcode access width for the reset register.
  ACPICA: Update comment: no functional change.
  ACPICA: Simplify configuration of global ACPI_REDUCED_HARDWARE macro.
  ACPICA: Update version to 20130927.

Lv Zheng (9):
  ACPICA: Cleanup memory allocation macros and configurability.
  ACPICA: Fix possible memory leaks in the GPE handling.
  ACPICA: Add EXPORT_ACPI_INTERFACES macro to external interface
    modules.
  ACPICA: Linuxize: Change indentation of C labels.
  ACPICA: Deploy ACPI_EXPORT_SYMBOL_INIT for main ACPICA initialization
    interfaces.
  ACPICA: Prevent possible build issues for use of ACPI_PRINTF_LIKE
    macro
  ACPICA: AcpiSrc: Fix indentation issues for macro invocations.
  ACPICA: Add support to allow host to redefine individual OSL
    prototypes.
  ACPICA: Update aclinux.h for new OSL override mechanism.

Tomasz Nowicki (1):
  ACPICA: Ensure that debug output is immediately disabled on
    termination.

 drivers/acpi/acpica/acdebug.h   |    5 +-
 drivers/acpi/acpica/acevents.h  |    3 +-
 drivers/acpi/acpica/aclocal.h   |    3 +-
 drivers/acpi/acpica/acmacros.h  |   31 --------
 drivers/acpi/acpica/acutils.h   |   17 +++--
 drivers/acpi/acpica/dsargs.c    |    2 +-
 drivers/acpi/acpica/dsfield.c   |    2 +-
 drivers/acpi/acpica/dsmethod.c  |    4 +-
 drivers/acpi/acpica/dsobject.c  |    2 +-
 drivers/acpi/acpica/dsopcode.c  |    2 +-
 drivers/acpi/acpica/dsutils.c   |   10 +--
 drivers/acpi/acpica/dswexec.c   |    6 +-
 drivers/acpi/acpica/dswload2.c  |    2 +-
 drivers/acpi/acpica/evglock.c   |    2 +-
 drivers/acpi/acpica/evgpe.c     |    3 +-
 drivers/acpi/acpica/evgpeblk.c  |    6 +-
 drivers/acpi/acpica/evgpeinit.c |    2 +-
 drivers/acpi/acpica/evgpeutil.c |    2 +-
 drivers/acpi/acpica/evhandler.c |    4 +-
 drivers/acpi/acpica/evregion.c  |    6 +-
 drivers/acpi/acpica/evxface.c   |   15 ++--
 drivers/acpi/acpica/evxfevnt.c  |    3 +-
 drivers/acpi/acpica/evxfgpe.c   |    9 ++-
 drivers/acpi/acpica/evxfregn.c  |    7 +-
 drivers/acpi/acpica/excreate.c  |    8 +-
 drivers/acpi/acpica/exfield.c   |    2 +-
 drivers/acpi/acpica/exfldio.c   |    2 +-
 drivers/acpi/acpica/exmisc.c    |    4 +-
 drivers/acpi/acpica/exoparg1.c  |    8 +-
 drivers/acpi/acpica/exoparg2.c  |   10 +--
 drivers/acpi/acpica/exoparg3.c  |    4 +-
 drivers/acpi/acpica/exoparg6.c  |    2 +-
 drivers/acpi/acpica/exresolv.c  |    2 +-
 drivers/acpi/acpica/exresop.c   |    2 +-
 drivers/acpi/acpica/hwregs.c    |    2 +-
 drivers/acpi/acpica/hwtimer.c   |    3 +-
 drivers/acpi/acpica/hwxface.c   |   17 +++--
 drivers/acpi/acpica/hwxfsleep.c |    3 +-
 drivers/acpi/acpica/nsaccess.c  |    2 +-
 drivers/acpi/acpica/nsdump.c    |    9 ++-
 drivers/acpi/acpica/nseval.c    |    4 +-
 drivers/acpi/acpica/nsinit.c    |    2 +-
 drivers/acpi/acpica/nsload.c    |    2 +-
 drivers/acpi/acpica/nsparse.c   |    2 +-
 drivers/acpi/acpica/nspredef.c  |    2 +-
 drivers/acpi/acpica/nsprepkg.c  |    4 +-
 drivers/acpi/acpica/nsrepair.c  |    2 +-
 drivers/acpi/acpica/nsrepair2.c |    2 +-
 drivers/acpi/acpica/nsutils.c   |    2 +-
 drivers/acpi/acpica/nsxfeval.c  |   17 +++--
 drivers/acpi/acpica/nsxfname.c  |    7 +-
 drivers/acpi/acpica/nsxfobj.c   |    7 +-
 drivers/acpi/acpica/psparse.c   |    2 +-
 drivers/acpi/acpica/psxface.c   |    6 +-
 drivers/acpi/acpica/rsmisc.c    |    4 +-
 drivers/acpi/acpica/rsutils.c   |    2 +-
 drivers/acpi/acpica/rsxface.c   |    3 +-
 drivers/acpi/acpica/tbinstal.c  |    6 +-
 drivers/acpi/acpica/tbprint.c   |    6 +-
 drivers/acpi/acpica/tbutils.c   |    2 +-
 drivers/acpi/acpica/tbxface.c   |   14 +++-
 drivers/acpi/acpica/tbxfload.c  |    9 ++-
 drivers/acpi/acpica/utalloc.c   |  113 +++++++++-------------------
 drivers/acpi/acpica/utcache.c   |    2 +-
 drivers/acpi/acpica/utcopy.c    |    4 +-
 drivers/acpi/acpica/utdebug.c   |    3 +-
 drivers/acpi/acpica/utdecode.c  |    1 -
 drivers/acpi/acpica/utdelete.c  |    2 +-
 drivers/acpi/acpica/uteval.c    |    2 +-
 drivers/acpi/acpica/utexcep.c   |    3 +-
 drivers/acpi/acpica/utglobal.c  |    5 +-
 drivers/acpi/acpica/utids.c     |    2 +-
 drivers/acpi/acpica/utownerid.c |    2 +-
 drivers/acpi/acpica/utresrc.c   |    4 +-
 drivers/acpi/acpica/utstring.c  |   66 ++++++++++++++++-
 drivers/acpi/acpica/uttrack.c   |   31 ++++++--
 drivers/acpi/acpica/utxface.c   |    5 +-
 drivers/acpi/acpica/utxferror.c |    3 +-
 drivers/acpi/acpica/utxfinit.c  |   12 ++-
 include/acpi/acconfig.h         |    2 +
 include/acpi/acnames.h          |   26 +++----
 include/acpi/acpiosxf.h         |  155 +++++++++++++++++++++++++++++++++++----
 include/acpi/acpixf.h           |   64 ++++++++--------
 include/acpi/actypes.h          |   51 +++++++++++--
 include/acpi/platform/aclinux.h |  132 +++++++++++++++++++++++++--------
 85 files changed, 664 insertions(+), 361 deletions(-)

-- 
1.7.10

