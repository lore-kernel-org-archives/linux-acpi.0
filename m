From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC][PATCH] ACPI/MPS SMP cleanup (smpenum)
Date: Tue, 10 Aug 2004 11:40:16 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847071DE02D@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This patch series makes it possible to compile out MPS, while using ACPI
for SMP=20
boot information.

http://www.kernel.org/pub/linux/kernel/people/grover/smp-20040810-2.6.8-
rc4.diff.gz
bk://linux-acpi.bkbits.net/linux-smp-init

History:

When SMP support was added to the i386 architecture (1995?), information
about the
processors, ioapics, and interrupt routing was obtained through the MPS
table. In
implementing this support, Linux used many MPS-specific data structures,
not just
in the MPS parsing code, but everywhere.

When ACPI SMP support was added, we didn't change the data structures,
we=20
just filled them in with information from the ACPI tables. This was the
only way=20
to get ACPI SMP working without a massive rearch of io_apic.c and
mpparse.c, but=20
it made the two smp init paths (MPS and ACPI) very confusing and
nonintuitive (not=20
to mention creating a dependency on MPS from ACPI.)

This patch properly re-architects the smp init code to handle multiple
smp=20
enumerators.

Major changes:

1) ACPI and MPS code is abstracted into "SMP enumeration drivers". ACPI
and MPS
report CPU and I/OAPIC information through a standard function
interface, instead
of manipulating the kernel data structures directly.

2) ACPI and MPS export function pointers that allow the SMP core to
configure=20
interrupts.

Minor changes:

1) Added #defines for MPS/ACPI polarity/trigger values
2) non-MPS SMP variables prefixed with "smp_", MPS variables prefixed
with "mps_"=20
ACPI variables with "acpi_".
3) Erroneous balanced irq debug #define removed
4) Renamed mp_register_gsi to acpi_register_io_apic_gsi
5) Simplified setup_ioapic_dest().

Benefits:

1) ACPI and MPS init code and data structs make more sense without
interference=20
from the other. e.g. mp_irqs is now only used by MPS.

2) SMP core data structures no longer contain MPS-specific baggage
(there was A=20
LOT).

3) Common algorithm for determining ioapic ids.

4) Lots of duplicated array bounds checking unified.

5) It should be possible to fall back to a secondary smp enumerator if
the primary=20
one fails (not fully implemented yet.)

Known issues:

1) This patch still does not move ACPI-specific code out of io_apic.c
and
mpparse.c, because this would make merging more difficult. After this
patch, this=20
should be easy.

2) this breaks Summit/x440 build, because mp_bus_id_to_node is no longer
defined=20
for non-MPS builds. I need some advice from people who know about the
proper=20
solution to this.

3) Config should insist on either MPS or ACPI support if SMP.

4) Still some small uglinesses, such as translation_table[], and setup.c
still has hardcoded init calls to ACPI/MPS (I think this is probably ok
unless more smpenums are added in the future.)

Testing/feedback:

This patch applies against 2.6.8-rc4.

Please test on any/all SMP machines, in ACPI and MPS (acpi=3Doff),
especially Via=20
and Nvidia chipsets, and note any changes in /proc/interrupts. (ACPI and
MPS might=20
not be the same, but patch vs. no patch should be). I also greatly
simplified visws smp init, so some testing there would also be nice (if
possible).

Feedback to acpi-devel. diffstat follows.

Thanks -- Andy

 arch/i386/Kconfig                            |   24 -
 arch/i386/kernel/Makefile                    |    2=20
 arch/i386/kernel/acpi/boot.c                 |   82 ++-
 arch/i386/kernel/apic.c                      |   25 -
 arch/i386/kernel/i386_ksyms.c                |    2=20
 arch/i386/kernel/io_apic.c                   |  406 +++++++++--------
 arch/i386/kernel/mpparse.c                   |  625
+++++++++------------------
 arch/i386/kernel/nmi.c                       |    1=20
 arch/i386/kernel/reboot.c                    |    1=20
 arch/i386/kernel/setup.c                     |   21=20
 arch/i386/kernel/smpenum.c                   |  195 ++++++++
 arch/i386/kernel/time.c                      |    1=20
 arch/i386/kernel/timers/timer_pit.c          |    2=20
 arch/i386/mach-visws/mpparse.c               |   80 ---
 arch/i386/mm/discontig.c                     |    2=20
 arch/i386/pci/irq.c                          |   11=20
 drivers/acpi/bus.c                           |    1=20
 drivers/acpi/pci_irq.c                       |    3=20
 include/asm-i386/acpi.h                      |   20=20
 include/asm-i386/genapic.h                   |   18=20
 include/asm-i386/hpet.h                      |    1=20
 include/asm-i386/io_apic.h                   |   22=20
 include/asm-i386/mach-bigsmp/mach_apic.h     |   13=20
 include/asm-i386/mach-default/mach_apic.h    |   13=20
 include/asm-i386/mach-default/mach_mpparse.h |    8=20
 include/asm-i386/mach-es7000/mach_apic.h     |   13=20
 include/asm-i386/mach-es7000/mach_mpparse.h  |    8=20
 include/asm-i386/mach-generic/mach_mpparse.h |    2=20
 include/asm-i386/mach-numaq/mach_apic.h      |   13=20
 include/asm-i386/mach-numaq/mach_mpparse.h   |    8=20
 include/asm-i386/mach-summit/mach_apic.h     |   14=20
 include/asm-i386/mach-summit/mach_mpparse.h  |    8=20
 include/asm-i386/mach-visws/mach_apic.h      |    8=20
 include/asm-i386/mpspec.h                    |   76 ---
 include/asm-i386/mpspec_def.h                |   13=20
 include/asm-i386/smp.h                       |    2=20
 include/asm-i386/smpenum.h                   |  108 ++++
 37 files changed, 990 insertions(+), 862 deletions(-)


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
