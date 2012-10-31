From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/26] ACPICA 20121018 Release
Date: Wed, 31 Oct 2012 10:24:34 +0800
Message-ID: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6459 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab2JaCy7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:54:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

Here are the 20121018 ACPICA linuxized patches based on the acpi/next branch, please review.


Bob Moore (18):
  Cleanup of invalid ACPI name handling and repair
  ACPICA: Audit/update for ACPICA return macros and debug depth counter
  ACPICA: ACPICA core: Cleanup empty lines at file start and end
  ACPICA: Fix some typos in comments
  ACPICA: Update local C library module comments for ASCII table
  ACPICA: Remove extra spaces after periods within comments
  ACPICA: Remove extra spaces after periods in the Intel license
  ACPICA: Add debug print message for mutex objects that are
    force-released
  ACPICA: AcpiExec: Improve algorithm for tracking memory leaks
  ACPICA: Add ACPI_MOVE_NAME macro to optimize 4-byte ACPI_NAME copies
  ACPICA: Enhance error reporting for invalid opcodes and bad
    ACPI_NAMEs
  ACPICA: Update support for ACPI 5 MPST table
  ACPICA: Deploy ACPI_MOVE_NAME across ACPICA source base
  ACPICA: Add starting offset parameter to common dump buffer routine
  ACPICA: Fix externalize name to complete migration to ACPI_MOVE_NAME
  ACPICA: Update for 64-bit generation of recent error message changes
  ACPICA: AcpiGetObjectInfo: Add support for ACPI 5 _SUB method
  ACPICA: Update version to 20121018

Feng Tang (1):
  ACPICA: Resource Mgr: Small fix for buffer size calculation

Lv Zheng (6):
  ACPICA: Fix unmerged utility divergences.
  ACPICA: Fix unmerged debugger divergences.
  ACPICA: Fix divergences of definition conflicts.
  ACPICA: Fix AcpiSrc caused divergences.
  ACPICA: Fix indent caused divergences.
  ACPICA: Fix unmerged acmacros.h divergences.

