From: Jan Kokoska <kokoskaj-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Subject: Lost interrupt on IRQ 11 during swsusp2; CC me on reply
Date: Sat, 25 Sep 2004 15:07:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1096121275.2502.32.camel@zirael>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-OEjsr854L3lPPNqs0b2E"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


--=-OEjsr854L3lPPNqs0b2E
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

swsusp2 guys asked me to forward the bug report to you, so here it
comes.

I got swsusp2 working fine, about 10 suspends without trouble (once I
figured out ACPI is not happy about my USB HCI module being loaded, just
to be sure I also unload Intel Centrino's ipw2100 in my scripts).

But after one resume, all my terminals printed "Disabling IRQ #11", to
which IRQ just about everything (/proc/interrupts attached) in this IBM
Thinkpad R40 laptop seems to be bound, including e100 NIC, which
couldn't go on network subsequently.

I found the following in kern.log, reboot fixed it of course. But I am
wondering what is the cause, the lost interrupt was on FireWire bus,
does that have anything to do with it?

Kernel 2.6.8.1, ACPI patch 20040816-26-stable-release, swsusp2 
2.0.0.105-for-2.6.8.1. Everything I attach except for kern.log is newer,
i.e. dmesg doesn't show trace of this particular problem, but might be
useful nevertheless.

Jan Kokoska

--

kern.log:

Sep 24 08:52:41 zirael kernel: ACPI: PCI interrupt 0000:00:1d.7[D] ->
GSI 11 (level, low) -> IRQ 11
Sep 24 08:52:41 zirael kernel: ehci_hcd 0000:00:1d.7: Intel Corp.
82801DB (ICH4) USB2 EHCI Controller
Sep 24 08:52:41 zirael kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Sep 24 08:52:41 zirael kernel: ehci_hcd 0000:00:1d.7: irq 11, pci mem
f0a34000
Sep 24 08:52:41 zirael kernel: ehci_hcd 0000:00:1d.7: new USB bus
registered, assigned bus number 1
Sep 24 08:52:41 zirael kernel: PCI: cache line size of 32 is not
supported by device 0000:00:1d.7
Sep 24 08:52:41 zirael kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled,
EHCI 1.00, driver 2004-May-10
Sep 24 08:52:41 zirael kernel: hub 1-0:1.0: USB hub found
Sep 24 08:52:41 zirael kernel: hub 1-0:1.0: 6 ports detected
Sep 24 08:52:42 zirael kernel: Warning: CPU frequency out of sync:
cpufreq and timing core thinks of 1400000, is 600000 kHz.
Sep 24 09:17:57 zirael kernel: ehci_hcd 0000:00:1d.7: remove, state 1
Sep 24 09:17:57 zirael kernel: usb usb1: USB disconnect, address 1
Sep 24 09:17:57 zirael kernel: ehci_hcd 0000:00:1d.7: USB bus 1
deregistered
Sep 24 09:17:59 zirael kernel: Software Suspend 2.0.0.105: Initiating a
software_suspend cycle.
Sep 24 09:18:23 zirael kernel: Unable to allocate enough swap. Got 24
pages of 126 wanted.
Sep 24 09:18:23 zirael kernel: ACPI: PCI interrupt 0000:00:1f.1[A] ->
GSI 11 (level, low) -> IRQ 11
Sep 24 09:18:23 zirael kernel: ACPI: PCI interrupt 0000:00:1d.7[D] ->
GSI 11 (level, low) -> IRQ 11
Sep 24 09:18:23 zirael kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
Sep 24 09:18:23 zirael kernel: ACPI: PCI interrupt 0000:00:1f.5[B] ->
GSI 11 (level, low) -> IRQ 11
Sep 24 09:18:23 zirael kernel: PCI: Setting latency timer of device
0000:00:1f.5 to 64
Sep 24 09:18:23 zirael kernel: ACPI: PCI interrupt 0000:00:1f.6[B] ->
GSI 11 (level, low) -> IRQ 11
Sep 24 09:18:23 zirael kernel: PCI: Setting latency timer of device
0000:00:1f.6 to 64
Sep 24 09:18:23 zirael kernel: ACPI: PCI interrupt 0000:02:07.0[A] ->
GSI 11 (level, low) -> IRQ 11
Sep 24 09:18:23 zirael kernel: irq 11: nobody cared!
Sep 24 09:18:23 zirael kernel:  [__report_bad_irq+42/144]
__report_bad_irq+0x2a/0x90
Sep 24 09:18:23 zirael kernel:  [note_interrupt+112/176] note_interrupt
+0x70/0xb0
Sep 24 09:18:23 zirael kernel:  [do_IRQ+288/304] do_IRQ+0x120/0x130
Sep 24 09:18:23 zirael kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Sep 24 09:18:23 zirael kernel:  [__do_softirq+46/128] __do_softirq
+0x2e/0x80
Sep 24 09:18:23 zirael kernel:  [do_softirq+39/48] do_softirq+0x27/0x30
Sep 24 09:18:23 zirael kernel:  [do_IRQ+251/304] do_IRQ+0xfb/0x130
Sep 24 09:18:23 zirael kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Sep 24 09:18:23 zirael kernel:  [delay_pmtmr+20/32] delay_pmtmr
+0x14/0x20
Sep 24 09:18:23 zirael kernel:  [__delay+18/32] __delay+0x12/0x20
Sep 24 09:18:23 zirael kernel:  [e100_hw_reset+125/160] e100_hw_reset
+0x7d/0xa0
Sep 24 09:18:23 zirael kernel:  [e100_hw_init+19/1680] e100_hw_init
+0x13/0x690
Sep 24 09:18:23 zirael kernel:  [__get_free_pages+31/64]
__get_free_pages+0x1f/0x40
Sep 24 09:18:23 zirael kernel:  [dma_alloc_coherent+74/128]
dma_alloc_coherent+0x4a/0x80
Sep 24 09:18:23 zirael kernel:  [e100_alloc_cbs+112/352] e100_alloc_cbs
+0x70/0x160
Sep 24 09:18:23 zirael kernel:  [e100_up+81/464] e100_up+0x51/0x1d0
Sep 24 09:18:23 zirael kernel:  [e100_resume+168/208] e100_resume
+0xa8/0xd0
Sep 24 09:18:23 zirael kernel:  [pci_device_resume+42/48]
pci_device_resume+0x2a/0x30
Sep 24 09:18:23 zirael kernel:  [resume_device+41/48] resume_device
+0x29/0x30
Sep 24 09:18:23 zirael kernel:  [dpm_resume_tree+108/112]
dpm_resume_tree+0x6c/0x70
Sep 24 09:18:23 zirael kernel:  [dpm_resume+15/32] dpm_resume+0xf/0x20
Sep 24 09:18:23 zirael kernel:  [device_resume+25/48] device_resume
+0x19/0x30
Sep 24 09:18:23 zirael kernel:  [do_suspend2_resume_2+162/192]
do_suspend2_resume_2+0xa2/0xc0
Sep 24 09:18:23 zirael kernel:  [do_suspend2_lowlevel+1556/1576]
do_suspend2_lowlevel+0x614/0x628
Sep 24 09:18:23 zirael kernel:  [save_image+335/432] save_image
+0x14f/0x1b0
Sep 24 09:18:23 zirael kernel:  [do_activate+2185/2192] do_activate
+0x889/0x890
Sep 24 09:18:23 zirael kernel:  [software_suspend_pending+80/96]
software_suspend_pending+0x50/0x60
Sep 24 09:18:23 zirael kernel:  [proc_software_suspend_pending+5/16]
proc_software_suspend_pending+0x5/0x10
Sep 24 09:18:23 zirael kernel:  [proc_file_write+55/80] proc_file_write
+0x37/0x50
Sep 24 09:18:23 zirael kernel:  [vfs_write+237/352] vfs_write+0xed/0x160
Sep 24 09:18:23 zirael kernel:  [filp_close+89/144] filp_close+0x59/0x90
Sep 24 09:18:23 zirael kernel:  [sys_write+81/128] sys_write+0x51/0x80
Sep 24 09:18:23 zirael kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 24 09:18:23 zirael kernel: handlers:
Sep 24 09:18:23 zirael kernel: [yenta_interrupt+0/64] (yenta_interrupt
+0x0/0x40)
Sep 24 09:18:23 zirael kernel: [snd_intel8x0_interrupt+0/608]
(snd_intel8x0_interrupt+0x0/0x260)
Sep 24 09:18:23 zirael kernel: [snd_intel8x0_interrupt+0/560]
(snd_intel8x0_interrupt+0x0/0x230)
Sep 24 09:18:23 zirael kernel: [__crc_do_softirq+286697/1620852]
(ohci_irq_handler+0x0/0x840 [ohci1394])
Sep 24 09:18:23 zirael kernel: [radeon_irq_handler+0/192]
(radeon_irq_handler+0x0/0xc0)
Sep 24 09:18:23 zirael kernel: Disabling IRQ #11
Sep 24 09:18:23 zirael kernel: Please include the following information
in bug reports:
Sep 24 09:18:23 zirael kernel: - SWSUSP core    : 2.0.0.105
Sep 24 09:18:23 zirael kernel: - Kernel Version : 2.6.8-qua
Sep 24 09:18:23 zirael kernel: - Version spec.  : 2.0.1
Sep 24 09:18:23 zirael kernel: - Compiler vers. : 3.3
Sep 24 09:18:23 zirael kernel: - Modules loaded : ipv6 ibm_acpi ohci1394
ieee1394 
Sep 24 09:18:23 zirael kernel: - Attempt number : 5
Sep 24 09:18:23 zirael kernel: - Pageset sizes  : 19991 and 102595
(102595 low).
Sep 24 09:18:23 zirael kernel: - Parameters     : 0 2048 0 1 0 2048
Sep 24 09:18:23 zirael kernel: - Calculations   : Image size: 122712.
Ram to suspend: 3601.
Sep 24 09:18:23 zirael kernel: - Limits         : 196448 pages RAM.
Initial boot: 191468.
Sep 24 09:18:23 zirael kernel: - Overall expected compression
percentage: 0.
Sep 24 09:18:23 zirael kernel: - LZF Compressor enabled.
Sep 24 09:18:23 zirael kernel:   Compressed 502112256 bytes into
251079037 (49 percent compression).
Sep 24 09:18:23 zirael kernel: - Swapwriter active.
Sep 24 09:18:23 zirael kernel:   Swap available for image: 0.
Sep 24 09:18:23 zirael kernel: - Debugging compiled in.
Sep 24 09:18:23 zirael kernel: - Preemptive kernel.
Sep 24 09:18:23 zirael kernel: - Max ranges used: 42098 ranges in 124
pages.
Sep 24 09:18:23 zirael kernel: - I/O speed: Write 48 MB/s, Read 51 MB/s.

--

/proc/version:

Linux version 2.6.8-qua (root@zirael) (gcc version 3.3.4 (Debian
1:3.3.4-11)) #1 Sun Sep 19 23:28:37 BST 2004

--

/proc/interrupts:

           CPU0       
  0:   37935438          XT-PIC  timer
  1:     108420          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:    5360716          XT-PIC  rtc
  9:       1124          XT-PIC  acpi
 11:    2614609          XT-PIC  yenta, Intel 82801DB-ICH4, Intel
82801DB-ICH4 Modem, ohci1394, radeon@PCI:1:0:0, eth0, ehci_hcd
 12:    2821715          XT-PIC  i8042
 14:     185744          XT-PIC  ide0
 15:         30          XT-PIC  ide1
NMI:          0 
ERR:          0


--=-OEjsr854L3lPPNqs0b2E
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

e Suspend text mode support loading.
Software Suspend LZF Compression Driver registering.
Software Suspend Swap Writer registering.
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
 LID SLPB PCI0 UART PCI1 USB0 USB1 USB2 AC9M 
Software Suspend 2.0.0.105: Swap space signature found.
Software Suspend 2.0.0.105: Suspending enabled.
Software Suspend 2.0.0.105: Checking for image...
Software Suspend 2.0.0.105: This is normal swap space.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 491356k swap on /dev/hda1.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem f0a30000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ieee80211_crypt: registered algorithm 'NULL'
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.54
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ipw2100: 0000:02:02.0: Detected at mem: 0xC0204000-0xC0204FFF -> f0a38000, irq: 11
eth1: Using hotplug firmware load.
eth1: Bound to 0000:02:02.0
ohci1394: $Rev: 1223 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[c0206000-c02067ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b0020101780]
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
ibm_acpi: IBM ThinkPad ACPI Extras v0.4
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0469120(lo)
IPv6 over IPv4 tunneling driver
ieee80211_crypt: unregistered algorithm 'NULL' (deinit)
cdrom: open failed.
eth0: no IPv6 routers present
ieee80211_crypt: registered algorithm 'NULL'
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.54
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ipw2100: 0000:02:02.0: Detected at mem: 0xC0204000-0xC0204FFF -> f0a49000, irq: 11
eth1: Using hotplug firmware load.
eth1: Bound to 0000:02:02.0
ieee80211_crypt: unregistered algorithm 'NULL' (deinit)
mtrr: 0xe0000000,0x2000000 overlaps existing 0xe0000000,0x100000
mtrr: 0xe0000000,0x2000000 overlaps existing 0xe0000000,0x100000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ieee80211_crypt: registered algorithm 'NULL'
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.54
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ipw2100: 0000:02:02.0: Detected at mem: 0xC0204000-0xC0204FFF -> f0a51000, irq: 11
eth1: Using hotplug firmware load.
eth1: Bound to 0000:02:02.0
ieee80211_crypt: unregistered algorithm 'NULL' (deinit)
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
PM: Preparing system for suspend
PM: Entering state.
Back to C!
PM: Finishing up.
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem f0a4b000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
Software Suspend 2.0.0.105: Initiating a software_suspend cycle.
Unable to allocate enough swap. Got 51 pages of 215 wanted.
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Please include the following information in bug reports:
- SWSUSP core    : 2.0.0.105
- Kernel Version : 2.6.8-qua
- Version spec.  : 2.0.1
- Compiler vers. : 3.3
- Modules loaded : ipv6 ibm_acpi ohci1394 ieee1394 
- Attempt number : 1
- Pageset sizes  : 49817 and 72256 (72256 low).
- Parameters     : 0 2048 0 1 0 2048
- Calculations   : Image size: 122288. Ram to suspend: 3601.
- Limits         : 196448 pages RAM. Initial boot: 191468.
- Overall expected compression percentage: 0.
- LZF Compressor enabled.
  Compressed 500011008 bytes into 220987261 (55 percent compression).
- Swapwriter active.
  Swap available for image: 0.
- Debugging compiled in.
- Preemptive kernel.
- Max ranges used: 72453 ranges in 213 pages.
- I/O speed: Write 52 MB/s, Read 54 MB/s.
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem f0a4b000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
Warning: CPU frequency out of sync: cpufreq and timing core thinks of 1400000, is 600000 kHz.
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
PM: Preparing system for suspend
PM: Entering state.
Back to C!
PM: Finishing up.
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem f0a4b000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
Software Suspend 2.0.0.105: Initiating a software_suspend cycle.
Unable to allocate enough swap. Got 14 pages of 182 wanted.
Unable to allocate enough swap. Got 0 pages of 169 wanted.
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Please include the following information in bug reports:
- SWSUSP core    : 2.0.0.105
- Kernel Version : 2.6.8-qua
- Version spec.  : 2.0.1
- Compiler vers. : 3.3
- Modules loaded : ipv6 ibm_acpi ohci1394 ieee1394 
- Attempt number : 2
- Pageset sizes  : 42515 and 80076 (80076 low).
- Parameters     : 0 2048 0 1 0 2048
- Calculations   : Image size: 122773. Ram to suspend: 3601.
- Limits         : 196448 pages RAM. Initial boot: 191468.
- Overall expected compression percentage: 0.
- LZF Compressor enabled.
  Compressed 502132736 bytes into 218059051 (56 percent compression).
- Swapwriter active.
  Swap available for image: 0.
- Debugging compiled in.
- Preemptive kernel.
- Max ranges used: 61172 ranges in 180 pages.
- I/O speed: Write 53 MB/s, Read 58 MB/s.
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem f0a4b000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
PM: Preparing system for suspend
PM: Entering state.
Back to C!
PM: Finishing up.
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem f0a4b000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
PM: Preparing system for suspend
PM: Entering state.
Back to C!
PM: Finishing up.
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem f0a4b000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
PM: Preparing system for suspend
PM: Entering state.
Back to C!
PM: Finishing up.
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem f0a4b000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected

--=-OEjsr854L3lPPNqs0b2E
Content-Disposition: attachment; filename=lspci-vvxxx
Content-Type: text/plain; name=lspci-vvxxx; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
	Subsystem: IBM: Unknown device 0529
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
00: 86 80 40 33 06 01 90 20 03 00 00 06 00 00 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 29 05
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 02 00 00 00 00 00 00 00 00 00 00 00 27 00 00
60: 04 08 10 18 00 00 00 00 00 00 00 00 00 00 00 00
70: 02 03 00 00 00 00 00 00 00 02 02 2c 71 32 40 30
80: 71 00 80 05 00 00 00 00 00 02 01 00 00 00 00 00
90: 10 11 11 00 30 11 11 00 41 19 00 00 00 1a 3d 00
a0: 02 00 20 00 17 02 00 1f 01 03 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 d0 2f 20 10 00 00
c0: 44 40 50 11 00 30 05 08 00 00 00 00 00 00 00 00
d0: 02 28 00 0e 0b 00 00 30 00 00 31 b5 00 00 02 00
e0: 00 00 00 00 09 a0 04 f1 00 00 00 00 00 00 00 00
f0: 00 00 01 00 74 f8 20 80 38 0f 00 00 04 00 00 00

0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 41 33 07 01 a0 00 03 00 04 06 00 60 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 02
20: 10 c0 10 c0 00 e0 f0 e7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: da 93 ff 2f 3b f4 09 00 cc 9b ff df 52 f4 01 00
60: 01 00 00 00 52 48 80 00 b2 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 1800 [size=32]
00: 86 80 c2 24 05 00 80 02 01 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 14 10 2d 05
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1820 [size=32]
00: 86 80 c4 24 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 14 10 2d 05
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 1840 [size=32]
00: 86 80 c7 24 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 14 10 2d 05
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 052e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]
00: 86 80 cd 24 06 01 90 02 01 20 03 0c 00 00 00 00
10: 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 2e 05
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 c2 c9 00 00 00 00 0a 00 80 20 00 00 00 00
60: 20 20 7f 00 00 00 00 00 01 00 00 00 00 00 08 c0
70: 00 00 c5 0f 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3f 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 78 bf 1f 00 88 83 00 00 60 0f 00 00 06 00 00 00

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=64
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 48 24 07 01 80 80 81 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 05 40 40 80 80 22
20: 20 c0 f0 cf 00 e8 f0 ef 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00
40: 02 28 20 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 74 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 60 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 01 00 02 00 00 00 c0 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 2e 48

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 cc 24 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 10 00 00 10 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 81 11 00 00 10 00 00 00
60: 0b 0b 0b 0b 92 00 00 00 0b 80 80 0b 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: ff fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 24 02 00 00 00 00 00 00 0d 00 00 00 00 00 08 00
b0: 00 00 00 00 00 00 00 00 00 00 02 02 00 00 00 00
c0: 80 00 00 00 00 00 00 00 00 00 80 00 00 00 00 00
d0: 07 28 00 02 02 0f 00 00 04 00 00 00 00 00 00 00
e0: 10 02 00 ff 01 16 07 3c 33 22 11 00 00 00 67 45
f0: 00 00 00 00 00 00 00 00 60 0f 03 00 00 00 80 00

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 30000000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 ca 24 07 00 80 02 01 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 61 18 00 00 00 00 00 30 00 00 00 00 14 10 2d 05
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
40: 07 a3 07 a3 00 00 00 00 05 00 01 02 00 00 00 00
50: 00 00 00 00 11 14 00 00 00 00 00 00 00 00 00 00
60: 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1880 [size=32]
00: 86 80 c3 24 01 00 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 18 00 00 00 00 00 00 00 00 00 00 14 10 2d 05
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00
40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
	Subsystem: IBM: Unknown device 0523
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at c0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c5 24 07 00 90 02 01 00 01 04 00 00 00 00
10: 01 1c 00 00 c1 18 00 00 00 0c 00 c0 00 08 00 c0
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 23 05
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 02 00 00
40: 09 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0524
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 c6 24 05 00 90 02 01 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 24 05
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0527
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 57 4c 87 03 b0 02 00 00 00 03 08 42 00 00
10: 08 00 00 e0 01 30 00 00 00 00 10 c0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 27 05
30: 00 00 00 00 58 00 00 00 00 00 00 00 0b 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 27 05
50: 01 00 02 06 00 00 00 00 02 50 20 00 07 02 00 2f
60: 01 03 00 1f 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:02:00.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller
	Subsystem: IBM: Unknown device 0528
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 30001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 30400000-307ff000 (prefetchable)
	Memory window 1: 30800000-30bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 56 ac 07 00 10 02 00 00 07 06 10 a8 02 00
