From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI update
Date: Fri, 28 Feb 2003 13:07:47 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8471380FC@orsmsx401.jf.intel.com>
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

This will update the following files:

 Documentation/kernel-parameters.txt |    8 
 arch/i386/kernel/acpi/wakeup.S      |   25 +
 arch/i386/kernel/setup.c            |    6 
 drivers/acpi/Kconfig                |    1 
 drivers/acpi/acpi_ksyms.c           |    2 
 drivers/acpi/ec.c                   |   73 +--
 drivers/acpi/events/Makefile        |    2 
 drivers/acpi/events/evevent.c       |   12 
 drivers/acpi/events/evgpe.c         |  581 ++++--------------------
 drivers/acpi/events/evgpeblk.c      |  545 ++++++++++++++++++++++
 drivers/acpi/events/evmisc.c        |  114 ----
 drivers/acpi/events/evsci.c         |   18 
 drivers/acpi/events/evxface.c       |   34 -
 drivers/acpi/events/evxfevnt.c      |   27 -
 drivers/acpi/hardware/hwgpe.c       |  167 +++---
 drivers/acpi/hardware/hwregs.c      |   13 
 drivers/acpi/hardware/hwsleep.c     |   65 ++
 drivers/acpi/osl.c                  |   41 +
 drivers/acpi/pci_link.c             |  151 +++---
 drivers/acpi/processor.c            |   25 -
 drivers/acpi/resources/rsutils.c    |   54 ++
 drivers/acpi/resources/rsxface.c    |  145 +++++
 drivers/acpi/sleep/main.c           |   31 +
 drivers/acpi/sleep/proc.c           |    5 
 drivers/acpi/tables.c               |   46 +
 drivers/acpi/tables/tbconvrt.c      |   10 
 drivers/acpi/utilities/utcopy.c     |    8 
 drivers/acpi/utilities/utglobal.c   |    6 
 drivers/hotplug/acpiphp_glue.c      |  170 +------
 include/acpi/acconfig.h             |    2 
 include/acpi/acdebug.h              |    7 
 include/acpi/acevents.h             |   18 
 include/acpi/acglobal.h             |   17 
 include/acpi/achware.h              |   14 
 include/acpi/aclocal.h              |   47 -
 include/acpi/acpixf.h               |   21 
 include/acpi/acresrc.h              |    6 
 include/acpi/acutils.h              |    2 
 include/linux/suspend.h             |    1 
 39 files changed, 1458 insertions(+), 1062 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/28 1.1117.2.7)
   ACPI: Update version to 20030228

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/28 1.1117.2.6)
   ACPI: S3 fixes (Ole Rohne)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/27 1.1117.2.5)
   ACPI: Update ACPI PHP driver with to use new acpi_walk_resource API
   (Bjorn Helgaas)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/27 1.1117.2.4)
   ACPI: Add S4BIOS support (Pavel Machek)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/27 1.1117.2.3)
   ACPI: Modify drivers to use new acpi_walk_resource API (Bjorn
Helgaas)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/27 1.1117.2.2)
   ACPI: Interpreter update
     - Add acpi_walk_resource support (Bjorn Helgaas)
     - Add S4BIOS support (Pavel Machek)
     - Rewrite GPE code to deal with future GPE block devices
     - Fix a bug that caused long delays when receiving SCIs
     - Fix a bug that causes oopses when battery strings are ""

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/27 1.1087.1.7)
   ACPI: Add new file for GPE code

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/27 1.1087.1.6)
   ACPI: Add S4BIOS support (Pavel Machek)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/26 1.1087.1.5)
   ACPI: Map in entire table before performing checksum (John Stultz)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/26 1.1087.1.4)
   ACPI: Expand the mem= cmdline to allow the specification of reserved
and
   ACPI DATA blocks (Pavel Machek)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/26 1.1087.1.3)
   ACPI: Never use ACPI on VISWS

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/26 1.1087.1.2)
   ACPI: Fix derive_pci_id (Ducrot Bruno, Alvaro Lopez)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/19 1.990.7.2)
   ACPI: Revert a change that allowed P_BLK lengths to be 4 or 5. This
is causing
   us to think that some systems support C2 when they really don't.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/02/19 1.990.7.1)
   ACPI: Do not count processor objects for non-present CPUs
   (Thanks to Dominik Brodowski)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
