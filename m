From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI 2.4 interim patch released (20030730)
Date: Wed, 30 Jul 2003 11:00:08 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EEB8@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

I just posted an interim patch to http://sf.net/projects/acpi, but this
isn't going to kernel maintainers right away. The big thing is Andrew de
Quincey's irq stuff. *This needs a lot of testing*. Please try it on as
many systems as possible, both big and small.

In addition, the 2.4 patch has a rewrite of the ACPI compile-time and
cmdline boot options by Len Brown. This should be showing up in the 2.5
patch soon, but for now, give it a go. See
Documentation/kernel-parameters.txt for more information.

Finally, the patch (already in 2.5-test2, and also in this patch) that
dynamically allocates the SDT array causes problems on ia64. This will
be fixed before patch submission.

I'm out on vacation until August 7. So in the meantime, give this code a
shot.

Regards -- Andy


-----------------------------------
This updates the following files:

 arch/i386/kernel/acpitable.c        |  553 ------------------------
 arch/i386/kernel/acpitable.h        |  260 -----------
 Documentation/Configure.help        |   41 -
 Documentation/kernel-parameters.txt |   18=20
 Makefile                            |    2=20
 arch/i386/kernel/Makefile           |    1=20
 arch/i386/kernel/acpi.c             |   50 +-
 arch/i386/kernel/dmi_scan.c         |  394 ++++++++++++++---
 arch/i386/kernel/io_apic.c          |   14=20
 arch/i386/kernel/mpparse.c          |   37 +
 arch/i386/kernel/setup.c            |   99 ++--
 arch/i386/kernel/smpboot.c          |    2=20
 drivers/Makefile                    |    2=20
 drivers/acpi/Config.in              |   68 +-
 drivers/acpi/Makefile               |    7=20
 drivers/acpi/bus.c                  |    2=20
 drivers/acpi/executer/exutils.c     |    2=20
 drivers/acpi/hardware/hwregs.c      |   21=20
 drivers/acpi/osl.c                  |   26 -
 drivers/acpi/pci_irq.c              |   15=20
 drivers/acpi/pci_link.c             |  100 ++--
 drivers/acpi/processor.c            |    1=20
 drivers/acpi/tables.c               |  120 ++---
 drivers/acpi/tables/tbconvrt.c      |    6=20
 drivers/acpi/tables/tbget.c         |    4=20
 drivers/acpi/tables/tbinstal.c      |   42 +
 drivers/acpi/tables/tbrsdt.c        |    2=20
 drivers/acpi/tables/tbxfroot.c      |    6=20
 drivers/acpi/toshiba_acpi.c         |    3=20
 drivers/acpi/utilities/utglobal.c   |    6=20
 include/acpi/acconfig.h             |    2=20
 include/acpi/acpi_drivers.h         |    2=20
 include/acpi/platform/acenv.h       |    6=20
 include/asm-i386/acpi.h             |   26 -
 include/asm-i386/io_apic.h          |    2=20
 init/do_mounts.c                    |   12=20
 36 files changed, 779 insertions(+), 1175 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/29 1.1027)
   ACPI: Allow irqs > 15 to use interrupt semantics other than PCI's
standard
   active-low, level trigger. Make other changes as required for this.
(Andrew de
   Quincey)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/29 1.1026)
   ACPI: Trivial changes that don't deserve their own changeset

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/29 1.1025)
   ACPI: If notify handler fails to be removed properly, don't just
return, but
   clean up other resources too (Daniele Bellucci)

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/07/29 1.1018.1.3)
   minor cleanup of previous cset

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/07/29 1.1018.1.1)
   rename CONFIG_ACPI_BOOT to CONFIG_ACPI_HT; "acpi=3Dboot" to =
"acpi=3Dht"
   Allow acpi=3Dht, or CONFIG_ACPI_HT to enable HT on systems w/o an MPS
table.
  =20

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/28 1.1022)
   ACPI: toshiba_acpi update (John Belmonte)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/28 1.1021)
   ACPI: Better blacklist messages (Jasper Spaans)

<lenb@dhcppc3.> (03/07/23 1.1016.1.1)
   ACPI: update acpi=3Dboot code post testing

<lenb@dhcppc3.> (03/07/22 1.1003.37.2)
   CONFIG_ACPI_BOOT is now a sub-set of CONFIG_ACPI.  It enables just
boot-time config via ACPI --
   useful for enabling HT w/o loading the AML interpreter.
  =20
   When full CONFIG_ACPI is selected, cmdline "acpi=3Dboot" runs the =
same
sub-set.
   deleted acpitable.c, deleted broken "noht" cmdline option.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/17 1.1015)
   ACPI: fix intr enable for IA64 (davidm)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/17 1.1014)
   ACPI: Fix spinlock warnings (Bjorn Helgaas)

<lenb@dhcppc3.> (03/07/15 1.1002.2.3)
   ACPI: DMI blacklist from UnitedLinux, plus "acpi=3Doldboot" scheme,
re-named "acpi=3Dcpu"

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/14 1.1003.31.6)
   ACPI: Dynamically allocate SDT list (suggested by Andi Kleen)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1003.31.5)
   ACPI: Parse SSDTs in order discovered, as opposed to reverse order
(Hrvoje Habjanic)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1003.31.4)
   ACPI: Fixes from FreeBSD and NetBSD. (Frank van der Linden, Thomas
Klausner,
   Nate Lawson)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1003.31.3)
   ACPI: DTRT regarding the watchdog during long stalls (Andrew Morton)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1002.7.2)
   ACPI: Make things compile on gcc 3.3

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1002.7.1)
   ACPI: Make mp_bus_id_to_pci_bus initialization moderately more
correct

<lenb@dhcppc6.> (03/06/26 1.1002.2.2)
   update kernel-parameters.txt with current acpi and acpismp
parameters.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
