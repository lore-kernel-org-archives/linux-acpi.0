From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: acpi integration in kernel 2.4.20
Date: 08 Dec 2002 03:12:31 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039317144.4690.22.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Hi=20
I search in lkml (it stands for Linux Kernel Mailing List) about apic (
not acpi)  problem with compaq pressario and I discover this my notebook
have mode then 8 workarounds for PCI and irq stuff.

So in file drivers/pci you can find then in quirks.c for via south
bridge workaround and in=20
arch/i386/kernel/pci-pc.c function pci_fixup_via_northbridge_bug for
north bridge workaround. This one is a little danger remove him because
some strange thing happens in monitor.

Now the interesting is that we have in quirks.c=20
/*
 * VIA VT82C686 ACPI: Three IO region pointed to by (long)words at
 *  0x48 (256 bytes of ACPI registers)
 *  0x70 (128 bytes of hardware monitoring register)
 *  0x90 (16 bytes of SMB registers)
 */
static void __init quirk_vt82c686_acpi(struct pci_dev *dev)

and=20

#ifdef CONFIG_X86_IO_APIC
/*
 * VIA 686A/B: If an IO-APIC is active, we need to route all on-chip
 * devices to the external APIC.
 *
 * TODO: When we have device-specific interrupt routers,
 * this code will go away from quirks.
 */
static void __init quirk_via_ioapic(struct pci_dev *dev)
...

and=20

/*
 * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
 * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
 * when written, it makes an internal connection to the PIC.
 * For these devices, this register is defined to be 4 bits wide.
 * Normally this is fine.  However for IO-APIC motherboards, or
 * non-x86 architectures (yes Via exists on PPC among other places),
 * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
 * interrupts delivered properly.
 *
 * TODO: When we have device-specific interrupt routers,
 * quirk_via_irqpic will go away from quirks.
 */

/*
 * FIXME: it is questionable that quirk_via_acpi
 * is needed.  It shows up as an ISA bridge, and does not
 * support the PCI_INTERRUPT_LINE register at all.  Therefore
 * it seems like setting the pci_dev's 'irq' to the
 * value of the ACPI SCI interrupt is only done for convenience.
 *  -jgarzik
 */
static void __init quirk_via_acpi(struct pci_dev *d)
{
    /*
     * VIA ACPI device: SCI IRQ line in PCI config byte 0x42
     */
...
static void __init quirk_via_irqpic(struct pci_dev *dev)
{
...


The question is can I remove it ?
and what do=20
the functions for new acpi in file arch/i386/kernel/pci-pc.c
       pcibios_irq_init();
       pcibios_fixup_peer_bridges();
       pcibios_fixup_irqs();
 more fixups irqs for me it seem that last one is in more (useless).

S=E9rgioMB



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
