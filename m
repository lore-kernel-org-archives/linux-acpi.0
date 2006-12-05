From: Thomas Andrews <tandrews@grok.co.za>
Subject: Re: pci_enable_device() and pci=routeirq
Date: Tue, 5 Dec 2006 06:39:50 +0200
Message-ID: <20061205043950.GA14299@grok.co.za>
References: <20061202150530.GA5159@grok.co.za> <200612041049.00690.bjorn.helgaas@hp.com> <4574770B.80009@grok.co.za> <200612041420.12741.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.grok.org.za ([196.1.58.22]:2985 "EHLO mail.grok.org.za"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968339AbWLEEkb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 23:40:31 -0500
Content-Disposition: inline
In-Reply-To: <200612041420.12741.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Dec 04, 2006 at 02:20:12PM -0700, Bjorn Helgaas wrote:

> On Monday 04 December 2006 12:29, Thomas Andrews wrote:
> > Bjorn Helgaas wrote:
> > > On Saturday 02 December 2006 08:05, Thomas Andrews wrote:
> > >> A driver that I've written for the Cologne HFC-4S (based heavily on
> > >> qozap.c) only receives interrupts when pci=routeirq is specified. The
> > >> driver is calling pci_enable_device(), so pci=routeirq should not be
> > >> necessary surely?
> > > 
> > > Can you point me to your driver?  I don't see it in the Linus or
> > > -mm trees.
> > > 
> > > The most likely problem is that you are using pci_dev.irq before
> > > calling pci_enable_device().
> > 
> > Thanks Bjorn. My driver and the original are at 
> > http://www.grok.org.za/qozap/
> > 
> > I'm pretty sure the interrupt is not invoked before calling 
> > pci_enable_device(), but perhaps you can shed some light...
> 
> It looks like you're doing the right thing.
> 
> Can you post the entire dmesg log with and without "pci=routeirq"?

OK, here it is:


Linux version 2.6.17.7-elf (tandrews@zorg.nextlink.co.za) (gcc version 3.3.6 (Debian 1:3.3.6-13)) #12 Tue Nov 28 09:13:40 SAST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000006fb0000 (usable)
 BIOS-e820: 0000000006fb0000 - 0000000006fb3000 (ACPI NVS)
 BIOS-e820: 0000000006fb3000 - 0000000006fc0000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
111MB LOWMEM available.
On node 0 totalpages: 28592
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 24496 pages, LIFO batch:3
DMI 2.2 present.
ACPI: RSDP (v000 AMDGX3                                ) @ 0x000f60f0
ACPI: RSDT (v001 AMDGX3 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x06fb3040
ACPI: FADT (v001 AMDGX3 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x06fb30c0
ACPI: DSDT (v001 AMDGX3 AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x9c10
Allocating PCI resources starting at 10000000 (gap: 06fc0000:f9030000)
Built 1 zonelists
Kernel command line: root=/dev/hdb1 idebus=33 console=ttyS0,38400
ide_setup: idebus=33
Initializing CPU#0
PID hash table entries: 512 (order: 9, 2048 bytes)
Detected 501.231 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 110728k/114368k available (1333k kernel code, 3180k reserved, 538k data, 116k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1003.98 BogoMIPS (lpj=2007972)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0088a93d c0c0a13d 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0088a93d c0c0a13d 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 128K (32 bytes/line)
CPU: After all inits, caps: 0088a93d c0c0a13d 00000000 00000000 00000000 00000000 00000000
CPU: AMD Geode(TM) Integrated Processor by AMD PCS stepping 02
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0c20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfaa10, last bus=0
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:00:01.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 11) *0
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 11) *0
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:01.1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
io scheduler cfq registered
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
cs5535_gpio: base=0x6100 mask=0xb003c66 major=254
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt Link [LNKD] BIOS reported IRQ 0, using IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xc7806000, 00:03:1d:03:7b:12, IRQ 11
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
Probing IDE interface ide0...
hdb: Hitachi XX.V.3.5.0.0, CFA DISK drive
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: max request size: 128KiB
hdb: 2002896 sectors (1025 MB) w/1KiB Cache, CHS=1987/16/63
 hdb: hdb1
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
i2c-core: driver [dev_driver] registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
SLPB PCI0 USB0 USB1 PCI1 PCI2 PCI3 PCI4 
ACPI: (supports S0 S1 S3 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 116k freed
spurious 8259A interrupt: IRQ7.
EXT3 FS on hdb1, internal journal
r8169: eth0: link up

--- modules loaded manually here ---

Axon registration driver (v0.01) Copyright (C) 2006 Thomas Andrews 
Zapata Telephony Interface Registered on major 196
Zaptel Version: 1.2.6 Echo Canceller: KB1
qozap: no version for "zt_receive" found: kernel tainted.
ACPI: PCI Interrupt 0000:00:0a.0[A]: no GSI - using IRQ 10
PCI: setting IRQ 10 as level-triggered
qozap: CologneChip HFC-4S evaluation board configured at io port 0xff00 IRQ 10 HZ 250
qozap: S/T ports: 4 [ TE TE TE TE ]
qozap: 1 multiBRI card(s) in this box, 4 BRI ports total, bloop 0, pcmslave 0.


Many thanks,
Thomas

