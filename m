From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Mon, 28 Oct 2002 13:27:37 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A478@orsmsx119.jf.intel.com>
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
To: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

Early reports are that we hosed something to do with processor/thermal
support, but the consensus seems to be to handle that with a follow-on patch
instead of waiting.

Regards -- Andy

This will update the following files:

 drivers/acpi/Config.help           |    5 
 drivers/acpi/Config.in             |    6 
 drivers/acpi/acpi_ksyms.c          |   15 +
 drivers/acpi/blacklist.c           |    2 
 drivers/acpi/dispatcher/dsfield.c  |   22 -
 drivers/acpi/dispatcher/dsmthdat.c |    4 
 drivers/acpi/dispatcher/dsobject.c |    6 
 drivers/acpi/dispatcher/dsopcode.c |    4 
 drivers/acpi/dispatcher/dsutils.c  |    4 
 drivers/acpi/dispatcher/dswload.c  |  206 ++++++++------
 drivers/acpi/dispatcher/dswscope.c |   48 +++
 drivers/acpi/dispatcher/dswstate.c |    6 
 drivers/acpi/ec.c                  |   92 +++---
 drivers/acpi/events/evevent.c      |   82 +++--
 drivers/acpi/events/evxface.c      |    4 
 drivers/acpi/events/evxfregn.c     |    4 
 drivers/acpi/executer/exconfig.c   |   13 
 drivers/acpi/executer/exconvrt.c   |   10 
 drivers/acpi/executer/excreate.c   |   17 -
 drivers/acpi/executer/exdump.c     |  128 +++------
 drivers/acpi/executer/exfldio.c    |    8 
 drivers/acpi/executer/exmisc.c     |    6 
 drivers/acpi/executer/exmutex.c    |   36 ++
 drivers/acpi/executer/exnames.c    |    8 
 drivers/acpi/executer/exoparg1.c   |    4 
 drivers/acpi/executer/exoparg2.c   |   10 
 drivers/acpi/executer/exprep.c     |   10 
 drivers/acpi/executer/exresnte.c   |   12 
 drivers/acpi/executer/exresolv.c   |   27 +
 drivers/acpi/executer/exresop.c    |   23 -
 drivers/acpi/executer/exstore.c    |   10 
 drivers/acpi/executer/exstoren.c   |   12 
 drivers/acpi/executer/exstorob.c   |    4 
 drivers/acpi/executer/exutils.c    |   30 --
 drivers/acpi/hardware/hwsleep.c    |    7 
 drivers/acpi/include/acconfig.h    |    4 
 drivers/acpi/include/acdisasm.h    |    6 
 drivers/acpi/include/acglobal.h    |    8 
 drivers/acpi/include/acinterp.h    |    6 
 drivers/acpi/include/aclocal.h     |    4 
 drivers/acpi/include/acnamesp.h    |   16 -
 drivers/acpi/include/acobject.h    |    3 
 drivers/acpi/include/acstruct.h    |    4 
 drivers/acpi/include/actypes.h     |  107 +++----
 drivers/acpi/include/acutils.h     |    7 
 drivers/acpi/namespace/nsaccess.c  |   63 +---
 drivers/acpi/namespace/nsalloc.c   |  154 +++++++----
 drivers/acpi/namespace/nsdump.c    |  135 +++------
 drivers/acpi/namespace/nsobject.c  |   33 +-
 drivers/acpi/namespace/nssearch.c  |   86 ++----
 drivers/acpi/namespace/nsutils.c   |   41 --
 drivers/acpi/namespace/nsxfeval.c  |    6 
 drivers/acpi/namespace/nsxfobj.c   |    4 
 drivers/acpi/parser/psopcode.c     |  256 +++++++++---------
 drivers/acpi/pci_irq.c             |    9 
 drivers/acpi/power.c               |    6 
 drivers/acpi/processor.c           |  349 ++++++++++++++++++++++++-
 drivers/acpi/resources/rscalc.c    |    4 
 drivers/acpi/resources/rscreate.c  |  128 +++++----
 drivers/acpi/tables/tbconvrt.c     |    4 
 drivers/acpi/tables/tbget.c        |    3 
 drivers/acpi/tables/tbgetall.c     |   10 
 drivers/acpi/tables/tbinstal.c     |    7 
 drivers/acpi/tables/tbrsdt.c       |    3 
 drivers/acpi/utilities/utcopy.c    |    4 
 drivers/acpi/utilities/utdelete.c  |   12 
 drivers/acpi/utilities/utglobal.c  |   56 +---
 drivers/acpi/utilities/utmisc.c    |   94 ++++++
 drivers/acpi/utilities/utobject.c  |    6 
 include/linux/acpi.h               |    6 
 70 files changed, 1471 insertions(+), 1058 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/24 1.808.2.12)
   ACPI: Try #2 at fixing the PCI IRQ bridge swizzle (Kai Germaschewski)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/24 1.808.2.11)
   ACPI: implement support for cpufreq interface (Dominik Brodowski)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/23 1.808.2.10)
   ACPI: eliminate duplicate lines of code

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/23 1.808.2.9)
   ACPI: Add support for GPE1 block defined with no GPE0 block

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/23 1.808.2.8)
   ACPI: Use dev->devfn instead of bridge->devfn to determine the pin when
         trying to derive a device's irq from its parent (Ville Syrjala)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/23 1.808.2.7)
   ACPI: Remove too-broad blacklist entries

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/22 1.808.2.6)
   ACPI: Rename acpi_power_off to acpi_power_off_device (Pavel Machek)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/22 1.808.2.5)
   ACPI: Restore ARB_DIS bit on resume from S1 (Eric Brunet)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/22 1.808.2.4)
   ACPI: Add needed exports for ACPI-based PCI Hot Plug (J.I. Lee)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/22 1.808.2.3)
   ACPI: Enable compilation using Intel compiler

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/22 1.808.2.2)
   ACPI: EC update
    - Move call to acpi_ec_query out of the interrupt handler. This will
      ensure that we do not try to acquire the Global Lock at interrupt
      level.
    - Get the handle for the ECDT.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/22 1.808.2.1)
   ACPI: Update to interpreter 20021022
    - Remove old code
    - Change some defines
    - Change Scope behavior


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
