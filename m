From: Michael Madore <mmadore-JChM1cqIHx8AvxtiuMwx3w@public.gmane.org>
Subject: Re: APIC not enabled on Opteron
Date: Mon, 25 Aug 2003 14:30:23 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F4A7FEF.9010405@aslab.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCC4@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020303030909040106040206"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FCC4-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020303030909040106040206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Brown, Len wrote:

>Michael,
>I don't see the log attachment.
>
>In any case, 2.6-test3 is missing a couple of acpi interrupt changes
>that are now in 2.4.22-rc2; and I'll be getting those changes ready for
>2.6 shortly.
>
>In the mean-time, if you want the APIC more than you want ACPI, you can
>boot with acpi=off for now and the legacy code will configure your
>interrupts.
>
>Cheers,
>-Len
>
>  
>
Hi Len,

Sorry about that.  Here are the kernel messages, this time from the new 
2.4.22 and booted with acpi=off.  In this case, I still only get 16 irqs.

           CPU0
  0:     120189    IO-APIC-edge  timer
  1:         97    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  5:          4    IO-APIC-edge  ehci_hcd
  8:          1    IO-APIC-edge  rtc
 11:       5203    IO-APIC-edge  usb-ohci, ohci1394, eth0
 12:          0    IO-APIC-edge  PS/2 Mouse
 14:       6706    IO-APIC-edge  ide0
 15:          1    IO-APIC-edge  ide1
NMI:          0
LOC:     120129
ERR:          0
MIS:          0

Thanks for your advice

Mike


--------------020303030909040106040206
Content-Type: text/plain;
 name="apic.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apic.log"

Linux version 2.4.22 (root-+BuE2envYkR9v3KYkwAI1Vjtk6BVbLCt@public.gmane.org) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP Mon Aug 25 16:16:19 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dbf40000 (usable)
 BIOS-e820: 00000000dbf40000 - 00000000dbf50000 (ACPI data)
 BIOS-e820: 00000000dbf50000 - 00000000dc000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
2623MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0002000
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 900928
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 671552 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: TEMPLATE Product ID: SK8N         APIC at: 0xFEE00000
Processor #0 Unknown CPU [15:5] APIC version 16
I/O APIC #1 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: auto BOOT_IMAGE=2.4.22 ro BOOT_FILE=/boot/vmlinuz-2.4.22 root=/dev/hda2 acpi=off
Initializing CPU#0
Detected 1399.998 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2791.83 BogoMIPS
Memory: 3557628k/3603712k available (1890k kernel code, 45696k reserved, 657k data, 136k init, 2686208k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 262144 (order: 8, 1048576 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 078bfbff e1d3fbff 00000000 00000000
CPU:             Common caps: 078bfbff e1d3fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 078bfbff e1d3fbff 00000000 00000000
CPU:             Common caps: 078bfbff e1d3fbff 00000000 00000000
CPU0: AMD Opteron(tm) Processor 240 stepping 01
per-CPU timeslice cutoff: 2927.40 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 1 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 1 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1399.9860 MHz.
..... host bus clock speed is 199.9980 MHz.
cpu: 0, clocks: 1999980, slice: 999990
CPU0<T0:1999968,T1:999968,D:10,S:999990,C:1999980>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
ACPI: Subsystem revision 20030813
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [10de/00d0] at 00:01.0

--------------020303030909040106040206--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
