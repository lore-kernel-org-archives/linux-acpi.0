From: "Holger W." <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Subject: problems with PRT and PCI routing table
Date: Sat, 8 Mar 2003 01:51:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000501c2e50c$d43b2790$0200a8c0@brutzler>
Reply-To: <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0006_01C2E515.35FF8F90"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This is a multi-part message in MIME format.

------=_NextPart_000_0006_01C2E515.35FF8F90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi everybody,

I've got some serious problems with ACPI and the IRQ mapping for my =
devices. (look at my
postings "mpparse.c APIC/ACPI support" and "APIC, USB mouse and =
errors").
It seems that not all devices get the IRQs they should regarding the PRT =
table. I've verified it
and it seems that the table is all right (attachment "PRT_table.txt"). =
Especially the devices
00:00:10, 00:00:11 and 00:00:12 which point to "\_SB_.PCI0.ALKx[0]" =
(x=3DA..D) don't get the
interrupts they should regarding the table.

There's perhaps a problem in "acpi_pci_link_add" (pci_link.c), because =
the function returns ...

<4>ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
<4>ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
<4>ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
<4>ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)

... or "acpi_pci_link_get_current" (pci_link.c) has got a problem ? ...

<4>pci_link-0252 [18] acpi_pci_link_get_curr: No IRQ resource found
<4>pci_link-0252 [20] acpi_pci_link_get_curr: No IRQ resource found
<4>pci_link-0252 [22] acpi_pci_link_get_curr: No IRQ resource found
<4>pci_link-0252 [24] acpi_pci_link_get_curr: No IRQ resource found

I don't know which function I should "blame" - I only know that =
everything works fine for LNKA-D
but not for ALKA-D:

<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 *14 15)

So this causes a lot of linked errors. First of all I get a lot of =
"<7>Pin 2-xx already
programmed" (mp_parse_prt / mpparse.c) messages. Next, =
"acpi_pci_irq_lookup" (pci_irq.c) fails
because it can't find the PRT entries and "acpi_pci_link_get_irq", =
"acpi_pci_irq_lookup" and
"acpi_pci_irq_derive" also fail.
And finally "eisa_set_level_irq" is not called in "acpi_pci_irq_enable" =
which results in
non-functional devices which require a "level" trigger mode.

So could one of the hardware experts pleeeeease help me ???

MANY MANY MANY THANKS in advance,

HOLGER W.

P.S.: if you need more information about my boot messages or sth. =
similar - feel free to ask for
it !!!

------=_NextPart_000_0006_01C2E515.35FF8F90
Content-Type: text/plain;
	name="PRT_table.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="PRT_table.txt"

<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]=0A=
<4>PRT entry:   00:00:08[A] -> [16]=0A=
<4>PRT entry:   00:00:08[B] -> [17]=0A=
<4>PRT entry:   00:00:08[C] -> [18]=0A=
<4>PRT entry:   00:00:08[D] -> [19]=0A=
<4>PRT entry:   00:00:09[A] -> [17]=0A=
<4>PRT entry:   00:00:09[B] -> [18]=0A=
<4>PRT entry:   00:00:09[C] -> [19]=0A=
<4>PRT entry:   00:00:09[D] -> [16]=0A=
<4>PRT entry:   00:00:0A[A] -> [18]=0A=
<4>PRT entry:   00:00:0A[B] -> [19]=0A=
<4>PRT entry:   00:00:0A[C] -> [16]=0A=
<4>PRT entry:   00:00:0A[D] -> [17]=0A=
<4>PRT entry:   00:00:0B[A] -> [19]=0A=
<4>PRT entry:   00:00:0B[B] -> [16]=0A=
<4>PRT entry:   00:00:0B[C] -> [17]=0A=
<4>PRT entry:   00:00:0B[D] -> [18]=0A=
<4>PRT entry:   00:00:0C[A] -> [18]=0A=
<4>PRT entry:   00:00:0C[B] -> [19]=0A=
<4>PRT entry:   00:00:0C[C] -> [16]=0A=
<4>PRT entry:   00:00:0C[D] -> [17]=0A=
<4>PRT entry:   00:00:0D[A] -> [19]=0A=
<4>PRT entry:   00:00:0D[B] -> [16]=0A=
<4>PRT entry:   00:00:0D[C] -> [17]=0A=
<4>PRT entry:   00:00:0D[D] -> [18]=0A=
<4>PRT entry:   00:00:0E[A] -> [17]=0A=
<4>PRT entry:   00:00:0E[B] -> [18]=0A=
<4>PRT entry:   00:00:0E[C] -> [19]=0A=
<4>PRT entry:   00:00:0E[D] -> [16]=0A=
<4>PRT entry:   00:00:10[A] -> \_SB_.PCI0.ALKB[0]=0A=
<4>PRT entry:   00:00:10[B] -> \_SB_.PCI0.ALKB[0]=0A=
<4>PRT entry:   00:00:10[C] -> \_SB_.PCI0.ALKB[0]=0A=
<4>PRT entry:   00:00:10[D] -> \_SB_.PCI0.ALKB[0]=0A=
<4>PRT entry:   00:00:11[A] -> \_SB_.PCI0.ALKA[0]=0A=
<4>PRT entry:   00:00:11[B] -> \_SB_.PCI0.ALKB[0]=0A=
<4>PRT entry:   00:00:11[C] -> \_SB_.PCI0.ALKC[0]=0A=
<4>PRT entry:   00:00:11[D] -> \_SB_.PCI0.ALKD[0]=0A=
<4>PRT entry:   00:00:01[A] -> [16]=0A=
<4>PRT entry:   00:00:01[B] -> [17]=0A=
<4>PRT entry:   00:00:01[C] -> [18]=0A=
<4>PRT entry:   00:00:01[D] -> [19]=0A=
<4>PRT entry:   00:00:12[A] -> \_SB_.PCI0.ALKD[0]=0A=
<4>PRT entry:   00:00:12[B] -> \_SB_.PCI0.ALKD[0]=0A=
<4>PRT entry:   00:00:12[C] -> \_SB_.PCI0.ALKD[0]=0A=
<4>PRT entry:   00:00:12[D] -> \_SB_.PCI0.ALKD[0]=0A=

------=_NextPart_000_0006_01C2E515.35FF8F90--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
