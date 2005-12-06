From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: Re: 2.6.15-rc5-mm1
Date: Tue, 6 Dec 2005 14:08:41 +1100
Message-ID: <20051206140841.2c3d7c52.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__6_Dec_2005_14_08_41_+1100_Pf0FT8GpVi8kOSQZ"
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
Cc: Roman I Khimov <rik-MdmE8JOsREphl2p70BpVqQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__6_Dec_2005_14_08_41_+1100_Pf0FT8GpVi8kOSQZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


I assume this is due to recent updates in Len's tree.


Begin forwarded message:

Date: Mon, 5 Dec 2005 21:59:05 +0300
From: Roman I Khimov <rik-MdmE8JOsREphl2p70BpVqQ@public.gmane.org>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: 2.6.15-rc5-mm1


Hello.

5 ______________ 2005 10:21 | Andrew Morton:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/

Something went wrong with ACPI, my fan is blowing constantly. This is an
old MiTAC notebook with mobile Athlon XP 1700+.

Here is the diff between dmesg on 2.6.15-rc3-mm1 and 2.6.15-rc5-mm1:

rik@pu-erh:~> diff -up dmesg-2.6.15-rc3-mm1 dmesg-2.6.15-rc5-mm1
--- dmesg-2.6.15-rc3-mm1        2005-12-05 21:49:10.291930507 +0300
+++ dmesg-2.6.15-rc5-mm1        2005-12-05 21:45:13.203193011 +0300
@@ -1,4 +1,4 @@
-Linux version 2.6.15-rc3-mm1-pu-erh-static (root@pu-erh) (gcc version 3.3.3 (SuSE Linux)) #1 PREEMPT Wed Nov 30 15:04:54 MSK 2005
+Linux version 2.6.15-rc5-mm1-pu-erh (root@pu-erh) (gcc version 3.3.3 (SuSE Linux)) #1 PREEMPT Mon Dec 5 18:01:01 MSK 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -9,10 +9,10 @@ BIOS-provided physical RAM map:
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 735MB LOWMEM available.
 On node 0 totalpages: 188400
-  DMA zone: 4096 pages, LIFO batch:2
-  DMA32 zone: 0 pages, LIFO batch:2
-  Normal zone: 184304 pages, LIFO batch:64
-  HighMem zone: 0 pages, LIFO batch:2
+  DMA zone: 4096 pages, LIFO batch:0
+  DMA32 zone: 0 pages, LIFO batch:0
+  Normal zone: 184304 pages, LIFO batch:31
+  HighMem zone: 0 pages, LIFO batch:0
 DMI 2.3 present.
 ACPI: RSDP (v000 OID_00                                ) @ 0x000e5010
 ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010100) @ 0x2dfffbc0
@@ -31,14 +31,14 @@ Initializing CPU#0
 Kernel command line: lapic root=/dev/hda3 video=savagefb:1024x768-32@60 splash=silent desktop resume=/dev/hda5 showopts init=/sbin/initng rw
 CPU 0 irqstacks, hard=c0498000 soft=c0497000
 PID hash table entries: 4096 (order: 12, 65536 bytes)
