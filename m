From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI update
Date: Mon, 12 May 2003 11:37:13 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96E6F@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
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
To: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

This will update the following files:

 drivers/acpi/dispatcher/dsinit.c   |    4 
 drivers/acpi/dispatcher/dsopcode.c |    6 
 drivers/acpi/ec.c                  |   22 -
 drivers/acpi/events/evgpe.c        |    4 
 drivers/acpi/events/evgpeblk.c     |    4 
 drivers/acpi/events/evmisc.c       |   24 +-
 drivers/acpi/events/evregion.c     |  279 +++++++++++--------------
 drivers/acpi/events/evrgnini.c     |  166 ++++++++------
 drivers/acpi/events/evxface.c      |   62 ++---
 drivers/acpi/events/evxfevnt.c     |    4 
 drivers/acpi/events/evxfregn.c     |   96 +++++---
 drivers/acpi/executer/exconfig.c   |    8 
 drivers/acpi/executer/exdump.c     |   38 +--
 drivers/acpi/hardware/hwgpe.c      |   24 +-
 drivers/acpi/hardware/hwregs.c     |  120 +++++-----
 drivers/acpi/hardware/hwtimer.c    |    2 
 drivers/acpi/namespace/nsalloc.c   |   40 +++
 drivers/acpi/namespace/nsload.c    |   18 -
 drivers/acpi/namespace/nsparse.c   |    3 
 drivers/acpi/namespace/nsutils.c   |   21 -
 drivers/acpi/osl.c                 |    2 
 drivers/acpi/parser/pswalk.c       |    2 
 drivers/acpi/parser/psxface.c      |    2 
 drivers/acpi/resources/rsxface.c   |   12 -
 drivers/acpi/scan.c                |    2 
 drivers/acpi/tables/tbconvrt.c     |  114 +++++++---
 drivers/acpi/tables/tbget.c        |   14 -
 drivers/acpi/tables/tbgetall.c     |    2 
 drivers/acpi/tables/tbinstal.c     |  195 ++++++-----------
 drivers/acpi/tables/tbutils.c      |   17 -
 drivers/acpi/tables/tbxface.c      |   20 -
 drivers/acpi/utilities/utdelete.c  |   71 ++----
 drivers/acpi/utilities/utglobal.c  |   36 +--
 drivers/acpi/utilities/utmisc.c    |   46 ++--
 drivers/acpi/utilities/utxface.c   |   64 +++--
 include/acpi/acconfig.h            |    4 
 include/acpi/acevents.h            |    2 
 include/acpi/acexcep.h             |    6 
 include/acpi/acglobal.h            |   20 -
 include/acpi/achware.h             |    6 
 include/acpi/aclocal.h             |   19 -
 include/acpi/acmacros.h            |   20 -
 include/acpi/acnamesp.h            |    5 
 include/acpi/acobject.h            |   12 -
 include/acpi/acpiosxf.h            |    4 
 include/acpi/actables.h            |   10 
 include/acpi/actypes.h             |    4 
 47 files changed, 848 insertions(+), 808 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/05/12 1.1083.3.4)
   ACPI: Interpreter update to 20030509
   Changed the subsystem initialization sequence to hold off
installation of
   address space handlers until the hardware has been initialized and
the
   system has entered ACPI mode.  This is because the installation of
space
   handlers can cause _REG methods to be run.  Previously, the _REG
methods
   could potentially be run before ACPI mode was enabled.
   
   Fixed some memory leak issues related to address space handler and
notify
   handler installation.  There were some problems with the reference
count
   mechanism caused by the fact that the handler objects are shared
across
   several namespace objects.
   
   Fixed a reported problem where reference counts within the namespace
were
   not properly updated when named objects created by method execution
were
   deleted.
   
   Fixed a reported problem where multiple SSDTs caused a deletion issue
   during subsystem termination.  Restructured the table data structures
   to simplify the linked lists and the related code.
   
   Fixed a problem where the table ID associated with secondary tables
(SSDTs)
   was not being propagated into the namespace objects created by those
   tables.  This would only present a problem for tables that are
unloaded
   at run-time, however.
   
   Updated AcpiOsReadable and AcpiOsWritable to use the ACPI_SIZE type
as
   the length parameter (instead of UINT32).
   
   Solved a long-standing problem where an ALREADY_EXISTS error appears
on
   various systems.  This problem could happen when there are multiple
   PCI_Config operation regions under a single PCI root bus.  This
doesnt
   happen very frequently, but there are some systems that do this in
the
   ASL.
   
   Fixed a reported problem where the internal DeleteNode function was
   incorrectly handling the case where a namespace node was the first in
   the parents child list, and had additional peers (not the only child,
   but first in the list of children.)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/05/12 1.1083.3.3)
   ACPI: Allow ":" in OS override string (Ducrot Bruno)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/05/12 1.1083.3.2)
   ACPI: kobject fix (Greg KH)
   Here's a small patch that fixes the logic of the kobject creation and
   registration in the acpi code (since we use kobject_init(), we need
to
   use kobject_add(), not kobject_register() to add the kobject to the
   kernel systems).

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/04/24 1.1042.42.4)
   ACPI: Update to 20030424
   - Remove an unused parameter from lowlevel read/write functions
   - FADT initialization cleanups


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
