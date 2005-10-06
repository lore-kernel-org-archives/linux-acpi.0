From: foolish-joSiycWv2dg+3ClZCHpbBg@public.gmane.org
Subject: ACPI trouble in SHG 4000 notebook
Date: Thu, 6 Oct 2005 06:45:15 -0500 (CDT)
Message-ID: <60125.84.48.53.145.1128599115.squirrel@84.48.53.145>
Mime-Version: 1.0
Content-Type: multipart/alternative;boundary="----=_20051006064515_83482"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

------=_20051006064515_83482
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



I recently aquired a budget notebook from SHGcomputers.com, believing tha=
t
the hardware included would be supported by a modern distribution. After
installing Fedora Core 4 on it, I realised the wireless card, an ipw2200,
didn't work.

After some research, I've come to the conclusion that it's somehow an ACP=
I
fault. I get the following ACPI messages:

PCI: PCI BIOS revision 2.10 entry at 0xe9bf4, last bus=3D1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 *7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 23) *11
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *5, disabled
    ACPI-0229: *** Error: Return object type is incorrect
[\_SB_.PCI0.ALKD._CRS] (Node f7ecdee0), AE_TYPE
ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *0

and the wireless card fails with the message of:

ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.0
ipw2200: Copyright(c) 2003-2004 Intel Corporation
PCI: Enabling device 0000:00:06.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:06.0[A]: no GSI
PCI: Setting latency timer of device 0000:00:06.0 to 64
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Error allocating IRQ 0
ipw2200: probe of 0000:00:06.0 failed with error -16

I've tried to use the pci=3Drouteirq option, but that changed nothing.
I've attached the full dmesg output.

Please help me get to the bottom of this, as my laptop is seriously
crippled by the lack of a wireless card.

------=_20051006064515_83482
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I recently aquired a budget notebook from SHGcomputers.com, believing tha=
t
the hardware included would be supported by a modern distribution. After
installing Fedora Core 4 on it, I realised the wireless card, an ipw2200,
didn't work.

After some research, I've come to the conclusion that it's somehow an ACP=
I
fault. I get the following ACPI messages:

PCI: PCI BIOS revision 2.10 entry at 0xe9bf4, last bus=3D1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 *7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 23) *11
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *5, disabled
    ACPI-0229: *** Error: Return object type is incorrect
[\_SB_.PCI0.ALKD._CRS] (Node f7ecdee0), AE_TYPE
ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *0

and the wireless card fails with the message of:

ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.0
ipw2200: Copyright(c) 2003-2004 Intel Corporation
PCI: Enabling device 0000:00:06.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:06.0[A]: no GSI
PCI: Setting latency timer of device 0000:00:06.0 to 64
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Error allocating IRQ 0
ipw2200: probe of 0000:00:06.0 failed with error -16

I've tried to use the pci=3Drouteirq option, but that changed nothing.
I've attached the full dmesg output.

Please help me get to the bottom of this, as my laptop is seriously
crippled by the lack of a wireless card.
------=_20051006064515_83482--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