Robert Moore (1):
  ACPICA: Fix for predefined name loop during ACPICA initialization

 drivers/acpi/acpica/Makefile    |    3 +
 drivers/acpi/acpica/acdebug.h   |   94 +++--
 drivers/acpi/acpica/acdispat.h  |   11 +-
 drivers/acpi/acpica/acevents.h  |    6 +-
 drivers/acpi/acpica/acglobal.h  |   73 ++--
 drivers/acpi/acpica/aclocal.h   |   16 +-
 drivers/acpi/acpica/acmacros.h  |  163 +++------
 drivers/acpi/acpica/acobject.h  |    7 +-
 drivers/acpi/acpica/acopcode.h  |    6 +-
 drivers/acpi/acpica/acparser.h  |    3 +-
 drivers/acpi/acpica/acpredef.h  |   11 +-
 drivers/acpi/acpica/acstruct.h  |    2 +-
 drivers/acpi/acpica/acutils.h   |   58 ++-
 drivers/acpi/acpica/amlresrc.h  |    1 -
 drivers/acpi/acpica/dscontrol.c |    2 +-
 drivers/acpi/acpica/dsfield.c   |    2 +-
 drivers/acpi/acpica/dsmethod.c  |    6 +-
 drivers/acpi/acpica/dsmthdat.c  |   14 +-
 drivers/acpi/acpica/dsobject.c  |    6 +-
 drivers/acpi/acpica/dsopcode.c  |    3 +-
 drivers/acpi/acpica/dsutils.c   |   33 +-
 drivers/acpi/acpica/dswexec.c   |   10 +-
 drivers/acpi/acpica/dswload2.c  |    4 +-
 drivers/acpi/acpica/dswstate.c  |   26 +-
 drivers/acpi/acpica/evgpe.c     |   20 +-
 drivers/acpi/acpica/evgpeblk.c  |    3 +-
 drivers/acpi/acpica/evgpeutil.c |    3 +-
 drivers/acpi/acpica/evrgnini.c  |    7 +-
 drivers/acpi/acpica/evxface.c   |    2 +-
 drivers/acpi/acpica/evxfgpe.c   |   13 +-
 drivers/acpi/acpica/exconvrt.c  |    4 +-
 drivers/acpi/acpica/excreate.c  |    9 +-
 drivers/acpi/acpica/exdebug.c   |   10 +-
 drivers/acpi/acpica/exdump.c    |   20 +-
 drivers/acpi/acpica/exfield.c   |    4 +-
 drivers/acpi/acpica/exfldio.c   |   15 +-
 drivers/acpi/acpica/exmisc.c    |    5 +-
 drivers/acpi/acpica/exmutex.c   |    9 +-
 drivers/acpi/acpica/exnames.c   |    9 +-
 drivers/acpi/acpica/exoparg1.c  |   11 +-
 drivers/acpi/acpica/exoparg2.c  |    2 +-
 drivers/acpi/acpica/exoparg3.c  |    3 +-
 drivers/acpi/acpica/exoparg6.c  |    5 +-
 drivers/acpi/acpica/exprep.c    |   13 +-
 drivers/acpi/acpica/exregion.c  |    3 +-
 drivers/acpi/acpica/exresnte.c  |    9 +-
 drivers/acpi/acpica/exresolv.c  |    3 +-
 drivers/acpi/acpica/exresop.c   |    8 +-
 drivers/acpi/acpica/exstore.c   |    4 +-
 drivers/acpi/acpica/exstoren.c  |   11 +-
 drivers/acpi/acpica/exstorob.c  |    5 +-
 drivers/acpi/acpica/exsystem.c  |    9 +-
 drivers/acpi/acpica/exutils.c   |    5 +-
 drivers/acpi/acpica/hwacpi.c    |    3 +-
 drivers/acpi/acpica/hwgpe.c     |    4 +-
 drivers/acpi/acpica/hwpci.c     |    4 +-
 drivers/acpi/acpica/hwregs.c    |    1 -
 drivers/acpi/acpica/hwtimer.c   |    6 +-
 drivers/acpi/acpica/hwvalid.c   |    1 -
 drivers/acpi/acpica/hwxface.c   |    1 -
 drivers/acpi/acpica/hwxfsleep.c |   12 +-
 drivers/acpi/acpica/nsaccess.c  |    7 +-
 drivers/acpi/acpica/nsalloc.c   |    4 +-
 drivers/acpi/acpica/nsdump.c    |   10 +-
 drivers/acpi/acpica/nsinit.c    |    4 +-
 drivers/acpi/acpica/nsload.c    |   10 +-
 drivers/acpi/acpica/nsnames.c   |    2 +-
 drivers/acpi/acpica/nsobject.c  |    8 +-
 drivers/acpi/acpica/nsparse.c   |    8 +-
 drivers/acpi/acpica/nssearch.c  |   17 +-
 drivers/acpi/acpica/nsutils.c   |   18 +-
 drivers/acpi/acpica/nswalk.c    |   10 +-
 drivers/acpi/acpica/nsxfeval.c  |   20 +-
 drivers/acpi/acpica/nsxfname.c  |   66 ++--
 drivers/acpi/acpica/nsxfobj.c   |    4 +-
 drivers/acpi/acpica/psargs.c    |    8 +-
 drivers/acpi/acpica/psloop.c    |   59 ++-
 drivers/acpi/acpica/psopcode.c  |   29 +-
 drivers/acpi/acpica/psparse.c   |   13 +-
 drivers/acpi/acpica/psutils.c   |    4 +-
 drivers/acpi/acpica/rscalc.c    |   14 +-
 drivers/acpi/acpica/rslist.c    |    4 +-
 drivers/acpi/acpica/tbfind.c    |    2 +-
 drivers/acpi/acpica/tbinstal.c  |    2 +
 drivers/acpi/acpica/tbutils.c   |    2 +-
 drivers/acpi/acpica/tbxface.c   |    4 +-
 drivers/acpi/acpica/tbxfload.c  |    2 +-
 drivers/acpi/acpica/tbxfroot.c  |    3 +-
 drivers/acpi/acpica/utcache.c   |  323 +++++++++++++++++
 drivers/acpi/acpica/utclib.c    |  749 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utdebug.c   |   37 +-
 drivers/acpi/acpica/utids.c     |  104 +++++-
 drivers/acpi/acpica/utmath.c    |    2 +-
 drivers/acpi/acpica/utmisc.c    |  150 ++++++--
 drivers/acpi/acpica/utmutex.c   |   14 +-
 drivers/acpi/acpica/utobject.c  |    8 +-
 drivers/acpi/acpica/utstate.c   |    2 +-
 drivers/acpi/acpica/uttrack.c   |  692 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utxface.c   |    5 +-
 drivers/acpi/acpica/utxferror.c |    2 +-
 drivers/acpi/scan.c             |    2 +-
 drivers/acpi/sysfs.c            |    4 +-
 include/acpi/acconfig.h         |    1 +
 include/acpi/acexcep.h          |    2 +-
 include/acpi/acnames.h          |    1 +
 include/acpi/acpiosxf.h         |    3 +-
 include/acpi/acpixf.h           |   18 +-
 include/acpi/actbl3.h           |   22 +-
 include/acpi/actypes.h          |   42 ++-
 109 files changed, 2669 insertions(+), 664 deletions(-)
 create mode 100644 drivers/acpi/acpica/utcache.c
 create mode 100644 drivers/acpi/acpica/utclib.c
 create mode 100644 drivers/acpi/acpica/uttrack.c

-- 
1.7.10

