From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI updates (2.6)
Date: Wed, 13 Aug 2003 10:26:34 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EECE@orsmsx401.jf.intel.com>
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

This patch attempts to start correcting the PCI IRQ routing issues we're
still seeing, and also redoes the ACPI cmdline and config options, which
were pretty messy. There are also some IA64 fixes, and some other
miscellaneous things. Please apply.

Thanks -- Regards -- Andy

This will update the following files:

 arch/i386/kernel/acpi/acpitable.c         |  553 ------------------
 arch/i386/kernel/acpi/acpitable.h         |  260 --------
 Documentation/kbuild/kconfig-language.txt |    4=20
 Documentation/kernel-parameters.txt       |   21=20
 arch/i386/Kconfig                         |   11=20
 arch/i386/kernel/Makefile                 |    2=20
 arch/i386/kernel/acpi/Makefile            |    1=20
 arch/i386/kernel/acpi/boot.c              |   56 +
 arch/i386/kernel/cpu/intel.c              |   12=20
 arch/i386/kernel/dmi_scan.c               |  353 +++++++++--
 arch/i386/kernel/io_apic.c                |   16=20
 arch/i386/kernel/mpparse.c                |   26=20
 arch/i386/kernel/setup.c                  |   39 -
 arch/i386/kernel/smpboot.c                |    2=20
 arch/i386/pci/acpi.c                      |   10=20
 arch/x86_64/kernel/acpi/boot.c            |    3=20
 drivers/Makefile                          |    2=20
 drivers/acpi/Kconfig                      |  112 ++-
 drivers/acpi/Makefile                     |    5=20
 drivers/acpi/bus.c                        |    2=20
 drivers/acpi/osl.c                        |    9=20
 drivers/acpi/pci_irq.c                    |   15=20
 drivers/acpi/pci_link.c                   |  102 ++-
 drivers/acpi/processor.c                  |    1=20
 drivers/acpi/tables.c                     |   21=20
 drivers/acpi/toshiba_acpi.c               |    3=20
 include/acpi/acconfig.h                   |    2=20
 include/acpi/acpi_drivers.h               |    2=20
 include/asm-i386/acpi.h                   |   26=20
 include/asm-i386/io_apic.h                |    2=20
 include/linux/acpi.h                      |    6=20
 init/do_mounts.c                          |   23=20
 init/do_mounts.h                          |   11=20
 33 files changed, 647 insertions(+), 1066 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/08/13 1.1130)
   ACPI: Update version so we can keep bugreports straight

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/08/13 1.1129)
   ACPI: Fix ACPI for IA64 on Big Sur machines (HJ Lu)

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/12 1.1128)
   ACPI
   dmi_scan.c: delete some incomplete code that broke !SMP + APIC build;
add ACPI blacklist comment,
   move __i386__ out of do_mounts.c and into create
mount_root_failed_msg()

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/12 1.1127)
   ACPI: merge andy-2.6 into lenb-2.6

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/10 1.1046.1.429)
   ACPI -- CONFIG_ACPI_HT -- this delta should have been in previous
cset

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/10 1.1046.1.428)
   ACPI -- CONFIG_ACPI_HT

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/10 1.1046.1.427)
   ACPI: this delta should have been included in previous cset

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (03/08/09 1.1046.1.426)
   ACPI from 2.4:
   build: add ACPI_HT, delete ACPI_HT_ONLY
   boot: add acpi=3D{force, off, ht}; delete "noht", "acpismp=3D"
   add DMI blacklist from UnitedLinux

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/29 1.1046.1.425)
   ACPI: If notify handler fails to be removed properly, don't just
return, but
   clean up other resources too (Daniele Bellucci)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/29 1.1046.1.424)
   ACPI: Allow irqs > 15 to use interrupt semantics other than PCI's
standard
   active-low, level trigger. Make other changes as required for this.
(Andrew de Quincey)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/28 1.1046.1.423)
   ACPI: toshiba_acpi update (John Belmonte)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/28 1.1046.1.422)
   ACPI: Fix Kconfig for ia64 and SN2 (Jesse Barnes)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/28 1.1046.1.421)
   ACPI: Better blacklist messages (Jasper Spaans)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/17 1.1046.526.1)
   ACPI: Fix intr on IA64 (davidm)

<lenb@dhcppc6.> (03/06/26 1.1046.370.2)
   update acpi=3D and acpismp=3D in kernel-parameters.txt


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
