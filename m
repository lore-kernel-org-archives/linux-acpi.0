From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI Updates for 2.4
Date: Tue, 12 Aug 2003 15:36:18 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EECD@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Marcelo, here's a bunch of ACPI updates.

bk pull http://linux-acpi.bkbits.net/linux-acpi-2.4

This includes a rework of the ACPI config and cmdline options. It now
supports DMI-based blacklisting, and cmdline options have been
simplified to "acpi=off", "acpi=ht" (use ACPI for CPU enum only) and
"acpi=force" (to override the blacklist.)

It also includes some PCI IRQ routing changes, that seem to help some
people's systems work better.

Please apply.

Thanks -- Regards -- Andy

This will update the following files:

 arch/i386/kernel/acpitable.c        |  553 ------------------------
 arch/i386/kernel/acpitable.h        |  260 -----------
 Documentation/Configure.help        |   41 -
 Documentation/kernel-parameters.txt |   18 
 Makefile                            |    2 
 arch/i386/kernel/Makefile           |    1 
 arch/i386/kernel/acpi.c             |   50 +-
 arch/i386/kernel/dmi_scan.c         |  394 ++++++++++++++---
 arch/i386/kernel/io_apic.c          |   14 
 arch/i386/kernel/mpparse.c          |   37 +
 arch/i386/kernel/setup.c            |   99 ++--
 arch/i386/kernel/smpboot.c          |    2 
 drivers/Makefile                    |    2 
 drivers/acpi/Config.in              |   68 +-
 drivers/acpi/Makefile               |    7 
 drivers/acpi/bus.c                  |    2 
 drivers/acpi/executer/exutils.c     |    2 
 drivers/acpi/hardware/hwregs.c      |   21 
 drivers/acpi/osl.c                  |   26 -
 drivers/acpi/pci_irq.c              |   15 
 drivers/acpi/pci_link.c             |  100 ++--
 drivers/acpi/processor.c            |    1 
 drivers/acpi/tables.c               |  120 ++---
 drivers/acpi/tables/tbconvrt.c      |    6 
 drivers/acpi/tables/tbget.c         |    4 
 drivers/acpi/tables/tbinstal.c      |   42 +
 drivers/acpi/tables/tbrsdt.c        |    2 
 drivers/acpi/tables/tbxfroot.c      |    6 
 drivers/acpi/toshiba_acpi.c         |    3 
 drivers/acpi/utilities/utglobal.c   |    6 
 include/acpi/acconfig.h             |    2 
 include/acpi/acpi_drivers.h         |    2 
 include/acpi/platform/acenv.h       |    6 
 include/asm-i386/acpi.h             |   26 -
 include/asm-i386/io_apic.h          |    2 
 init/do_mounts.c                    |   12 
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
   rename CONFIG_ACPI_BOOT to CONFIG_ACPI_HT; "acpi=boot" to "acpi=ht"
   Allow acpi=ht, or CONFIG_ACPI_HT to enable HT on systems w/o an MPS
table.
   

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/28 1.1022)
   ACPI: toshiba_acpi update (John Belmonte)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/28 1.1021)
   ACPI: Better blacklist messages (Jasper Spaans)

<lenb@dhcppc3.> (03/07/23 1.1016.1.1)
   ACPI: update acpi=boot code post testing

<lenb@dhcppc3.> (03/07/22 1.1003.38.2)
   CONFIG_ACPI_BOOT is now a sub-set of CONFIG_ACPI.  It enables just
boot-time config via ACPI --
   useful for enabling HT w/o loading the AML interpreter.
   
   When full CONFIG_ACPI is selected, cmdline "acpi=boot" runs the same
sub-set.
   deleted acpitable.c, deleted broken "noht" cmdline option.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/17 1.1015)
   ACPI: fix intr enable for IA64 (davidm)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/17 1.1014)
   ACPI: Fix spinlock warnings (Bjorn Helgaas)

<lenb@dhcppc3.> (03/07/15 1.1002.2.3)
   ACPI: DMI blacklist from UnitedLinux, plus "acpi=oldboot" scheme,
re-named "acpi=cpu"

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/14 1.1003.32.6)
   ACPI: Dynamically allocate SDT list (suggested by Andi Kleen)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1003.32.5)
   ACPI: Parse SSDTs in order discovered, as opposed to reverse order
(Hrvoje Habjanic)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1003.32.4)
   ACPI: Fixes from FreeBSD and NetBSD. (Frank van der Linden, Thomas
Klausner,
   Nate Lawson)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/07/13 1.1003.32.3)
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
