From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Mon, 18 Nov 2002 17:38:04 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A51A@orsmsx119.jf.intel.com>
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

 drivers/acpi/dispatcher/dsutils.c |   41 +++++++
 drivers/acpi/dispatcher/dswexec.c |   16 --
 drivers/acpi/events/evmisc.c      |    9 -
 drivers/acpi/executer/exconvrt.c  |  146 +++++++++++---------------
 drivers/acpi/executer/exfield.c   |   53 ---------
 drivers/acpi/executer/exmisc.c    |   79 +++-----------
 drivers/acpi/executer/exoparg1.c  |   10 -
 drivers/acpi/executer/exoparg2.c  |   50 ++------
 drivers/acpi/executer/exresnte.c  |    6 -
 drivers/acpi/executer/exresop.c   |   26 ----
 drivers/acpi/include/acconfig.h   |    4 
 drivers/acpi/include/acdispat.h   |    6 -
 drivers/acpi/include/acutils.h    |    6 -
 drivers/acpi/namespace/nseval.c   |    4 
 drivers/acpi/namespace/nsinit.c   |    4 
 drivers/acpi/osl.c                |   27 ++--
 drivers/acpi/parser/psparse.c     |   18 +--
 drivers/acpi/sleep.c              |    2 
 drivers/acpi/utilities/utobject.c |   69 +++++++++++-
 19 files changed, 263 insertions(+), 313 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/15 1.805.12.6)
   ACPI: Interpreter fixes
     Fixed memory leak in method argument resolution
     Fixed Index() operator to work properly with a target operand
     Fixed attempted double delete in the Index() code
     Code size improvements
     Improved debug/error messages and levels
     Fixed a problem with premature deletion of a buffer object

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/15 1.805.12.5)
   ACPI: fix debug print levels, and use down() instead of
down_interruptible(),
     and some whitespace.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/11/14 1.805.12.3)
   ACPI: Fix compilation error when CONFIG_SOFTWARE_SUSPEND is not set
(Shawn Starr)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
