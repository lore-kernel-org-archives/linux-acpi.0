From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Fri, 13 Dec 2002 14:39:37 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A598@orsmsx119.jf.intel.com>
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

Summary: Bugfixes, and the beginning of an effort to make the code look more
Linux-like.

This will update the following files:

 drivers/acpi/dispatcher/dsfield.c       |    6 -
 drivers/acpi/dispatcher/dsmthdat.c      |    2 
 drivers/acpi/dispatcher/dsobject.c      |   26 ++---
 drivers/acpi/dispatcher/dsutils.c       |    4 
 drivers/acpi/dispatcher/dswexec.c       |    9 +
 drivers/acpi/dispatcher/dswload.c       |    8 -
 drivers/acpi/dispatcher/dswstate.c      |    4 
 drivers/acpi/events/evgpe.c             |   20 ++--
 drivers/acpi/events/evmisc.c            |    2 
 drivers/acpi/executer/exconvrt.c        |   25 +++--
 drivers/acpi/executer/excreate.c        |    2 
 drivers/acpi/executer/exdump.c          |    8 -
 drivers/acpi/executer/exfield.c         |    2 
 drivers/acpi/executer/exfldio.c         |    2 
 drivers/acpi/executer/exmisc.c          |   12 +-
 drivers/acpi/executer/exmutex.c         |    2 
 drivers/acpi/executer/exnames.c         |   14 +-
 drivers/acpi/executer/exoparg2.c        |    2 
 drivers/acpi/executer/exresolv.c        |    2 
 drivers/acpi/executer/exstoren.c        |    4 
 drivers/acpi/executer/exstorob.c        |   14 +-
 drivers/acpi/executer/exutils.c         |    8 -
 drivers/acpi/hardware/hwacpi.c          |    2 
 drivers/acpi/hardware/hwregs.c          |   40 ++++----
 drivers/acpi/include/acconfig.h         |    4 
 drivers/acpi/include/acdebug.h          |   96 ++++++++++----------
 drivers/acpi/include/acexcep.h          |   12 +-
 drivers/acpi/include/acglobal.h         |   22 ++--
 drivers/acpi/include/acinterp.h         |   21 ++--
 drivers/acpi/include/aclocal.h          |   36 +++----
 drivers/acpi/include/acmacros.h         |    8 -
 drivers/acpi/include/acnamesp.h         |   38 +++----
 drivers/acpi/include/acobject.h         |    4 
 drivers/acpi/include/acparser.h         |   12 +-
 drivers/acpi/include/acpiosxf.h         |   12 +-
 drivers/acpi/include/acpixf.h           |    2 
 drivers/acpi/include/acstruct.h         |    4 
 drivers/acpi/include/actables.h         |   10 +-
 drivers/acpi/include/actbl.h            |   20 ++--
 drivers/acpi/include/actbl1.h           |    4 
 drivers/acpi/include/actbl2.h           |    4 
 drivers/acpi/include/actypes.h          |   12 +-
 drivers/acpi/include/acutils.h          |   96 ++++++++++----------
 drivers/acpi/include/platform/aclinux.h |   16 +--
 drivers/acpi/namespace/nsaccess.c       |    6 -
 drivers/acpi/namespace/nsalloc.c        |    2 
 drivers/acpi/namespace/nsdump.c         |    4 
 drivers/acpi/namespace/nseval.c         |   10 +-
 drivers/acpi/namespace/nsinit.c         |    4 
 drivers/acpi/namespace/nsnames.c        |    8 -
 drivers/acpi/namespace/nsobject.c       |    2 
 drivers/acpi/namespace/nsparse.c        |    2 
 drivers/acpi/namespace/nssearch.c       |    4 
 drivers/acpi/namespace/nsutils.c        |   30 +++---
 drivers/acpi/namespace/nsxfeval.c       |    4 
 drivers/acpi/namespace/nsxfname.c       |    4 
 drivers/acpi/parser/psargs.c            |    8 -
 drivers/acpi/parser/psopcode.c          |    4 
 drivers/acpi/parser/psparse.c           |    2 
 drivers/acpi/resources/rsaddr.c         |   20 ++--
 drivers/acpi/resources/rscreate.c       |    2 
 drivers/acpi/resources/rsirq.c          |    8 -
 drivers/acpi/sleep.c                    |   12 +-
 drivers/acpi/tables/tbconvrt.c          |   22 ++--
 drivers/acpi/tables/tbget.c             |    2 
 drivers/acpi/tables/tbgetall.c          |    8 -
 drivers/acpi/tables/tbinstal.c          |    4 
 drivers/acpi/tables/tbrsdt.c            |    6 -
 drivers/acpi/tables/tbxfroot.c          |   16 +--
 drivers/acpi/utilities/utalloc.c        |   22 +---
 drivers/acpi/utilities/utcopy.c         |    4 
 drivers/acpi/utilities/utdebug.c        |    4 
 drivers/acpi/utilities/utdelete.c       |   10 +-
 drivers/acpi/utilities/uteval.c         |    6 -
 drivers/acpi/utilities/utglobal.c       |   32 +++---
 drivers/acpi/utilities/utinit.c         |   16 +--
 drivers/acpi/utilities/utmisc.c         |   20 ++--
 drivers/acpi/utilities/utobject.c       |    6 -
 78 files changed, 494 insertions(+), 473 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/13 1.868)
   ACPI: Fix write-related /proc entry functionality

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/12/12 1.867)
   ACPI: update to 20021212
    - remove NATIVE_CHAR typedef
    - remove ACPI_{GET,VALID}_ADDRESS macros
    - fix memory corruption in deletion of a static AML buffer
    - fix fault caused by 0-length AML
    - fix user-buffer overwrite/corruption of buffer is too small
    - fix buffer-to-string conversion


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
