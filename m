From: Len Brown <lenb@kernel.org>
Subject: [git pull request] ACPICA patches for Linux-2.6.34-merge
Date: Mon, 01 Mar 2010 01:57:46 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1003010152540.3898@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49042 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0CAG55 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 01:57:57 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYL00E7SCOIMOX3@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 00:57:57 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica

This will update the files shown below.

thanks!

Len Brown
Intel Open Source Technology Center


ps. individual patches are available on linux-acpi@vger.kernel.org
and a consolidated plain patch is available here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/2.6.33/acpi-acpica-20100121-2.6.33-rc5.diff.gz

 arch/ia64/hp/common/aml_nfw.c             |    6 +-
 arch/x86/kernel/cpu/cpufreq/powernow-k8.c |    6 +-
 drivers/acpi/acpica/accommon.h            |    2 +-
 drivers/acpi/acpica/acconfig.h            |    2 +-
 drivers/acpi/acpica/acdebug.h             |    2 +-
 drivers/acpi/acpica/acdispat.h            |    2 +-
 drivers/acpi/acpica/acevents.h            |    5 +-
 drivers/acpi/acpica/acglobal.h            |    2 +-
 drivers/acpi/acpica/achware.h             |    2 +-
 drivers/acpi/acpica/acinterp.h            |   44 ++++----
 drivers/acpi/acpica/aclocal.h             |    6 +-
 drivers/acpi/acpica/acmacros.h            |   14 +-
 drivers/acpi/acpica/acnamesp.h            |   18 ++-
 drivers/acpi/acpica/acobject.h            |    4 +-
 drivers/acpi/acpica/acopcode.h            |    2 +-
 drivers/acpi/acpica/acparser.h            |    2 +-
 drivers/acpi/acpica/acpredef.h            |    2 +-
 drivers/acpi/acpica/acresrc.h             |    2 +-
 drivers/acpi/acpica/acstruct.h            |    2 +-
 drivers/acpi/acpica/actables.h            |    2 +-
 drivers/acpi/acpica/acutils.h             |   22 ++--
 drivers/acpi/acpica/amlcode.h             |    2 +-
 drivers/acpi/acpica/amlresrc.h            |    2 +-
 drivers/acpi/acpica/dsfield.c             |   12 +-
 drivers/acpi/acpica/dsinit.c              |    2 +-
 drivers/acpi/acpica/dsmethod.c            |    2 +-
 drivers/acpi/acpica/dsmthdat.c            |    2 +-
 drivers/acpi/acpica/dsobject.c            |    4 +-
 drivers/acpi/acpica/dsopcode.c            |    2 +-
 drivers/acpi/acpica/dsutils.c             |    2 +-
 drivers/acpi/acpica/dswexec.c             |    2 +-
 drivers/acpi/acpica/dswload.c             |    2 +-
 drivers/acpi/acpica/dswscope.c            |    2 +-
 drivers/acpi/acpica/dswstate.c            |    2 +-
 drivers/acpi/acpica/evevent.c             |    2 +-
 drivers/acpi/acpica/evgpe.c               |    2 +-
 drivers/acpi/acpica/evgpeblk.c            |    2 +-
 drivers/acpi/acpica/evmisc.c              |    2 +-
 drivers/acpi/acpica/evregion.c            |    7 +-
 drivers/acpi/acpica/evrgnini.c            |    4 +-
 drivers/acpi/acpica/evsci.c               |    2 +-
 drivers/acpi/acpica/evxface.c             |    2 +-
 drivers/acpi/acpica/evxfevnt.c            |    2 +-
 drivers/acpi/acpica/evxfregn.c            |    2 +-
 drivers/acpi/acpica/exconfig.c            |   17 +--
 drivers/acpi/acpica/exconvrt.c            |   21 ++--
 drivers/acpi/acpica/excreate.c            |    2 +-
 drivers/acpi/acpica/exdump.c              |    2 +-
 drivers/acpi/acpica/exfield.c             |    9 +-
 drivers/acpi/acpica/exfldio.c             |   59 +++++-----
 drivers/acpi/acpica/exmisc.c              |   12 +-
 drivers/acpi/acpica/exmutex.c             |    2 +-
 drivers/acpi/acpica/exnames.c             |    2 +-
 drivers/acpi/acpica/exoparg1.c            |   16 ++--
 drivers/acpi/acpica/exoparg2.c            |    6 +-
 drivers/acpi/acpica/exoparg3.c            |    4 +-
 drivers/acpi/acpica/exoparg6.c            |   10 +-
 drivers/acpi/acpica/exprep.c              |    2 +-
 drivers/acpi/acpica/exregion.c            |   35 +++---
 drivers/acpi/acpica/exresnte.c            |    2 +-
 drivers/acpi/acpica/exresolv.c            |    2 +-
 drivers/acpi/acpica/exresop.c             |    2 +-
 drivers/acpi/acpica/exstore.c             |    2 +-
 drivers/acpi/acpica/exstoren.c            |    2 +-
 drivers/acpi/acpica/exstorob.c            |    2 +-
 drivers/acpi/acpica/exsystem.c            |    4 +-
 drivers/acpi/acpica/exutils.c             |   24 ++--
 drivers/acpi/acpica/hwacpi.c              |    2 +-
 drivers/acpi/acpica/hwgpe.c               |    8 +-
 drivers/acpi/acpica/hwregs.c              |    2 +-
 drivers/acpi/acpica/hwsleep.c             |    2 +-
 drivers/acpi/acpica/hwtimer.c             |    4 +-
 drivers/acpi/acpica/hwvalid.c             |    2 +-
 drivers/acpi/acpica/hwxface.c             |    2 +-
 drivers/acpi/acpica/nsaccess.c            |    2 +-
 drivers/acpi/acpica/nsalloc.c             |    2 +-
 drivers/acpi/acpica/nsdump.c              |    2 +-
 drivers/acpi/acpica/nsdumpdv.c            |    2 +-
 drivers/acpi/acpica/nseval.c              |    2 +-
 drivers/acpi/acpica/nsinit.c              |    2 +-
 drivers/acpi/acpica/nsload.c              |    2 +-
 drivers/acpi/acpica/nsnames.c             |    2 +-
 drivers/acpi/acpica/nsobject.c            |    2 +-
 drivers/acpi/acpica/nsparse.c             |    2 +-
 drivers/acpi/acpica/nspredef.c            |   53 ++++++---
 drivers/acpi/acpica/nsrepair.c            |  175 ++++++++++++++++++++++++++++-
 drivers/acpi/acpica/nsrepair2.c           |  110 ++----------------
 drivers/acpi/acpica/nssearch.c            |    2 +-
 drivers/acpi/acpica/nsutils.c             |    2 +-
 drivers/acpi/acpica/nswalk.c              |    2 +-
 drivers/acpi/acpica/nsxfeval.c            |   54 ++++++----
 drivers/acpi/acpica/nsxfname.c            |    2 +-
 drivers/acpi/acpica/nsxfobj.c             |    2 +-
 drivers/acpi/acpica/psargs.c              |    4 +-
 drivers/acpi/acpica/psloop.c              |    2 +-
 drivers/acpi/acpica/psopcode.c            |    2 +-
 drivers/acpi/acpica/psparse.c             |    2 +-
 drivers/acpi/acpica/psscope.c             |    2 +-
 drivers/acpi/acpica/pstree.c              |    2 +-
 drivers/acpi/acpica/psutils.c             |    2 +-
 drivers/acpi/acpica/pswalk.c              |    2 +-
 drivers/acpi/acpica/psxface.c             |    2 +-
 drivers/acpi/acpica/rsaddr.c              |    2 +-
 drivers/acpi/acpica/rscalc.c              |    2 +-
 drivers/acpi/acpica/rscreate.c            |    4 +-
 drivers/acpi/acpica/rsdump.c              |    2 +-
 drivers/acpi/acpica/rsinfo.c              |    2 +-
 drivers/acpi/acpica/rsio.c                |    2 +-
 drivers/acpi/acpica/rsirq.c               |    2 +-
 drivers/acpi/acpica/rslist.c              |    2 +-
 drivers/acpi/acpica/rsmemory.c            |    2 +-
 drivers/acpi/acpica/rsmisc.c              |    2 +-
 drivers/acpi/acpica/rsutils.c             |    2 +-
 drivers/acpi/acpica/rsxface.c             |    2 +-
 drivers/acpi/acpica/tbfadt.c              |    2 +-
 drivers/acpi/acpica/tbfind.c              |    2 +-
 drivers/acpi/acpica/tbinstal.c            |    2 +-
 drivers/acpi/acpica/tbutils.c             |    2 +-
 drivers/acpi/acpica/tbxface.c             |    2 +-
 drivers/acpi/acpica/tbxfroot.c            |    2 +-
 drivers/acpi/acpica/utalloc.c             |    2 +-
 drivers/acpi/acpica/utcopy.c              |    2 +-
 drivers/acpi/acpica/utdebug.c             |    5 +-
 drivers/acpi/acpica/utdelete.c            |    2 +-
 drivers/acpi/acpica/uteval.c              |    4 +-
 drivers/acpi/acpica/utglobal.c            |    4 +-
 drivers/acpi/acpica/utids.c               |    2 +-
 drivers/acpi/acpica/utinit.c              |    2 +-
 drivers/acpi/acpica/utlock.c              |    2 +-
 drivers/acpi/acpica/utmath.c              |   27 ++---
 drivers/acpi/acpica/utmisc.c              |   16 +--
 drivers/acpi/acpica/utmutex.c             |   18 +---
 drivers/acpi/acpica/utobject.c            |    2 +-
 drivers/acpi/acpica/utresrc.c             |    2 +-
 drivers/acpi/acpica/utstate.c             |    2 +-
 drivers/acpi/acpica/utxface.c             |    2 +-
 drivers/acpi/battery.c                    |    4 +-
 drivers/acpi/ec.c                         |    4 +-
 drivers/acpi/glue.c                       |    4 +-
 drivers/acpi/osl.c                        |    4 +-
 drivers/acpi/power_meter.c                |   30 +++---
 drivers/acpi/processor_idle.c             |    2 +-
 drivers/acpi/processor_throttling.c       |   24 ++--
 drivers/acpi/utils.c                      |   16 ++--
 drivers/acpi/video.c                      |    2 +-
 drivers/ata/libata-acpi.c                 |    4 +-
 drivers/ide/ide-acpi.c                    |    8 +-
 drivers/input/misc/atlas_btns.c           |    2 +-
 drivers/pci/pci-acpi.c                    |    2 +-
 drivers/platform/x86/toshiba_bluetooth.c  |    4 +-
 drivers/platform/x86/wmi.c                |    4 +-
 include/acpi/acexcep.h                    |    2 +-
 include/acpi/acnames.h                    |    2 +-
 include/acpi/acoutput.h                   |    2 +-
 include/acpi/acpi.h                       |    2 +-
 include/acpi/acpi_bus.h                   |    6 +-
 include/acpi/acpiosxf.h                   |    6 +-
 include/acpi/acpixf.h                     |    4 +-
 include/acpi/acrestyp.h                   |    4 +-
 include/acpi/actbl.h                      |    2 +-
 include/acpi/actbl1.h                     |    2 +-
 include/acpi/actbl2.h                     |   43 +++++++
 include/acpi/actypes.h                    |   34 +++---
 include/acpi/platform/acenv.h             |    6 +-
 include/acpi/platform/acgcc.h             |    2 +-
 include/acpi/platform/aclinux.h           |    2 +-
 include/acpi/processor.h                  |   42 ++++----
 167 files changed, 721 insertions(+), 603 deletions(-)

