From: =?iso-8859-2?Q?Zden=ECk?= OGAR =?iso-8859-2?Q?Skal=E1k?=
	<skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Wed, 25 Sep 2002 16:45:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D91CC07.D0D7593A@monetplus.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------6E32B00044856FEB4BF573C3"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------6E32B00044856FEB4BF573C3
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Compaq Armada 110, patched DSDT (myself :-), kernel 2.4.19

> - DOES IT BOOT?

	yes !

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

	Seems be Okay :-)

	Zdenek OGAR Skalak

-- =

Ing. Zden=ECk OGAR Skal=E1k
Monet+ a.s.
Z=E1meck=E1 365
763 14 Zl=EDn - =A9t=EDpa, CZ
Tel: 067 / 711 04 11,  Fax: 067 / 791 45 57
--------------6E32B00044856FEB4BF573C3
Content-Type: text/plain; charset=iso-8859-2;
 name="interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts"

           CPU0       
  0:      77185          XT-PIC  timer
  1:       1375          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  via82cxxx
 10:        137          XT-PIC  acpi
 11:        336          XT-PIC  Texas Instruments PCI1410 PC card Cardbus Controller, usb-uhci, eth0
 12:         23          XT-PIC  PS/2 Mouse
 14:      11732          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0 
ERR:          0

--------------6E32B00044856FEB4BF573C3
Content-Type: text/plain; charset=iso-8859-2;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.19 (root@nb-skalak) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)) #14 Wed Sep 25 15:22:39 CEST 2002
.....
ACPI: have wakeup address 0xc0001000
Advanced speculative caching feature not present
On node 0 totalpages: 63472
zone(0): 4096 pages.
zone(1): 59376 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6e90
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0f7fbdc2
ACPI: FADT (v001 COMPAQ Borg     01540.00000) @ 0x0f7ffb64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0f7ffbd8
ACPI: DSDT (v001 Compaq Wrangler 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
.....
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *9 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 9 *11 12)
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: Power Resource [PLPC] (on)
pci_bind-0191 [06] acpi_pci_bind         : Device 00:00:07.06 not present in PCI namespace
PCI: Probing PCI hardware
 pci_irq-0293 [05] acpi_pci_irq_derive   : Unable to derive IRQ for device 01:00.0
PCI: No IRQ known for interrupt pin A of device 01:00.0 - using IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'

--------------6E32B00044856FEB4BF573C3--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
