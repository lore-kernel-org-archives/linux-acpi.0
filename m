From: Mike Kasick <mkasick-lacpi@club.cc.cmu.edu>
Subject: Battery & cpufreq problems with HP nc6320
Date: Thu, 25 May 2006 14:16:07 -0400
Message-ID: <20060525181607.GA20444@club.cc.cmu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from MAGNESIUM.CLUB.CC.cmu.edu ([128.237.157.15]:57801 "EHLO
	magnesium.club.cc.cmu.edu") by vger.kernel.org with ESMTP
	id S1030312AbWEYSQJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 May 2006 14:16:09 -0400
Received: from mkasick by bismuth.club.cc.cmu.edu with local (Exim 4.50)
	id 1FjKNT-0005Lf-Nf
	for linux-acpi@vger.kernel.org; Thu, 25 May 2006 14:16:07 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've recently purchased a HP Compaq nc6320 notebook and have experienced
two ACPI-related issues with the machine.

For the first problem, it seems that the AC adapter and battery state
reporting doesn't work appropriately.  The
/proc/acpi/(ac_adapter|battery)/*/state files do exist, and if I cat
them I do get state information.  However, it seems that the state
information is only collected once per boot, and never updates.

For example, if I unplug the AC adapter and run on battery, the AC
adapter still claims to be on-line and the battery still claims to be
charged with no change in remaining capacity.  Similarly, if I boot with
a mostly discharged battery, the battery state claims to be charging
with no change in battery capacity for the charge duration and long
after.

The second problem is related to changing cpu frequency.  The processor
is an Intel Core Duo T2400 which has three running frequencies, 1.0,
1.3, and 1.8 GHz.  When the machine boots, both cores run at 1.8 GHz
until the speedstep_centrino module is activated.  At that point both
core frequencies drop to 1.3 GHz and will not return to 1.8 (though I
can change between 1.0 and 1.3 without a problem).

This latter issue I've debugged somewhat.  When changing cpu
frequencies, the acpi_processor_ppc_notifier notifiers calls
cpufreq_verify_within_limits() to determine if the new frequency is
currently compatible with the hardware.  This in turn calls
acpi_processor_get_platform_limit() which evaluates the ACPI _PPC
method.  It turns out that the _PPC method reports that only the lower
two states are available, leading me to believe that it is a bug in the
DSDT or even deeper in the firmware.

For this second issue, I can get around it by commenting out the call to
cpufreq_verify_within_limits().  By doing so I can switch between the
three operation frequencies without issue.  However, the incorrect
battery state reporting I can't work around, so I'm interested in
determining the root cause of it.

I've tested this machine with the 2.6.17-rc4 and 2.6.17-rc5 kernels,
both exhibit the same problems.  I've disassembled & reassembled the
machine's DSDT.  There were a few minor syntax warnings and two errors
in the process, both of which I fixed and tested with an override DSDT,
but there was no change in functionality.

I've attached the dmesg output from 2.6.17-rc4 with ACPI debugging
enabled using the stock DSDT.

Does anyone any insight as to what the cause of this problem might be,
or where/what I can consult next to dig deeper?  Thanks.

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6.17-rc4-acpi-debug"

Linux version 2.6.17-rc4-acpi-debug (root@agahnim) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #1 SMP PREEMPT Wed May 24 09:49:52 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f7d0000 (usable)
 BIOS-e820: 000000003f7d0000 - 000000003f7e5500 (reserved)
 BIOS-e820: 000000003f7e5500 - 000000003f7f6000 (ACPI NVS)
 BIOS-e820: 000000003f7f6000 - 000000003f800000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed9b000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
1015MB LOWMEM available.
On node 0 totalpages: 260048
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 255952 pages, LIFO batch:31
DMI 2.4 present.
ACPI: RSDP (v000 HP                                    ) @ 0x000f7d30
ACPI: RSDT (v001 HP     30AA     0x20030620 HP   0x00000001) @ 0x3f7e5584
ACPI: FADT (v002 HP     30AA     0x00000002 HP   0x00000001) @ 0x3f7e5500
ACPI: MADT (v001 HP     30AA     0x00000001 HP   0x00000001) @ 0x3f7e55c0
ACPI: MCFG (v001 HP     30AA     0x00000001 HP   0x00000001) @ 0x3f7e5628
ACPI: TCPA (v002 HP     30AA     0x00000001 HP   0x00000001) @ 0x3f7e5664
ACPI: SSDT (v001 HP       HPQSAT 0x00000001 MSFT 0x0100000e) @ 0x3f7f40c7
ACPI: SSDT (v001 HP        CpuPm 0x00003000 INTL 0x20050624) @ 0x3f7f48b4
ACPI: DSDT (v001 HP       nc6200 0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:14 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3f800000:bf400000)
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1829.819 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1028284k/1040192k available (1475k kernel code, 11372k reserved, 541k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3661.75 BogoMIPS (lpj=1830877)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
 tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0007) - 1181 Objects with 113 Devices 349 Methods 44 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 16 Objects with 4 Devices 5 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0005) - 14 Objects with 0 Devices 5 Methods 0 Regions
ACPI Namespace successfully loaded at root b033f758
evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
CPU0: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3657.04 BogoMIPS (lpj=1828524)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
Total of 2 processors activated (7318.80 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=2000
HP Compaq Laptop series board detected. Selecting BIOS-method for reboots.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 2.10 entry at 0xf0322, last bus=32
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI Error (evgpeblk-0284): Unknown GPE method type: C257 (name not of form _Lxx or _Exx) [20060127]
evgpeblk-0941 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1037 [05] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 5 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:...............................................................................................................................................................
Initialized 42/44 Regions 0/0 Fields 62/62 Buffers 55/67 Packages (1220 nodes)
Executing all Device _STA and_INI methods:..............................................................................................................................
126 Devices found - executed 3 _STA, 7 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [C002] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C002] bus is 0
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.C002._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C092._PRT]
ACPI: Embedded Controller [C005] (gpe 22) interrupt mode.
ACPI: Power Resource [C1E4] (on)
ACPI: Power Resource [C1F1] (on)
ACPI: Power Resource [C207] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C0FC._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C10F._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C112._PRT]
ACPI: PCI Interrupt Link [C108] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C109] (IRQs *10 11)
ACPI: PCI Interrupt Link [C10A] (IRQs *10 11)
ACPI: PCI Interrupt Link [C10B] (IRQs *10 11)
ACPI: PCI Interrupt Link [C124] (IRQs *10 11)
ACPI: PCI Interrupt Link [C125] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C126] (IRQs *10 11)
pci_link-0186 [07] pci_link_get_possible : Error evaluating _PRS
ACPI: Power Resource [C2F4] (off)
ACPI: Power Resource [C2F5] (off)
ACPI: Power Resource [C2F6] (off)
ACPI: Power Resource [C2F7] (off)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: d4000000-d40fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: 3000-3fff
  MEM window: d2000000-d3ffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
  IO window: 2000-2fff
  MEM window: d0000000-d1ffffff
  PREFETCH window: disabled.
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00005000-000050ff
  IO window: 00005400-000054ff
  PREFETCH window: 40000000-41ffffff
  MEM window: 42000000-43ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 5000-5fff
  MEM window: d4100000-d43fffff
  PREFETCH window: 40000000-41ffffff
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.2 to 64
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
acpi_bus-0201 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 17
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1148523292.417:1): initialized
JFS: nTxBlock = 8034, nTxLock = 64277
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: AC Adapter [C1B0] (on-line)
ACPI: Battery Slot [C1B2] (battery present)
ACPI: Battery Slot [C1B1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C226]
ACPI: Lid Switch [C21F]
ACPI: Fan [C2F8] (off)
ACPI: Fan [C2F9] (off)
ACPI: Fan [C2FA] (off)
ACPI: Fan [C2FB] (off)
ACPI: Video Device [C07F] (multi-head: yes  rom: no  post: no)
Parsing all Control Methods:
Table [SSDT](id 00B8) - 5 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 00B9) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
Parsing all Control Methods:
Table [SSDT](id 00C0) - 3 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 00C1) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI: CPU1 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [TZ0] (49 C)
ACPI: Thermal Zone [TZ1] (52 C)
ACPI: Thermal Zone [TZ2] (44 C)
ACPI: Thermal Zone [TZ3] (29 C)
ACPI: Thermal Zone [TZ4] (20 C)
libata version 1.20 loaded.
ahci 0000:00:1f.2: version 1.2
acpi_bus-0201 [05] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pmp pio slum part 
ata1: SATA max UDMA/133 cmd 0xF0014100 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF0014180 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xF0014200 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF0014280 ctl 0x0 bmdma 0x0 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:0f00 82:706b 83:7c09 84:6023 85:7069 86:3c09 87:6023 88:203f
ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ahci
ata2: SATA link down (SStatus 0)
scsi1 : ahci
ata3: SATA link down (SStatus 0)
scsi2 : ahci
ata4: SATA link down (SStatus 0)
scsi3 : ahci
  Vendor: ATA       Model: HTS541080G9SA00   Rev: MB4O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
TCP bic registered
input: AT Translated Set 2 keyboard as /class/input/input0
Starting balanced_irq
Using IPI Shortcut mode
VFS: Mounted root (jfs filesystem) readonly.
Freeing unused kernel memory: 156k freed
NET: Registered protocol family 1
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:02:06.1[B] -> GSI 19 (level, low) -> IRQ 18
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[d4101000-d41017ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x40a0-0x40a7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
USB Universal Host Controller Interface driver v3.0
synaptics reset failed
synaptics reset failed
synaptics reset failed
Linux agpgart interface v0.101 (c) Dave Jones
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04793/0x300000
serio: Synaptics pass-through port at isa0060/serio4/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
mice: PS/2 mouse device common for all mice
hda: HL-DT-ST DVDRAM GSA-4082N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
agpgart: Detected an Intel 945GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
acpi_bus-0201 [09] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xd4584000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00004020
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f9929451d0c]
eth1394: eth0: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00004040
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 17, io base 0x00004060
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new high speed USB device using ehci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 18, io base 0x00004080
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
tg3.c:v3.57 (Apr 28, 2006)
acpi_bus-0201 [09] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:15:60:bb:08:04
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:02:06.0 [103c:30aa]
Yenta: ISA IRQ mask 0x0cf8, PCI irq 17
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x5fff
cs: IO port probe 0x5000-0x5fff: clean.
pcmcia: parent PCI bridge Memory window: 0xd4100000 - 0xd43fffff
pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x41ffffff
acpi_bus-0201 [09] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
usb 4-2: new low speed USB device using uhci_hcd and address 2
cs: IO port probe 0x100-0x3af: excluding 0x378-0x37f
cs: IO port probe 0x3e0-0x4ff: excluding 0x3f8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
usb 4-2: configuration #1 chosen from 1 choice
usb 1-1.2: new full speed USB device using ehci_hcd and address 4
usb 1-1.2: device descriptor read/64, error -32
Adding 1052248k swap on /dev/sda2.  Priority:-1 extents:1 across:1052248k
usb 1-1.2: configuration #1 chosen from 1 choice
input: B16_b_02 USB-PS/2 Optical Mouse as /class/input/input2
input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:1d.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_conntrack version 2.4 (8126 buckets, 65008 max) - 224 bytes per conntrack
NET: Registered protocol family 17
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.

--vkogqOf2sHV7VnPd--
