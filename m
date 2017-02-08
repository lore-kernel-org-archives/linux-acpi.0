From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/4] ACPICA 20170119 Release
Date: Wed,  8 Feb 2017 10:59:50 +0800
Message-ID: <cover.1486522441.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18855 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdBHC77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Feb 2017 21:59:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The 20170119 ACPICA kernel-resident subsystem updates are linuxized based
on the linux-pm/linux-next branch.

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
1. x86_64 + default + ACPI_DEBUGGER=y
Where:
1. i386: machine named as "Dell Inspiron Mini 1010"
2. x86_64: machine named as "Microsoft Surface Pro 3"
3. default: kernel configuration with following items enabled:
   All hardware drivers related to the machines of i386/x86_64
   All "drivers/acpi" configurations
   All "drivers/platform" drivers
   All other drivers that link the APIs provided by ACPICA subsystem

The divergences checking result:
Before applying (20161222 Release):
  369 lines
After applying (20170119 Release):
  369 lines

Bob Moore (3):
  ACPICA: Source tree: Update copyright notices to 2017
  ACPICA: Tools: Update common signon, remove compilation bit width
  ACPICA: Update version to 20170119

Lv Zheng (1):
  ACPICA: Linuxize: Restore and fix intel compiler build

 drivers/acpi/acpica/acapps.h                       | 14 ++--
 drivers/acpi/acpica/accommon.h                     |  2 +-
 drivers/acpi/acpica/acdebug.h                      |  2 +-
 drivers/acpi/acpica/acdispat.h                     |  2 +-
 drivers/acpi/acpica/acevents.h                     |  2 +-
 drivers/acpi/acpica/acglobal.h                     |  2 +-
 drivers/acpi/acpica/achware.h                      |  2 +-
 drivers/acpi/acpica/acinterp.h                     |  2 +-
 drivers/acpi/acpica/aclocal.h                      |  2 +-
 drivers/acpi/acpica/acmacros.h                     |  2 +-
 drivers/acpi/acpica/acnamesp.h                     |  2 +-
 drivers/acpi/acpica/acobject.h                     |  2 +-
 drivers/acpi/acpica/acopcode.h                     |  2 +-
 drivers/acpi/acpica/acparser.h                     |  2 +-
 drivers/acpi/acpica/acpredef.h                     |  2 +-
 drivers/acpi/acpica/acresrc.h                      |  2 +-
 drivers/acpi/acpica/acstruct.h                     |  2 +-
 drivers/acpi/acpica/actables.h                     |  2 +-
 drivers/acpi/acpica/acutils.h                      |  2 +-
 drivers/acpi/acpica/amlcode.h                      |  2 +-
 drivers/acpi/acpica/amlresrc.h                     |  2 +-
 drivers/acpi/acpica/dbcmds.c                       |  2 +-
 drivers/acpi/acpica/dbconvert.c                    |  2 +-
 drivers/acpi/acpica/dbdisply.c                     |  2 +-
 drivers/acpi/acpica/dbexec.c                       |  2 +-
 drivers/acpi/acpica/dbfileio.c                     |  2 +-
 drivers/acpi/acpica/dbhistry.c                     |  2 +-
 drivers/acpi/acpica/dbinput.c                      |  2 +-
 drivers/acpi/acpica/dbmethod.c                     |  2 +-
 drivers/acpi/acpica/dbnames.c                      |  2 +-
 drivers/acpi/acpica/dbobject.c                     |  2 +-
 drivers/acpi/acpica/dbstats.c                      |  2 +-
 drivers/acpi/acpica/dbtest.c                       |  2 +-
 drivers/acpi/acpica/dbutils.c                      |  2 +-
 drivers/acpi/acpica/dbxface.c                      |  2 +-
 drivers/acpi/acpica/dsargs.c                       |  2 +-
 drivers/acpi/acpica/dscontrol.c                    |  2 +-
 drivers/acpi/acpica/dsdebug.c                      |  2 +-
 drivers/acpi/acpica/dsfield.c                      |  2 +-
 drivers/acpi/acpica/dsinit.c                       |  2 +-
 drivers/acpi/acpica/dsmethod.c                     |  2 +-
 drivers/acpi/acpica/dsmthdat.c                     |  2 +-
 drivers/acpi/acpica/dsobject.c                     |  2 +-
 drivers/acpi/acpica/dsopcode.c                     |  2 +-
 drivers/acpi/acpica/dsutils.c                      |  2 +-
 drivers/acpi/acpica/dswexec.c                      |  2 +-
 drivers/acpi/acpica/dswload.c                      |  2 +-
 drivers/acpi/acpica/dswload2.c                     |  2 +-
 drivers/acpi/acpica/dswscope.c                     |  2 +-
 drivers/acpi/acpica/dswstate.c                     |  2 +-
 drivers/acpi/acpica/evevent.c                      |  2 +-
 drivers/acpi/acpica/evglock.c                      |  2 +-
 drivers/acpi/acpica/evgpe.c                        |  2 +-
 drivers/acpi/acpica/evgpeblk.c                     |  2 +-
 drivers/acpi/acpica/evgpeinit.c                    |  2 +-
 drivers/acpi/acpica/evgpeutil.c                    |  2 +-
 drivers/acpi/acpica/evhandler.c                    |  2 +-
 drivers/acpi/acpica/evmisc.c                       |  2 +-
 drivers/acpi/acpica/evregion.c                     |  2 +-
 drivers/acpi/acpica/evrgnini.c                     |  2 +-
 drivers/acpi/acpica/evsci.c                        |  2 +-
 drivers/acpi/acpica/evxface.c                      |  2 +-
 drivers/acpi/acpica/evxfevnt.c                     |  2 +-
 drivers/acpi/acpica/evxfgpe.c                      |  2 +-
 drivers/acpi/acpica/evxfregn.c                     |  2 +-
 drivers/acpi/acpica/exconcat.c                     |  2 +-
 drivers/acpi/acpica/exconfig.c                     |  2 +-
 drivers/acpi/acpica/exconvrt.c                     |  2 +-
 drivers/acpi/acpica/excreate.c                     |  2 +-
 drivers/acpi/acpica/exdebug.c                      |  2 +-
 drivers/acpi/acpica/exdump.c                       |  2 +-
 drivers/acpi/acpica/exfield.c                      |  2 +-
 drivers/acpi/acpica/exfldio.c                      |  2 +-
 drivers/acpi/acpica/exmisc.c                       |  2 +-
 drivers/acpi/acpica/exmutex.c                      |  2 +-
 drivers/acpi/acpica/exnames.c                      |  2 +-
 drivers/acpi/acpica/exoparg1.c                     |  2 +-
 drivers/acpi/acpica/exoparg2.c                     |  2 +-
 drivers/acpi/acpica/exoparg3.c                     |  2 +-
 drivers/acpi/acpica/exoparg6.c                     |  2 +-
 drivers/acpi/acpica/exprep.c                       |  2 +-
 drivers/acpi/acpica/exregion.c                     |  2 +-
 drivers/acpi/acpica/exresnte.c                     |  2 +-
 drivers/acpi/acpica/exresolv.c                     |  2 +-
 drivers/acpi/acpica/exresop.c                      |  2 +-
 drivers/acpi/acpica/exstore.c                      |  2 +-
 drivers/acpi/acpica/exstoren.c                     |  2 +-
 drivers/acpi/acpica/exstorob.c                     |  2 +-
 drivers/acpi/acpica/exsystem.c                     |  2 +-
 drivers/acpi/acpica/extrace.c                      |  2 +-
 drivers/acpi/acpica/exutils.c                      |  2 +-
 drivers/acpi/acpica/hwacpi.c                       |  2 +-
 drivers/acpi/acpica/hwesleep.c                     |  2 +-
 drivers/acpi/acpica/hwgpe.c                        |  2 +-
 drivers/acpi/acpica/hwpci.c                        |  2 +-
 drivers/acpi/acpica/hwregs.c                       |  2 +-
 drivers/acpi/acpica/hwsleep.c                      |  2 +-
 drivers/acpi/acpica/hwtimer.c                      |  2 +-
 drivers/acpi/acpica/hwvalid.c                      |  2 +-
 drivers/acpi/acpica/hwxface.c                      |  2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |  2 +-
 drivers/acpi/acpica/nsaccess.c                     |  2 +-
 drivers/acpi/acpica/nsalloc.c                      |  2 +-
 drivers/acpi/acpica/nsarguments.c                  |  2 +-
 drivers/acpi/acpica/nsconvert.c                    |  2 +-
 drivers/acpi/acpica/nsdump.c                       |  2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |  2 +-
 drivers/acpi/acpica/nseval.c                       |  2 +-
 drivers/acpi/acpica/nsinit.c                       |  2 +-
 drivers/acpi/acpica/nsload.c                       |  2 +-
 drivers/acpi/acpica/nsnames.c                      |  2 +-
 drivers/acpi/acpica/nsobject.c                     |  2 +-
 drivers/acpi/acpica/nsparse.c                      |  2 +-
 drivers/acpi/acpica/nspredef.c                     |  2 +-
 drivers/acpi/acpica/nsprepkg.c                     |  2 +-
 drivers/acpi/acpica/nsrepair.c                     |  2 +-
 drivers/acpi/acpica/nsrepair2.c                    |  2 +-
 drivers/acpi/acpica/nssearch.c                     |  2 +-
 drivers/acpi/acpica/nsutils.c                      |  2 +-
 drivers/acpi/acpica/nswalk.c                       |  2 +-
 drivers/acpi/acpica/nsxfeval.c                     |  2 +-
 drivers/acpi/acpica/nsxfname.c                     |  2 +-
 drivers/acpi/acpica/nsxfobj.c                      |  2 +-
 drivers/acpi/acpica/psargs.c                       |  2 +-
 drivers/acpi/acpica/psloop.c                       |  2 +-
 drivers/acpi/acpica/psobject.c                     |  2 +-
 drivers/acpi/acpica/psopcode.c                     |  2 +-
 drivers/acpi/acpica/psopinfo.c                     |  2 +-
 drivers/acpi/acpica/psparse.c                      |  2 +-
 drivers/acpi/acpica/psscope.c                      |  2 +-
 drivers/acpi/acpica/pstree.c                       |  2 +-
 drivers/acpi/acpica/psutils.c                      |  2 +-
 drivers/acpi/acpica/pswalk.c                       |  2 +-
 drivers/acpi/acpica/psxface.c                      |  2 +-
 drivers/acpi/acpica/rsaddr.c                       |  2 +-
 drivers/acpi/acpica/rscalc.c                       |  2 +-
 drivers/acpi/acpica/rscreate.c                     |  2 +-
 drivers/acpi/acpica/rsdump.c                       |  2 +-
 drivers/acpi/acpica/rsdumpinfo.c                   |  2 +-
 drivers/acpi/acpica/rsinfo.c                       |  2 +-
 drivers/acpi/acpica/rsio.c                         |  2 +-
 drivers/acpi/acpica/rsirq.c                        |  2 +-
 drivers/acpi/acpica/rslist.c                       |  2 +-
 drivers/acpi/acpica/rsmemory.c                     |  2 +-
 drivers/acpi/acpica/rsmisc.c                       |  2 +-
 drivers/acpi/acpica/rsserial.c                     |  2 +-
 drivers/acpi/acpica/rsutils.c                      |  2 +-
 drivers/acpi/acpica/rsxface.c                      |  2 +-
 drivers/acpi/acpica/tbdata.c                       |  2 +-
 drivers/acpi/acpica/tbfadt.c                       |  2 +-
 drivers/acpi/acpica/tbfind.c                       |  2 +-
 drivers/acpi/acpica/tbinstal.c                     |  2 +-
 drivers/acpi/acpica/tbprint.c                      |  2 +-
 drivers/acpi/acpica/tbutils.c                      |  2 +-
 drivers/acpi/acpica/tbxface.c                      |  2 +-
 drivers/acpi/acpica/tbxfload.c                     |  2 +-
 drivers/acpi/acpica/tbxfroot.c                     |  2 +-
 drivers/acpi/acpica/utaddress.c                    |  2 +-
 drivers/acpi/acpica/utalloc.c                      |  2 +-
 drivers/acpi/acpica/utascii.c                      |  2 +-
 drivers/acpi/acpica/utbuffer.c                     |  2 +-
 drivers/acpi/acpica/utcache.c                      |  2 +-
 drivers/acpi/acpica/utcopy.c                       |  2 +-
 drivers/acpi/acpica/utdebug.c                      |  2 +-
 drivers/acpi/acpica/utdecode.c                     |  2 +-
 drivers/acpi/acpica/utdelete.c                     |  2 +-
 drivers/acpi/acpica/uterror.c                      |  2 +-
 drivers/acpi/acpica/uteval.c                       |  2 +-
 drivers/acpi/acpica/utexcep.c                      |  2 +-
 drivers/acpi/acpica/utglobal.c                     |  2 +-
 drivers/acpi/acpica/uthex.c                        |  2 +-
 drivers/acpi/acpica/utids.c                        |  2 +-
 drivers/acpi/acpica/utinit.c                       |  2 +-
 drivers/acpi/acpica/utlock.c                       |  2 +-
 drivers/acpi/acpica/utmath.c                       |  2 +-
 drivers/acpi/acpica/utmisc.c                       |  2 +-
 drivers/acpi/acpica/utmutex.c                      |  2 +-
 drivers/acpi/acpica/utnonansi.c                    |  2 +-
 drivers/acpi/acpica/utobject.c                     |  2 +-
 drivers/acpi/acpica/utosi.c                        |  2 +-
 drivers/acpi/acpica/utownerid.c                    |  2 +-
 drivers/acpi/acpica/utpredef.c                     |  2 +-
 drivers/acpi/acpica/utprint.c                      |  2 +-
 drivers/acpi/acpica/utresrc.c                      |  2 +-
 drivers/acpi/acpica/utstate.c                      |  2 +-
 drivers/acpi/acpica/utstring.c                     |  2 +-
 drivers/acpi/acpica/utstrtoul64.c                  |  2 +-
 drivers/acpi/acpica/uttrack.c                      |  2 +-
 drivers/acpi/acpica/utuuid.c                       |  2 +-
 drivers/acpi/acpica/utxface.c                      |  2 +-
 drivers/acpi/acpica/utxferror.c                    |  2 +-
 drivers/acpi/acpica/utxfinit.c                     |  2 +-
 drivers/acpi/acpica/utxfmutex.c                    |  2 +-
 include/acpi/acbuffer.h                            |  2 +-
 include/acpi/acconfig.h                            |  2 +-
 include/acpi/acexcep.h                             |  2 +-
 include/acpi/acnames.h                             |  2 +-
 include/acpi/acoutput.h                            |  2 +-
 include/acpi/acpi.h                                |  2 +-
 include/acpi/acpiosxf.h                            |  2 +-
 include/acpi/acpixf.h                              |  4 +-
 include/acpi/acrestyp.h                            |  2 +-
 include/acpi/actbl.h                               |  2 +-
 include/acpi/actbl1.h                              |  2 +-
 include/acpi/actbl2.h                              |  2 +-
 include/acpi/actbl3.h                              |  2 +-
 include/acpi/actypes.h                             |  2 +-
 include/acpi/acuuid.h                              |  2 +-
 include/acpi/platform/acenv.h                      |  4 +-
 include/acpi/platform/acenvex.h                    |  2 +-
 include/acpi/platform/acgcc.h                      |  2 +-
 include/acpi/platform/acgccex.h                    |  2 +-
 include/acpi/platform/acintel.h                    | 87 ++++++++++++++++++++++
 include/acpi/platform/aclinux.h                    |  2 +-
 include/acpi/platform/aclinuxex.h                  |  2 +-
 tools/power/acpi/common/cmfsize.c                  |  2 +-
 tools/power/acpi/common/getopt.c                   |  2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |  2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |  2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |  2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |  2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |  2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |  2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |  2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |  2 +-
 225 files changed, 319 insertions(+), 232 deletions(-)
 create mode 100644 include/acpi/platform/acintel.h

-- 
2.7.4

