From: Conke Hu <conke.hu@gmail.com>
Subject: [Help] "Error attaching device data"
Date: Thu, 29 Mar 2007 17:05:10 +0800
Message-ID: <1175159110.2901.22.camel@localhost.localdomain>
Reply-To: conke.hu@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-tgHl572HxJn/3L6sRFXe"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:10919 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbXC2JDY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Mar 2007 05:03:24 -0400
Received: by py-out-1112.google.com with SMTP id a29so54503pyi
        for <linux-acpi@vger.kernel.org>; Thu, 29 Mar 2007 02:03:24 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-tgHl572HxJn/3L6sRFXe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,
    I am idiot on ACPI knowing nothing about it :)
    When I boot linux on AMD Athlon64x2 + A690G + SB600 platform, I get
2 lines of error message saying "Error attaching device data", pls see
the attachment. I've tested on kernels 2.6.18 ~ 2.6.20, and each of them
has the same error.
    I debug the drivers/acpi/scan.c and find the error message is dumped
by the following code. and type == ACPI_BUS_TYPE_PROCESSOR, status ==
AE_ALREADY_EXISTS. 
    There are 2 error lines in dmesg because, I think, I use a dual core
CPU.
    Any suggestion is very thankful!


static int acpi_device_set_context(struct acpi_device *device, int type)
{
    acpi_status status = AE_OK;
    int result = 0;
    /*
     * Context
     * -------
     * Attach this 'struct acpi_device' to the ACPI object.  This makes
     * resolutions from handle->device very efficient.  Note that we
need
     * to be careful with fixed-feature devices as they all attach to
the
     * root object.
     */
    if (type != ACPI_BUS_TYPE_POWER_BUTTON &&
        type != ACPI_BUS_TYPE_SLEEP_BUTTON) {
        status = acpi_attach_data(device->handle,
                      acpi_bus_data_handler, device);

        if (ACPI_FAILURE(status)) {
            printk("Error attaching device data\n");
            result = -ENODEV;
        }
    }
    return result;
}
   
    
    

--=-tgHl572HxJn/3L6sRFXe
Content-Disposition: attachment; filename=dmesg-error-attching-driver-data
Content-Type: text/plain; name=dmesg-error-attching-driver-data; charset=UTF-8
Content-Transfer-Encoding: 7bit

Linux version 2.6.21-rc5-git1 (root@localhost.localdomain) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #2 SMP Sat Apr 7 22:47:58 CST 2007
Command line: ro root=LABEL=/1234 resume=/dev/hda6 3
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bfa0000 (usable)
 BIOS-e820: 000000001bfa0000 - 000000001bfae000 (ACPI data)
 BIOS-e820: 000000001bfae000 - 000000001bff0000 (ACPI NVS)
 BIOS-e820: 000000001bff0000 - 000000001c000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 114592) 1 entries of 3200 used
end_pfn_map = 114688
DMI present.
ACPI: RSDP 000F9020, 0024 (r2 ACPIAM)
ACPI: XSDT 1BFA0100, 004C (r1 A M I  OEMXSDT   2000701 MSFT       97)
ACPI: FACP 1BFA0290, 00F4 (r3 A M I  OEMFACP   2000701 MSFT       97)
ACPI: DSDT 1BFA0480, 4696 (r1  AMM66 AMM66B36      B36 INTL 20051117)
ACPI: FACS 1BFAE000, 0040
ACPI: APIC 1BFA0390, 005C (r1 A M I  OEMAPIC   2000701 MSFT       97)
ACPI: MCFG 1BFA03F0, 003C (r1 A M I  OEMMCFG   2000701 MSFT       97)
ACPI: HPET 1BFA4B20, 0038 (r1 A M I  OEMHPET   2000701 MSFT       97)
ACPI: SSDT 1BFA4CA0, 0248 (r1 A M I  POWERNOW        1 AMD         1)
No NUMA configuration found
Faking a node at 0000000000000000-000000001bfa0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 114592) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000001bfa0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   114592
On node 0 totalpages: 114495
  DMA zone: 56 pages used for memmap
  DMA zone: 793 pages reserved
  DMA zone: 3150 pages, LIFO batch:0
  DMA32 zone: 1510 pages used for memmap
  DMA32 zone: 108986 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
ACPI: HPET id: 0x8300 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e4000
Nosave address range: 00000000000e4000 - 0000000000100000
Allocating PCI resources starting at 20000000 (gap: 1c000000:e4000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 34176 bytes of per cpu data
Built 1 zonelists.  Total pages: 112136
Kernel command line: ro root=LABEL=/1234 resume=/dev/hda6 3
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 16384 bytes)
Extended CMOS year: 2000
time.c: Detected 2400.063 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Checking aperture...
CPU 0: aperture @ 442a000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 446036k/458368k available (1714k kernel code, 11944k reserved, 812k data, 268k init)
Calibrating delay using timer specific routine.. 4916.88 BogoMIPS (lpj=24584405)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12500341
Detected 12.500 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4800.16 BogoMIPS (lpj=24000821)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4800+ stepping 02
Brought up 2 CPUs
migration_cost=647
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
Error attaching device data
Error attaching device data
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
0000:00:14.1: trying to change BAR0 from 0000 to 01F0
0000:00:14.1: trying to change BAR1 from 0000 to 03F4
0000:00:14.1: trying to change BAR2 from 0000 to 0170
0000:00:14.1: trying to change BAR3 from 0000 to 0374
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
hpet0: 4 32-bit timers, 14318180 Hz
pnp: 00:01: iomem range 0x1c000000-0x1fffffff has been reserved
pnp: 00:08: iomem range 0xfec00000-0xfec00fff has been reserved
pnp: 00:08: iomem range 0xfee00000-0xfee00fff has been reserved
pnp: 00:09: iomem range 0xffb80000-0xffbfffff has been reserved
pnp: 00:09: iomem range 0xfff00000-0xffffffff has been reserved
pnp: 00:0c: ioport range 0xe00-0xe0f has been reserved
pnp: 00:0c: ioport range 0xe80-0xe8f has been reserved
pnp: 00:0c: ioport range 0xf40-0xf4f has been reserved
pnp: 00:0c: ioport range 0xa30-0xa3f has been reserved
pnp: 00:0d: iomem range 0xe0000000-0xefffffff has been reserved
pnp: 00:0e: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0e: iomem range 0xc0000-0xcffff has been reserved
pnp: 00:0e: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:0e: iomem range 0x100000-0x1bffffff could not be reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:01:05.0
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: ff000000-ff2fffff
  PREFETCH window: f6b00000-feafffff
PCI: Bridge: 0000:00:06.0
  IO window: a000-afff
  MEM window: ff300000-ff4fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: b000-bfff
  MEM window: ff500000-ff5fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:14.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
NET: Registered protocol family 2
Time: hpet clocksource has been installed.
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 6, 393216 bytes)
TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1601k freed
io scheduler noop registered
io scheduler cfq registered (default)
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
i2c /dev entries driver
it87: Found IT8712F chip at 0xe80, revision 7
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V Stand-By)
TCP cubic registered
NET: Registered protocol family 1
<snip>

--=-tgHl572HxJn/3L6sRFXe--

