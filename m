From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Wed, 2 Oct 2002 13:00:40 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEF7@orsmsx119.jf.intel.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi
<http://linux-acpi.bkbits.net/linux-acpi> 

This will update the following files:

 arch/i386/kernel/mpparse.c         |    6 +
 drivers/acpi/acpi_ksyms.c          |    4 -
 drivers/acpi/blacklist.c           |    2 
 drivers/acpi/dispatcher/dsfield.c  |   17 ++--
 drivers/acpi/dispatcher/dsobject.c |   24 +-----
 drivers/acpi/dispatcher/dsutils.c  |   16 +---
 drivers/acpi/dispatcher/dswload.c  |  133
+++++++++++++++++++------------------
 drivers/acpi/dispatcher/dswscope.c |    6 -
 drivers/acpi/events/evevent.c      |   16 ++--
 drivers/acpi/executer/exconvrt.c   |   15 ++--
 drivers/acpi/executer/excreate.c   |   65 ++++++++++++++----
 drivers/acpi/executer/exdump.c     |   10 ++
 drivers/acpi/executer/exoparg2.c   |   67 ++++++++++++++++--
 drivers/acpi/executer/exresnte.c   |   13 +++
 drivers/acpi/executer/exresop.c    |   92 ++++++++++++-------------
 drivers/acpi/executer/exstore.c    |    8 +-
 drivers/acpi/executer/exstorob.c   |   21 +++--
 drivers/acpi/include/acconfig.h    |    4 -
 drivers/acpi/include/acmacros.h    |    4 -
 drivers/acpi/include/acnamesp.h    |   10 ++
 drivers/acpi/include/acutils.h     |    2 
 drivers/acpi/namespace/nsdump.c    |   13 ++-
 drivers/acpi/namespace/nsutils.c   |   50 +++++++++++++
 drivers/acpi/osl.c                 |   19 +----
 drivers/acpi/pci_irq.c             |    6 +
 drivers/acpi/processor.c           |    3 
 drivers/acpi/sleep.c               |    2 
 drivers/acpi/tables/tbxface.c      |    4 -
 drivers/acpi/thermal.c             |   64 ++++++++++++++---
 drivers/acpi/utilities/utmisc.c    |    2 
 drivers/acpi/utils.c               |    2 
 31 files changed, 453 insertions(+), 247 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/02 1.593)
   ACPI: Interpreter update to 200201002
   - Fix problem where a store/copy of a string did not set string length
properly.
   - Fix ToString operator
   - Fix CopyObject not updating internal node type
   - Fix a memory leak during implicit operand source conversion
   - Enhanced error messages for namespace lookup problems
   - Revamped Alias support

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/01 1.590)
   ACPI: Initialize thermal driver's timer before it is used (Knut Neumann)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/01 1.589)
   ACPI: Add another cast to Bjoern's MADT walking fix to silence warning

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/01 1.588)
   ACPI: Allow handling negative celsius values (Kochi Takayoshi)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/01 1.587)
   ACPI: Fix thermal management and make trip points R/W (Pavel Machek)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/01 1.586)
   ACPI: Fix /proc/acpi/sleep (P. Christeas)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/01 1.585)
   ACPI: IA64 fixes (David Mosberger)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/01 1.584)
   ACPI: Fix reversed logic in blacklist code (Sergio Monteiro Basto)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/20 1.565.10.1)
   ACPI: Replace ACPI_DEBUG define with ACPI_DEBUG_OUTPUT (Dominik
Brodowski)




-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
