From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI followup patches
Date: Fri, 20 Sep 2002 13:16:51 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE9B@orsmsx119.jf.intel.com>
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
To: 'Linus Torvalds' <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, "'bzeeb=1p+UDdvUwrrk1uMJSBkQmQ@public.gmane.org'" <bzeeb-1p+UDdvUwrrk1uMJSBkQmQ@public.gmane.org>, "'bunk=cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org'" <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

This will update the following files:

 drivers/acpi/ac.c        |   14 +++++++-------
 drivers/acpi/battery.c   |   16 ++++++++--------
 drivers/acpi/button.c    |   14 +++++++-------
 drivers/acpi/fan.c       |   14 +++++++-------
 drivers/acpi/numa.c      |    1 +
 drivers/acpi/pci_bind.c  |    2 +-
 drivers/acpi/processor.c |   16 ++++++++--------
 drivers/acpi/thermal.c   |   24 ++++++++++++------------
 8 files changed, 51 insertions(+), 50 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/20 1.584)
   ACPI: Re-enable compilation of ACPI subordinate drivers as modules
   (Bjoern A. Zeeb)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/20 1.583)
   ACPI: Add include to provide PREFIX (Adrian Bunk)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/19 1.550.1.1)
   ACPI: change a non-critical debug message to a lower output level

Regards -- Andy

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
