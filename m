From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates
Date: Mon, 3 Feb 2003 11:23:30 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A148@orsmsx401.jf.intel.com>
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

diffstat is big because we finally got with the program and moved
headers to include/acpi.

Thanks -- Regards -- Andy

This will update the following files:

 drivers/acpi/acpi_bus.h                 |  312 -----
 drivers/acpi/acpi_drivers.h             |  163 --
 drivers/acpi/include/acconfig.h         |  188 ---
 drivers/acpi/include/acdebug.h          |  430 -------
 drivers/acpi/include/acdispat.h         |  494 --------
 drivers/acpi/include/acevents.h         |  221 ---
 drivers/acpi/include/acexcep.h          |  283 ----
 drivers/acpi/include/acglobal.h         |  298 -----
 drivers/acpi/include/achware.h          |  154 --
 drivers/acpi/include/acinterp.h         |  717 ------------
 drivers/acpi/include/aclocal.h          |  953 ----------------
 drivers/acpi/include/acmacros.h         |  578 ---------
 drivers/acpi/include/acnamesp.h         |  489 --------
 drivers/acpi/include/acobject.h         |  473 -------
 drivers/acpi/include/acoutput.h         |  166 --
 drivers/acpi/include/acparser.h         |  328 -----
 drivers/acpi/include/acpi.h             |   50 
 drivers/acpi/include/acpiosxf.h         |  337 -----
 drivers/acpi/include/acpixf.h           |  387 ------
 drivers/acpi/include/acresrc.h          |  366 ------
 drivers/acpi/include/acstruct.h         |  183 ---
 drivers/acpi/include/actables.h         |  218 ---
 drivers/acpi/include/actbl.h            |  208 ---
 drivers/acpi/include/actbl1.h           |  117 -
 drivers/acpi/include/actbl2.h           |  182 ---
 drivers/acpi/include/actbl71.h          |  144 --
 drivers/acpi/include/actypes.h          | 1189 --------------------
 drivers/acpi/include/acutils.h          |  815 -------------
 drivers/acpi/include/amlcode.h          |  477 --------
 drivers/acpi/include/amlresrc.h         |  310 -----
 drivers/acpi/include/platform/acenv.h   |  344 -----
 drivers/acpi/include/platform/acgcc.h   |   40 
 drivers/acpi/include/platform/aclinux.h |   72 -
 include/acpi/amlresrc.h                 |  310 -----
 arch/i386/Kconfig                       |   11 
 arch/i386/kernel/acpi.c                 |   22 
 arch/i386/kernel/acpi_wakeup.S          |   18 
 arch/i386/kernel/cpu/cpufreq/Makefile   |    7 
 arch/i386/kernel/cpu/cpufreq/acpi.c     |  696 +++++++++++
 arch/i386/kernel/setup.c                |    2 
 drivers/acpi/Kconfig                    |    8 
 drivers/acpi/Makefile                   |    2 
 drivers/acpi/ac.c                       |    1 
 drivers/acpi/acpi_bus.h                 |    2 
 drivers/acpi/acpi_ksyms.c               |    2 
 drivers/acpi/battery.c                  |    1 
 drivers/acpi/button.c                   |    1 
 drivers/acpi/dispatcher/dsinit.c        |    3 
 drivers/acpi/ec.c                       |    1 
 drivers/acpi/fan.c                      |    1 
 drivers/acpi/hardware/hwtimer.c         |    5 
 drivers/acpi/namespace/nsload.c         |    6 
 drivers/acpi/osl.c                      |    2 
 drivers/acpi/power.c                    |    1 
 drivers/acpi/processor.c                |  893 ---------------
 drivers/acpi/resources/rscalc.c         |    2 
 drivers/acpi/scan.c                     |    2 
 drivers/acpi/tables.c                   |    3 
 drivers/acpi/tables/tbinstal.c          |    8 
 drivers/acpi/thermal.c                  |   25 
 drivers/acpi/toshiba_acpi.c             |   24 
 drivers/acpi/utilities/utcopy.c         |    4 
 drivers/hotplug/acpiphp.h               |    3 
 include/acpi/acconfig.h                 |  190 +++
 include/acpi/acdebug.h                  |  462 +++++++
 include/acpi/acdispat.h                 |  494 ++++++++
 include/acpi/acevents.h                 |  221 +++
 include/acpi/acexcep.h                  |  283 ++++
 include/acpi/acglobal.h                 |  298 +++++
 include/acpi/achware.h                  |  154 ++
 include/acpi/acinterp.h                 |  717 ++++++++++++
 include/acpi/aclocal.h                  |  953 ++++++++++++++++
 include/acpi/acmacros.h                 |  578 +++++++++
 include/acpi/acnamesp.h                 |  489 ++++++++
 include/acpi/acobject.h                 |  473 +++++++
 include/acpi/acoutput.h                 |  166 ++
 include/acpi/acparser.h                 |  328 +++++
 include/acpi/acpi.h                     |   50 
 include/acpi/acpi_bus.h                 |  312 +++++
 include/acpi/acpi_drivers.h             |  163 ++
 include/acpi/acpiosxf.h                 |  346 +++++
 include/acpi/acpixf.h                   |  387 ++++++
 include/acpi/acresrc.h                  |  366 ++++++
 include/acpi/acstruct.h                 |  183 +++
 include/acpi/actables.h                 |  218 +++
 include/acpi/actbl.h                    |  210 +++
 include/acpi/actbl1.h                   |  117 +
 include/acpi/actbl2.h                   |  182 +++
 include/acpi/actbl71.h                  |  144 ++
 include/acpi/actypes.h                  | 1189 ++++++++++++++++++++
 include/acpi/acutils.h                  |  815 +++++++++++++
 include/acpi/amlcode.h                  |  477 ++++++++
 include/acpi/amlresrc.h                 |  310 +++++
 include/acpi/platform/acenv.h           |  344 +++++
 include/acpi/platform/acgcc.h           |   40 
 include/acpi/platform/aclinux.h         |   72 +
 include/acpi/processor.h                |  141 ++
 include/linux/acpi.h                    |   11 
 98 files changed, 12715 insertions(+), 12920 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/23 1.960)
   ACPI: update to 20030122

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/21 1.959)
   ACPI: Handle P_BLK lengths shorter than 6 more gracefully

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/20 1.958)
   ACPI: This makes it possible to select method of bios restoring after
S3
   resume. [=> no more ugly ifdefs] (Pavel Machek)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/20 1.957)
   ACPI: Make proc write interfaces work (Pavel Machek)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/20 1.956)
   ACPI: Properly init/clean up in cpufreq/acpi (Dominik Brodowski)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/20 1.955)
   ACPI: Remove include of unused header (Adrian Bunk)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/20 1.954)
   ACPI: acpiphp.h includes both linux/acpi.h and acpi_bus.h. Since the
   former now also includes the latter, acpiphp.h only needs the one,
now.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/20 1.953)
   CPUFREQ: Break out ACPI Perf code into its own module, under cpufreq
   (Dominik Brodowski)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/20 1.952)
   ACPI: Move more headers to include/acpi, and delete an unused header.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/17 1.951)
   ACPI: Move drivers/acpi/include directory to include/acpi

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/01/15 1.914.9.1)
   ACPI: Boot functions don't use cmdline, so don't pass it around




-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
