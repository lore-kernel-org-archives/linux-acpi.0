From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Mon, 14 Jul 2003 13:20:04 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE8A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: torvalds-3NddpPZAyC0@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

Lots of good stuff fixed, in preparation for 2.6.

This will update the following files:

 arch/i386/kernel/setup.c          |    4 -
 drivers/acpi/executer/exutils.c   |    2=20
 drivers/acpi/hardware/hwregs.c    |   21 ++---
 drivers/acpi/osl.c                |   14 ++-
 drivers/acpi/processor.c          |    4 -
 drivers/acpi/tables.c             |   99 ++++++++++++++------------
 drivers/acpi/tables/tbconvrt.c    |    6 -
 drivers/acpi/tables/tbget.c       |    4 -
 drivers/acpi/tables/tbinstal.c    |   42 +++++++----
 drivers/acpi/tables/tbrsdt.c      |    2=20
 drivers/acpi/tables/tbxfroot.c    |    6 -
 drivers/acpi/thermal.c            |   12 +--
 drivers/acpi/utilities/utglobal.c |    6 -
 include/acpi/acconfig.h           |    2=20
 include/acpi/platform/acenv.h     |    6 +
 15 files changed, 131 insertions(+), 99 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/14 1.1463)
   ACPI: Update version, and other trivialities

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/14 1.1461)
   ACPI: Dynamically allocate SDT list (suggested by Andi Kleen)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1460)
   ACPI: Parse SSDTs in order discovered, as opposed to reverse order
(Hrvoje Habjanic)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1459)
   ACPI: Fixes from FreeBSD and NetBSD. (Frank van der Linden, Thomas
Klausner,
   Nate Lawson)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1458)
   ACPI: proc function return value cleanups (Andi Kleen)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1457)
   ACPI: Correctly handle NMI watchdog during long stalls (Andrew
Morton)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/22 1.1310.61.1)
   ACPI: make it so acpismp=3Dforce works (reported by Andrew Morton)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
