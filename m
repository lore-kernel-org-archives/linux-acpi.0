From: marco <marco@metm.org>
Subject: Re: suspend kills serial wacom tablet
Date: Mon, 16 Apr 2007 15:59:01 -0400
Message-ID: <4623D585.5010005@metm.org>
References: <pan.2007.02.20.13.52.07.111117@metm.org>	 <200704131249.23640.bjorn.helgaas@hp.com>	 <d120d5000704131216h7ccabc12uf0e649105fd7b6b0@mail.gmail.com>	 <200704131510.26565.bjorn.helgaas@hp.com> <d120d5000704131420n65dd47d1r97442785d8617977@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070800000306060007010405"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.metm.org ([64.81.200.243]:44930 "EHLO mail.metm.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753497AbXDPU0S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Apr 2007 16:26:18 -0400
In-Reply-To: <d120d5000704131420n65dd47d1r97442785d8617977@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070800000306060007010405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dmitry Torokhov wrote:
> On 4/13/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
>
>> I'm a little concerned because Marco said that after a resume,
>> "cat /dev/ttyS0" caused his system to hang, and not even Ctrl-Alt-Del
>> worked.  Can we blame that all on X?
>>
>
> No, I don't think we can. The device connected to the port is simply
> not re-initialized and mey either transmit garbage or not transmit
> data at all. However accessing the port should not hang kernel.
>
>> Would stopping the X server before suspend and restarting
>> it after resume be a workaround?
>>
>
> I do not think it is feasible.  If you have to shut down X you might
> as well shut down entire box.
>
Hello everyone,

Thanks for looking into this.  It is still a problem which renders the 
pen unusable after a suspend.
I am happy to run any tests you need.
Attatched are a dmesg right after a reboot when the pen is working 
dmesg.wpen and another dmesg after I suspend the laptop and the pen no 
longer works.

Thanks again, let me know if I can be of help,

-- 
Marco


--------------070800000306060007010405
Content-Type: text/plain;
 name="dmesg.wpen"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.wpen"

