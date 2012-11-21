From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/15] ACPICA 20121114 Release
Date: Wed, 21 Nov 2012 18:06:45 +0800
Message-ID: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12426 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258Ab2KUKGx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 05:06:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

The 20121114 ACPICA linuxized patches are based on the pm/linux-next branch.
Please review though the patches have passed the basic build & boot tests.

Bob Moore (6):
  ACPICA: Performance: Remove function tracing from critical allocation
    functions.
  ACPICA: Debugger: Major update for the Disassemble<method> command.
  ACPICA: Disassembler: Add new ACPI 5 interrupt sharing flags.
  ACPICA: Add macros to extract flag bits from resource descriptors.
  ACPICA: AcpiGetObjectInfo: optimize exit for mutex failure.
  ACPICA: Update version to 20121114.

Chao Guan (1):
  ACPICA: Performance enhancement for ACPI package objects.

Jesper Juhl (1):
  ACPICA: Fix possible memory leak.

Lv Zheng (7):
  ACPICA: Fixes unmerged (dis)assember divergences.
  ACPICA: Fixes comments caused divergences.
  ACPICA: Fixes indent caused divergences.
  ACPICA: Fixes code maintenance divergences.
  ACPICA: Fixes call depth check caused divergences.
  ACPICA: Enhance the ACPI_GETx and ACPI_SETx macros.
  ACPICA: Resource Manager: update template walking with
    ACPI_NEXT_RESOURCE.

 drivers/acpi/acpica/accommon.h  |    1 +
 drivers/acpi/acpica/acdisasm.h  |  647 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/acglobal.h  |   35 ++-
 drivers/acpi/acpica/aclocal.h   |   38 ++-
 drivers/acpi/acpica/acmacros.h  |   34 +-
 drivers/acpi/acpica/acobject.h  |    2 +-
 drivers/acpi/acpica/acpredef.h  |   14 +-
 drivers/acpi/acpica/acutils.h   |    7 +-
 drivers/acpi/acpica/amlresrc.h  |    6 +
 drivers/acpi/acpica/dsmethod.c  |    7 +-
 drivers/acpi/acpica/dsobject.c  |    2 +-
 drivers/acpi/acpica/dsopcode.c  |   14 +-
 drivers/acpi/acpica/dswload.c   |    5 +-
 drivers/acpi/acpica/evgpe.c     |    6 +-
 drivers/acpi/acpica/evxface.c   |   34 +-
 drivers/acpi/acpica/evxfevnt.c  |    4 +-
 drivers/acpi/acpica/evxfgpe.c   |    9 +-
 drivers/acpi/acpica/exconfig.c  |   13 +-
 drivers/acpi/acpica/exfldio.c   |    1 -
 drivers/acpi/acpica/exmutex.c   |    3 +-
 drivers/acpi/acpica/exoparg1.c  |    8 +-
 drivers/acpi/acpica/exregion.c  |   23 +-
 drivers/acpi/acpica/hwacpi.c    |    3 +-
 drivers/acpi/acpica/hwesleep.c  |    1 -
 drivers/acpi/acpica/hwgpe.c     |    6 +-
 drivers/acpi/acpica/hwregs.c    |    6 +-
 drivers/acpi/acpica/hwsleep.c   |    3 +-
 drivers/acpi/acpica/hwvalid.c   |   18 +-
 drivers/acpi/acpica/hwxface.c   |    2 +-
 drivers/acpi/acpica/hwxfsleep.c |    7 +-
 drivers/acpi/acpica/nsdump.c    |    4 +-
 drivers/acpi/acpica/nsdumpdv.c  |    1 -
 drivers/acpi/acpica/nsnames.c   |    3 +-
 drivers/acpi/acpica/nspredef.c  |    3 +-
 drivers/acpi/acpica/nsrepair2.c |    3 +-
 drivers/acpi/acpica/nssearch.c  |    5 +
 drivers/acpi/acpica/nsutils.c   |   13 +-
 drivers/acpi/acpica/nswalk.c    |    4 +-
 drivers/acpi/acpica/nsxfeval.c  |    4 +-
 drivers/acpi/acpica/nsxfname.c  |   16 +-
 drivers/acpi/acpica/psutils.c   |    2 +-
 drivers/acpi/acpica/rscalc.c    |    6 +-
 drivers/acpi/acpica/rscreate.c  |    7 +-
 drivers/acpi/acpica/rsdump.c    |    9 +-
 drivers/acpi/acpica/rsirq.c     |    6 +-
 drivers/acpi/acpica/rslist.c    |    7 +-
 drivers/acpi/acpica/rsmemory.c  |    6 +-
 drivers/acpi/acpica/rsmisc.c    |   74 +++--
 drivers/acpi/acpica/rsutils.c   |    8 +-
 drivers/acpi/acpica/rsxface.c   |    4 +-
 drivers/acpi/acpica/tbfadt.c    |    5 +-
 drivers/acpi/acpica/tbutils.c   |    6 +-
 drivers/acpi/acpica/utcopy.c    |    4 +-
 drivers/acpi/acpica/utdelete.c  |   68 ++--
 drivers/acpi/acpica/uteval.c    |    2 +-
 drivers/acpi/acpica/utglobal.c  |    9 +-
 drivers/acpi/acpica/utlock.c    |   14 +-
 drivers/acpi/acpica/utmisc.c    |    8 +-
 drivers/acpi/acpica/utobject.c  |    2 +-
 drivers/acpi/acpica/utresrc.c   |   81 ++---
 drivers/acpi/acpica/utstate.c   |   40 ++-
 drivers/acpi/acpica/uttrack.c   |   16 +-
 drivers/acpi/acpica/utxface.c   |    4 -
 drivers/acpi/acpica/utxferror.c |    4 +-
 include/acpi/acconfig.h         |    2 +-
 include/acpi/acpiosxf.h         |    9 +-
 include/acpi/acpixf.h           |   57 ++--
 include/acpi/acrestyp.h         |    5 +-
 include/acpi/actbl1.h           |    6 +-
 include/acpi/actypes.h          |    4 +-
 include/acpi/platform/acenv.h   |   97 ++++--
 71 files changed, 1184 insertions(+), 403 deletions(-)
 create mode 100644 drivers/acpi/acpica/acdisasm.h

-- 
1.7.10

