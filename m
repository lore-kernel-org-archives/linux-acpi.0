From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Tue, 26 Nov 2002 17:51:01 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A554@orsmsx119.jf.intel.com>
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

(this doesn't include a fix for the interrupt = 0xFF thing, but there are a
bunch of other things that should get merged.)

Regards -- Andy

This will update the following files:

 drivers/acpi/ac.c                  |   57 +---
 drivers/acpi/button.c              |   45 +--
 drivers/acpi/dispatcher/dsmthdat.c |   49 ++-
 drivers/acpi/events/evevent.c      |   78 +++--
 drivers/acpi/events/evrgnini.c     |    7 
 drivers/acpi/include/acconfig.h    |    4 
 drivers/acpi/include/aclocal.h     |    5 
 drivers/acpi/include/acpiosxf.h    |    8 
 drivers/acpi/osl.c                 |   39 ++
 drivers/acpi/parser/psopcode.c     |    4 
 drivers/acpi/power.c               |   63 ++--
 drivers/acpi/processor.c           |  338 +++++++++++--------------
 drivers/acpi/sleep.c               |  100 +++----
 drivers/acpi/thermal.c             |  247 ++++++++----------
 drivers/acpi/toshiba_acpi.c        |  234 ++++++++++-------
 drivers/acpi/utilities/utcopy.c    |   64 +++-
 drivers/acpi/utilities/utmisc.c    |   17 -
 17 files changed, 706 insertions(+), 653 deletions(-)

through these ChangeSets:

<aris-YqEmrenMroyQb786VAuzj9i2O/JbrIOy@public.gmane.org> (02/11/23 1.842.45.7)
   o acpi: convert drivers/acpi/toshiba_acpi.c to seq_file

<aris-YqEmrenMroyQb786VAuzj9i2O/JbrIOy@public.gmane.org> (02/11/23 1.842.45.6)
   o acpi: convert drivers/acpi/thermal.c

<acme-KCZ47A4bww4P48s/oLjRZg@public.gmane.org> (02/11/23 1.842.45.5)
   o acpi/processor.o: fix up seq_file conversion, add missing comma

<aris-YqEmrenMroyQb786VAuzj9i2O/JbrIOy@public.gmane.org> (02/11/23 1.842.45.4)
   o acpi: convert drivers/acpi/sleep.c to seq_file

<aris-YqEmrenMroyQb786VAuzj9i2O/JbrIOy@public.gmane.org> (02/11/23 1.842.45.3)
   o acpi: convert drivers/acpi/processor.c to seq_file

<aris-YqEmrenMroyQb786VAuzj9i2O/JbrIOy@public.gmane.org> (02/11/23 1.842.45.2)
   o acpi: convert drivers/acpi/power.c to seq_file

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/22 1.842.44.2)
   ACPI: Fix IRQ assignment on Tiger (JI Lee)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/22 1.842.44.1)
   ACPI: Interpreter update to 20021122
     Fixed a problem with RefOf and named fields
     Fixed a protection fault involving Packages with Null/nested packages
     Fixed GPE initialization to handle a pathological case

<aris-YqEmrenMroyQb786VAuzj9i2O/JbrIOy@public.gmane.org> (02/11/15 1.805.15.3)
   o acpi: convert drivers/acpi/button.c to seq_file

<aris-YqEmrenMroyQb786VAuzj9i2O/JbrIOy@public.gmane.org> (02/11/13 1.805.15.1)
   drivers/acpi/ac.c: convert to seq_file


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