-Detected 1459.924 MHz processor.
+Detected 1459.922 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 742096k/753600k available (2626k kernel code, 10964k reserved, 844k data, 180k init, 0k highmem)
+Memory: 742140k/753600k available (2627k kernel code, 10964k reserved, 843k data, 180k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 2922.34 BogoMIPS (lpj=1461170)
+Calibrating delay using timer specific routine.. 2922.34 BogoMIPS (lpj=1461172)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
 CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
@@ -56,12 +56,10 @@ NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: PCI BIOS revision 2.10 entry at 0xe8b24, last bus=1
 PCI: Using configuration type 1
-usbcore: registered new driver usbfs
-usbcore: registered new driver hub
 ACPI: Subsystem revision 20050916
-spurious 8259A interrupt: IRQ7.
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
+spurious 8259A interrupt: IRQ7.
 ACPI: PCI Root Bridge [PCI0] (0000:00)
 PCI: Probing PCI hardware (bus 00)
 ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
@@ -77,6 +75,8 @@ ACPI: PCI Interrupt Link [LNKD] (IRQs 5
 Linux Plug and Play Support v0.97 (c) Adam Belay
 pnp: PnP ACPI init
 pnp: PnP ACPI: found 11 devices
+usbcore: registered new driver usbfs
+usbcore: registered new driver hub
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
 pnp: 00:07: ioport range 0x330-0x331 has been reserved
@@ -103,37 +103,12 @@ Total HugeTLB memory allocated, 0
 Initializing Cryptographic API
 io scheduler noop registered
 io scheduler cfq registered
-ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
-ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
-ehci_hcd 0000:00:10.3: EHCI Host Controller
-ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
-ehci_hcd 0000:00:10.3: irq 11, io mem 0xf0000000
-ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
-usb usb1: configuration #1 chosen from 1 choice
-hub 1-0:1.0: USB hub found
-hub 1-0:1.0: 4 ports detected
-USB Universal Host Controller Interface driver v2.3
 ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
 PCI: setting IRQ 10 as level-triggered
-ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
-uhci_hcd 0000:00:10.0: UHCI Host Controller
-uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
-uhci_hcd 0000:00:10.0: irq 10, io base 0x00001200
-usb usb2: configuration #1 chosen from 1 choice
-hub 2-0:1.0: USB hub found
-hub 2-0:1.0: 2 ports detected
-ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
-uhci_hcd 0000:00:10.1: UHCI Host Controller
-uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
-uhci_hcd 0000:00:10.1: irq 11, io base 0x00001300
-usb usb3: configuration #1 chosen from 1 choice
-hub 3-0:1.0: USB hub found
-hub 3-0:1.0: 2 ports detected
-usbcore: registered new driver libusual
 ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
 savagefb: mapped io at ee880000
 savagefb: probed videoram:  32768k
-savagefb: Detected current MCLK value of 25256 kHz
+savagefb: Detected current MCLK value of 14318 kHz
 savagefb: mapped framebuffer at ee980000, pbase == 90000000
 savagefb v0.4.0_2.6: 32640kB VRAM, using 1024x768, 48.364kHz, 60Hz
 Console: switching to colour frame buffer device 128x48
@@ -145,7 +120,6 @@ ACPI: Sleep Button (CM) [SBTN]
 ACPI: Lid Switch [LID]
 ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
 Using specific hotkey driver
-ACPI: CPU0 (power states: C1[C1] C2[C2])
 ACPI: Processor [CPU0] (supports 16 throttling states)
 Real Time Clock Driver v1.12
 Non-volatile memory driver v1.2
@@ -171,7 +145,7 @@ loop: loaded (max 8 devices)
 via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
 ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
 eth0: VIA Rhine II at 0xf0000100, 00:40:d0:2e:06:bc, IRQ 10.
-eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
+eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 VP_IDE: IDE controller at PCI slot 0000:00:11.1
@@ -184,9 +158,9 @@ VP_IDE: VIA vt8235 (rev 00) IDE UDMA133
 Probing IDE interface ide0...
 hda: ST94811A, ATA DISK drive
 Synaptics Touchpad, model: 1, fw: 5.1, id: 0x8f40b1, caps: 0x80471b/0x0
-input: SynPS/2 Synaptics TouchPad as /class/input/input1
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 Probing IDE interface ide1...
+input: SynPS/2 Synaptics TouchPad as /class/input/input1
 hdc: QSI CD-RW/DVD-ROM SBW-161, ATAPI CD/DVD-ROM drive
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: max request size: 1024KiB
@@ -202,13 +176,39 @@ ACPI: PCI Interrupt 0000:00:0b.0[A] -> L
 ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[fedff800-fedfffff]  Max Packet=[2048]
 ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
 Yenta: CardBus bridge found at 0000:00:09.0 [1071:8375]
-Yenta: ISA IRQ mask 0x0010, PCI irq 11
+Yenta: ISA IRQ mask 0x0040, PCI irq 11
 Socket status: 30000006
+ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
+ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
+ehci_hcd 0000:00:10.3: EHCI Host Controller
+ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
+ehci_hcd 0000:00:10.3: irq 11, io mem 0xf0000000
+ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
+usb usb1: configuration #1 chosen from 1 choice
+hub 1-0:1.0: USB hub found
+hub 1-0:1.0: 4 ports detected
+USB Universal Host Controller Interface driver v2.3
+ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
+uhci_hcd 0000:00:10.0: UHCI Host Controller
+uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
+uhci_hcd 0000:00:10.0: irq 10, io base 0x00001200
+usb usb2: configuration #1 chosen from 1 choice
+hub 2-0:1.0: USB hub found
+hub 2-0:1.0: 2 ports detected
+ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
+uhci_hcd 0000:00:10.1: UHCI Host Controller
+uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
+uhci_hcd 0000:00:10.1: irq 11, io base 0x00001300
+usb usb3: configuration #1 chosen from 1 choice
+hub 3-0:1.0: USB hub found
+hub 3-0:1.0: 2 ports detected
+usbcore: registered new driver libusual
 i2c /dev entries driver
 device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
 Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 13:30:21 2005 UTC).
 ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
 PCI: Setting latency timer of device 0000:00:11.5 to 64
+ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0040d001000a8f08]
 ACPI: PCI Interrupt 0000:00:11.6[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
 PCI: Setting latency timer of device 0000:00:11.6 to 64
 ALSA device list:
@@ -223,11 +223,10 @@ TCP reno registered
 TCP bic registered
 NET: Registered protocol family 1
 powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
-Detected 1459.676 MHz processor.
+Detected 1460.133 MHz processor.
 powernow: SGTC: 13333
-powernow: Minimum speed 862 MHz. Maximum speed 1459 MHz.
+powernow: Minimum speed 862 MHz. Maximum speed 1460 MHz.
 Using IPI Shortcut mode
-ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0040d001000a8f08]
 ACPI wakeup devices:
 SBTN USB0 USB1 AC97 MC97 LAN0 FSD0
 ACPI: (supports S0 S3 S4 S5)
