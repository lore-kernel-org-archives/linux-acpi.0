From: floyd-fQS1DxmpaU3QT0dZR+AlfA@public.gmane.org (Matt Mercer)
Subject: hwclock/rtc ongoing issue
Date: Tue, 13 May 2003 02:44:06 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030513094406.GA443@unpunk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi All,

I have found atleast one other person whos system uses an ALi 1533/1535
southbridge that is also experiencing the lockup when hwclock hits the 
rtc device.

# lspci -s 00:07.0 -xxx
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 33 15
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 01 21 08 c0 1d 0a 00 67 69 95 90 55 00 00 fd 03
50: 00 00 00 00 02 00 02 00 5c 00 00 00 00 00 e0 f0
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 64 25 03
70: d2 00 20 00 09 1f 81 76 40 04 00 82 20 00 00 11
80: 07 00 33 01 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ALi Corporation. [ALi] M5229 IDE
01f0-01f7 : ide0
02f8-02ff : serial(set)
0300-030f : 3c589_cs
0376-0376 : ALi Corporation. [ALi] M5229 IDE
03c0-03df : vesafb
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1000-100f : ALi Corporation. [ALi] M5229 IDE
  1000-1007 : ide0
  1008-100f : ide1
1400-14ff : ALi Corporation. [ALi] M5451 PCI AC-Link Controller Audio Device
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
8000-803f : ALi Corporation. [ALi] M7101 PMU
8040-805f : ALi Corporation. [ALi] M7101 PMU

# cat /proc/interrupts
           CPU0
  0:     151945          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       2233          XT-PIC  3c589_cs
  5:          0          XT-PIC  Texas Instruments PCI1410 PC card Cardbus Controller
  8:          0          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:         33          XT-PIC  usb-ohci
 14:       3789          XT-PIC  ide0
NMI:          0
ERR:          0

I am still trying to work out a scheme to debug the system, but perhaps knowing
the hardware commonality will help some.

Interesting note, my chip is actually an ALi 1535.  The datasheet on this chip
states the PCI ID is 0x1533. Guess the ID wasn't bumped during early 
generations.

Will post more information as I discover it.

Matt


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
