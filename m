From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: suspend to ram on Acer Travelmate 803
Date: Sat, 28 Feb 2004 10:23:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402272216.47701.stefandoesinger@gmx.at>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello List,
I'm trying to get suspend to ram working on my acer travelmate 803=20
notebook(centrino).=20
I've found a few kernel/X11 patches to get suspend working with the built-i=
n=20
Radeon Mobility 9000 M9, so it basically works, but I had to set "noaccel"=
=20
"true" in my XF86Config. I can resume, but then I've=20
major problems with my pci bus:

Most devices attached to pci bus 00 work after resume(except the soundcard)=
,=20
and all devices on bus 02 are unuseable after resume. Loading a driver=20
eighter crashes hard or reports a lot of pci errors. The video adapter at b=
us=20
01 works only, if hardware acceleration is completely disabled.
Suspend to ram works properly on other systems with nearly the same hardwar=
e.

Device drivers can re-enable the resources, but they can't communicate with=
=20
the device.

I attached an lspci -v output before and after suspend and a dmesg of=20
suspend/resume.

I use kernel 2.6.3-mm2 with the patch for radeon_pm.c I found on this list =
and=20
Xfree-4.4-rc3 with the patch for radeon_driver.c I found on this list.
I load the acpi dsdt from the acpi.sf.net website.

Thanks for your help
Stefan D=F6singer

This is what lspci -v prints before suspend:
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 0=
3)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=3D256M]
        Capabilities: [e4] #09 [f104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03=
)=20
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 96
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: d8000000-dfffffff

