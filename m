From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BKPATCH] ACPI for 2.4
Date: 06 Mar 2004 01:32:42 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078554761.12998.3197.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.26/acpi-20040220-2.4.26.diff.gz

This will update the following files:

 Documentation/Configure.help        |    8 --
 Documentation/kernel-parameters.txt |    2 
 MAINTAINERS                         |    2 
 arch/i386/kernel/acpi.c             |    9 +--
 arch/i386/kernel/mpparse.c          |   11 ++--
 arch/i386/kernel/setup.c            |    5 +
 arch/x86_64/kernel/acpi.c           |   10 +--
 arch/x86_64/kernel/e820.c           |    6 ++
 arch/x86_64/kernel/mpparse.c        |   11 ++--
 drivers/acpi/executer/exfldio.c     |    7 +-
 drivers/acpi/hardware/hwgpe.c       |    8 ++
 drivers/acpi/hardware/hwregs.c      |    6 +-
 drivers/acpi/hardware/hwsleep.c     |   66 +++++++++++++++++++++---
 drivers/acpi/namespace/nseval.c     |    4 -
 drivers/acpi/namespace/nsutils.c    |    6 +-
 drivers/acpi/namespace/nsxfname.c   |    7 ++
 drivers/acpi/pci_link.c             |    2 
 drivers/acpi/resources/rsxface.c    |   18 ++++++
 drivers/acpi/system.c               |   10 ++-
 drivers/acpi/utilities/uteval.c     |   60 +++++++++++++++++++++
 drivers/acpi/utilities/utglobal.c   |    7 ++
 include/acpi/acconfig.h             |    2 
 include/acpi/acglobal.h             |   25 ++++-----
 include/acpi/actypes.h              |    3 -
 include/acpi/acutils.h              |    4 +
 include/asm-i386/acpi.h             |    1 
 include/asm-ia64/acpi.h             |    2 
 include/asm-x86_64/acpi.h           |    1 
 28 files changed, 233 insertions(+), 70 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/06 1.1331)
   [ACPI] fix ia64 build error (Bjorn Helgaas)

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/02/27 1.1063.46.78)
   [ACPI] ACPICA 20040220 from Bob Moore
   
   Implemented execution of _SxD methods for Device objects in the
   GetObjectInfo interface.
   
   Fixed calls to _SST method to pass the correct arguments.
   
   Added a call to _SST on wake to restore to "working" state.
   
   Check for End-Of-Buffer failure case in the WalkResources interface.
   
   Integrated fix for 64-bit alignment issue in acglobal.h by moving two
   structures to the beginning of the file.
   
   After wake, clear GPE status register(s) before enabling GPEs.
   
   After wake, clear/enable power button.
   (Perhaps we should clear/enable all fixed events upon wake.)
   
   Fixed a couple of possible memory leaks in the Namespace manager.

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/02/27 1.1063.46.77)
   [ACPI] include CONFIG_ACPI_RELAXED_AML code always
     add acpi=strict option to disable platform workarounds

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/02/26 1.1321.1.1)
   [ACPI] delete unnecessary dmesg lines, fix spelling

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/02/25 1.1063.46.76)
   [ACPI] interrupt over-ride for nforce from Maciej W. Rozycki

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/02/25 1.1063.46.75)
   ACPI URL update






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
