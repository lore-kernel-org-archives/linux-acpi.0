From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates, mostly cosmetic
Date: Tue, 17 Dec 2002 13:55:19 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A5B4@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Linus Torvalds' <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

This will update the following files:

 drivers/acpi/ac.c                       |    4 
 drivers/acpi/battery.c                  |    4 
 drivers/acpi/button.c                   |    4 
 drivers/acpi/dispatcher/dsfield.c       |   87 ++++----
 drivers/acpi/dispatcher/dsinit.c        |   23 +-
 drivers/acpi/dispatcher/dsmethod.c      |   49 ++--
 drivers/acpi/dispatcher/dsmthdat.c      |   97 ++++-----
 drivers/acpi/dispatcher/dsobject.c      |   57 ++---
 drivers/acpi/dispatcher/dsopcode.c      |  147 +++++++-------
 drivers/acpi/dispatcher/dsutils.c       |   51 ++---
 drivers/acpi/dispatcher/dswexec.c       |   39 +--
 drivers/acpi/dispatcher/dswload.c       |   49 ++--
 drivers/acpi/dispatcher/dswscope.c      |   17 -
 drivers/acpi/dispatcher/dswstate.c      |  153 +++++++--------
 drivers/acpi/ec.c                       |    2 
 drivers/acpi/events/evevent.c           |   30 +-
 drivers/acpi/events/evgpe.c             |   97 ++++-----
 drivers/acpi/events/evmisc.c            |   53 ++---
 drivers/acpi/events/evregion.c          |   53 ++---
 drivers/acpi/events/evrgnini.c          |   85 ++++----
 drivers/acpi/events/evsci.c             |   17 -
 drivers/acpi/events/evxface.c           |   51 ++---
 drivers/acpi/events/evxfevnt.c          |   25 +-
 drivers/acpi/events/evxfregn.c          |   23 +-
 drivers/acpi/executer/exconfig.c        |   61 ++----
 drivers/acpi/executer/exconvrt.c        |   82 +++-----
 drivers/acpi/executer/excreate.c        |   75 +++----
 drivers/acpi/executer/exdump.c          |  127 ++++++------
 drivers/acpi/executer/exfield.c         |   31 +--
 drivers/acpi/executer/exfldio.c         |  109 +++++-----
 drivers/acpi/executer/exmisc.c          |   55 ++---
 drivers/acpi/executer/exmutex.c         |   45 ++--
 drivers/acpi/executer/exnames.c         |   49 ++--
 drivers/acpi/executer/exoparg1.c        |   93 ++++-----
 drivers/acpi/executer/exoparg2.c        |   59 ++---
 drivers/acpi/executer/exoparg3.c        |   37 +--
 drivers/acpi/executer/exoparg6.c        |   23 +-
 drivers/acpi/executer/exprep.c          |   77 +++----
 drivers/acpi/executer/exregion.c        |  109 +++++-----
 drivers/acpi/executer/exresnte.c        |   15 -
 drivers/acpi/executer/exresolv.c        |   51 ++---
 drivers/acpi/executer/exresop.c         |   33 +--
 drivers/acpi/executer/exstore.c         |   47 ++--
 drivers/acpi/executer/exstoren.c        |   37 +--
 drivers/acpi/executer/exstorob.c        |   25 +-
 drivers/acpi/executer/exsystem.c        |   47 ++--
 drivers/acpi/executer/exutils.c         |   45 ++--
 drivers/acpi/fan.c                      |    4 
 drivers/acpi/hardware/hwacpi.c          |   13 -
 drivers/acpi/hardware/hwgpe.c           |   41 +---
 drivers/acpi/hardware/hwregs.c          |  153 +++++++--------
 drivers/acpi/hardware/hwsleep.c         |   49 ++--
 drivers/acpi/hardware/hwtimer.c         |   25 +-
 drivers/acpi/include/acconfig.h         |    5 
 drivers/acpi/include/acdebug.h          |    1 
 drivers/acpi/include/acdispat.h         |   13 -
 drivers/acpi/include/acevents.h         |    3 
 drivers/acpi/include/acexcep.h          |    1 
 drivers/acpi/include/acglobal.h         |   31 +--
 drivers/acpi/include/achware.h          |    3 
 drivers/acpi/include/acinterp.h         |   27 +-
 drivers/acpi/include/aclocal.h          |   67 +++---
 drivers/acpi/include/acmacros.h         |   69 ++----
 drivers/acpi/include/acnamesp.h         |   17 -
 drivers/acpi/include/acobject.h         |  151 +++++++-------
 drivers/acpi/include/acoutput.h         |   13 -
 drivers/acpi/include/acparser.h         |    1 
 drivers/acpi/include/acpi.h             |    1 
 drivers/acpi/include/acpiosxf.h         |   26 +-
 drivers/acpi/include/acpixf.h           |   18 -
 drivers/acpi/include/acresrc.h          |  101 ++++------
 drivers/acpi/include/acstruct.h         |   27 +-
 drivers/acpi/include/actables.h         |   21 --
 drivers/acpi/include/actbl.h            |    3 
 drivers/acpi/include/actbl1.h           |   13 -
 drivers/acpi/include/actbl2.h           |   35 +--
 drivers/acpi/include/actbl71.h          |   15 -
 drivers/acpi/include/actypes.h          |  202 ++++++++++----------
 drivers/acpi/include/acutils.h          |   79 +++----
 drivers/acpi/include/amlcode.h          |   31 +--
 drivers/acpi/include/amlresrc.h         |   95 ++++-----
 drivers/acpi/include/platform/acenv.h   |   33 +--
 drivers/acpi/include/platform/acgcc.h   |    1 
 drivers/acpi/include/platform/aclinux.h |    1 
 drivers/acpi/namespace/nsaccess.c       |   39 +--
 drivers/acpi/namespace/nsalloc.c        |   43 ++--
 drivers/acpi/namespace/nsdump.c         |   41 +---
 drivers/acpi/namespace/nsdumpdv.c       |   13 -
 drivers/acpi/namespace/nseval.c         |   49 ++--
 drivers/acpi/namespace/nsinit.c         |   27 +-
 drivers/acpi/namespace/nsload.c         |   28 +-
 drivers/acpi/namespace/nsnames.c        |   37 +--
 drivers/acpi/namespace/nsobject.c       |   37 +--
 drivers/acpi/namespace/nsparse.c        |   17 -
 drivers/acpi/namespace/nssearch.c       |   37 +--
 drivers/acpi/namespace/nsutils.c        |  127 ++++++------
 drivers/acpi/namespace/nswalk.c         |   31 +--
 drivers/acpi/namespace/nsxfeval.c       |   93 ++++-----
 drivers/acpi/namespace/nsxfname.c       |   15 -
 drivers/acpi/namespace/nsxfobj.c        |   15 -
 drivers/acpi/osl.c                      |   26 +-
 drivers/acpi/parser/psargs.c            |   79 +++----
 drivers/acpi/parser/psopcode.c          |   11 -
 drivers/acpi/parser/psparse.c           |   73 +++----
 drivers/acpi/parser/psscope.c           |   41 +---
 drivers/acpi/parser/pstree.c            |   11 -
 drivers/acpi/parser/psutils.c           |   27 +-
 drivers/acpi/parser/pswalk.c            |   23 +-
 drivers/acpi/parser/psxface.c           |   13 -
 drivers/acpi/power.c                    |    4 
 drivers/acpi/processor.c                |   16 -
 drivers/acpi/resources/rsaddr.c         |  165 ++++++++--------
 drivers/acpi/resources/rscalc.c         |   65 +++---
 drivers/acpi/resources/rscreate.c       |   83 ++++----
 drivers/acpi/resources/rsdump.c         |   41 +---
 drivers/acpi/resources/rsio.c           |  119 +++++------
 drivers/acpi/resources/rsirq.c          |   91 ++++-----
 drivers/acpi/resources/rslist.c         |   43 ++--
 drivers/acpi/resources/rsmemory.c       |  133 ++++++-------
 drivers/acpi/resources/rsmisc.c         |  155 +++++++--------
 drivers/acpi/resources/rsutils.c        |   35 +--
 drivers/acpi/resources/rsxface.c        |   51 ++---
 drivers/acpi/sleep.c                    |    4 
 drivers/acpi/tables/tbconvrt.c          |  101 ++++------
 drivers/acpi/tables/tbget.c             |   61 ++----
 drivers/acpi/tables/tbgetall.c          |   27 +-
 drivers/acpi/tables/tbinstal.c          |   55 ++---
 drivers/acpi/tables/tbrsdt.c            |   35 +--
 drivers/acpi/tables/tbutils.c           |   27 +-
 drivers/acpi/tables/tbxface.c           |   71 +++----
 drivers/acpi/tables/tbxfroot.c          |   57 ++---
 drivers/acpi/thermal.c                  |    4 
 drivers/acpi/utilities/utalloc.c        |  157 +++++++--------
 drivers/acpi/utilities/utcopy.c         |  109 +++++-----
 drivers/acpi/utilities/utdebug.c        |  155 +++++++--------
 drivers/acpi/utilities/utdelete.c       |   29 +-
 drivers/acpi/utilities/uteval.c         |   43 ++--
 drivers/acpi/utilities/utglobal.c       |   91 ++++-----
 drivers/acpi/utilities/utinit.c         |   41 +---
 drivers/acpi/utilities/utmath.c         |   39 +--
 drivers/acpi/utilities/utmisc.c         |  151 +++++++-------
 drivers/acpi/utilities/utobject.c       |   85 ++++----
 drivers/acpi/utilities/utxface.c        |   47 ++--
 143 files changed, 3572 insertions(+), 3709 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/17 1.888)
   ACPI: More cosmetic changes to make the code more Linux-like

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/17 1.887)
   ACPI: remove non-Linux revision on files, and make types more Linux-like

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/16 1.886)
   ACPI: Fix oops on module insert/remove (Matthew Tippett)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
