From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BKPATCH] ACPI for 2.6
Date: 20 May 2004 15:12:20 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085033656.12352.486.camel@dhcppc4>
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
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.7

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.7/acpi-20040326-2.6.7.diff.gz

This will update the following files:

 arch/i386/kernel/acpi/boot.c       |   42 +++++++++++++++++--------
 arch/i386/kernel/mpparse.c         |    8 ++--
 arch/i386/mach-es7000/es7000plat.c |   24 ++++++++++++++
 arch/ia64/kernel/acpi.c            |   41 ++++++++++++++++--------
 arch/x86_64/kernel/io_apic.c       |    2 -
 drivers/acpi/ac.c                  |    3 +
 drivers/acpi/acpi_ksyms.c          |    2 -
 drivers/acpi/asus_acpi.c           |   26 ++++++++++++++-
 drivers/acpi/battery.c             |    7 ++++
 drivers/acpi/bus.c                 |    8 ++++
 drivers/acpi/button.c              |   19 +++++------
 drivers/acpi/ec.c                  |    6 +++
 drivers/acpi/events/evxface.c      |   27 ++++++++++++++++
 drivers/acpi/fan.c                 |    2 +
 drivers/acpi/osl.c                 |   16 ++++++++-
 drivers/acpi/power.c               |    2 +
 drivers/acpi/scan.c                |   18 ++--------
 drivers/acpi/tables.c              |    5 +-
 drivers/acpi/thermal.c             |   10 +++++
 include/acpi/acpiosxf.h            |    4 ++
 include/linux/acpi.h               |    2 -
 21 files changed, 213 insertions(+), 61 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/05/18 1.1371.709.22)
   [ACPI] remove /proc files before unloading modules
   from Sau Dan Lee, Zhenyu Wang
   http://bugzilla.kernel.org/show_bug.cgi?id=2705

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/05/18 1.1371.709.21)
   [ACPI] revert button module unload fix (2281)
   Cset exclude: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org|ChangeSet|20040503042906|02093
   Cset exclude: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org|ChangeSet|20040428081825|02121
   Cset exclude:
len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org[lenb]|ChangeSet|20040428071221|03892

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/05/14 1.1608.9.6)
   [ACPI] delete IOAPIC-disable workaround on x86_64/VIA
   http://bugme.osdl.org/show_bug.cgi?id=1530

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/05/13 1.1608.9.5)
   [ACPI] create kacpid thread to handle ACPI work in process context.
   Also will be needed for cpu hot-unplug.
   from Anil S Keshavamurthy and David Shaohua Li
   http://bugzilla.kernel.org/show_bug.cgi?id=2515

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/05/12 1.1608.9.4)
   [ACPI] Add MADT error checking (Yi Zhu)
   http://bugzilla.kernel.org/show_bug.cgi?id=1434

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/05/12 1.1608.9.3)
   [ACPI] if _STA.functional, set _STA.present (Bjorn Helgaas)
   workaround for Big Sur and Bull systems

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/05/11 1.1608.9.2)
   [ACPI] create platform_rename_gsi() so ES7000 can munge IRQ numbers
   from Natalie Protasevich






-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
