From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI source release updated (20021002)
Date: Thu, 3 Oct 2002 11:31:41 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEFF@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "'berndp=p32f3XyCuykqcZcGjlUOXw@public.gmane.org'" <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> ACPI: PCI Interrupt Link [LNUS] enabled at IRQ 0
> pci_link-0480 [04] acpi_pci_link_get_irq : Link disabled
>  pci_irq-0258 [03] acpi_pci_irq_lookup   : Invalid IRQ link 
> routing entry
>  pci_irq-0296 [03] acpi_pci_irq_derive   : Unable to derive IRQ for 
> device 00:0f
> .2

            Name(PICA, Package(0xc) {
                Package(0x4) {
                    0x000fffff,
                    0x0,
                    LNUS,
                    0x0,
                },
--------------------------------------------------

    Device(LNUS) {
	...
        Method(_STA) {
            If(GETI(PIUS)) {
                Return(0xb)
            }
            Else {
                Return(0x9)
            }
--------------------------------------------------
    Method(GETI, 1) {
        If(And(Arg0, 0xf, )) {
            Return(Zero)
        }
        Else {
            Return(\MLIB.CNV2(And(Arg0, 0xf, )))
        }

This BIOS appears to be unusual, in that it uses a link device (LNUS), even
in IOAPIC mode. Unfortunately, this causes a bug in GETI to show the link
device as disabled.

If you are familiar with the whole DSDT-loading process, you might try that,
and modify GETI by swapping what is in the two parts of the If/Else.

Regards -- Andy



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