00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03)=20
(prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1800 [size=3D32]

00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03)=20
(prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 1820 [size=3D32]

00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 03)=20
(prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1840 [size=3D32]

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (re=
v=20
03) (prog-if 20 [EHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 10
        Memory at d0000000 (32-bit, non-prefetchable) [size=3D1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 0=
0=20
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D=
64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: d0200000-d05fffff

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage=20
Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1860 [size=3D16]
        Memory at 20000000 (32-bit, non-prefetchable) [size=3D1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: medium devsel, IRQ 10
        I/O ports at 1880 [size=3D32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio=
=20
Controller (rev 03)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1c00 [size=3D256]
        I/O ports at 18c0 [size=3D64]
        Memory at d0000c00 (32-bit, non-prefetchable) [size=3D512]
        Memory at d0000800 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [50] Power Management version 2

00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03)=20
(prog-if 00 [Generic])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 2400 [size=3D256]
        I/O ports at 2000 [size=3D128]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Rad=
eon=20
Mobility 9000 M9] (rev 01) (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel,=
=20
latency 66, IRQ 10
        Memory at d8000000 (32-bit, prefetchable) [size=3D128M]
        I/O ports at 3000 [size=3D256]
        Memory at d0100000 (32-bit, non-prefetchable) [size=3D64K]
        Expansion ROM at <unassigned> [disabled] [size=3D128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, fast devsel, latency 64, IRQ 5
        Memory at d0204000 (32-bit, non-prefetchable) [size=3D8K]
        Capabilities: [40] Power Management version 2

02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI=20
Adapter (rev 04)
        Subsystem: Intel Corp.: Unknown device 2527
        Flags: medium devsel, IRQ 10
        Memory at d0206000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [dc] Power Management version 2

02:06.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, stepping, slow devsel, latency 168, IRQ 10
        Memory at d0207000 (32-bit, non-prefetchable) [size=3D4K]
        Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D=
176
        Memory window 0: d0400000-d04ff000 (prefetchable)
        Memory window 1: d0300000-d03ff000
        I/O window 0: 00004400-000044ff
        I/O window 1: 00004000-000040ff
        16-bit legacy interface ports at 0001

02:06.1 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, stepping, slow devsel, latency 168, IRQ 10
        Memory at 20001000 (32-bit, non-prefetchable) [size=3D4K]
        Bus: primary=3D02, secondary=3D07, subordinate=3D0a, sec-latency=3D=
176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001

02:06.2 System peripheral: O2 Micro, Inc.: Unknown device 7110
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: slow devsel, IRQ 10
        Memory at d0208000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [a0] Power Management version 2

02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000=20
Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at d0209000 (32-bit, non-prefetchable) [size=3D2K]
        Memory at d0200000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [44] Power Management version 2

=2D-----------------------------------------lspci ends---------------------=
=2D--
After resuming, the resources of most devices are disabled:
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 0=
3)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=3D256M]
        Capabilities: [e4] #09 [f104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03=
)=20
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 96
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: d8000000-dfffffff

00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03)=20
(prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1800 [size=3D32]

00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03)=20
(prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 1820 [size=3D32]

00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 03)=20
(prog-if 00 [UHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at 1840 [size=3D32]

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (re=
v=20
03) (prog-if 20 [EHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 10
        Memory at d0000000 (32-bit, non-prefetchable) [size=3D1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 0=
0=20
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D=
64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: d0200000-d05fffff

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage=20
Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1860 [size=3D16]
        [virtual] Memory at 20000000 (32-bit, non-prefetchable) [disabled]=
=20
[size=3D1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: medium devsel, IRQ 10
        I/O ports at 1880 [size=3D32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio=
=20
Controller (rev 03)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: medium devsel, IRQ 10
        I/O ports at 1c00 [disabled] [size=3D256]
        I/O ports at 18c0 [disabled] [size=3D64]
        [virtual] Memory at d0000c00 (32-bit, non-prefetchable) [disabled]=
=20
[size=3D512]
        [virtual] Memory at d0000800 (32-bit, non-prefetchable) [disabled]=
=20
[size=3D256]
        Capabilities: [50] Power Management version 2

00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03)=20
(prog-if 00 [Generic])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: medium devsel, IRQ 10
        I/O ports at 2400 [disabled] [size=3D256]
        I/O ports at 2000 [disabled] [size=3D128]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Rad=
eon=20
Mobility 9000 M9] (rev 01) (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel,=
=20
latency 66, IRQ 10
        Memory at d8000000 (32-bit, prefetchable) [size=3D128M]
        I/O ports at 3000 [size=3D256]
        Memory at d0100000 (32-bit, non-prefetchable) [size=3D64K]
        Expansion ROM at <unassigned> [disabled] [size=3D128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: fast devsel, IRQ 5
        [virtual] Memory at d0204000 (32-bit, non-prefetchable) [disabled]=
=20
[size=3D8K]
        Capabilities: [40] Power Management version 2

02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI=20
Adapter (rev 04)
        Subsystem: Intel Corp.: Unknown device 2527
        Flags: medium devsel, IRQ 10
        [virtual] Memory at d0206000 (32-bit, non-prefetchable) [disabled]=
=20
[size=3D4K]
        Capabilities: [dc] Power Management version 2

02:06.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
        Subsystem: Unknown device 0001:0000
        Flags: bus master, stepping, slow devsel, latency 168, IRQ 10
        Memory at d0207000 (32-bit, non-prefetchable) [size=3D4K]
        Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D=
176
        Memory window 0: d0400000-d04ff000 (prefetchable)
        Memory window 1: d0300000-d03ff000
        I/O window 0: 00004400-000044ff
        I/O window 1: 00004000-000040ff
        16-bit legacy interface ports at 0001

02:06.1 Class ffff: O2 Micro, Inc.: Unknown device 7114 (rev ff) (prog-if f=
f)
        !!! Unknown header type 7f

02:06.2 System peripheral: O2 Micro, Inc.: Unknown device 7110
        Subsystem: Unknown device 0001:0000
        Flags: slow devsel, IRQ 10
        Memory at d0208000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [a0] Power Management version 2

02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000=20
Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: medium devsel, IRQ 10
        [virtual] Memory at d0209000 (32-bit, non-prefetchable) [disabled]=
=20
[size=3D2K]
        [virtual] Memory at d0200000 (32-bit, non-prefetchable) [disabled]=
=20
[size=3D16K]
        Capabilities: [44] Power Management version 2

Here's a dmesg of suspend/resume:
[ACPI Debug] String: Length 0x19, "Sleep Button Query: Fn+F4"
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
uhci_hcd 0000:00:1d.0: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:1d.0: USB bus 2 deregistered
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb3: USB disconnect, address 1
usb 3-1: USB disconnect, address 2
uhci_hcd 0000:00:1d.1: USB bus 3 deregistered
uhci_hcd 0000:00:1d.2: remove, state 1
usb usb4: USB disconnect, address 1
uhci_hcd 0000:00:1d.2: USB bus 4 deregistered
drivers/usb/core/usb.c: deregistering driver hid
PM: Preparing system for suspend
Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D|
[ACPI Debug] String: Length 0x16, ">>>> _PTS ------------"
[ACPI Debug] Integer: 0x0000000000000003
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
radeonfb: suspending to state: 2...
PM: Entering state.
 hwsleep-0265 [903] acpi_enter_sleep_state: Entering sleep state [S3]
Back to C!
zapping low mappings.
PM: Finishing up.
radeonfb: resumed !
PCMCIA: socket de92202c: *** DANGER *** unable to remove socket power
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue dfcf0c00, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
[ACPI Debug] String: Length 0x16, ">>>> _WAK ------------"
[ACPI Debug] Integer: 0x0000000000000002
Restarting tasks... done
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e18da000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-1: new low speed USB device using address 2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on=20
usb-0000:00:1d.1-1
MCE: The hardware reports a non fatal, correctable incident occurred on CPU=
 0.
Bank 1: f200000000000135


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
