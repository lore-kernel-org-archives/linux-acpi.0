From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI update
Date: Wed, 23 Apr 2003 11:48:36 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96E0A@orsmsx401.jf.intel.com>
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
To: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

This will update the following files:

 arch/i386/kernel/mpparse.c         |   12 -
 drivers/acpi/dispatcher/dsfield.c  |   12 -
 drivers/acpi/dispatcher/dsmthdat.c |    8 
 drivers/acpi/dispatcher/dsobject.c |    2 
 drivers/acpi/dispatcher/dswexec.c  |    2 
 drivers/acpi/events/evgpe.c        |    2 
 drivers/acpi/events/evgpeblk.c     |   43 ++--
 drivers/acpi/events/evregion.c     |    5 
 drivers/acpi/events/evxfregn.c     |   81 +++-----
 drivers/acpi/executer/exfldio.c    |   55 +++--
 drivers/acpi/executer/exregion.c   |   11 -
 drivers/acpi/hardware/hwacpi.c     |    4 
 drivers/acpi/hardware/hwgpe.c      |    4 
 drivers/acpi/hardware/hwregs.c     |    6 
 drivers/acpi/hardware/hwsleep.c    |   11 -
 drivers/acpi/namespace/nsaccess.c  |    2 
 drivers/acpi/namespace/nsnames.c   |    2 
 drivers/acpi/namespace/nsutils.c   |   35 ++-
 drivers/acpi/namespace/nsxfeval.c  |    4 
 drivers/acpi/osl.c                 |   12 -
 drivers/acpi/parser/psargs.c       |   12 -
 drivers/acpi/resources/rsaddr.c    |  104 +++--------
 drivers/acpi/resources/rscalc.c    |   12 -
 drivers/acpi/resources/rsio.c      |   12 -
 drivers/acpi/resources/rsirq.c     |   12 -
 drivers/acpi/resources/rsmemory.c  |   56 ++---
 drivers/acpi/resources/rsmisc.c    |    4 
 drivers/acpi/resources/rsxface.c   |   34 +--
 drivers/acpi/tables/tbutils.c      |    2 
 drivers/acpi/utilities/utdebug.c   |   12 -
 drivers/acpi/utilities/utmisc.c    |    2 
 include/acpi/acconfig.h            |   48 ++---
 include/acpi/acinterp.h            |    6 
 include/acpi/aclocal.h             |   37 +--
 include/acpi/acmacros.h            |  235 ++++++++++++++++++-------
 include/acpi/acpiosxf.h            |    8 
 include/acpi/actbl.h               |   10 -
 include/acpi/actypes.h             |    6 
 include/linux/acpi.h               |    1 
 39 files changed, 509 insertions(+), 417 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/04/23 1.1182)
   ACPI: Indicate whether we handled the interrupt or not

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/04/23 1.971.109.3)
   ACPI: Add missing include

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/04/18 1.971.109.2)
   ACPI: Fix link devices on SMP systems (Dan Zink)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/04/18 1.971.109.1)
   ACPI: interpreter update to 20030418
   - Fix for big-endian arcitectures


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
