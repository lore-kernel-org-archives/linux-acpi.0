From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Fri, 6 Dec 2002 10:23:59 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A578@orsmsx119.jf.intel.com>
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
<http://linux-acpi.bkbits.net/linux-acpi> 

This will update the following files:

 drivers/acpi/include/acdisasm.h       |  361 -----------
 drivers/acpi/acpi_drivers.h           |    2 
 drivers/acpi/dispatcher/Makefile      |    3 
 drivers/acpi/dispatcher/dsinit.c      |  220 ++++++
 drivers/acpi/dispatcher/dsmthdat.c    |   20 
 drivers/acpi/dispatcher/dsobject.c    |  183 -----
 drivers/acpi/dispatcher/dsopcode.c    |    6 
 drivers/acpi/dispatcher/dswload.c     |   58 +
 drivers/acpi/dispatcher/dswstate.c    |   16 
 drivers/acpi/events/Makefile          |    3 
 drivers/acpi/events/evevent.c         |  677 ---------------------
 drivers/acpi/events/evgpe.c           |  706 ++++++++++++++++++++++
 drivers/acpi/events/evregion.c        |    4 
 drivers/acpi/events/evxfevnt.c        |   15 
 drivers/acpi/executer/exconvrt.c      |    4 
 drivers/acpi/executer/exfield.c       |   10 
 drivers/acpi/executer/exmisc.c        |    6 
 drivers/acpi/executer/exregion.c      |    6 
 drivers/acpi/executer/exstorob.c      |   19 
 drivers/acpi/hardware/hwregs.c        |    9 
 drivers/acpi/hardware/hwsleep.c       |    4 
 drivers/acpi/include/acconfig.h       |   67 +-
 drivers/acpi/include/acdisasm.h       |   10 
 drivers/acpi/include/acexcep.h        |    8 
 drivers/acpi/include/acglobal.h       |    5 
 drivers/acpi/include/aclocal.h        |    4 
 drivers/acpi/include/acmacros.h       |   12 
 drivers/acpi/include/acnamesp.h       |   19 
 drivers/acpi/include/acoutput.h       |   46 -
 drivers/acpi/include/acstruct.h       |    8 
 drivers/acpi/include/actypes.h        |    7 
 drivers/acpi/include/acutils.h        |   12 
 drivers/acpi/include/platform/acgcc.h |    9 
 drivers/acpi/namespace/Makefile       |    3 
 drivers/acpi/namespace/nsdump.c       |   21 
 drivers/acpi/namespace/nsinit.c       |   23 
 drivers/acpi/namespace/nsload.c       |  120 ---
 drivers/acpi/namespace/nsnames.c      |    6 
 drivers/acpi/namespace/nsparse.c      |  153 ++++
 drivers/acpi/namespace/nsutils.c      |   97 ++-
 drivers/acpi/namespace/nsxfname.c     |    4 
 drivers/acpi/namespace/nsxfobj.c      |    2 
 drivers/acpi/osl.c                    |    4 
 drivers/acpi/parser/psparse.c         |    8 
 drivers/acpi/pci_bind.c               |    8 
 drivers/acpi/pci_irq.c                |   10 
 drivers/acpi/resources/rscalc.c       |    8 
 drivers/acpi/resources/rscreate.c     |    6 
 drivers/acpi/resources/rsutils.c      |   75 --
 drivers/acpi/tables/tbxface.c         |    4 
 drivers/acpi/tables/tbxfroot.c        |   32 
 drivers/acpi/utilities/utalloc.c      |    6 
 drivers/acpi/utilities/utcopy.c       |   25 
 drivers/acpi/utilities/utdelete.c     |    4 
 drivers/acpi/utilities/uteval.c       |  332 ++++------
 drivers/acpi/utilities/utglobal.c     |   27 
 drivers/acpi/utilities/utmisc.c       |   55 +
 57 files changed, 1697 insertions(+), 1875 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/06 1.838)
   ACPI: Fix check of schedule_work()'s return value (Ducrot Bruno)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/05 1.837)
   ACPI: Never return a value from the PCI device's Interrupt Line field if
     it might be bogus -- return 0 instead.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/05 1.836)
   ACPI: eliminate spurious unused variables warning w.r.t. ACPI_MODULE_NAME

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/05 1.835)
   ACPI: Remove unneeded file

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/05 1.834)
   ACPI: changed code for new ACPI_ prefixes on constants

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/05 1.833)
   ACPI: Interpreter update to 20021205
     Prefix more contants with ACPI_
     Fixed a problem causing DSDT image corruption
     Fixed a problem if a method was called in an object declaration
     Fixed a problem in the string copy routine
     Broke out some code into new files

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/02 1.797.139.1)
   ACPI: Alter comment to reduce unwarranted hyperbole




-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
