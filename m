From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Thu, 19 Sep 2002 20:37:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209192037.17191.earny@net4u.de>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Moin.

On Donnerstag, 19. September 2002 08:27, Grover, Andrew wrote:
> I wanted to make a special request for testing of the 2.4 patch (or should
> I say, MEGA-patch).

Gericom Supersonic M6-T Intel 1.2GHz

> - DOES IT BOOT?

Linux version 2.4.20-pre7 (root@lidl) (gcc version 2.95.3 20010315 (SuSE)) #4 Thu Sep 19 19:02:33 CEST 2002
Yes.

ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6d40
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x1fefb426
ACPI: FADT (v001 SMDVIA VT5228C  01540.00000) @ 0x1fefef8c
ACPI: DSDT (v001  VIA   PTL_ACPI 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

Yes. Sound is not loaded yet, i will try that later.

ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5, disabled)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
pci_bind-0194 [07] acpi_pci_bind         : Device 00:00:06.01 not present in PCI namespace (??)

( lidl:~ # lspci | grep "00:06"
00:06.0 Communication controller: Lucent Microelectronics LT WinModem )

lidl:~ # cat /proc/interrupts
           CPU0
  0:     210767          XT-PIC  timer
  1:       1245          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       2125          XT-PIC  usb-uhci
  8:          2          XT-PIC  rtc
  9:          1          XT-PIC  acpi
 10:       2359          XT-PIC  eth0, O2 Micro, Inc. OZ6933 Cardbus Controller, O2 Micro, Inc. OZ6933 Cardbus Controller (#2)
 14:      12914          XT-PIC  ide0
 15:        191          XT-PIC  ide1
NMI:          0
LOC:     210735
ERR:          0
MIS:          0


>
> Issues like whether the battery reports stats properly are of secondary
> importance.

Working:

lidl:~ # cat /proc/acpi/battery/BAT0/*
alarm:                   unsupported
present:                 yes
design capacity:         54720 mWh
last full capacity:      47600 mWh
battery technology:      rechargeable
design voltage:          14400 mV
design capacity warning: 3808 mWh
design capacity low:     1428 mWh
capacity granularity 1:  238 mWh
capacity granularity 2:  238 mWh
model number:            PC-VP-WP22/OP-570-74001
serial number:
battery type:            Lion
OEM info:                NEC
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            30189 mW
remaining capacity:      33320 mWh
present voltage:         14860 mV


Reagards

<Earny>





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
