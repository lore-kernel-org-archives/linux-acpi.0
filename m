From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/7] ACPICA 20130117 Release
Date: Fri, 25 Jan 2013 13:38:19 +0800
Message-ID: <cover.1358825277.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45287 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab3AYFim (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2013 00:38:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Rafael J Wysocki <rjw@sisk.pl>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

The 20130117 ACPICA linuxized patches are based on the pm/linux-next
branch.
This patch set has passed 0-day kernel build/boot tests.

Bob Moore (6):
  ACPICA: Update ACPICA copyrights to 2013
  ACPICA: AcpiGetSleepTypeData: Allow \_Sx to return either 1 or 2
    integers
  ACPICA: iASL/Disassembler: Add option to ignore NOOP
    opcodes/operators
  ACPICA: Remove some extraneous newlines in ACPI_ERROR type calls
  ACPICA: Update predefined info table for _MLS method
  ACPICA: Update version to 20130117

Lv Zheng (1):
  ACPICA: Update predefined info table

 drivers/acpi/acpica/accommon.h   |    2 +-
 drivers/acpi/acpica/acdebug.h    |    2 +-
 drivers/acpi/acpica/acdispat.h   |    2 +-
 drivers/acpi/acpica/acevents.h   |    2 +-
 drivers/acpi/acpica/acglobal.h   |    6 +-
 drivers/acpi/acpica/achware.h    |    2 +-
 drivers/acpi/acpica/acinterp.h   |    2 +-
 drivers/acpi/acpica/aclocal.h    |    2 +-
 drivers/acpi/acpica/acmacros.h   |    2 +-
 drivers/acpi/acpica/acnamesp.h   |    2 +-
 drivers/acpi/acpica/acobject.h   |    2 +-
 drivers/acpi/acpica/acopcode.h   |    2 +-
 drivers/acpi/acpica/acparser.h   |    2 +-
 drivers/acpi/acpica/acpredef.h   |   17 ++---
 drivers/acpi/acpica/acresrc.h    |    2 +-
 drivers/acpi/acpica/acstruct.h   |    2 +-
 drivers/acpi/acpica/actables.h   |    2 +-
 drivers/acpi/acpica/acutils.h    |    2 +-
 drivers/acpi/acpica/amlcode.h    |    2 +-
 drivers/acpi/acpica/amlresrc.h   |    2 +-
 drivers/acpi/acpica/dsargs.c     |    2 +-
 drivers/acpi/acpica/dscontrol.c  |    2 +-
 drivers/acpi/acpica/dsfield.c    |    2 +-
 drivers/acpi/acpica/dsinit.c     |    2 +-
 drivers/acpi/acpica/dsmethod.c   |    2 +-
 drivers/acpi/acpica/dsmthdat.c   |    2 +-
 drivers/acpi/acpica/dsobject.c   |    4 +-
 drivers/acpi/acpica/dsopcode.c   |    2 +-
 drivers/acpi/acpica/dsutils.c    |    2 +-
 drivers/acpi/acpica/dswexec.c    |    2 +-
 drivers/acpi/acpica/dswload.c    |    2 +-
 drivers/acpi/acpica/dswload2.c   |    4 +-
 drivers/acpi/acpica/dswscope.c   |    2 +-
 drivers/acpi/acpica/dswstate.c   |    2 +-
 drivers/acpi/acpica/evevent.c    |    2 +-
 drivers/acpi/acpica/evglock.c    |    2 +-
 drivers/acpi/acpica/evgpe.c      |    2 +-
 drivers/acpi/acpica/evgpeblk.c   |    2 +-
 drivers/acpi/acpica/evgpeinit.c  |    2 +-
 drivers/acpi/acpica/evgpeutil.c  |    2 +-
 drivers/acpi/acpica/evhandler.c  |    2 +-
 drivers/acpi/acpica/evmisc.c     |    2 +-
 drivers/acpi/acpica/evregion.c   |    2 +-
 drivers/acpi/acpica/evrgnini.c   |    2 +-
 drivers/acpi/acpica/evsci.c      |    2 +-
 drivers/acpi/acpica/evxface.c    |    2 +-
 drivers/acpi/acpica/evxfevnt.c   |    2 +-
 drivers/acpi/acpica/evxfgpe.c    |    2 +-
 drivers/acpi/acpica/evxfregn.c   |    2 +-
 drivers/acpi/acpica/exconfig.c   |    2 +-
 drivers/acpi/acpica/exconvrt.c   |    2 +-
 drivers/acpi/acpica/excreate.c   |    2 +-
 drivers/acpi/acpica/exdebug.c    |    2 +-
 drivers/acpi/acpica/exdump.c     |    2 +-
 drivers/acpi/acpica/exfield.c    |    2 +-
 drivers/acpi/acpica/exfldio.c    |    2 +-
 drivers/acpi/acpica/exmisc.c     |    2 +-
 drivers/acpi/acpica/exmutex.c    |    2 +-
 drivers/acpi/acpica/exnames.c    |    2 +-
 drivers/acpi/acpica/exoparg1.c   |    2 +-
 drivers/acpi/acpica/exoparg2.c   |    2 +-
 drivers/acpi/acpica/exoparg3.c   |    2 +-
 drivers/acpi/acpica/exoparg6.c   |    2 +-
 drivers/acpi/acpica/exprep.c     |    2 +-
 drivers/acpi/acpica/exregion.c   |    2 +-
 drivers/acpi/acpica/exresnte.c   |    2 +-
 drivers/acpi/acpica/exresolv.c   |    2 +-
 drivers/acpi/acpica/exresop.c    |    2 +-
 drivers/acpi/acpica/exstore.c    |    2 +-
 drivers/acpi/acpica/exstoren.c   |    2 +-
 drivers/acpi/acpica/exstorob.c   |    2 +-
 drivers/acpi/acpica/exsystem.c   |    2 +-
 drivers/acpi/acpica/exutils.c    |    2 +-
 drivers/acpi/acpica/hwacpi.c     |    2 +-
 drivers/acpi/acpica/hwesleep.c   |    2 +-
 drivers/acpi/acpica/hwgpe.c      |    4 +-
 drivers/acpi/acpica/hwpci.c      |    2 +-
 drivers/acpi/acpica/hwregs.c     |    2 +-
 drivers/acpi/acpica/hwsleep.c    |    2 +-
 drivers/acpi/acpica/hwtimer.c    |    2 +-
 drivers/acpi/acpica/hwvalid.c    |    2 +-
 drivers/acpi/acpica/hwxface.c    |  127 ++++++++++++++++++++++----------------
 drivers/acpi/acpica/hwxfsleep.c  |    2 +-
 drivers/acpi/acpica/nsaccess.c   |    2 +-
 drivers/acpi/acpica/nsalloc.c    |    2 +-
 drivers/acpi/acpica/nsdump.c     |    2 +-
 drivers/acpi/acpica/nsdumpdv.c   |    2 +-
 drivers/acpi/acpica/nseval.c     |    2 +-
 drivers/acpi/acpica/nsinit.c     |    2 +-
 drivers/acpi/acpica/nsload.c     |    2 +-
 drivers/acpi/acpica/nsnames.c    |    2 +-
 drivers/acpi/acpica/nsobject.c   |    2 +-
 drivers/acpi/acpica/nsparse.c    |    2 +-
 drivers/acpi/acpica/nspredef.c   |    2 +-
 drivers/acpi/acpica/nsprepkg.c   |    2 +-
 drivers/acpi/acpica/nsrepair.c   |    2 +-
 drivers/acpi/acpica/nsrepair2.c  |    2 +-
 drivers/acpi/acpica/nssearch.c   |    2 +-
 drivers/acpi/acpica/nsutils.c    |    2 +-
 drivers/acpi/acpica/nswalk.c     |    2 +-
 drivers/acpi/acpica/nsxfeval.c   |    2 +-
 drivers/acpi/acpica/nsxfname.c   |    2 +-
 drivers/acpi/acpica/nsxfobj.c    |    2 +-
 drivers/acpi/acpica/psargs.c     |    2 +-
 drivers/acpi/acpica/psloop.c     |    2 +-
 drivers/acpi/acpica/psobject.c   |    2 +-
 drivers/acpi/acpica/psopcode.c   |    2 +-
 drivers/acpi/acpica/psopinfo.c   |    2 +-
 drivers/acpi/acpica/psparse.c    |    2 +-
 drivers/acpi/acpica/psscope.c    |    2 +-
 drivers/acpi/acpica/pstree.c     |    2 +-
 drivers/acpi/acpica/psutils.c    |    2 +-
 drivers/acpi/acpica/pswalk.c     |    2 +-
 drivers/acpi/acpica/psxface.c    |    2 +-
 drivers/acpi/acpica/rsaddr.c     |    2 +-
 drivers/acpi/acpica/rscalc.c     |    2 +-
 drivers/acpi/acpica/rscreate.c   |    2 +-
 drivers/acpi/acpica/rsdump.c     |    2 +-
 drivers/acpi/acpica/rsdumpinfo.c |    2 +-
 drivers/acpi/acpica/rsinfo.c     |    2 +-
 drivers/acpi/acpica/rsio.c       |    2 +-
 drivers/acpi/acpica/rsirq.c      |    2 +-
 drivers/acpi/acpica/rslist.c     |    2 +-
 drivers/acpi/acpica/rsmemory.c   |    2 +-
 drivers/acpi/acpica/rsmisc.c     |    2 +-
 drivers/acpi/acpica/rsserial.c   |    2 +-
 drivers/acpi/acpica/rsutils.c    |    2 +-
 drivers/acpi/acpica/rsxface.c    |    2 +-
 drivers/acpi/acpica/tbfadt.c     |    2 +-
 drivers/acpi/acpica/tbfind.c     |    2 +-
 drivers/acpi/acpica/tbinstal.c   |    2 +-
 drivers/acpi/acpica/tbutils.c    |    2 +-
 drivers/acpi/acpica/tbxface.c    |    2 +-
 drivers/acpi/acpica/tbxfload.c   |    2 +-
 drivers/acpi/acpica/tbxfroot.c   |    2 +-
 drivers/acpi/acpica/utaddress.c  |    2 +-
 drivers/acpi/acpica/utalloc.c    |    2 +-
 drivers/acpi/acpica/utcache.c    |    2 +-
 drivers/acpi/acpica/utcopy.c     |    2 +-
 drivers/acpi/acpica/utdebug.c    |    2 +-
 drivers/acpi/acpica/utdecode.c   |    2 +-
 drivers/acpi/acpica/utdelete.c   |    2 +-
 drivers/acpi/acpica/uteval.c     |    2 +-
 drivers/acpi/acpica/utexcep.c    |    2 +-
 drivers/acpi/acpica/utglobal.c   |    2 +-
 drivers/acpi/acpica/utids.c      |    2 +-
 drivers/acpi/acpica/utinit.c     |    2 +-
 drivers/acpi/acpica/utlock.c     |    2 +-
 drivers/acpi/acpica/utmath.c     |    2 +-
 drivers/acpi/acpica/utmisc.c     |    2 +-
 drivers/acpi/acpica/utmutex.c    |    2 +-
 drivers/acpi/acpica/utobject.c   |    2 +-
 drivers/acpi/acpica/utosi.c      |    2 +-
 drivers/acpi/acpica/utownerid.c  |    2 +-
 drivers/acpi/acpica/utresrc.c    |    2 +-
 drivers/acpi/acpica/utstate.c    |    2 +-
 drivers/acpi/acpica/utstring.c   |    2 +-
 drivers/acpi/acpica/uttrack.c    |    2 +-
 drivers/acpi/acpica/utxface.c    |    2 +-
 drivers/acpi/acpica/utxferror.c  |    2 +-
 drivers/acpi/acpica/utxfinit.c   |    2 +-
 drivers/acpi/acpica/utxfmutex.c  |    2 +-
 include/acpi/acbuffer.h          |    2 +-
 include/acpi/acconfig.h          |    2 +-
 include/acpi/acexcep.h           |    2 +-
 include/acpi/acnames.h           |    2 +-
 include/acpi/acoutput.h          |    2 +-
 include/acpi/acpi.h              |    2 +-
 include/acpi/acpiosxf.h          |    2 +-
 include/acpi/acpixf.h            |    4 +-
 include/acpi/acrestyp.h          |    2 +-
 include/acpi/actbl.h             |    2 +-
 include/acpi/actbl1.h            |    2 +-
 include/acpi/actbl2.h            |    2 +-
 include/acpi/actbl3.h            |    2 +-
 include/acpi/actypes.h           |    2 +-
 include/acpi/platform/acenv.h    |    2 +-
 include/acpi/platform/acgcc.h    |    2 +-
 include/acpi/platform/aclinux.h  |    2 +-
 179 files changed, 268 insertions(+), 242 deletions(-)

-- 
1.7.10

