From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BKPATCH] ACPI for 2.4
Date: 28 Oct 2004 05:33:21 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098955997.5402.122.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/24-latest-release

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/24-latest-release/acpi-20040326-24-latest-release.diff.gz

This will update the following files:

 arch/i386/kernel/apic.c           |    6 
 arch/i386/kernel/dmi_scan.c       |   40 ------
 arch/i386/kernel/mpparse.c        |    2 
 drivers/acpi/Makefile             |    2 
 drivers/acpi/bus.c                |   39 +++++-
 drivers/acpi/events/evmisc.c      |    2 
 drivers/acpi/motherboard.c        |  159 ++++++++++++++++++++++++++
 drivers/acpi/osl.c                |    6 
 drivers/acpi/utilities/utglobal.c |    6 
 include/acpi/acglobal.h           |   37 ++++--
 include/acpi/acpi_drivers.h       |    3 
 include/asm-i386/mpspec.h         |    1 
 init/main.c                       |    6 
 13 files changed, 246 insertions(+), 63 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/10/13 1.1458.1.4)
   [ACPI] If BIOS disabled the LAPIC, believe it by default.
   "lapic" is available to force enabling the LAPIC
   in the event you know more than your BIOS vendor.
   http://bugzilla.kernel.org/show_bug.cgi?id=3238

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/08/25 1.1458.1.3)
   [ACPI] build fix

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/08/24 1.1458.1.2)
   [ACPI] fix build warnings

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/08/24 1.1458.1.1)
   [ACPI] Enter ACPI mode earlier
   Fixes two common boot failures due to buggy SMM BIOS code
   
   SMP boot crash if SMI_CMD=ACPI written from CPU1
   http://bugzilla.kernel.org/show_bug.cgi?id=2941
   
   laptop crash due to LAPIC timer before SMI_CMD=ACPI
   http://bugzilla.kernel.org/show_bug.cgi?id=1269

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/08/13 1.1458)
   set acpi_gbl_leave_wake_gpes_disabled to FALSE for 2.4
   because it would take a backport of big 2.6 changes to make
   this code work and 2.4 doesn't support suspend/resume anyway.

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/08/13 1.1457)
   [ACPI] boot option fixes from 2.6
   "acpi_serialize" "acpi_wake_gpes_always_on" "acpi_osi="
   http://bugzilla.kernel.org/show_bug.cgi?id=2534

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/06/24 1.1359.6.29)
   [ACPI] reserve IOPORTS for ACPI (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=2641






-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