@@ -238,7 +237,7 @@ ReiserFS: hda3: checking transaction log
 ReiserFS: hda3: Using r5 hash to sort names
 VFS: Mounted root (reiserfs filesystem).
 Freeing unused kernel memory: 180k freed
-Write protecting the kernel read-only data: 402k
+Write protecting the kernel read-only data: 403k
 Loading Reiser4. See www.namesys.com for a description of Reiser4.
 Adding 979892k swap on /dev/hda5.  Priority:-1 extents:1 across:979892k
 NET: Registered protocol family 17


Also DMA info in the start of the log looks strange to me (but everything
works).

Any additional info on request, any patches are welcome.

-- 
                            Roman
 ,---------------------------. ,--------------------------.
/     http://www.3os.ru/      V    http://www.osrc.info/   \         .o.
\    mailto: rik-EZ1ikkraMFw@public.gmane.org       ^   mailto: rik-MdmE8JOsREphl2p70BpVqQ@public.gmane.org    /         ..o
 `---------------------------' `--------------------------'          ooo
gpg --recv-keys 0xE5E055C3 --keyserver hkp://subkeys.pgp.net


--Multipart=_Tue__6_Dec_2005_14_08_41_+1100_Pf0FT8GpVi8kOSQZ
Content-Type: application/pgp-signature;
 name="00000000.mimetmp"
Content-Disposition: attachment;
 filename="00000000.mimetmp"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuMi40IChHTlUv
TGludXgpCgppRDhEQlFCRGxJMzlYSjcweitYZ1ZjTVJBb2pxQUtDYndtS0ZJNndaK2NGTjNGcHRj
azEzaE90b3NnQ2VMQnVvClQrTGpndXR6bFo2akJVV0tzWlJac2tVPQo9bUNNbwotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--Multipart=_Tue__6_Dec_2005_14_08_41_+1100_Pf0FT8GpVi8kOSQZ--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
