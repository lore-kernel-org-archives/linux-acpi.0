From: Dieter =?iso-8859-15?q?N=FCtzel?= <d.nuetzel-VZcQ4qwp+CzQLMG2gba6HQ@public.gmane.org>
Subject: 2.4.22-rc1 + ACPI patch: amd76x_pm do not work any longer
Date: Wed, 6 Aug 2003 06:21:06 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200308060621.06216.d.nuetzel@wearabrain.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Linux Kernel List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello,

I had it running very well on my dual Athlon MP 1900+ for several month=
s=20
before. Latest Kernel was 2.4.22-pre5+ACPI patch.

Any changes?
I changed lm_sensors from 2.7.0 (?) to 2.8.0

System:
dual Athlon MP 1900+
MSI K7D Master-L

2.4.22-rc1
acpi-20030730-2.4.22-pre8.diff
preempt-kernel-rml-2.4.21-1.patch
IDE as modules

SunWave1 /home/nuetzel# modprobe amd76x_pm
/lib/modules/2.4.22-rc1-rl/kernel/drivers/char/amd76x_pm.o: init_module=
:=20
Device or resource busy
Hint: insmod errors can be caused by incorrect module parameters, inclu=
ding=20
invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-rc1-rl/kernel/drivers/char/amd76x_pm.o: insmod=20
/lib/modules/2.4.22-rc1-rl/kernel/drivers/char/amd76x_pm.o failed
/lib/modules/2.4.22-rc1-rl/kernel/drivers/char/amd76x_pm.o: insmod amd7=
6x_pm=20
failed

dmesg:
amd76x_pm: Version 20020730
amd76x_pm: Initializing northbridge Advanced Micro Devices [AMD] AMD-76=
0 MP=20
[IGD4-2P] System Controller
amd76x_pm: Could not find southbridge		<----!!!!!!!!

2.4.22-pre5
older ACPI patch
preempt-kernel-rml-2.4.21-1.patch

<6>amd76x_pm: Version 20020730
<6>amd76x_pm: Initializing northbridge Advanced Micro Devices [AMD] AMD=
-760 MP=20
[IGD4-2P] System Controller



PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] Syst=
em=20
Controller (rev 17).
      Master Capable.  Latency=3D32.
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
      Prefetchable 32 bit memory at 0xf1101000 [0xf1101fff].
      I/O at 0xc800 [0xc803].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP B=
ridge=20
(rev 0).
      Master Capable.  Latency=3D32.  Min Gnt=3D14.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 5)=
=2E
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev=
 4).
      Master Capable.  Latency=3D32.
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 3).
      Master Capable.  Latency=3D32.
  Bus  0, device   9, function  0:
    SCSI storage controller: Adaptec AIC-7892A U160/m (rev 2).
      IRQ 17.
      Master Capable.  Latency=3D32.  Min Gnt=3D40.Max Lat=3D25.
      I/O at 0xc400 [0xc4ff].
      Non-prefetchable 64 bit memory at 0xf1100000 [0xf1100fff].
  Bus  0, device  16, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 5)=
=2E
      Master Capable.  Latency=3D32.  Min Gnt=3D6.
  Bus  1, device   5, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Rad=
eon=20
8500 LE] (rev 0).
      IRQ 17.
      Master Capable.  Latency=3D32.  Min Gnt=3D8.
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
      I/O at 0xb000 [0xb0ff].
      Non-prefetchable 32 bit memory at 0xed000000 [0xed00ffff].
  Bus  2, device   0, function  0:
    USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (re=
v 7).
      IRQ 19.
      Master Capable.  Latency=3D32.  Max Lat=3D80.
      Non-prefetchable 32 bit memory at 0xf0122000 [0xf0122fff].
  Bus  2, device   4, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 8)=
=2E
      IRQ 16.
      Master Capable.  Latency=3D32.  Min Gnt=3D2.Max Lat=3D20.
      I/O at 0x9000 [0x901f].
  Bus  2, device   4, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev=
 8).
      Master Capable.  Latency=3D32.
      I/O at 0x9400 [0x9407].
  Bus  2, device   5, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev =
4).
      IRQ 17.
      Master Capable.  Latency=3D32.  Min Gnt=3D8.Max Lat=3D56.
      Prefetchable 32 bit memory at 0xf1000000 [0xf1000fff].
      I/O at 0x9800 [0x981f].
      Non-prefetchable 32 bit memory at 0xf0000000 [0xf00fffff].
  Bus  2, device   6, function  0:
    SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 1)=
=2E
      IRQ 18.
      Master Capable.  Latency=3D32.  Min Gnt=3D8.Max Lat=3D8.
      I/O at 0x9c00 [0x9cff].
      Non-prefetchable 32 bit memory at 0xf0120000 [0xf0120fff].
  Bus  2, device   9, function  0:
    Ethernet controller: Intel Corp. 82559ER (rev 9).
      IRQ 17.
      Master Capable.  Latency=3D32.  Min Gnt=3D8.Max Lat=3D56.
      Non-prefetchable 32 bit memory at 0xf0121000 [0xf0121fff].
      I/O at 0xa000 [0xa03f].
      Non-prefetchable 32 bit memory at 0xf0100000 [0xf011ffff].

Thanks.

--=20
Dieter N=FCtzel
Leiter F&E, WEAR-A-BRAIN GmbH, Wiener Str. 5, 28359 Bremen, Germany
Mobil: 0162 673 09 09