[17179569.184000] Linux version 2.6.17-11-386 (root@terranova) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #2 Thu Feb 1 19:50:13 UTC 2007 (Ubuntu 2.6.17-11.35-386)
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[17179569.184000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000003f6d0000 (usable)
[17179569.184000]  BIOS-e820: 000000003f6d0000 - 000000003f6e5000 (ACPI data)
[17179569.184000]  BIOS-e820: 000000003f6e5000 - 000000003f700000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
[17179569.184000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[17179569.184000]  BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[17179569.184000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[17179569.184000] 118MB HIGHMEM available.
[17179569.184000] 896MB LOWMEM available.
[17179569.184000] On node 0 totalpages: 259792
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
[17179569.184000]   Normal zone: 225280 pages, LIFO batch:31
[17179569.184000]   HighMem zone: 30416 pages, LIFO batch:7
[17179569.184000] DMI present.
[17179569.184000] ACPI: RSDP (v002 IBM                                   ) @ 0x000f6c90
[17179569.184000] ACPI: XSDT (v001 IBM    TP-75    0x00002010  LTP 0x00000000) @ 0x3f6d5c5e
[17179569.184000] ACPI: FADT (v003 IBM    TP-75    0x00002010 IBM  0x00000001) @ 0x3f6d5d00
[17179569.184000] ACPI: SSDT (v001 IBM    TP-75    0x00002010 MSFT 0x0100000e) @ 0x3f6d5eb4
[17179569.184000] ACPI: ECDT (v001 IBM    TP-75    0x00002010 IBM  0x00000001) @ 0x3f6e4d83
[17179569.184000] ACPI: TCPA (v001 IBM    TP-75    0x00002010 PTL  0x00000001) @ 0x3f6e4dd5
[17179569.184000] ACPI: MADT (v001 IBM    TP-75    0x00002010 IBM  0x00000001) @ 0x3f6e4e07
[17179569.184000] ACPI: MCFG (v001 IBM    TP-75    0x00002010 IBM  0x00000001) @ 0x3f6e4e61
[17179569.184000] ACPI: BOOT (v001 IBM    TP-75    0x00002010  LTP 0x00000001) @ 0x3f6e4fd8
[17179569.184000] ACPI: DSDT (v001 IBM    TP-75    0x00002010 MSFT 0x0100000e) @ 0x00000000
[17179569.184000] ACPI: PM-Timer IO Port: 0x1008
[17179569.184000] ACPI: Local APIC address 0xfee00000
[17179569.184000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 6:13 APIC version 20
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[17179569.184000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[17179569.184000] ACPI: IRQ0 used by override.
[17179569.184000] ACPI: IRQ2 used by override.
[17179569.184000] ACPI: IRQ9 used by override.
[17179569.184000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=UUID=70f86326-0df2-423d-9ce5-cb18aac2f9b3 ro quiet splash
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
[17179569.184000] Enabling fast FPU save and restore... done.
[17179569.184000] Enabling unmasked SIMD FPU exception support... done.
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[17179569.184000] Detected 1596.284 MHz processor.
[17179569.184000] Using pmtmr for high-res timesource
[17179569.184000] Console: colour VGA+ 80x25
[17179570.032000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[17179570.032000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[17179570.064000] Memory: 1019332k/1039168k available (1829k kernel code, 19196k reserved, 1041k data, 288k init, 121664k highmem)
[17179570.064000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[17179570.144000] Calibrating delay using timer specific routine.. 3196.90 BogoMIPS (lpj=6393813)
[17179570.144000] Security Framework v1.0.0 initialized
[17179570.144000] SELinux:  Disabled at boot.
[17179570.144000] Mount-cache hash table entries: 512
[17179570.144000] CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
[17179570.144000] CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
[17179570.144000] CPU: L1 I cache: 32K, L1 D cache: 32K
[17179570.144000] CPU: L2 cache: 2048K
[17179570.144000] CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
[17179570.144000] CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 08
[17179570.144000] Checking 'hlt' instruction... OK.
[17179570.160000] SMP alternatives: switching to UP code
[17179570.160000] Freeing SMP alternatives: 0k freed
[17179570.160000] checking if image is initramfs... it is
[17179570.840000] Freeing initrd memory: 6696k freed
[17179570.840000] ACPI: Core revision 20060707
[17179570.840000] ACPI: Looking for DSDT ... not found!
[17179570.856000] ENABLING IO-APIC IRQs
[17179570.856000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[17179571.000000] NET: Registered protocol family 16
[17179571.000000] EISA bus registered
[17179571.000000] ACPI: bus type pci registered
[17179571.000000] PCI: Using MMCONFIG
[17179571.000000] Setting up standard PCI resources
[17179571.000000] ACPI: Found ECDT
[17179571.132000] ACPI: Interpreter enabled
[17179571.132000] ACPI: Using IOAPIC for interrupt routing
[17179571.132000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.132000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.132000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.132000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.132000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.136000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.136000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.136000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.136000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[17179571.136000] PCI: Probing PCI hardware (bus 00)
[17179571.140000] Boot video device is 0000:00:02.0
[17179571.140000] PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[17179571.140000] PCI quirk: region 1180-11bf claimed by ICH6 GPIO
[17179571.140000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
[17179571.140000] PCI: Transparent bridge - 0000:00:1e.0
[17179571.140000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[17179571.144000] ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
[17179571.144000] ACPI: Power Resource [PUBS] (on)
[17179571.148000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
[17179571.148000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[17179571.152000] Linux Plug and Play Support v0.97 (c) Adam Belay
[17179571.152000] pnp: PnP ACPI init
[17179571.156000] pnp: PnP ACPI: found 12 devices
[17179571.156000] PnPBIOS: Disabled by ACPI PNP
[17179571.156000] PCI: Using ACPI for IRQ routing
[17179571.156000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[17179571.156000] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[17179571.156000] PCI: Bridge: 0000:00:1c.0
[17179571.156000]   IO window: disabled.
[17179571.156000]   MEM window: a0100000-a01fffff
[17179571.156000]   PREFETCH window: disabled.
[17179571.156000] PCI: Bus 5, cardbus bridge: 0000:04:00.0
[17179571.156000]   IO window: 00003000-000030ff
[17179571.156000]   IO window: 00003400-000034ff
[17179571.156000]   PREFETCH window: d0000000-d1ffffff
[17179571.156000]   MEM window: a2000000-a3ffffff
[17179571.156000] PCI: Bridge: 0000:00:1e.0
[17179571.156000]   IO window: 3000-6fff
[17179571.156000]   MEM window: a0200000-afffffff
[17179571.156000]   PREFETCH window: d0000000-d7ffffff
[17179571.156000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 169
[17179571.156000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[17179571.156000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[17179571.156000] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179571.156000] NET: Registered protocol family 2
[17179571.184000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[17179571.184000] TCP established hash table entries: 131072 (order: 7, 524288 bytes)
[17179571.184000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[17179571.184000] TCP: Hash tables configured (established 131072 bind 65536)
[17179571.184000] TCP reno registered
[17179571.184000] Simple Boot Flag at 0x35 set to 0x1
[17179571.184000] audit: initializing netlink socket (disabled)
[17179571.184000] audit(1176738752.184:1): initialized
[17179571.184000] highmem bounce pool size: 64 pages
[17179571.184000] VFS: Disk quotas dquot_6.5.1
[17179571.184000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[17179571.184000] Initializing Cryptographic API
[17179571.184000] io scheduler noop registered
[17179571.184000] io scheduler anticipatory registered
[17179571.184000] io scheduler deadline registered
[17179571.184000] io scheduler cfq registered (default)
[17179571.184000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 169
[17179571.184000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[17179571.184000] assign_interrupt_mode Found MSI capability
[17179571.184000] Allocate Port Service[0000:00:1c.0:pcie00]
[17179571.184000] Allocate Port Service[0000:00:1c.0:pcie02]
[17179571.184000] Allocate Port Service[0000:00:1c.0:pcie03]
[17179571.184000] isapnp: Scanning for PnP cards...
[17179571.540000] isapnp: No Plug & Play device found
[17179571.560000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[17179571.564000] 00:0a: ttyS0 at I/O 0x200 (irq = 5) is a NS16550A
[17179571.564000] ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 23 (level, low) -> IRQ 201
[17179571.564000] ACPI: PCI interrupt for device 0000:00:1e.3 disabled
[17179571.564000] mice: PS/2 mouse device common for all mice
[17179571.564000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[17179571.564000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[17179571.564000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[17179571.564000] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[17179571.576000] serio: i8042 AUX port at 0x60,0x64 irq 12
[17179571.576000] serio: i8042 KBD port at 0x60,0x64 irq 1
[17179571.576000] EISA: Probing bus 0 at eisa.0
[17179571.576000] Cannot allocate resource for EISA slot 1
[17179571.576000] Cannot allocate resource for EISA slot 2
[17179571.576000] Cannot allocate resource for EISA slot 3
[17179571.576000] Cannot allocate resource for EISA slot 4
[17179571.576000] Cannot allocate resource for EISA slot 5
[17179571.576000] Cannot allocate resource for EISA slot 6
[17179571.576000] EISA: Detected 0 cards.
[17179571.576000] TCP bic registered
[17179571.576000] NET: Registered protocol family 1
[17179571.576000] NET: Registered protocol family 8
[17179571.576000] NET: Registered protocol family 20
[17179571.576000] Using IPI Shortcut mode
[17179571.576000] ACPI: (supports S0 S3 S4 S5)
[17179571.576000] Freeing unused kernel memory: 288k freed
[17179571.588000] input: AT Translated Set 2 keyboard as /class/input/input0
[17179572.652000] Capability LSM initialized
[17179572.684000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[17179572.684000] ACPI: Processor [CPU] (supports 8 throttling states)
[17179572.688000] ACPI: Thermal Zone [THM0] (52 C)
[17179572.964000] SCSI subsystem initialized
[17179572.968000] libata version 1.20 loaded.
[17179572.968000] ahci 0000:00:1f.2: version 1.2
[17179572.968000] ahci: probe of 0000:00:1f.2 failed with error -12
[17179572.968000] ata_piix 0000:00:1f.2: version 1.05
[17179572.968000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[17179572.968000] ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
[17179573.132000] ata1: dev 0 cfg 49:0b00 82:746b 83:5988 84:6003 85:7469 86:1808 87:6003 88:203f
[17179573.132000] ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
[17179573.132000] ata1(0): applying bridge limits
[17179573.140000] ata1: dev 0 configured for UDMA/100
[17179573.140000] scsi0 : ata_piix
[17179573.140000]   Vendor: ATA       Model: HTC426060G9AT00   Rev: 00P3
[17179573.140000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[17179573.140000] ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
[17179573.296000] ata2: disabling port
[17179573.296000] scsi1 : ata_piix
[17179573.300000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[17179573.300000] sda: Write Protect is off
[17179573.300000] sda: Mode Sense: 00 3a 00 00
[17179573.300000] SCSI device sda: drive cache: write back
[17179573.300000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[17179573.300000] sda: Write Protect is off
[17179573.300000] sda: Mode Sense: 00 3a 00 00
[17179573.300000] SCSI device sda: drive cache: write back
[17179573.300000]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 > sda4
[17179573.512000] sd 0:0:0:0: Attached scsi disk sda
[17179574.484000] ide0: I/O resource 0x1F0-0x1F7 not free.
[17179574.484000] ide0: ports already in use, skipping probe
[17179574.484000] ide1: I/O resource 0x170-0x177 not free.
[17179574.484000] ide1: ports already in use, skipping probe
[17179574.508000] usbcore: registered new driver usbfs
[17179574.512000] usbcore: registered new driver hub
[17179574.512000] USB Universal Host Controller Interface driver v3.0
[17179574.512000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179574.512000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179574.512000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[17179574.512000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[17179574.512000] uhci_hcd 0000:00:1d.0: irq 177, io base 0x00001820
[17179574.512000] usb usb1: configuration #1 chosen from 1 choice
[17179574.512000] hub 1-0:1.0: USB hub found
[17179574.512000] hub 1-0:1.0: 2 ports detected
[17179574.616000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 209
[17179574.616000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179574.616000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[17179574.616000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[17179574.616000] uhci_hcd 0000:00:1d.1: irq 209, io base 0x00001840
[17179574.616000] usb usb2: configuration #1 chosen from 1 choice
[17179574.616000] hub 2-0:1.0: USB hub found
[17179574.616000] hub 2-0:1.0: 2 ports detected
[17179574.720000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 217
[17179574.720000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[17179574.720000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[17179574.720000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[17179574.720000] uhci_hcd 0000:00:1d.2: irq 217, io base 0x00001860
[17179574.720000] usb usb3: configuration #1 chosen from 1 choice
[17179574.720000] hub 3-0:1.0: USB hub found
[17179574.720000] hub 3-0:1.0: 2 ports detected
[17179574.824000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 225
[17179574.824000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[17179574.824000] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[17179574.824000] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[17179574.824000] uhci_hcd 0000:00:1d.3: irq 225, io base 0x00001880
[17179574.824000] usb usb4: configuration #1 chosen from 1 choice
[17179574.824000] hub 4-0:1.0: USB hub found
[17179574.824000] hub 4-0:1.0: 2 ports detected
[17179574.928000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 225
[17179574.928000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179574.928000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[17179574.928000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[17179574.928000] ehci_hcd 0000:00:1d.7: debug port 1
[17179574.928000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[17179574.928000] ehci_hcd 0000:00:1d.7: irq 225, io mem 0xa0040000
[17179574.932000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179574.932000] usb usb5: configuration #1 chosen from 1 choice
[17179574.932000] hub 5-0:1.0: USB hub found
[17179574.932000] hub 5-0:1.0: 8 ports detected
[17179575.820000] usb 3-1: new full speed USB device using uhci_hcd and address 2
[17179575.916000] kjournald starting.  Commit interval 5 seconds
[17179575.916000] EXT3-fs: mounted filesystem with ordered data mode.
[17179575.984000] usb 3-1: configuration #1 chosen from 1 choice
[17179576.228000] usb 3-2: new full speed USB device using uhci_hcd and address 3
[17179576.404000] usb 3-2: configuration #1 chosen from 1 choice
[17179583.620000] irda_init()
[17179583.620000] NET: Registered protocol family 23
[17179583.716000] Real Time Clock Driver v1.12ac
[17179583.804000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[17179583.828000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[17179583.844000] input: PC Speaker as /class/input/input1
[17179583.856000] pnp: Device 00:09 activated.
[17179583.856000] nsc_ircc_pnp_probe() : From PnP, found firbase 0x2F8 ; irq 3 ; dma 1.
[17179583.856000] nsc-ircc, chip->init
[17179583.856000] nsc-ircc, Found chip at base=0x164e
[17179583.856000] nsc-ircc, driver loaded (Dag Brattli)
[17179583.856000] IrDA: Registered device irda0
[17179583.856000] nsc-ircc, Using dongle: IBM31T1100 or Temic TFDS6000/TFDS6500
[17179584.620000] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[17179584.640000] input: TPPS/2 IBM TrackPoint as /class/input/input2
[17179584.736000] hw_random: RNG not detected
[17179584.968000] Linux agpgart interface v0.101 (c) Dave Jones
[17179584.980000] agpgart: Detected an Intel 915GM Chipset.
[17179584.980000] agpgart: Detected 7932K stolen memory.
[17179585.000000] agpgart: AGP aperture is 256M @ 0xc0000000
[17179585.372000] tg3.c:v3.59.1 (August 25, 2006)
[17179585.372000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179585.372000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[17179585.408000] eth0: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:0a:e4:3f:5d:7a
[17179585.408000] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[17179585.408000] eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[17179585.916000] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179585.916000] Yenta: CardBus bridge found at 0000:04:00.0 [1014:0555]
[17179586.000000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[17179586.048000] Yenta: ISA IRQ mask 0x04b0, PCI irq 177
[17179586.048000] Socket status: 30000006
[17179586.048000] pcmcia: parent PCI bridge I/O window: 0x3000 - 0x6fff
[17179586.048000] cs: IO port probe 0x3000-0x6fff: clean.
[17179586.048000] pcmcia: parent PCI bridge Memory window: 0xa0200000 - 0xafffffff
[17179586.048000] pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd7ffffff
[17179587.112000] ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 22 (level, low) -> IRQ 233
[17179587.112000] PCI: Setting latency timer of device 0000:00:1e.2 to 64
[17179587.200000] Bluetooth: Core ver 2.8
[17179587.200000] NET: Registered protocol family 31
[17179587.200000] Bluetooth: HCI device and connection manager initialized
[17179587.200000] Bluetooth: HCI socket layer initialized
[17179587.312000] sdhci: Secure Digital Host Controller Interface driver, 0.12
[17179587.312000] sdhci: Copyright(c) Pierre Ossman
[17179587.324000] ieee80211_crypt: registered algorithm 'NULL'
[17179587.324000] ieee80211: 802.11 data/management/control stack, git-1.1.13
[17179587.324000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[17179587.336000] Bluetooth: HCI USB driver ver 2.9
[17179587.340000] usbcore: registered new driver hci_usb
[17179587.372000] ts: Compaq touchscreen protocol output
[17179587.444000] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.2kmprq
[17179587.444000] ipw2200: Copyright(c) 2003-2006 Intel Corporation
[17179587.444000] Driver 'ipw2200' needs updating - please use bus_type methods
[17179587.776000] cs: IO port probe 0x100-0x4ff: excluding 0x370-0x377 0x3f0-0x3f7 0x4d0-0x4d7
[17179587.780000] cs: IO port probe 0xc00-0xcf7: clean.
[17179587.780000] cs: IO port probe 0xa00-0xaff: clean.
[17179587.932000] intel8x0_measure_ac97_clock: measured 55497 usecs
[17179587.932000] intel8x0: clocking to 48000
[17179587.932000] sdhci: SDHCI controller found at 0000:04:00.1 [1180:0822] (rev 13)
[17179587.932000] ACPI: PCI Interrupt 0000:04:00.1[B] -> GSI 17 (level, low) -> IRQ 209
[17179587.932000] mmc0: SDHCI at 0xa0201000 irq 209 DMA
[17179587.948000] ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 50
[17179587.948000] ipw2200: Detected Intel PRO/Wireless 2915ABG Network Connection
[17179588.476000] ipw2200: Detected geography ZZA (11 802.11bg channels, 13 802.11a channels)
[17179588.488000] NET: Registered protocol family 17
[17179588.632000] lp: driver loaded but no devices found
[17179588.708000] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
[17179588.708000] ibm_acpi: http://ibm-acpi.sf.net/
[17179588.712000] ibm_acpi: bay device not present
[17179588.780000] acpi_cpufreq: Unknown symbol cpu_online_map
[17179588.792000] Non-volatile memory driver v1.2
[17179588.848000] Adding 1630556k swap on /dev/sda5.  Priority:-1 extents:1 across:1630556k
[17179589.316000] EXT3 FS on sda2, internal journal
[17179589.492000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[17179589.492000] md: bitmap version 4.39
[17179589.700000] device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
[17179663.236000] kjournald starting.  Commit interval 5 seconds
[17179663.244000] EXT3 FS on sda7, internal journal
[17179663.244000] EXT3-fs: mounted filesystem with ordered data mode.
[17179663.284000] kjournald starting.  Commit interval 5 seconds
[17179663.292000] EXT3 FS on sda8, internal journal
[17179663.292000] EXT3-fs: mounted filesystem with ordered data mode.
[17179663.376000] kjournald starting.  Commit interval 5 seconds
[17179663.396000] EXT3 FS on sda6, internal journal
[17179663.396000] EXT3-fs: mounted filesystem with ordered data mode.
[17179663.488000] kjournald starting.  Commit interval 5 seconds
[17179663.496000] EXT3 FS on sda1, internal journal
[17179663.496000] EXT3-fs: mounted filesystem with ordered data mode.
[17179677.180000] ACPI: AC Adapter [AC] (on-line)
[17179677.228000] ACPI: Battery Slot [BAT0] (battery present)
[17179677.244000] ACPI: Power Button (FF) [PWRF]
[17179677.244000] ACPI: Lid Switch [LID]
[17179677.244000] ACPI: Sleep Button (CM) [SLPB]
[17179677.280000] ACPI: ACPI Dock Station Driver 
[17179677.352000] pcc_acpi: loading...
[17179677.444000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[17179685.348000] [drm] Initialized drm 1.0.1 20051102
[17179685.364000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179685.364000] [drm] Initialized i915 1.5.0 20060119 on minor 0
[17179689.732000] NET: Registered protocol family 10
[17179689.732000] lo: Disabled Privacy Extensions
[17179689.732000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[17179689.732000] IPv6 over IPv4 tunneling driver
[17179693.040000] IBM machine detected. Enabling interrupts during APM calls.
[17179693.040000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[17179693.040000] apm: overridden by ACPI.
[17179693.332000] input: /usr/sbin/thinkpad-keys as /class/input/input3
[17179697.220000] Bluetooth: L2CAP ver 2.8
[17179697.220000] Bluetooth: L2CAP socket layer initialized
[17179697.376000] Bluetooth: HIDP (Human Interface Emulation) ver 1.1-mh1
[17179697.412000] Bluetooth: RFCOMM socket layer initialized
[17179697.412000] Bluetooth: RFCOMM TTY layer initialized
[17179697.412000] Bluetooth: RFCOMM ver 1.7
[17179700.544000] eth1: no IPv6 routers present

--------------070800000306060007010405
Content-Type: text/plain;
 name="dmesg.no-pen"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.no-pen"

[17179569.184000] Linux version 2.6.17-11-386 (root@terranova) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #2 Thu Feb 1 19:50:13 UTC 2007 (Ubuntu 2.6.17-11.35-386)
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[17179569.184000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000003f6d0000 (usable)
[17179569.184000]  BIOS-e820: 000000003f6d0000 - 000000003f6e5000 (ACPI data)
[17179569.184000]  BIOS-e820: 000000003f6e5000 - 000000003f700000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
[17179569.184000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[17179569.184000]  BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[17179569.184000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[17179569.184000] 118MB HIGHMEM available.
[17179569.184000] 896MB LOWMEM available.
[17179569.184000] On node 0 totalpages: 259792
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
[17179569.184000]   Normal zone: 225280 pages, LIFO batch:31
[17179569.184000]   HighMem zone: 30416 pages, LIFO batch:7
[17179569.184000] DMI present.
[17179569.184000] ACPI: RSDP (v002 IBM                                   ) @ 0x000f6c90
[17179569.184000] ACPI: XSDT (v001 IBM    TP-75    0x00002010  LTP 0x00000000) @ 0x3f6d5c5e
[17179569.184000] ACPI: FADT (v003 IBM    TP-75    0x00002010 IBM  0x00000001) @ 0x3f6d5d00
[17179569.184000] ACPI: SSDT (v001 IBM    TP-75    0x00002010 MSFT 0x0100000e) @ 0x3f6d5eb4
[17179569.184000] ACPI: ECDT (v001 IBM    TP-75    0x00002010 IBM  0x00000001) @ 0x3f6e4d83
[17179569.184000] ACPI: TCPA (v001 IBM    TP-75    0x00002010 PTL  0x00000001) @ 0x3f6e4dd5
[17179569.184000] ACPI: MADT (v001 IBM    TP-75    0x00002010 IBM  0x00000001) @ 0x3f6e4e07
[17179569.184000] ACPI: MCFG (v001 IBM    TP-75    0x00002010 IBM  0x00000001) @ 0x3f6e4e61
[17179569.184000] ACPI: BOOT (v001 IBM    TP-75    0x00002010  LTP 0x00000001) @ 0x3f6e4fd8
[17179569.184000] ACPI: DSDT (v001 IBM    TP-75    0x00002010 MSFT 0x0100000e) @ 0x00000000
[17179569.184000] ACPI: PM-Timer IO Port: 0x1008
[17179569.184000] ACPI: Local APIC address 0xfee00000
[17179569.184000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 6:13 APIC version 20
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[17179569.184000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[17179569.184000] ACPI: IRQ0 used by override.
[17179569.184000] ACPI: IRQ2 used by override.
[17179569.184000] ACPI: IRQ9 used by override.
[17179569.184000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=UUID=70f86326-0df2-423d-9ce5-cb18aac2f9b3 ro quiet splash
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
[17179569.184000] Enabling fast FPU save and restore... done.
[17179569.184000] Enabling unmasked SIMD FPU exception support... done.
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[17179569.184000] Detected 1596.284 MHz processor.
[17179569.184000] Using pmtmr for high-res timesource
[17179569.184000] Console: colour VGA+ 80x25
[17179570.032000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[17179570.032000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[17179570.064000] Memory: 1019332k/1039168k available (1829k kernel code, 19196k reserved, 1041k data, 288k init, 121664k highmem)
[17179570.064000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[17179570.144000] Calibrating delay using timer specific routine.. 3196.90 BogoMIPS (lpj=6393813)
[17179570.144000] Security Framework v1.0.0 initialized
[17179570.144000] SELinux:  Disabled at boot.
[17179570.144000] Mount-cache hash table entries: 512
[17179570.144000] CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
[17179570.144000] CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
[17179570.144000] CPU: L1 I cache: 32K, L1 D cache: 32K
[17179570.144000] CPU: L2 cache: 2048K
[17179570.144000] CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
[17179570.144000] CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 08
[17179570.144000] Checking 'hlt' instruction... OK.
[17179570.160000] SMP alternatives: switching to UP code
[17179570.160000] Freeing SMP alternatives: 0k freed
[17179570.160000] checking if image is initramfs... it is
[17179570.840000] Freeing initrd memory: 6696k freed
[17179570.840000] ACPI: Core revision 20060707
[17179570.840000] ACPI: Looking for DSDT ... not found!
[17179570.856000] ENABLING IO-APIC IRQs
[17179570.856000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[17179571.000000] NET: Registered protocol family 16
[17179571.000000] EISA bus registered
[17179571.000000] ACPI: bus type pci registered
[17179571.000000] PCI: Using MMCONFIG
[17179571.000000] Setting up standard PCI resources
[17179571.000000] ACPI: Found ECDT
[17179571.132000] ACPI: Interpreter enabled
[17179571.132000] ACPI: Using IOAPIC for interrupt routing
[17179571.132000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.132000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.132000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.132000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.132000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.136000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.136000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.136000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[17179571.136000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[17179571.136000] PCI: Probing PCI hardware (bus 00)
[17179571.140000] Boot video device is 0000:00:02.0
[17179571.140000] PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[17179571.140000] PCI quirk: region 1180-11bf claimed by ICH6 GPIO
[17179571.140000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
[17179571.140000] PCI: Transparent bridge - 0000:00:1e.0
[17179571.140000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[17179571.144000] ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
[17179571.144000] ACPI: Power Resource [PUBS] (on)
[17179571.148000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP0._PRT]
[17179571.148000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[17179571.152000] Linux Plug and Play Support v0.97 (c) Adam Belay
[17179571.152000] pnp: PnP ACPI init
[17179571.156000] pnp: PnP ACPI: found 12 devices
[17179571.156000] PnPBIOS: Disabled by ACPI PNP
[17179571.156000] PCI: Using ACPI for IRQ routing
[17179571.156000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[17179571.156000] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[17179571.156000] PCI: Bridge: 0000:00:1c.0
[17179571.156000]   IO window: disabled.
[17179571.156000]   MEM window: a0100000-a01fffff
[17179571.156000]   PREFETCH window: disabled.
[17179571.156000] PCI: Bus 5, cardbus bridge: 0000:04:00.0
[17179571.156000]   IO window: 00003000-000030ff
[17179571.156000]   IO window: 00003400-000034ff
[17179571.156000]   PREFETCH window: d0000000-d1ffffff
[17179571.156000]   MEM window: a2000000-a3ffffff
[17179571.156000] PCI: Bridge: 0000:00:1e.0
[17179571.156000]   IO window: 3000-6fff
[17179571.156000]   MEM window: a0200000-afffffff
[17179571.156000]   PREFETCH window: d0000000-d7ffffff
[17179571.156000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 169
[17179571.156000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[17179571.156000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[17179571.156000] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179571.156000] NET: Registered protocol family 2
[17179571.184000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[17179571.184000] TCP established hash table entries: 131072 (order: 7, 524288 bytes)
[17179571.184000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[17179571.184000] TCP: Hash tables configured (established 131072 bind 65536)
[17179571.184000] TCP reno registered
[17179571.184000] Simple Boot Flag at 0x35 set to 0x1
[17179571.184000] audit: initializing netlink socket (disabled)
[17179571.184000] audit(1176738752.184:1): initialized
[17179571.184000] highmem bounce pool size: 64 pages
[17179571.184000] VFS: Disk quotas dquot_6.5.1
[17179571.184000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[17179571.184000] Initializing Cryptographic API
[17179571.184000] io scheduler noop registered
[17179571.184000] io scheduler anticipatory registered
[17179571.184000] io scheduler deadline registered
[17179571.184000] io scheduler cfq registered (default)
[17179571.184000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 169
[17179571.184000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[17179571.184000] assign_interrupt_mode Found MSI capability
[17179571.184000] Allocate Port Service[0000:00:1c.0:pcie00]
[17179571.184000] Allocate Port Service[0000:00:1c.0:pcie02]
[17179571.184000] Allocate Port Service[0000:00:1c.0:pcie03]
[17179571.184000] isapnp: Scanning for PnP cards...
[17179571.540000] isapnp: No Plug & Play device found
[17179571.560000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[17179571.564000] 00:0a: ttyS0 at I/O 0x200 (irq = 5) is a NS16550A
[17179571.564000] ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 23 (level, low) -> IRQ 201
[17179571.564000] ACPI: PCI interrupt for device 0000:00:1e.3 disabled
[17179571.564000] mice: PS/2 mouse device common for all mice
[17179571.564000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[17179571.564000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[17179571.564000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[17179571.564000] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[17179571.576000] serio: i8042 AUX port at 0x60,0x64 irq 12
[17179571.576000] serio: i8042 KBD port at 0x60,0x64 irq 1
[17179571.576000] EISA: Probing bus 0 at eisa.0
[17179571.576000] Cannot allocate resource for EISA slot 1
[17179571.576000] Cannot allocate resource for EISA slot 2
[17179571.576000] Cannot allocate resource for EISA slot 3
[17179571.576000] Cannot allocate resource for EISA slot 4
[17179571.576000] Cannot allocate resource for EISA slot 5
[17179571.576000] Cannot allocate resource for EISA slot 6
[17179571.576000] EISA: Detected 0 cards.
[17179571.576000] TCP bic registered
[17179571.576000] NET: Registered protocol family 1
[17179571.576000] NET: Registered protocol family 8
[17179571.576000] NET: Registered protocol family 20
[17179571.576000] Using IPI Shortcut mode
[17179571.576000] ACPI: (supports S0 S3 S4 S5)
[17179571.576000] Freeing unused kernel memory: 288k freed
[17179571.588000] input: AT Translated Set 2 keyboard as /class/input/input0
[17179572.652000] Capability LSM initialized
[17179572.684000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[17179572.684000] ACPI: Processor [CPU] (supports 8 throttling states)
[17179572.688000] ACPI: Thermal Zone [THM0] (52 C)
[17179572.964000] SCSI subsystem initialized
[17179572.968000] libata version 1.20 loaded.
[17179572.968000] ahci 0000:00:1f.2: version 1.2
[17179572.968000] ahci: probe of 0000:00:1f.2 failed with error -12
[17179572.968000] ata_piix 0000:00:1f.2: version 1.05
[17179572.968000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[17179572.968000] ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
[17179573.132000] ata1: dev 0 cfg 49:0b00 82:746b 83:5988 84:6003 85:7469 86:1808 87:6003 88:203f
[17179573.132000] ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
[17179573.132000] ata1(0): applying bridge limits
[17179573.140000] ata1: dev 0 configured for UDMA/100
[17179573.140000] scsi0 : ata_piix
[17179573.140000]   Vendor: ATA       Model: HTC426060G9AT00   Rev: 00P3
[17179573.140000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[17179573.140000] ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
[17179573.296000] ata2: disabling port
[17179573.296000] scsi1 : ata_piix
[17179573.300000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[17179573.300000] sda: Write Protect is off
[17179573.300000] sda: Mode Sense: 00 3a 00 00
[17179573.300000] SCSI device sda: drive cache: write back
[17179573.300000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[17179573.300000] sda: Write Protect is off
[17179573.300000] sda: Mode Sense: 00 3a 00 00
[17179573.300000] SCSI device sda: drive cache: write back
[17179573.300000]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 > sda4
[17179573.512000] sd 0:0:0:0: Attached scsi disk sda
[17179574.484000] ide0: I/O resource 0x1F0-0x1F7 not free.
[17179574.484000] ide0: ports already in use, skipping probe
[17179574.484000] ide1: I/O resource 0x170-0x177 not free.
[17179574.484000] ide1: ports already in use, skipping probe
[17179574.508000] usbcore: registered new driver usbfs
[17179574.512000] usbcore: registered new driver hub
[17179574.512000] USB Universal Host Controller Interface driver v3.0
[17179574.512000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179574.512000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179574.512000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[17179574.512000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[17179574.512000] uhci_hcd 0000:00:1d.0: irq 177, io base 0x00001820
[17179574.512000] usb usb1: configuration #1 chosen from 1 choice
[17179574.512000] hub 1-0:1.0: USB hub found
[17179574.512000] hub 1-0:1.0: 2 ports detected
[17179574.616000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 209
[17179574.616000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179574.616000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[17179574.616000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[17179574.616000] uhci_hcd 0000:00:1d.1: irq 209, io base 0x00001840
[17179574.616000] usb usb2: configuration #1 chosen from 1 choice
[17179574.616000] hub 2-0:1.0: USB hub found
[17179574.616000] hub 2-0:1.0: 2 ports detected
[17179574.720000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 217
[17179574.720000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[17179574.720000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[17179574.720000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[17179574.720000] uhci_hcd 0000:00:1d.2: irq 217, io base 0x00001860
[17179574.720000] usb usb3: configuration #1 chosen from 1 choice
[17179574.720000] hub 3-0:1.0: USB hub found
[17179574.720000] hub 3-0:1.0: 2 ports detected
[17179574.824000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 225
[17179574.824000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[17179574.824000] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[17179574.824000] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[17179574.824000] uhci_hcd 0000:00:1d.3: irq 225, io base 0x00001880
[17179574.824000] usb usb4: configuration #1 chosen from 1 choice
[17179574.824000] hub 4-0:1.0: USB hub found
[17179574.824000] hub 4-0:1.0: 2 ports detected
[17179574.928000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 225
[17179574.928000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179574.928000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[17179574.928000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[17179574.928000] ehci_hcd 0000:00:1d.7: debug port 1
[17179574.928000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[17179574.928000] ehci_hcd 0000:00:1d.7: irq 225, io mem 0xa0040000
[17179574.932000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179574.932000] usb usb5: configuration #1 chosen from 1 choice
[17179574.932000] hub 5-0:1.0: USB hub found
[17179574.932000] hub 5-0:1.0: 8 ports detected
[17179575.820000] usb 3-1: new full speed USB device using uhci_hcd and address 2
[17179575.916000] kjournald starting.  Commit interval 5 seconds
[17179575.916000] EXT3-fs: mounted filesystem with ordered data mode.
[17179575.984000] usb 3-1: configuration #1 chosen from 1 choice
[17179576.228000] usb 3-2: new full speed USB device using uhci_hcd and address 3
[17179576.404000] usb 3-2: configuration #1 chosen from 1 choice
[17179583.620000] irda_init()
[17179583.620000] NET: Registered protocol family 23
[17179583.716000] Real Time Clock Driver v1.12ac
[17179583.804000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[17179583.828000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[17179583.844000] input: PC Speaker as /class/input/input1
[17179583.856000] pnp: Device 00:09 activated.
[17179583.856000] nsc_ircc_pnp_probe() : From PnP, found firbase 0x2F8 ; irq 3 ; dma 1.
[17179583.856000] nsc-ircc, chip->init
[17179583.856000] nsc-ircc, Found chip at base=0x164e
[17179583.856000] nsc-ircc, driver loaded (Dag Brattli)
[17179583.856000] IrDA: Registered device irda0
[17179583.856000] nsc-ircc, Using dongle: IBM31T1100 or Temic TFDS6000/TFDS6500
[17179584.620000] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[17179584.640000] input: TPPS/2 IBM TrackPoint as /class/input/input2
[17179584.736000] hw_random: RNG not detected
[17179584.968000] Linux agpgart interface v0.101 (c) Dave Jones
[17179584.980000] agpgart: Detected an Intel 915GM Chipset.
[17179584.980000] agpgart: Detected 7932K stolen memory.
[17179585.000000] agpgart: AGP aperture is 256M @ 0xc0000000
[17179585.372000] tg3.c:v3.59.1 (August 25, 2006)
[17179585.372000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179585.372000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[17179585.408000] eth0: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:0a:e4:3f:5d:7a
[17179585.408000] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[17179585.408000] eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[17179585.916000] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179585.916000] Yenta: CardBus bridge found at 0000:04:00.0 [1014:0555]
[17179586.000000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[17179586.048000] Yenta: ISA IRQ mask 0x04b0, PCI irq 177
[17179586.048000] Socket status: 30000006
[17179586.048000] pcmcia: parent PCI bridge I/O window: 0x3000 - 0x6fff
[17179586.048000] cs: IO port probe 0x3000-0x6fff: clean.
[17179586.048000] pcmcia: parent PCI bridge Memory window: 0xa0200000 - 0xafffffff
[17179586.048000] pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd7ffffff
[17179587.112000] ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 22 (level, low) -> IRQ 233
[17179587.112000] PCI: Setting latency timer of device 0000:00:1e.2 to 64
[17179587.200000] Bluetooth: Core ver 2.8
[17179587.200000] NET: Registered protocol family 31
[17179587.200000] Bluetooth: HCI device and connection manager initialized
[17179587.200000] Bluetooth: HCI socket layer initialized
[17179587.312000] sdhci: Secure Digital Host Controller Interface driver, 0.12
[17179587.312000] sdhci: Copyright(c) Pierre Ossman
[17179587.324000] ieee80211_crypt: registered algorithm 'NULL'
[17179587.324000] ieee80211: 802.11 data/management/control stack, git-1.1.13
[17179587.324000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[17179587.336000] Bluetooth: HCI USB driver ver 2.9
[17179587.340000] usbcore: registered new driver hci_usb
[17179587.372000] ts: Compaq touchscreen protocol output
[17179587.444000] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.2kmprq
[17179587.444000] ipw2200: Copyright(c) 2003-2006 Intel Corporation
[17179587.444000] Driver 'ipw2200' needs updating - please use bus_type methods
[17179587.776000] cs: IO port probe 0x100-0x4ff: excluding 0x370-0x377 0x3f0-0x3f7 0x4d0-0x4d7
[17179587.780000] cs: IO port probe 0xc00-0xcf7: clean.
[17179587.780000] cs: IO port probe 0xa00-0xaff: clean.
[17179587.932000] intel8x0_measure_ac97_clock: measured 55497 usecs
[17179587.932000] intel8x0: clocking to 48000
[17179587.932000] sdhci: SDHCI controller found at 0000:04:00.1 [1180:0822] (rev 13)
[17179587.932000] ACPI: PCI Interrupt 0000:04:00.1[B] -> GSI 17 (level, low) -> IRQ 209
[17179587.932000] mmc0: SDHCI at 0xa0201000 irq 209 DMA
[17179587.948000] ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 50
[17179587.948000] ipw2200: Detected Intel PRO/Wireless 2915ABG Network Connection
[17179588.476000] ipw2200: Detected geography ZZA (11 802.11bg channels, 13 802.11a channels)
[17179588.488000] NET: Registered protocol family 17
[17179588.632000] lp: driver loaded but no devices found
[17179588.708000] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
[17179588.708000] ibm_acpi: http://ibm-acpi.sf.net/
[17179588.712000] ibm_acpi: bay device not present
[17179588.780000] acpi_cpufreq: Unknown symbol cpu_online_map
[17179588.792000] Non-volatile memory driver v1.2
[17179588.848000] Adding 1630556k swap on /dev/sda5.  Priority:-1 extents:1 across:1630556k
[17179589.316000] EXT3 FS on sda2, internal journal
[17179589.492000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[17179589.492000] md: bitmap version 4.39
[17179589.700000] device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
[17179663.236000] kjournald starting.  Commit interval 5 seconds
[17179663.244000] EXT3 FS on sda7, internal journal
[17179663.244000] EXT3-fs: mounted filesystem with ordered data mode.
[17179663.284000] kjournald starting.  Commit interval 5 seconds
[17179663.292000] EXT3 FS on sda8, internal journal
[17179663.292000] EXT3-fs: mounted filesystem with ordered data mode.
[17179663.376000] kjournald starting.  Commit interval 5 seconds
[17179663.396000] EXT3 FS on sda6, internal journal
[17179663.396000] EXT3-fs: mounted filesystem with ordered data mode.
[17179663.488000] kjournald starting.  Commit interval 5 seconds
[17179663.496000] EXT3 FS on sda1, internal journal
[17179663.496000] EXT3-fs: mounted filesystem with ordered data mode.
[17179677.180000] ACPI: AC Adapter [AC] (on-line)
[17179677.228000] ACPI: Battery Slot [BAT0] (battery present)
[17179677.244000] ACPI: Power Button (FF) [PWRF]
[17179677.244000] ACPI: Lid Switch [LID]
[17179677.244000] ACPI: Sleep Button (CM) [SLPB]
[17179677.280000] ACPI: ACPI Dock Station Driver 
[17179677.352000] pcc_acpi: loading...
[17179677.444000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[17179685.348000] [drm] Initialized drm 1.0.1 20051102
[17179685.364000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179685.364000] [drm] Initialized i915 1.5.0 20060119 on minor 0
[17179689.732000] NET: Registered protocol family 10
[17179689.732000] lo: Disabled Privacy Extensions
[17179689.732000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[17179689.732000] IPv6 over IPv4 tunneling driver
[17179693.040000] IBM machine detected. Enabling interrupts during APM calls.
[17179693.040000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[17179693.040000] apm: overridden by ACPI.
[17179693.332000] input: /usr/sbin/thinkpad-keys as /class/input/input3
[17179697.220000] Bluetooth: L2CAP ver 2.8
[17179697.220000] Bluetooth: L2CAP socket layer initialized
[17179697.376000] Bluetooth: HIDP (Human Interface Emulation) ver 1.1-mh1
[17179697.412000] Bluetooth: RFCOMM socket layer initialized
[17179697.412000] Bluetooth: RFCOMM TTY layer initialized
[17179697.412000] Bluetooth: RFCOMM ver 1.7
[17179700.544000] eth1: no IPv6 routers present
[17179761.948000] Stopping tasks: ==================================================================================================|
[17179764.084000] pnp: Device 00:0a disabled.
[17179764.084000] pnp: Device 00:09 disabled.
[17179764.084000] eth1: Going into suspend...
[17179764.088000] ACPI: PCI interrupt for device 0000:04:02.0 disabled
[17179764.104000] ACPI: PCI interrupt for device 0000:04:00.1 disabled
[17179764.120000] ACPI: PCI interrupt for device 0000:04:00.0 disabled
[17179764.120000] ACPI: PCI interrupt for device 0000:00:1e.2 disabled
[17179764.120000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[17179764.236000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
[17179764.236000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[17179764.236000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[17179764.236000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[17179764.236000] Back to C!
[17179767.236000] PM: Writing back config space on device 0000:00:00.0 at offset 1 (was 900106, writing 20900106)
[17179767.256000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179767.256000] PM: Writing back config space on device 0000:00:02.1 at offset 4 (was 0, writing 50000000)
[17179767.256000] PM: Writing back config space on device 0000:00:1c.0 at offset 7 (was f0, writing 200000f0)
[17179767.256000] PM: Writing back config space on device 0000:00:1c.0 at offset 1 (was 100107, writing 100507)
[17179767.256000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 169
[17179767.256000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[17179767.256000] PCI: Enabling device 0000:00:1d.0 (0000 -> 0001)
[17179767.256000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179767.256000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179767.256000] PM: Writing back config space on device 0000:00:1d.0 at offset f (was 100, writing 10b)
[17179767.256000] PM: Writing back config space on device 0000:00:1d.0 at offset 8 (was 1, writing 1821)
[17179767.256000] usb usb1: root hub lost power or was reset
[17179767.256000] PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
[17179767.256000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 209
[17179767.256000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179767.256000] PM: Writing back config space on device 0000:00:1d.1 at offset f (was 200, writing 20b)
[17179767.256000] PM: Writing back config space on device 0000:00:1d.1 at offset 8 (was 1, writing 1841)
[17179767.256000] usb usb2: root hub lost power or was reset
[17179767.256000] PCI: Enabling device 0000:00:1d.2 (0000 -> 0001)
[17179767.256000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 217
[17179767.256000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[17179767.256000] PM: Writing back config space on device 0000:00:1d.2 at offset f (was 300, writing 30b)
[17179767.256000] PM: Writing back config space on device 0000:00:1d.2 at offset 8 (was 1, writing 1861)
[17179767.256000] usb usb3: root hub lost power or was reset
[17179767.256000] PCI: Enabling device 0000:00:1d.3 (0000 -> 0001)
[17179767.256000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 225
[17179767.256000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[17179767.256000] PM: Writing back config space on device 0000:00:1d.3 at offset f (was 400, writing 40b)
[17179767.256000] PM: Writing back config space on device 0000:00:1d.3 at offset 8 (was 1, writing 1881)
[17179767.256000] usb usb4: root hub lost power or was reset
[17179767.272000] PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
[17179767.272000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 225
[17179767.272000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179767.272000] PM: Writing back config space on device 0000:00:1d.7 at offset f (was 400, writing 40b)
[17179767.272000] PM: Writing back config space on device 0000:00:1d.7 at offset 4 (was 0, writing a0040000)
[17179767.272000] PM: Writing back config space on device 0000:00:1d.7 at offset 1 (was 2900006, writing 2900106)
[17179767.272000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[17179767.272000] PM: Writing back config space on device 0000:00:1e.2 at offset 1 (was 2900007, writing 2900003)
[17179767.272000] ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 22 (level, low) -> IRQ 233
[17179767.272000] PCI: Setting latency timer of device 0000:00:1e.2 to 64
[17179767.524000] PM: Writing back config space on device 0000:00:1e.3 at offset 1 (was 2900005, writing 2900001)
[17179767.524000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[17179767.524000] PM: Writing back config space on device 0000:04:00.0 at offset 1 (was 2100003, writing 2100007)
[17179767.524000] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179767.540000] PM: Writing back config space on device 0000:04:00.1 at offset 4 (was 0, writing a0201000)
[17179767.540000] PM: Writing back config space on device 0000:04:00.1 at offset 3 (was 800000, writing 804000)
[17179767.540000] PM: Writing back config space on device 0000:04:00.1 at offset 1 (was 2100000, writing 2100106)
[17179767.540000] ACPI: PCI Interrupt 0000:04:00.1[B] -> GSI 17 (level, low) -> IRQ 209
[17179767.932000] eth1: Coming out of suspend...
[17179767.948000] ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 50
[17179768.076000] pnp: Device 00:07 does not support activation.
[17179768.076000] pnp: Device 00:08 does not support activation.
[17179768.076000] pnp: Device 00:09 activated.
[17179768.076000] pnp: Device 00:0a activated.
[17179769.652000] ata1: dev 0 configured for UDMA/100
[17179769.980000] Restarting tasks...<6>usb 3-1: USB disconnect, address 2
[17179770.032000]  done
[17179770.320000] ACPI: Power Button (FF) [PWRF]
[17179770.320000] ACPI: Lid Switch [LID]
[17179770.320000] ACPI: Sleep Button (CM) [SLPB]
[17179770.356000] usb 3-2: USB disconnect, address 3
[17179770.596000] usb 3-2: new full speed USB device using uhci_hcd and address 4
[17179770.772000] PM: Writing back config space on device 0000:02:00.0 at offset 1 (was 100102, writing 100106)
[17179770.948000] usb 3-2: configuration #1 chosen from 1 choice
[17179770.948000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[17179770.968000] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[17179770.984000] input: TPPS/2 IBM TrackPoint as /class/input/input4
[17179771.440000] usb 3-1: new full speed USB device using uhci_hcd and address 5
[17179771.664000] usb 3-1: configuration #1 chosen from 1 choice

--------------070800000306060007010405--
