From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI fixes
Date: Fri, 1 Nov 2002 13:01:08 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A49A@orsmsx119.jf.intel.com>
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

Bug fixes, mostly for bugs introduced recently ;-)

-- Andy

This will update the following files:

 drivers/acpi/events/evxfregn.c   |    6 +-
 drivers/acpi/include/acconfig.h  |    4 -
 drivers/acpi/include/acparser.h  |    6 +-
 drivers/acpi/namespace/nsalloc.c |   23 +++++++
 drivers/acpi/osl.c               |    5 +
 drivers/acpi/parser/psargs.c     |   79 +++++++++++++++++++-------
 drivers/acpi/parser/psparse.c    |   80 +++++++++++++--------------
 drivers/acpi/processor.c         |    3 +
 drivers/acpi/scan.c              |   29 ++++-----
 drivers/acpi/tables/tbutils.c    |    6 +-
 10 files changed, 150 insertions(+), 91 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/01 1.864)
   ACPI: Interpreter update to (20021101)
   - Fix namespace ordering, which was causing breakage
   - Enhance some error messages

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/31 1.844.13.2)
   ACPI: Ensure we don't try to sleep when we shouldn't

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/10/31 1.844.13.1)
   ACPI:
   - Clean up debug-only code
   - Fix typo
   - Correct walking of namespace, to prevent disappearance of processor and
     thermal zone objects
   - Fix button add calls to have the right handle (i.e. none)
   - Prevent spurious cpufreq error


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
