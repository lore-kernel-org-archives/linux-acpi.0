From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Fri, 28 Mar 2003 15:15:20 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96D8C@orsmsx401.jf.intel.com>
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

Thanks -- Andy

This will update the following files:

 arch/i386/kernel/acpi/boot.c      |    1 
 drivers/acpi/Kconfig              |    2 
 drivers/acpi/acpi_ksyms.c         |    2 
 drivers/acpi/ec.c                 |   21 
 drivers/acpi/events/evevent.c     |   10 
 drivers/acpi/events/evgpe.c       |  164 ++++--
 drivers/acpi/events/evgpeblk.c    |  446 ++++++++++++++++--
 drivers/acpi/events/evmisc.c      |   84 +--
 drivers/acpi/events/evsci.c       |   64 ++
 drivers/acpi/events/evxface.c     |   59 +-
 drivers/acpi/events/evxfevnt.c    |  627 ++++++++++++++++++--------
 drivers/acpi/hardware/hwgpe.c     |  268 ++++++++---
 drivers/acpi/hardware/hwregs.c    |   16 
 drivers/acpi/namespace/nsaccess.c |    5 
 drivers/acpi/namespace/nswalk.c   |   13 
 drivers/acpi/osl.c                |  110 ++++
 drivers/acpi/processor.c          |    4 
 drivers/acpi/resources/rsxface.c  |   55 +-
 drivers/acpi/tables/tbgetall.c    |    2 
 drivers/acpi/utilities/utdelete.c |    9 
 drivers/acpi/utilities/utglobal.c |    4 
 drivers/acpi/utilities/utinit.c   |   26 -
 drivers/acpi/utilities/utmisc.c   |    4 
 include/acpi/acconfig.h           |    4 
 include/acpi/acevents.h           |   31 +
 include/acpi/acglobal.h           |    4 
 include/acpi/achware.h            |   12 
 include/acpi/aclocal.h            |   49 +-
 include/acpi/acobject.h           |    1 
 include/acpi/acpiosxf.h           |   37 -
 include/acpi/acpixf.h             |   53 +-
 include/acpi/actypes.h            |   26 -
 32 files changed, 1614 insertions(+), 599 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/03/28 1.996)
   ACPI: Interpreter update to 20030328
   - Add APIs to add and remove GPE Block devices
   - Clean up problems with semaphore acquisition from the ISR

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/03/24 1.889.1.219)
   ACPI: Fix compile issue (reported by Brendan Burns and Christian
Neumair)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/03/24 1.889.1.218)
   ACPI: Disable NUMA support on x86-64 (Andi Kleen)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/03/21 1.889.1.215)
   ACPI: Interpreter update to 20030321
   - Walking a list in the ISR is now required, so add a spinlock
   - Add core support for GPE Block devices
   - Change GPE interface accordingly

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/03/19 1.889.1.214)
   ACPI: Fix off by 1 error in C2/3 detection (Ducrot Bruno)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/03/12 1.889.1.212)
   ACPI: Fix GPE 1 handling (Takayoshi Kochi)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/03/05 1.889.301.1)
   ACPI: Re-enable build w/o CONFIG_PCI (Pavel Machek)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
