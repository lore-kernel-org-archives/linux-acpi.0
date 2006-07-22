From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: ACPI problem on dual-Xeon server (2.6.18-rc2)
Date: Sat, 22 Jul 2006 04:57:34 +0200
Message-ID: <20060722025734.GA26468@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from run.smurf.noris.de ([192.109.102.41]:24483 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1751121AbWGVDAV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jul 2006 23:00:21 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by smurf.noris.de with smtp (Exim 4.60)
	(envelope-from <smurf@smurf.noris.de>)
	id 1G47gO-00029a-UL
	for linux-acpi@vger.kernel.org; Sat, 22 Jul 2006 04:59:22 +0200
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This box didn't boot on 2.6.18-rc2.
(The last kernel I tested which worked (at least until it broke for
other reasons...) was 2.6.17-rc2.)

What happened was that after the ACPI error message in the log
(appended), udevplug ran. udevplug sleeps for a tenth of a second. 
A sleep may happen to be rather longer than expected when the two CPUs in
question have wildly varying ideas of what the current time is. :-(
("date" flipped values.)

I can run a "git bisect". Somebody please tell me what the offending
files or subdiretories might be, so that I don't waste time rebooting on
inconsequential changes. Thanks.

Linux version 2.6.18-rc2-1.28 (root@kiste) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #38 SMP PREEMPT Thu Jul 20 05:03:48 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b000 (usable)
 BIOS-e820: 000000000009b000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000d7f70000 (usable)
 BIOS-e820: 00000000d7f70000 - 00000000d7f7b000 (ACPI data)
 BIOS-e820: 00000000d7f7b000 - 00000000d7f80000 (ACPI NVS)
 BIOS-e820: 00000000d7f80000 - 00000000d8000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
Warning only 1152MB will be used.
Use a PAE enabled kernel.
1152MB LOWMEM available.
found SMP MP-table at 000f6700
On node 0 totalpages: 294912
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 290816 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6750
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0xd7f75ea1
ACPI: FADT (v001 INTEL  TUMWATER 0x06040000 PTL  0x00000003) @ 0xd7f7ae35
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0xd7f7aea9
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0xd7f7af39
ACPI: MCFG (v001 PTLTD  	 Mcfg   0x06040000  LTP 0x00000000) @ 0xd7f7af61
ACPI: ASF! (v016   CETP     CETP 0x06040000 PTL  0x00000001) @ 0xd7f7af9d
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0xd7f75edd
ACPI: DSDT (v001  Intel Lindhrst 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f1000000 (gap: f0000000:0ec00000)
Detected 3000.371 MHz processor.
Built 1 zonelists.  Total pages: 294912
Kernel command line: root=/dev/md1 ro single break
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec10000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Memory: 1151592k/1179648k available (1466k kernel code, 27392k reserved, 776k data, 188k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6006.38 BogoMIPS (lpj=12012776)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
lockdep: not fixing up alternatives.
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6003.75 BogoMIPS (lpj=12007514)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
lockdep: not fixing up alternatives.
Booting processor 2/6 eip 2000
Initializing CPU#2
Calibrating delay using timer specific routine.. 5600.75 BogoMIPS (lpj=11201511)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
CPU2: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
lockdep: not fixing up alternatives.
Booting processor 3/7 eip 2000
Initializing CPU#3
Calibrating delay using timer specific routine.. 5600.71 BogoMIPS (lpj=11201438)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
CPU3: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Total of 4 processors activated (23211.61 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 4 CPUs: 
Brought up 4 CPUs
migration_cost=7,1514
checking if image is initramfs... it is
Freeing initrd memory: 5065k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:03.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIX._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *3
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 *10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: da100000-da1fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: da200000-da2fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
  IO window: 2000-2fff
  MEM window: da300000-da3fffff
  PREFETCH window: de000000-dfffffff
PCI: Bridge: 0000:05:04.0
  IO window: 4000-4fff
  MEM window: dc000000-dc0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:02.0
  IO window: 4000-4fff
  MEM window: dc000000-dc0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-4fff
  MEM window: da400000-dc0fffff
  PREFETCH window: f1000000-f10fffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 65536 (order: 9, 2359296 bytes)
TCP bind hash table entries: 32768 (order: 8, 1179648 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:1d.0: uhci_check_and_reset_hc: legsup = 0x003b
pci 0000:00:1d.0: Performing full reset
pci 0000:00:1d.1: uhci_check_and_reset_hc: legsup = 0x0010
pci 0000:00:1d.1: Performing full reset
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 188k freed
Time: tsc clocksource has been installed.
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
md: raid1 personality registered for level 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: Maxtor 6Y120L0, ATA DISK drive
hdd: IC35L100AVVA07-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3
hdd: max request size: 128KiB
hdd: 201045600 sectors (102935 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hdd: cache flushes supported
 hdd: hdd1 hdd2 hdd3
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
ACPI: Processor [CPU3] (supports 8 throttling states)

[ the following lines do not show up with older kernels ]
BIOS reported wrong ACPI idfor the processor
ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify handler [20060707]
BIOS reported wrong ACPI idfor the processor
ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify handler [20060707]
BIOS reported wrong ACPI idfor the processor
ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify handler [20060707]
BIOS reported wrong ACPI idfor the processor
ACPI Exception (evxface-0545): AE_NOT_EXIST, Removing notify handler [20060707]

[ hang ]
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
[...]
udevplug      S 003954DF     0   429    424                     (NOTLB)
       dfea5f38 5b12f0c8 00000017 003954df dff3caa0 f76e7540 5ca442e7 00000017 
       00000002 dff3cbc4 b1fe7cc0 00000076 00000000 00000004 00000417 00000000 
       80f8f2be 00000417 00000286 dfea5f68 00000001 00000001 dfea5f4c b026c835 
Call Trace:
 [<b026c835>] do_nanosleep+0x3f/0x71
 [<b012be84>] hrtimer_nanosleep+0x3c/0xe9
 [<b012bf72>] sys_nanosleep+0x41/0x53
 [<b01029b3>] syscall_call+0x7/0xb

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I will hire a team of board-certified architects and surveyors to
examine my castle and inform me of any secret passages and abandoned
tunnels that I might not know about.
		-- The Evil Overlord List
