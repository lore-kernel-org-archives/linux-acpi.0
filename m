From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI update
Date: Tue, 18 Feb 2003 16:06:32 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A18E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

Thanks -- Andy

This will update the following files:

 arch/i386/kernel/mpparse.c         |   21 +
 drivers/acpi/dispatcher/dsfield.c  |   43 ++-
 drivers/acpi/dispatcher/dsinit.c   |   43 ++-
 drivers/acpi/dispatcher/dsmethod.c |   43 ++-
 drivers/acpi/dispatcher/dsmthdat.c |   43 ++-
 drivers/acpi/dispatcher/dsobject.c |   43 ++-
 drivers/acpi/dispatcher/dsopcode.c |   43 ++-
 drivers/acpi/dispatcher/dsutils.c  |   43 ++-
 drivers/acpi/dispatcher/dswexec.c  |   43 ++-
 drivers/acpi/dispatcher/dswload.c  |   43 ++-
 drivers/acpi/dispatcher/dswscope.c |   43 ++-
 drivers/acpi/dispatcher/dswstate.c |   43 ++-
 drivers/acpi/events/evevent.c      |   43 ++-
 drivers/acpi/events/evgpe.c        |   99 +++++---
 drivers/acpi/events/evmisc.c       |   81 +++++--
 drivers/acpi/events/evregion.c     |   43 ++-
 drivers/acpi/events/evrgnini.c     |   43 ++-
 drivers/acpi/events/evsci.c        |   43 ++-
 drivers/acpi/events/evxface.c      |   69 +++---
 drivers/acpi/events/evxfevnt.c     |   43 ++-
 drivers/acpi/events/evxfregn.c     |   43 ++-
 drivers/acpi/executer/exconfig.c   |   44 ++-
 drivers/acpi/executer/exconvrt.c   |   43 ++-
 drivers/acpi/executer/excreate.c   |   43 ++-
 drivers/acpi/executer/exdump.c     |   43 ++-
 drivers/acpi/executer/exfield.c    |   43 ++-
 drivers/acpi/executer/exfldio.c    |   43 ++-
 drivers/acpi/executer/exmisc.c     |   43 ++-
 drivers/acpi/executer/exmutex.c    |   43 ++-
 drivers/acpi/executer/exnames.c    |   43 ++-
 drivers/acpi/executer/exoparg1.c   |   43 ++-
 drivers/acpi/executer/exoparg2.c   |   43 ++-
 drivers/acpi/executer/exoparg3.c   |   43 ++-
 drivers/acpi/executer/exoparg6.c   |   43 ++-
 drivers/acpi/executer/exprep.c     |   43 ++-
 drivers/acpi/executer/exregion.c   |   43 ++-
 drivers/acpi/executer/exresnte.c   |   43 ++-
 drivers/acpi/executer/exresolv.c   |   43 ++-
 drivers/acpi/executer/exresop.c    |  108 +++++++--
 drivers/acpi/executer/exstore.c    |   43 ++-
 drivers/acpi/executer/exstoren.c   |   43 ++-
 drivers/acpi/executer/exstorob.c   |   43 ++-
 drivers/acpi/executer/exsystem.c   |   43 ++-
 drivers/acpi/executer/exutils.c    |   43 ++-
 drivers/acpi/hardware/hwacpi.c     |   43 ++-
 drivers/acpi/hardware/hwgpe.c      |  173 ++++++++-------
 drivers/acpi/hardware/hwregs.c     |   43 ++-
 drivers/acpi/hardware/hwsleep.c    |   43 ++-
 drivers/acpi/hardware/hwtimer.c    |   43 ++-
 drivers/acpi/namespace/nsaccess.c  |   71 ++++--
 drivers/acpi/namespace/nsalloc.c   |   43 ++-
 drivers/acpi/namespace/nsdump.c    |   43 ++-
 drivers/acpi/namespace/nsdumpdv.c  |   43 ++-
 drivers/acpi/namespace/nseval.c    |   43 ++-
 drivers/acpi/namespace/nsinit.c    |   43 ++-
 drivers/acpi/namespace/nsload.c    |   43 ++-
 drivers/acpi/namespace/nsnames.c   |   43 ++-
 drivers/acpi/namespace/nsobject.c  |   43 ++-
 drivers/acpi/namespace/nsparse.c   |   43 ++-
 drivers/acpi/namespace/nssearch.c  |   43 ++-
 drivers/acpi/namespace/nsutils.c   |   43 ++-
 drivers/acpi/namespace/nswalk.c    |   43 ++-
 drivers/acpi/namespace/nsxfeval.c  |   43 ++-
 drivers/acpi/namespace/nsxfname.c  |   43 ++-
 drivers/acpi/namespace/nsxfobj.c   |   43 ++-
 drivers/acpi/numa.c                |    2 
 drivers/acpi/osl.c                 |   58 ++++-
 drivers/acpi/parser/psargs.c       |   43 ++-
 drivers/acpi/parser/psopcode.c     |   47 ++--
 drivers/acpi/parser/psparse.c      |   43 ++-
 drivers/acpi/parser/psscope.c      |   43 ++-
 drivers/acpi/parser/pstree.c       |   43 ++-
 drivers/acpi/parser/psutils.c      |   43 ++-
 drivers/acpi/parser/pswalk.c       |   43 ++-
 drivers/acpi/parser/psxface.c      |   43 ++-
 drivers/acpi/pci_irq.c             |    4 
 drivers/acpi/pci_link.c            |   33 ++
 drivers/acpi/resources/rsaddr.c    |   58 ++++-
 drivers/acpi/resources/rscalc.c    |   43 ++-
 drivers/acpi/resources/rscreate.c  |   43 ++-
 drivers/acpi/resources/rsdump.c    |  138 +++++++-----
 drivers/acpi/resources/rsio.c      |   43 ++-
 drivers/acpi/resources/rsirq.c     |   43 ++-
 drivers/acpi/resources/rslist.c    |   43 ++-
 drivers/acpi/resources/rsmemory.c  |   43 ++-
 drivers/acpi/resources/rsmisc.c    |   43 ++-
 drivers/acpi/resources/rsutils.c   |   43 ++-
 drivers/acpi/resources/rsxface.c   |   43 ++-
 drivers/acpi/tables/tbconvrt.c     |   43 ++-
 drivers/acpi/tables/tbget.c        |   43 ++-
 drivers/acpi/tables/tbgetall.c     |   43 ++-
 drivers/acpi/tables/tbinstal.c     |   43 ++-
 drivers/acpi/tables/tbrsdt.c       |   43 ++-
 drivers/acpi/tables/tbutils.c      |   43 ++-
 drivers/acpi/tables/tbxface.c      |   43 ++-
 drivers/acpi/tables/tbxfroot.c     |   43 ++-
 drivers/acpi/toshiba_acpi.c        |  285 +++++++++----------------
 drivers/acpi/utilities/utalloc.c   |   43 ++-
 drivers/acpi/utilities/utcopy.c    |   43 ++-
 drivers/acpi/utilities/utdebug.c   |   43 ++-
 drivers/acpi/utilities/utdelete.c  |   43 ++-
 drivers/acpi/utilities/uteval.c    |   43 ++-
 drivers/acpi/utilities/utglobal.c  |   55 +++-
 drivers/acpi/utilities/utinit.c    |   43 ++-
 drivers/acpi/utilities/utmath.c    |   43 ++-
 drivers/acpi/utilities/utmisc.c    |   43 ++-
 drivers/acpi/utilities/utobject.c  |   43 ++-
 drivers/acpi/utilities/utxface.c   |   43 ++-
 include/acpi/acconfig.h            |   43 ++-
 include/acpi/acdebug.h             |   43 ++-
 include/acpi/acdispat.h            |   43 ++-
 include/acpi/acevents.h            |   51 +++-
 include/acpi/acexcep.h             |   43 ++-
 include/acpi/acglobal.h            |   43 ++-
 include/acpi/achware.h             |   43 ++-
 include/acpi/acinterp.h            |   43 ++-
 include/acpi/aclocal.h             |   43 ++-
 include/acpi/acmacros.h            |   43 ++-
 include/acpi/acnamesp.h            |   43 ++-
 include/acpi/acobject.h            |   43 ++-
 include/acpi/acoutput.h            |   43 ++-
 include/acpi/acparser.h            |   43 ++-
 include/acpi/acpi.h                |   73 ++++--
 include/acpi/acpiosxf.h            |   54 +++-
 include/acpi/acpixf.h              |   47 ++--
 include/acpi/acresrc.h             |   43 ++-
 include/acpi/acstruct.h            |   43 ++-
 include/acpi/actables.h            |   43 ++-
 include/acpi/actbl.h               |   43 ++-
 include/acpi/actbl1.h              |   43 ++-
 include/acpi/actbl2.h              |   43 ++-
 include/acpi/actypes.h             |   47 ++--
 include/acpi/acutils.h             |   43 ++-
 include/acpi/amlcode.h             |  109 ++++++---
 include/acpi/platform/acenv.h      |   45 ++-
 include/acpi/platform/acgcc.h      |   43 ++-
 include/acpi/platform/aclinux.h    |   47 ++--
 137 files changed, 4640 insertions(+), 1995 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/18 1.1064.1.11)
   ACPI: Toshiba ACPI device update (John Belmonte)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/18 1.1064.1.10)
   ACPI: Change license from GPL to dual GPL and BSD-style

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/18 1.1064.1.9)
   ACPI: misc cleanups

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/18 1.1064.1.8)
   ACPI: Misc interpreter improvements

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/18 1.1064.1.7)
   ACPI: Fix printk output (Jochen Hein)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/18 1.1064.1.6)
   ACPI: Decrease size of override's static array, add a define for the
length,
   and print a msg if used

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/18 1.1064.1.5)
   ACPI: Add ability to override predefined object values (Ducrot Bruno)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/18 1.1064.1.4)
   ACPI: Support translation attribute (Bjorn Helgaas)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/18 1.1064.1.3)
   ACPI: Eliminate use of acpi_gpl_gpe_number_info (Matthew Wilcox)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/18 1.1064.1.2)
   ACPI: Change NUMA maintainer email

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/14 1.988.1.82)
   ACPI: *really* fix ISO SCI override support (thanks again to John
Stultz)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/14 1.988.1.81)
   ACPI: Factor common code out of an if/else

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/14 1.988.45.2)
   ACPI: Properly handle an ISO reassigning the ACPI interrupt. Big
thanks to
   John Stultz.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/14 1.988.45.1)
   ACPI: Use extended IRQ resource type when setting IRQs on link
devices to more
   than IRQ 15 (Juan Quintela)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
