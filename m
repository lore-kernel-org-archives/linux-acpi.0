From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI update
Date: Mon, 11 Nov 2002 17:12:19 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F6@orsmsx119.jf.intel.com>
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
To: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

This will update the following files:

 drivers/acpi/ac.c                  |   21 +---
 drivers/acpi/battery.c             |   21 +---
 drivers/acpi/bus.c                 |    1 
 drivers/acpi/button.c              |   19 +--
 drivers/acpi/dispatcher/dsmethod.c |    4 
 drivers/acpi/dispatcher/dswstate.c |    6 -
 drivers/acpi/ec.c                  |   31 ++----
 drivers/acpi/events/evevent.c      |    8 -
 drivers/acpi/events/evmisc.c       |    4 
 drivers/acpi/events/evxface.c      |    4 
 drivers/acpi/executer/exdump.c     |    3 
 drivers/acpi/executer/exfield.c    |  124 ++++++++++++++++++++++---
 drivers/acpi/executer/exfldio.c    |   37 +++++--
 drivers/acpi/executer/exoparg1.c   |   24 ++--
 drivers/acpi/executer/exoparg2.c   |    6 -
 drivers/acpi/executer/exoparg3.c   |    6 -
 drivers/acpi/executer/exprep.c     |   18 +--
 drivers/acpi/executer/exstore.c    |    6 -
 drivers/acpi/executer/exsystem.c   |   10 +-
 drivers/acpi/executer/exutils.c    |    4 
 drivers/acpi/fan.c                 |   25 ++---
 drivers/acpi/include/acconfig.h    |    8 +
 drivers/acpi/include/acdisasm.h    |    5 -
 drivers/acpi/include/acevents.h    |    4 
 drivers/acpi/include/acinterp.h    |    9 +
 drivers/acpi/include/aclocal.h     |    4 
 drivers/acpi/include/acpiosxf.h    |    2 
 drivers/acpi/include/acpixf.h      |    2 
 drivers/acpi/include/actypes.h     |    3 
 drivers/acpi/include/amlcode.h     |    5 -
 drivers/acpi/namespace/nsdump.c    |    4 
 drivers/acpi/namespace/nsobject.c  |   40 +++++---
 drivers/acpi/namespace/nsutils.c   |   10 +-
 drivers/acpi/namespace/nsxfeval.c  |   19 ++-
 drivers/acpi/osl.c                 |    4 
 drivers/acpi/power.c               |   13 --
 drivers/acpi/processor.c           |   26 ++---
 drivers/acpi/scan.c                |    2 
 drivers/acpi/tables/tbconvrt.c     |   26 ++---
 drivers/acpi/tables/tbxfroot.c     |    9 +
 drivers/acpi/thermal.c             |   26 ++---
 drivers/acpi/utilities/utmisc.c    |    4 
 42 files changed, 360 insertions(+), 247 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/11 1.859)
   ACPI: Do not compile code for EC unloading, because it cannot be unloaded
atm

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/11 1.858)
   ACPI: Make unload/reload of modules work properly w.r.t. /proc

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/11 1.856)
   ACPI: Interpreter update to 20021111 - Adds support for SMBus OpRegions

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/08 1.786.190.2)
   ACPI: Correctly init device struct, permissing proper unloading/reloading
         (John Cagle)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/07 1.786.188.2)
   ACPI: bus.c needed device.h included

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/07 1.786.188.1)
   ACPI: Interpreter update to fix mutex wait problem
   This changes the timeout param around the interpreter to a u16, so that
   ACPI_WAIT_FOREVER is equivalent to 0xFFFF, the value ASL expects to
   mean "wait forever".



-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