through these commits:

Bob Moore (7):
      ACPICA: Update for new gcc-4 warning options
      ACPICA: Update all ACPICA copyrights and signons to 2010
      ACPICA: Predefined name repair: fix NULL package elements
      ACPICA: Remove obsolete ACPI_INTEGER (acpi_integer) type
      ACPICA: Disassembler: Remove obsolete "Integer64" field in parse object
      ACPICA: Remove unused uint32_struct type
      ACPICA: Update version to 20100121.

Lin Ming (2):
      ACPICA: AcpiGetDevices: Eliminate unnecessary _STA calls
      ACPI: replace acpi_integer by u64

with this log:

commit 439913fffd39374c3737186b22d2d56c3a0ae526
Author: Lin Ming <ming.m.lin@intel.com>
Date:   Thu Jan 28 10:53:19 2010 +0800

    ACPI: replace acpi_integer by u64
    
    acpi_integer is now obsolete and removed from the ACPICA code base,
    replaced by u64.
    
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit aea9c04bcc257caad9841c283b90ec1b28267fae
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Jan 22 19:09:06 2010 +0800

    ACPICA: Update version to 20100121.
    
    Version 20100121.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a8f13b7083a10580eeed0723df4b414ed741e0d2
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Jan 21 10:09:43 2010 +0800

    ACPICA: Remove unused uint32_struct type
    
    This type is not used in ACPICA and thus removed.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 758d49313d0bdea1c41aa1d91ab204ca47177aae
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Jan 21 10:08:42 2010 +0800

    ACPICA: Disassembler: Remove obsolete "Integer64" field in parse object
    
    This field is no longer needed. The "Integer" field is 64 bit
    and is sufficient.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5df7e6cb42da36c7d878239bebc81907b15f3943
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Jan 21 10:06:32 2010 +0800

    ACPICA: Remove obsolete ACPI_INTEGER (acpi_integer) type
    
    This type was introduced as the code was migrated from ACPI 1.0
    (with 32-bit AML integers) to ACPI 2.0 (with 64-bit integers). It
    is now obsolete and this change removes it from the ACPICA code
    base, replaced by u64.  The original typedef has been retained
    for now for compatibility with existing device driver code.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 091f4d718620a79698e1c8ca3e9acbf78eb62da3
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Jan 21 09:28:32 2010 +0800

    ACPICA: Predefined name repair: fix NULL package elements
    
    For the predefined methods that return fixed-length packages
    (or subpackages), attempt repair for a NULL element. Create an
    Integer of value 0, a NULL String, or a zero-length buffer as
    appropriate.
    
    http://www.acpica.org/bugzilla/show_bug.cgi?id=818
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5f8902acf87aa206ee4b3f633104456d82747ca6
Author: Lin Ming <ming.m.lin@intel.com>
Date:   Thu Jan 21 09:15:20 2010 +0800

    ACPICA: AcpiGetDevices: Eliminate unnecessary _STA calls
    
    In the case where a specific _HID is requested, do not run _STA
    until a _HID match is found. This eliminates potentially dozens
    of _STA calls during a search for a particular device/HID.
    
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a8357b0c95484b46944728712f8810d3b37bf588
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Jan 22 19:07:36 2010 +0800

    ACPICA: Update all ACPICA copyrights and signons to 2010
    
    Add 2010 copyright to all module headers and signons, including
    the Linux header. This affects virtually every file in the ACPICA
    core subsystem, iASL compiler, and all utilities.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2147d3f00f85c9e993786863d8138694672da01b
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Jan 21 09:08:31 2010 +0800

    ACPICA: Update for new gcc-4 warning options
    
    Added several new options for the gcc-4 generation, and updated
    the source accordingly. This includes some code restructuring to
    eliminate unreachable code, elimination of some gotos, elimination
    of unused return values, and some additional casting.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
