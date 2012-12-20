From: Lv Zheng <lv.zheng@intel.com>
Subject: [RESEND PATCH v2 00/19] ACPICA 20121114 Release
Date: Thu, 20 Dec 2012 09:06:31 +0800
Message-ID: <cover.1355810292.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:34856 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489Ab2LTBGz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 20:06:55 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

Resend [PATCH v2 02, 04, 08, 19] along with this cover letter as they are
not appearing in the community due to MDA issues.

The 20121114 ACPICA linuxized patches are based on the pm/linux-next branch.

The patch 10-19 are 20121114 ACPICA release patches while the 01-09 are
patches to reduce the source code differences between Linux and ACPICA so
that the release process can be easier with less human intervention and
the known bugs can also be prevented.
A QA process is executed to compare resulting binary files. Those patches
which were not expected to change any text section indeed, changed no text.
Sometimes line numbers changed due to line deletions and insertions, but
that is expected.
The source code differences between Linux and ACPICA can be summarized as
follows:
1. 3978 Lines (138.4 Kbytes) before applying the patch set;
2. 1964 Lines (70.0 Kbytes) after applying the patch set.

Please review.

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

Lv Zheng (11):
  ACPICA: Cleanup updated comments.
  ACPICA: Update compilation environment settings.
  ACPICA: Update codes under disabled build options.
  ACPICA: Cleanup source to reduce differences between Linux and
    ACPICA.
  ACPICA: Cleanup indentation to reduce differences between Linux and
    ACPICA.
  ACPICA: Cleanup coding style to reduce differences between Linux and
    ACPICA.
  ACPICA: Fix broken call depth tracing logic.
  ACPICA: Enhance error messages.
  ACPICA: Update initialization codes.
  ACPICA: Enhance the ACPI_GETx and ACPI_SETx macros.
  ACPICA: Resource Manager: update template walking with
    ACPI_NEXT_RESOURCE.

 arch/ia64/include/asm/acpi.h    |    4 -
 arch/x86/include/asm/acpi.h     |    4 -
 drivers/acpi/acpica/accommon.h  |    1 +
 drivers/acpi/acpica/acglobal.h  |   35 +++--
 drivers/acpi/acpica/aclocal.h   |   45 ++++--
 drivers/acpi/acpica/acmacros.h  |   34 ++++-
 drivers/acpi/acpica/acobject.h  |    2 +-
 drivers/acpi/acpica/acpredef.h  |   14 +-
 drivers/acpi/acpica/acutils.h   |    7 +-
 drivers/acpi/acpica/amlresrc.h  |    6 +
 drivers/acpi/acpica/dsmethod.c  |    5 +-
 drivers/acpi/acpica/dsobject.c  |    2 +-
 drivers/acpi/acpica/dsopcode.c  |   14 +-
 drivers/acpi/acpica/dswload.c   |    5 +-
 drivers/acpi/acpica/evgpe.c     |    6 +-
 drivers/acpi/acpica/evxface.c   |   34 ++---
 drivers/acpi/acpica/evxfevnt.c  |    5 +-
 drivers/acpi/acpica/evxfgpe.c   |    9 +-
 drivers/acpi/acpica/exconfig.c  |   13 +-
 drivers/acpi/acpica/exfldio.c   |    1 -
 drivers/acpi/acpica/exmutex.c   |    3 +-
 drivers/acpi/acpica/exoparg1.c  |    8 +-
 drivers/acpi/acpica/exregion.c  |   23 +--
 drivers/acpi/acpica/hwacpi.c    |    3 +-
 drivers/acpi/acpica/hwesleep.c  |    1 -
 drivers/acpi/acpica/hwgpe.c     |    6 +-
 drivers/acpi/acpica/hwregs.c    |    6 +-
 drivers/acpi/acpica/hwsleep.c   |    4 +-
 drivers/acpi/acpica/hwvalid.c   |   18 +--
 drivers/acpi/acpica/hwxface.c   |   10 +-
 drivers/acpi/acpica/hwxfsleep.c |    9 +-
 drivers/acpi/acpica/nsdump.c    |    4 +-
 drivers/acpi/acpica/nsdumpdv.c  |    1 -
 drivers/acpi/acpica/nsinit.c    |    6 -
 drivers/acpi/acpica/nsnames.c   |    3 +-
 drivers/acpi/acpica/nspredef.c  |    3 +-
 drivers/acpi/acpica/nsrepair2.c |    3 +-
 drivers/acpi/acpica/nssearch.c  |    5 +
 drivers/acpi/acpica/nsutils.c   |   13 +-
 drivers/acpi/acpica/nswalk.c    |    4 +-
 drivers/acpi/acpica/nsxfeval.c  |   15 +-
 drivers/acpi/acpica/nsxfname.c  |   16 +-
 drivers/acpi/acpica/psutils.c   |    2 +-
 drivers/acpi/acpica/rscalc.c    |    6 +-
 drivers/acpi/acpica/rscreate.c  |    7 +-
 drivers/acpi/acpica/rsdump.c    |    9 +-
 drivers/acpi/acpica/rsirq.c     |    6 +-
 drivers/acpi/acpica/rslist.c    |    7 +-
 drivers/acpi/acpica/rsmemory.c  |    6 +-
 drivers/acpi/acpica/rsmisc.c    |   74 ++++-----
 drivers/acpi/acpica/rsutils.c   |    8 +-
 drivers/acpi/acpica/rsxface.c   |    4 +-
 drivers/acpi/acpica/tbfadt.c    |    5 +-
 drivers/acpi/acpica/tbutils.c   |    2 +-
 drivers/acpi/acpica/tbxface.c   |    1 -
 drivers/acpi/acpica/utcopy.c    |    4 +-
 drivers/acpi/acpica/utdelete.c  |   68 ++++++---
 drivers/acpi/acpica/uteval.c    |    2 +-
 drivers/acpi/acpica/utglobal.c  |    9 +-
 drivers/acpi/acpica/utlock.c    |   14 +-
 drivers/acpi/acpica/utmisc.c    |    8 +-
 drivers/acpi/acpica/utobject.c  |    2 +-
 drivers/acpi/acpica/utresrc.c   |   81 +++++-----
 drivers/acpi/acpica/utstate.c   |   40 +++--
 drivers/acpi/acpica/uttrack.c   |   16 +-
 drivers/acpi/acpica/utxface.c   |    4 -
 drivers/acpi/acpica/utxferror.c |    4 +-
 include/acpi/acconfig.h         |   24 +--
 include/acpi/acoutput.h         |    1 +
 include/acpi/acpiosxf.h         |   11 +-
 include/acpi/acpixf.h           |   57 +++----
 include/acpi/acrestyp.h         |    5 +-
 include/acpi/actbl.h            |    7 +-
 include/acpi/actbl1.h           |    6 +-
 include/acpi/actypes.h          |    9 +-
 include/acpi/platform/acenv.h   |  317 ++++++++++++++++++++-------------------
 include/acpi/platform/acgcc.h   |    4 -
 include/acpi/platform/aclinux.h |    1 -
 78 files changed, 664 insertions(+), 577 deletions(-)

-- 
1.7.10

