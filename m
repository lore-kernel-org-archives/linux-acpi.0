From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: ACPI PCI routing problem
Date: Fri, 11 Jul 2003 00:22:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307110022.29512.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi, I have an Epox 8RDA+ NForce2-based motherboard (uniprocessor, Athlon XP=
).=20
This board has an IO-APIC with 0x17 pins. I can't tell you much more specif=
ic=20
about it, as it is in the nforce2 chipset to which I do not have docs. I'm=
=20
using kernel 2.5.74, with APIC, IO-APIC, ACPI turned on.=20

=46irst of all, here are the symptoms:

Kernel boots OK, devices with IRQs <=3D15 are fine. However, the system att=
empts=20
to allocate some devices (e.g. USB) to IRQs 20 and 21, as told by the AML=20
code in my BIOS (more on this later).

The USB busses do not work. The devices are detected, but all attempts to s=
end=20
USB packets time out. Examining /proc/interrupts shows the reason: IRQ21 ha=
s=20
had MILLIONS of spurious interrupts. It is receiving them even before the U=
SB=20
driver starts, so the kernel detected that no driver is registered, and=20
disabled the IRQ (in arch/i386/kernel/irq.c). It prints "IRQ 21:nobody=20
cared".

The other USB bus just seems to receive no interrupts at all.

If I pass pci=3Dnoapci as a kernel parameter, everything works (USB busses =
are=20
allocated to IRQs <=3D15), but I thought I would take the time to debug thi=
s=20
issue properly. Also, it gave me an excuse to learn about ACPI and APICs :)

The PCI Interrupt Link names for my USB devices are APCF, APCG respectively=
=2E=20
Here is the output from the ACPI PRT parsing code during kernel bootup:

pci_link-0256 [39] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22, disabled)
pci_link-0256 [41] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22, disabled)

I have decompiled the AML code in my BIOS to verify that the ACPI parser is=
=20
functioning correctly. It is.

During the initialisation of the IO-APIC (and the parsing of the MADT ACPI=
=20
table), the following is printed:
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 n=
ot=20
connected.

Heres my problem: is this a bug in my BIOS's ACPI tables, or a bug in the=20
kernel. The "not connected" stuff above kinda implies that the PRT=20
information is duff.. but I'm not sure what "not connected" means here...=20
does it mean physically unconnected, or just logically?

=46rom the ACPI spec, I got the impression that the MADT table contains=20
overrides for the *8539 PIC* IRQs.. so you wouldn't get IRQs > 15 in there=
=20
anyway.

If this is a BIOS bug, I'll probably develop a patch which warns when duff =
PRT=20
tables are present, and forces pci=3Dnoacpi.=20

If this is a kernel bug, can anyone suggest where to go next. I can provide=
=20
more information if necessary...

Incidentally, this only started in kernel 2.5.63 (or very close to there) w=
hen=20
a bug was fixed in the ACPI parser when a device does not have an IRQ=20
allocated already (The "No IRQ resource found" printout above). Prior to=20
this, I think the PRT parser just bombed out completely, and the system use=
d=20
some other IRQ routing method.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
