From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Updated smpenum patch
Date: Wed, 2 Mar 2005 16:52:08 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A84709370A8D@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Natalie.Protasevich-GLv8BlqOqDDQT0dZR+AlfA@public.gmane.org, ak-h9bWGtP8wOw@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

A new smpenum patch against 2.6.11 is available at:

http://www.kernel.org/pub/linux/kernel/people/grover/smp-20050302-2.6.11
.diff.gz

This patch changes i386 smp init to not rely on MPS data structures.
This simplifies ACPI and MPS init and reduces the size of internal data
structures. I would like to make similar changes to x86_64 (where the
reliance on MPS structs makes no sense) but for now this patch just
ensures x86_64 still builds by giving it its own copy of acpi/boot.c.

I have tested on the i386 and x86_64 smp machines I have, and would
appreciate any testing on smp machines, especially on subarchs like x440
and es7000. This shouldn't change boot functionality but imho should
make the code a lot more clean and maintainable.

Len, could I convince you to include this in your ACPI test patches?

Thanks -- Regards -- Andy


 arch/i386/Kconfig                            |    9=20
 arch/i386/Kconfig.debug                      |   10=20
 arch/i386/kernel/Makefile                    |    4=20
 arch/i386/kernel/acpi/boot.c                 |  431 +++-
 arch/i386/kernel/apic.c                      |   30=20
 arch/i386/kernel/i386_ksyms.c                |    2=20
 arch/i386/kernel/io_apic.c                   |  968 +--------
 arch/i386/kernel/mpparse.c                   | 1044 +++++-----
 arch/i386/kernel/nmi.c                       |    1=20
 arch/i386/kernel/reboot.c                    |    1=20
 arch/i386/kernel/setup.c                     |   21=20
 arch/i386/kernel/smpenum.c                   |  195 +
 arch/i386/kernel/time.c                      |    1=20
 arch/i386/kernel/timers/timer_pit.c          |    2=20
 arch/i386/mach-visws/mpparse.c               |   80=20
 arch/i386/mm/discontig.c                     |    2=20
 arch/i386/pci/irq.c                          |   11=20
 arch/x86_64/kernel/acpi/Makefile             |    1=20
 arch/x86_64/kernel/acpi/boot.c               |  868 ++++++++
 drivers/acpi/bus.c                           |    3=20
 drivers/acpi/pci_irq.c                       |    3=20
 include/asm-i386/acpi.h                      |   20=20
 include/asm-i386/genapic.h                   |   18=20
 include/asm-i386/hpet.h                      |    1=20
 include/asm-i386/io_apic.h                   |   37=20
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
 include/asm-i386/mpspec.h                    |   76=20
 include/asm-i386/mpspec_def.h                |   13=20
 include/asm-i386/smp.h                       |    1=20
 include/asm-i386/smpenum.h                   |  109 +
 40 files changed, 2509 insertions(+), 1561 deletions(-)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
