From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Thu, 9 Jan 2003 15:12:30 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A117@orsmsx401.jf.intel.com>
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
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

(The diffstat is artificially huge because of the global change from
typedefed structs to explicit struct tags.)

Regards -- Andy

This will update the following files:

 arch/i386/kernel/mpparse.c              |    2 
 drivers/acpi/acpi_bus.h                 |   21 
 drivers/acpi/acpi_drivers.h             |    4 
 drivers/acpi/battery.c                  |   24 
 drivers/acpi/bus.c                      |    6 
 drivers/acpi/button.c                   |   75 +-
 drivers/acpi/dispatcher/dsfield.c       |   76 +-
 drivers/acpi/dispatcher/dsinit.c        |   34 
 drivers/acpi/dispatcher/dsmethod.c      |   60 -
 drivers/acpi/dispatcher/dsmthdat.c      |   94 +-
 drivers/acpi/dispatcher/dsobject.c      |   86 +-
 drivers/acpi/dispatcher/dsopcode.c      |  134 +--
 drivers/acpi/dispatcher/dsutils.c       |   64 -
 drivers/acpi/dispatcher/dswexec.c       |   34 
 drivers/acpi/dispatcher/dswload.c       |   60 -
 drivers/acpi/dispatcher/dswscope.c      |   22 
 drivers/acpi/dispatcher/dswstate.c      |  140 +--
 drivers/acpi/ec.c                       |   24 
 drivers/acpi/events/evevent.c           |   20 
 drivers/acpi/events/evgpe.c             |   84 +-
 drivers/acpi/events/evmisc.c            |   56 -
 drivers/acpi/events/evregion.c          |   86 +-
 drivers/acpi/events/evrgnini.c          |   92 +-
 drivers/acpi/events/evsci.c             |   14 
 drivers/acpi/events/evxface.c           |   76 +-
 drivers/acpi/events/evxfevnt.c          |   40 -
 drivers/acpi/events/evxfregn.c          |   42 -
 drivers/acpi/executer/exconfig.c        |   72 -
 drivers/acpi/executer/exconvrt.c        |   86 +-
 drivers/acpi/executer/excreate.c        |  100 +-
 drivers/acpi/executer/exdump.c          |   64 -
 drivers/acpi/executer/exfield.c         |   38 -
 drivers/acpi/executer/exfldio.c         |  116 +--
 drivers/acpi/executer/exmisc.c          |   62 -
 drivers/acpi/executer/exmutex.c         |   34 
 drivers/acpi/executer/exnames.c         |   44 -
 drivers/acpi/executer/exoparg1.c        |   56 -
 drivers/acpi/executer/exoparg2.c        |   46 -
 drivers/acpi/executer/exoparg3.c        |   26 
 drivers/acpi/executer/exoparg6.c        |   20 
 drivers/acpi/executer/exprep.c          |   42 -
 drivers/acpi/executer/exregion.c        |  108 +-
 drivers/acpi/executer/exresnte.c        |   20 
 drivers/acpi/executer/exresolv.c        |   46 -
 drivers/acpi/executer/exresop.c         |   34 
 drivers/acpi/executer/exstore.c         |   44 -
 drivers/acpi/executer/exstoren.c        |   24 
 drivers/acpi/executer/exstorob.c        |   18 
 drivers/acpi/executer/exsystem.c        |   44 -
 drivers/acpi/executer/exutils.c         |   46 -
 drivers/acpi/hardware/hwacpi.c          |   14 
 drivers/acpi/hardware/hwgpe.c           |   72 -
 drivers/acpi/hardware/hwregs.c          |  106 +-
 drivers/acpi/hardware/hwsleep.c         |   32 
 drivers/acpi/hardware/hwtimer.c         |   22 
 drivers/acpi/include/acconfig.h         |    4 
 drivers/acpi/include/acdebug.h          |  222 +++---
 drivers/acpi/include/acdispat.h         |  370 +++++-----
 drivers/acpi/include/acevents.h         |  102 +-
 drivers/acpi/include/acexcep.h          |    2 
 drivers/acpi/include/acglobal.h         |  212 ++---
 drivers/acpi/include/achware.h          |   62 -
 drivers/acpi/include/acinterp.h         |  546 +++++++-------
 drivers/acpi/include/aclocal.h          |  669 ++++++++----------
 drivers/acpi/include/acmacros.h         |   16 
 drivers/acpi/include/acnamesp.h         |  324 ++++----
 drivers/acpi/include/acobject.h         |  415 +++++------
 drivers/acpi/include/acoutput.h         |    2 
 drivers/acpi/include/acparser.h         |  216 ++---
 drivers/acpi/include/acpi.h             |    2 
 drivers/acpi/include/acpiosxf.h         |  168 ++--
 drivers/acpi/include/acpixf.h           |  258 +++----
 drivers/acpi/include/acresrc.h          |  304 ++++----
 drivers/acpi/include/acstruct.h         |  190 ++---
 drivers/acpi/include/actables.h         |  110 +--
 drivers/acpi/include/actbl.h            |  150 +---
 drivers/acpi/include/actbl1.h           |  134 +--
 drivers/acpi/include/actbl2.h           |  195 ++---
 drivers/acpi/include/actbl71.h          |  140 +--
 drivers/acpi/include/actypes.h          |  732 +++++++++-----------
 drivers/acpi/include/acutils.h          |  532 +++++++-------
 drivers/acpi/include/amlcode.h          |    2 
 drivers/acpi/include/amlresrc.h         |  381 ++++------
 drivers/acpi/include/platform/acenv.h   |    2 
 drivers/acpi/include/platform/acgcc.h   |    2 
 drivers/acpi/include/platform/aclinux.h |    2 
 drivers/acpi/namespace/nsaccess.c       |   48 -
 drivers/acpi/namespace/nsalloc.c        |   74 +-
 drivers/acpi/namespace/nsdump.c         |   70 -
 drivers/acpi/namespace/nsdumpdv.c       |   20 
 drivers/acpi/namespace/nseval.c         |   64 -
 drivers/acpi/namespace/nsinit.c         |   48 -
 drivers/acpi/namespace/nsload.c         |   36 
 drivers/acpi/namespace/nsnames.c        |   34 
 drivers/acpi/namespace/nsobject.c       |   62 -
 drivers/acpi/namespace/nsparse.c        |   18 
 drivers/acpi/namespace/nssearch.c       |   44 -
 drivers/acpi/namespace/nsutils.c        |  142 +--
 drivers/acpi/namespace/nswalk.c         |   38 -
 drivers/acpi/namespace/nsxfeval.c       |  112 +--
 drivers/acpi/namespace/nsxfname.c       |   40 -
 drivers/acpi/namespace/nsxfobj.c        |   34 
 drivers/acpi/osl.c                      |  171 +---
 drivers/acpi/parser/psargs.c            |   76 +-
 drivers/acpi/parser/psopcode.c          |   12 
 drivers/acpi/parser/psparse.c           |   62 -
 drivers/acpi/parser/psscope.c           |   38 -
 drivers/acpi/parser/pstree.c            |   38 -
 drivers/acpi/parser/psutils.c           |   44 -
 drivers/acpi/parser/pswalk.c            |   28 
 drivers/acpi/parser/psxface.c           |   18 
 drivers/acpi/pci_bind.c                 |   10 
 drivers/acpi/pci_irq.c                  |   22 
 drivers/acpi/pci_link.c                 |   28 
 drivers/acpi/pci_root.c                 |   28 
 drivers/acpi/power.c                    |    4 
 drivers/acpi/processor.c                |   85 --
 drivers/acpi/resources/rsaddr.c         |  116 +--
 drivers/acpi/resources/rscalc.c         |  100 +-
 drivers/acpi/resources/rscreate.c       |   60 -
 drivers/acpi/resources/rsdump.c         |   84 +-
 drivers/acpi/resources/rsio.c           |   96 +-
 drivers/acpi/resources/rsirq.c          |   78 +-
 drivers/acpi/resources/rslist.c         |   44 -
 drivers/acpi/resources/rsmemory.c       |   92 +-
 drivers/acpi/resources/rsmisc.c         |  104 +-
 drivers/acpi/resources/rsutils.c        |   36 
 drivers/acpi/resources/rsxface.c        |   26 
 drivers/acpi/scan.c                     |   16 
 drivers/acpi/system.c                   |    4 
 drivers/acpi/tables/tbconvrt.c          |   56 -
 drivers/acpi/tables/tbget.c             |   68 -
 drivers/acpi/tables/tbgetall.c          |   30 
 drivers/acpi/tables/tbinstal.c          |   56 -
 drivers/acpi/tables/tbrsdt.c            |   34 
 drivers/acpi/tables/tbutils.c           |   38 -
 drivers/acpi/tables/tbxface.c           |   48 -
 drivers/acpi/tables/tbxfroot.c          |   72 -
 drivers/acpi/thermal.c                  |    4 
 drivers/acpi/toshiba_acpi.c             |   12 
 drivers/acpi/utilities/utalloc.c        |  156 ++--
 drivers/acpi/utilities/utcopy.c         |  168 ++--
 drivers/acpi/utilities/utdebug.c        |   86 +-
 drivers/acpi/utilities/utdelete.c       |   42 -
 drivers/acpi/utilities/uteval.c         |   58 -
 drivers/acpi/utilities/utglobal.c       |  100 +-
 drivers/acpi/utilities/utinit.c         |    8 
 drivers/acpi/utilities/utmath.c         |   58 -
 drivers/acpi/utilities/utmisc.c         |  210 ++---
 drivers/acpi/utilities/utobject.c       |   84 +-
 drivers/acpi/utilities/utxface.c        |   30 
 drivers/acpi/utils.c                    |   28 
 drivers/hotplug/acpiphp_glue.c          |   46 -
 include/linux/acpi.h                    |   28 
 154 files changed, 6552 insertions(+), 6744 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/09 1.935)
   ACPI: Update version string to 20030109

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/08 1.933)
   ACPI: Eliminate spawning of thread from timer callback. Use
schedule_work for
     all cases. Thanks to Ingo Oeser, Andrew Morton, and Pavel Machek
for their
     wisdom.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/08 1.932)
   cpufreq-ACPI: no longer use CPUFREQ_ALL_CPUS (Dominik Brodowski)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/07 1.889.4.4)
   ACPI: Express state of lid in words, not a number

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/07 1.889.4.3)
   ACPI: Make button functions static (Pavel Machek)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/07 1.889.4.2)
   ACPI: Expose lid state to userspace (Zdenek OGAR Skalak)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/07 1.838.136.19)
   ACPI: Remove typedefs in favor of using "struct" and "union"
explicitly

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/03 1.838.136.17)
   ACPI: Use printk instead of pr_debug (Randy Dunlap)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
