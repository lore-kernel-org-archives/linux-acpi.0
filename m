From: Sebastian Zimmermann <wegwerf-juni02-XrphxVexwn4ANkabGmIAxw@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: 23 Sep 2002 20:06:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1032804402.910.10.camel@coruscant.datenknoten.de>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

linux-2.4.20-pre7-acpi
Toshiba Tecra 9000

> - DOES IT BOOT?

yes

kernel: ACPI: have wakeup address 0xc0001000
kernel: On node 0 totalpages: 196320
kernel: zone(0): 4096 pages.
kernel: zone(1): 192224 pages.
kernel: zone(2): 0 pages.
kernel: ACPI: RSDP (v000 TOSHIB                     ) @ 0x000f0180
kernel: ACPI: RSDT (v001 TOSHIB 750      00151.02068) @ 0x2fee0000
kernel: ACPI: FADT (v002 TOSHIB 750      00151.02068) @ 0x2fee0054
kernel: ACPI: BOOT (v001 TOSHIB 750      00151.02068) @ 0x2fee002c
kernel: ACPI: DSDT (v001 TOSHIB 9000     08194.01552) @ 0x00000000
kernel: ACPI: BIOS passes blacklist
kernel: ACPI: MADT not present

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

          CPU0       
  0:     100838          XT-PIC  timer
  1:       2270          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
  9:         91          XT-PIC  acpi
 11:       2974          XT-PIC  Texas Instruments PCI1410 PC card
Cardbus Controller, Toshiba America Info Systems ToPIC95 PCI to Cardbus
Bridge with ZV Support, Toshiba America Info Systems ToPIC95 PCI to
Cardbus Bridge with ZV Support (#2), Intel ICH3, usb-uhci, usb-uhci,
usb-uhci, orinoco_cs
 12:      51835          XT-PIC  PS/2 Mouse
 14:      13212          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0 
LOC:     100801 
ERR:          0
MIS:          0

> Toshiba Laptop ACPI Extras version 0.13

Work fine

Lid ok
Battery ok

does enter S1 sleep (power led turns yellow), however, it won't wakeup
(power led turns green, but system hangs).

S.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