10: 00 10 00 30 a0 00 00 02 02 03 06 b0 00 00 40 30
20: 00 f0 7f 30 00 00 80 30 00 f0 bf 30 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 0b 01 c0 05
40: 14 10 28 05 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 71 d0 44 08 00 00 00 00 00 00 00 00 02 10 d1 01
90: c0 02 64 40 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 12 fe 00 00 c0 00 11 00 00 00 07 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:02:02.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2551
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0204000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
00: 86 80 43 10 12 01 90 02 04 00 80 02 08 40 00 00
10: 00 40 20 c0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 51 25
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 02 22
40: 80 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 00
e0: 00 20 00 14 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: IBM: Unknown device 0515
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0206000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at c0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 26 80 16 01 10 02 00 10 00 0c 08 40 00 00
10: 00 60 20 c0 00 00 20 c0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 15 05
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 02 04
40: 00 00 00 00 01 00 02 7e 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00
f0: 00 00 00 00 00 10 00 00 14 10 15 05 00 00 00 00

0000:02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (MOB) Ethernet Controller (rev 81)
	Subsystem: IBM: Unknown device 0522
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0205000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 8000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 3d 10 17 01 90 02 81 00 00 02 08 42 00 00
10: 00 50 20 c0 01 80 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 22 05
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 38
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 fe
e0: 00 40 00 3a 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--=-OEjsr854L3lPPNqs0b2E--



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
