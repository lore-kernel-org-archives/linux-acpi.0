From: Gregory Finch <Gregory.Finch-EynCeXvFgoheoWH0uzbU5w@public.gmane.org>
Subject: ACPI power-off problem in Linux 2.6.1-rc1
Date: Thu, 08 Jan 2004 13:09:00 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FFDC6EC.4050003@telus.net>
Reply-To: Grergory.Finch-EynCeXvFgoheoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I'm having a problem with power-off on my system. It's a dual P3-550 and
50% of the time it will not power-off when I shut it down. I have NMI
watchdog enabled and when the problem occurs, it trips saying it has
detected LOCKUP on CPU1. I haven't got serial console enabled yet so no
copy of the trace from the NMI, but if need be I can set it up.

My guess is that the power-off routine doesn't like to run on anything
but CPU0, but I haven't dug into the code too far yet.

MB is Epox KP6-BS
Dual P3 550MHz
Intel 440BX chipset
512MB RAM
attached is .config and dmesg

Please include me in replies, as I'm not subscribed to acpi-devel.

Thanks,

Gregory Finch



Jan  8 08:56:22 uberboxen syslogd 1.4.1: restart.
Jan  8 08:56:22 uberboxen kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jan  8 08:56:22 uberboxen kernel: Inspecting /boot/System.map-2.6.1-rc1
Jan  8 08:56:22 uberboxen kernel: Loaded 23240 symbols from /boot/System.map-2.6.1-rc1.
Jan  8 08:56:22 uberboxen kernel: Symbols match kernel version 2.6.1.
Jan  8 08:56:22 uberboxen kernel: No module symbols loaded - kernel modules not enabled.
Jan  8 08:56:22 uberboxen kernel: Linux version 2.6.1-rc1 (root-t/Pdn6GhL7X/PtFMR13I2A@public.gmane.org) (gcc version 3.2.2) #1 SMP Sat Jan 3 17:01:40 PST 2004
Jan  8 08:56:22 uberboxen kernel: BIOS-provided physical RAM map:
Jan  8 08:56:22 uberboxen kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jan  8 08:56:22 uberboxen kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jan  8 08:56:22 uberboxen kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  8 08:56:22 uberboxen kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Jan  8 08:56:22 uberboxen kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Jan  8 08:56:22 uberboxen kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Jan  8 08:56:22 uberboxen kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jan  8 08:56:22 uberboxen kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jan  8 08:56:22 uberboxen kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jan  8 08:56:22 uberboxen kernel: user-defined physical RAM map:
Jan  8 08:56:22 uberboxen kernel:  user: 0000000000000000 - 000000000009fc00 (usable)
Jan  8 08:56:22 uberboxen kernel:  user: 000000000009fc00 - 00000000000a0000 (reserved)
Jan  8 08:56:22 uberboxen kernel:  user: 00000000000f0000 - 0000000000100000 (reserved)
Jan  8 08:56:22 uberboxen kernel:  user: 0000000000100000 - 000000001fff0000 (usable)
Jan  8 08:56:22 uberboxen kernel: 511MB LOWMEM available.
Jan  8 08:56:22 uberboxen kernel: found SMP MP-table at 000f5820
Jan  8 08:56:22 uberboxen kernel: hm, page 000f5000 reserved twice.
Jan  8 08:56:22 uberboxen kernel: hm, page 000f6000 reserved twice.
Jan  8 08:56:22 uberboxen kernel: hm, page 000f1000 reserved twice.
Jan  8 08:56:22 uberboxen kernel: hm, page 000f2000 reserved twice.
Jan  8 08:56:22 uberboxen kernel: On node 0 totalpages: 131056
Jan  8 08:56:22 uberboxen kernel:   DMA zone: 4096 pages, LIFO batch:1
Jan  8 08:56:22 uberboxen kernel:   Normal zone: 126960 pages, LIFO batch:16
Jan  8 08:56:22 uberboxen kernel:   HighMem zone: 0 pages, LIFO batch:1
Jan  8 08:56:22 uberboxen kernel: DMI not present.
Jan  8 08:56:22 uberboxen kernel: ACPI: RSDP (v000 Award                                     ) @ 0x000f70c0
Jan  8 08:56:22 uberboxen kernel: ACPI: RSDT (v001 Award  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
Jan  8 08:56:22 uberboxen kernel: ACPI: FADT (v001 Award  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
Jan  8 08:56:22 uberboxen kernel: ACPI: MADT (v001 Award           0x00000000  0x00000000) @ 0x1fff55c0
Jan  8 08:56:22 uberboxen kernel: ACPI: DSDT (v001 AWARD  AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Jan  8 08:56:22 uberboxen kernel: ACPI: Local APIC address 0xfee00000
Jan  8 08:56:22 uberboxen kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan  8 08:56:22 uberboxen kernel: Processor #0 6:7 APIC version 17
Jan  8 08:56:22 uberboxen kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jan  8 08:56:22 uberboxen kernel: Processor #1 6:7 APIC version 17
Jan  8 08:56:22 uberboxen kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Jan  8 08:56:22 uberboxen kernel: IOAPIC[0]: Assigned apic_id 2
Jan  8 08:56:22 uberboxen kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
Jan  8 08:56:22 uberboxen kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x3])
Jan  8 08:56:22 uberboxen kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x14] polarity[0x1] trigger[0x3])
Jan  8 08:56:22 uberboxen kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jan  8 08:56:22 uberboxen kernel: Using ACPI (MADT) for SMP configuration information
Jan  8 08:56:22 uberboxen kernel: Building zonelist for node : 0
Jan  8 08:56:22 uberboxen kernel: Kernel command line: root=/dev/hdb1 vga=0x30B nmi_watchdog=1 mem=524224K
Jan  8 08:56:22 uberboxen kernel: Initializing CPU#0
Jan  8 08:56:22 uberboxen kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Jan  8 08:56:22 uberboxen kernel: Detected 551.372 MHz processor.
Jan  8 08:56:22 uberboxen kernel: Using tsc for high-res timesource
Jan  8 08:56:22 uberboxen kernel: Console: colour VGA+ 132x50
Jan  8 08:56:22 uberboxen kernel: Memory: 514788k/524224k available (2228k kernel code, 8696k reserved, 571k data, 356k init, 0k highmem)
Jan  8 08:56:22 uberboxen kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jan  8 08:56:22 uberboxen kernel: Calibrating delay loop... 1089.53 BogoMIPS
Jan  8 08:56:22 uberboxen kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Jan  8 08:56:22 uberboxen kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Jan  8 08:56:22 uberboxen kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jan  8 08:56:22 uberboxen kernel: CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
Jan  8 08:56:22 uberboxen kernel: CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
Jan  8 08:56:22 uberboxen kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jan  8 08:56:22 uberboxen kernel: CPU: L2 cache: 512K
Jan  8 08:56:22 uberboxen kernel: CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Jan  8 08:56:22 uberboxen kernel: Intel machine check architecture supported.
Jan  8 08:56:22 uberboxen kernel: Intel machine check reporting enabled on CPU#0.
Jan  8 08:56:22 uberboxen kernel: Enabling fast FPU save and restore... done.
Jan  8 08:56:22 uberboxen kernel: Enabling unmasked SIMD FPU exception support... done.
Jan  8 08:56:22 uberboxen kernel: Checking 'hlt' instruction... OK.
Jan  8 08:56:22 uberboxen kernel: POSIX conformance testing by UNIFIX
Jan  8 08:56:22 uberboxen kernel: CPU0: Intel Pentium III (Katmai) stepping 03
Jan  8 08:56:22 uberboxen kernel: per-CPU timeslice cutoff: 1462.62 usecs.
Jan  8 08:56:22 uberboxen kernel: task migration cache decay timeout: 2 msecs.
Jan  8 08:56:22 uberboxen kernel: enabled ExtINT on CPU#0
Jan  8 08:56:22 uberboxen kernel: ESR value before enabling vector: 00000000
Jan  8 08:56:22 uberboxen kernel: ESR value after enabling vector: 00000000
Jan  8 08:56:22 uberboxen kernel: Booting processor 1/1 eip 2000
Jan  8 08:56:22 uberboxen kernel: Initializing CPU#1
Jan  8 08:56:22 uberboxen kernel: masked ExtINT on CPU#1
Jan  8 08:56:22 uberboxen kernel: ESR value before enabling vector: 00000000
Jan  8 08:56:22 uberboxen kernel: ESR value after enabling vector: 00000000
Jan  8 08:56:22 uberboxen kernel: Calibrating delay loop... 1097.72 BogoMIPS
Jan  8 08:56:22 uberboxen kernel: CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
Jan  8 08:56:22 uberboxen kernel: CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
Jan  8 08:56:22 uberboxen kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jan  8 08:56:22 uberboxen kernel: CPU: L2 cache: 512K
Jan  8 08:56:22 uberboxen kernel: CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Jan  8 08:56:22 uberboxen kernel: Intel machine check architecture supported.
Jan  8 08:56:22 uberboxen kernel: Intel machine check reporting enabled on CPU#1.
Jan  8 08:56:22 uberboxen kernel: CPU1: Intel Pentium III (Katmai) stepping 03
Jan  8 08:56:22 uberboxen kernel: Total of 2 processors activated (2187.26 BogoMIPS).
Jan  8 08:56:22 uberboxen kernel: ENABLING IO-APIC IRQs
Jan  8 08:56:22 uberboxen kernel: init IO_APIC IRQs
Jan  8 08:56:22 uberboxen kernel:  IO-APIC (apicid-pin) 2-0, 2-9, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not connected.
Jan  8 08:56:22 uberboxen kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jan  8 08:56:22 uberboxen kernel: activating NMI Watchdog ... done.
Jan  8 08:56:22 uberboxen kernel: testing NMI watchdog ... OK.
Jan  8 08:56:22 uberboxen kernel: number of MP IRQ sources: 15.
Jan  8 08:56:22 uberboxen kernel: number of IO-APIC #2 registers: 24.
Jan  8 08:56:22 uberboxen kernel: testing the IO APIC.......................
Jan  8 08:56:22 uberboxen kernel: IO APIC #2......
Jan  8 08:56:22 uberboxen kernel: .... register #00: 02000000
Jan  8 08:56:22 uberboxen kernel: .......    : physical APIC id: 02
Jan  8 08:56:22 uberboxen kernel: .......    : Delivery Type: 0
Jan  8 08:56:22 uberboxen kernel: .......    : LTS          : 0
Jan  8 08:56:22 uberboxen kernel: .... register #01: 00170011
Jan  8 08:56:22 uberboxen kernel: .......     : max redirection entries: 0017
Jan  8 08:56:22 uberboxen kernel: .......     : PRQ implemented: 0
Jan  8 08:56:22 uberboxen kernel: .......     : IO APIC version: 0011
Jan  8 08:56:22 uberboxen kernel: .... register #02: 00000000
Jan  8 08:56:22 uberboxen kernel: .......     : arbitration: 00
Jan  8 08:56:22 uberboxen kernel: .... IRQ redirection table:
Jan  8 08:56:22 uberboxen kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Jan  8 08:56:22 uberboxen kernel:  00 000 00  1    0    0   0   0    0    0    00
Jan  8 08:56:22 uberboxen kernel:  01 001 01  0    0    0   0   0    1    1    39
Jan  8 08:56:22 uberboxen kernel:  02 001 01  0    0    0   0   0    1    1    31
Jan  8 08:56:22 uberboxen kernel:  03 001 01  0    0    0   0   0    1    1    41
Jan  8 08:56:22 uberboxen kernel:  04 001 01  0    0    0   0   0    1    1    49
Jan  8 08:56:22 uberboxen kernel:  05 001 01  0    0    0   0   0    1    1    51
Jan  8 08:56:22 uberboxen kernel:  06 001 01  0    0    0   0   0    1    1    59
Jan  8 08:56:22 uberboxen kernel:  07 001 01  0    0    0   0   0    1    1    61
Jan  8 08:56:22 uberboxen kernel:  08 001 01  0    0    0   0   0    1    1    69
Jan  8 08:56:22 uberboxen kernel:  09 000 00  1    0    0   0   0    0    0    00
Jan  8 08:56:22 uberboxen kernel:  0a 001 01  0    0    0   0   0    1    1    71
Jan  8 08:56:22 uberboxen kernel:  0b 001 01  0    0    0   0   0    1    1    79
Jan  8 08:56:22 uberboxen kernel:  0c 001 01  0    0    0   0   0    1    1    81
Jan  8 08:56:22 uberboxen kernel:  0d 001 01  0    0    0   0   0    1    1    89
Jan  8 08:56:22 uberboxen kernel:  0e 001 01  0    0    0   0   0    1    1    91
Jan  8 08:56:22 uberboxen kernel:  0f 001 01  0    0    0   0   0    1    1    99
Jan  8 08:56:22 uberboxen kernel:  10 000 00  1    0    0   0   0    0    0    00
Jan  8 08:56:22 uberboxen kernel:  11 000 00  1    0    0   0   0    0    0    00
Jan  8 08:56:22 uberboxen kernel:  12 000 00  1    0    0   0   0    0    0    00
Jan  8 08:56:22 uberboxen kernel:  13 000 00  1    0    0   0   0    0    0    00
Jan  8 08:56:22 uberboxen kernel:  14 001 01  1    1    0   0   0    1    1    A1
Jan  8 08:56:22 uberboxen kernel:  15 000 00  1    0    0   0   0    0    0    00
Jan  8 08:56:22 uberboxen kernel:  16 000 00  1    0    0   0   0    0    0    00
Jan  8 08:56:22 uberboxen kernel:  17 000 00  1    0    0   0   0    0    0    00
Jan  8 08:56:22 uberboxen kernel: IRQ to pin mappings:
Jan  8 08:56:22 uberboxen kernel: IRQ0 -> 0:2
Jan  8 08:56:22 uberboxen kernel: IRQ1 -> 0:1
Jan  8 08:56:22 uberboxen kernel: IRQ3 -> 0:3
Jan  8 08:56:22 uberboxen kernel: IRQ4 -> 0:4
Jan  8 08:56:22 uberboxen kernel: IRQ5 -> 0:5
Jan  8 08:56:22 uberboxen kernel: IRQ6 -> 0:6
Jan  8 08:56:22 uberboxen kernel: IRQ7 -> 0:7
Jan  8 08:56:22 uberboxen kernel: IRQ8 -> 0:8
Jan  8 08:56:22 uberboxen kernel: IRQ9 -> 0:20
Jan  8 08:56:22 uberboxen kernel: IRQ10 -> 0:10
Jan  8 08:56:22 uberboxen kernel: IRQ11 -> 0:11
Jan  8 08:56:22 uberboxen kernel: IRQ12 -> 0:12
Jan  8 08:56:22 uberboxen kernel: IRQ13 -> 0:13
Jan  8 08:56:22 uberboxen kernel: IRQ14 -> 0:14
Jan  8 08:56:22 uberboxen kernel: IRQ15 -> 0:15
Jan  8 08:56:22 uberboxen kernel: .................................... done.
Jan  8 08:56:22 uberboxen kernel: Using local APIC timer interrupts.
Jan  8 08:56:22 uberboxen kernel: calibrating APIC timer ...
Jan  8 08:56:22 uberboxen kernel: ..... CPU clock speed is 551.0144 MHz.
Jan  8 08:56:22 uberboxen kernel: ..... host bus clock speed is 100.0207 MHz.
Jan  8 08:56:22 uberboxen kernel: checking TSC synchronization across 2 CPUs: passed.
Jan  8 08:56:22 uberboxen kernel: Starting migration thread for cpu 0
Jan  8 08:56:22 uberboxen kernel: Bringing up 1
Jan  8 08:56:22 uberboxen kernel: CPU 1 IS NOW UP!
Jan  8 08:56:22 uberboxen kernel: Starting migration thread for cpu 1
Jan  8 08:56:22 uberboxen kernel: CPUS done 2
Jan  8 08:56:22 uberboxen kernel: NET: Registered protocol family 16
Jan  8 08:56:22 uberboxen kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb400, last bus=2
Jan  8 08:56:22 uberboxen kernel: PCI: Using configuration type 1
Jan  8 08:56:22 uberboxen kernel: mtrr: v2.0 (20020519)
Jan  8 08:56:22 uberboxen kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
Jan  8 08:56:22 uberboxen kernel: mtrr: probably your BIOS does not setup all CPUs.
Jan  8 08:56:22 uberboxen kernel: mtrr: corrected configuration.
Jan  8 08:56:22 uberboxen kernel: ACPI: Subsystem revision 20031002
Jan  8 08:56:22 uberboxen kernel: IOAPIC[0]: Set PCI routing entry (2-20 -> 0xa9 -> IRQ 20 Mode:1 Active:0)
Jan  8 08:56:22 uberboxen kernel:     ACPI-0352: *** Error: Looking up [\_PR_.CPU0] in namespace, AE_NOT_FOUND
Jan  8 08:56:22 uberboxen kernel: search_node dff35a20 start_node dff35a20 return_node 00000000
Jan  8 08:56:22 uberboxen kernel:     ACPI-1120: *** Error: [NULL NAME], AE_NOT_FOUND
Jan  8 08:56:22 uberboxen kernel: ACPI: Interpreter enabled
Jan  8 08:56:22 uberboxen kernel: ACPI: Using IOAPIC for interrupt routing
Jan  8 08:56:22 uberboxen kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jan  8 08:56:22 uberboxen kernel: PCI: Probing PCI hardware (bus 00)
Jan  8 08:56:22 uberboxen kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jan  8 08:56:22 uberboxen kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jan  8 08:56:22 uberboxen kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Jan  8 08:56:22 uberboxen kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jan  8 08:56:22 uberboxen kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15)
Jan  8 08:56:22 uberboxen kernel: ACPI: Power Resource [PFAN] (on)
Jan  8 08:56:22 uberboxen kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan  8 08:56:22 uberboxen kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb1 -> IRQ 16 Mode:1 Active:1)
Jan  8 08:56:22 uberboxen kernel: 00:00:08[A] -> 2-16 -> IRQ 16
Jan  8 08:56:22 uberboxen kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
Jan  8 08:56:22 uberboxen kernel: 00:00:08[B] -> 2-17 -> IRQ 17
Jan  8 08:56:22 uberboxen kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
Jan  8 08:56:22 uberboxen kernel: 00:00:08[C] -> 2-18 -> IRQ 18
Jan  8 08:56:22 uberboxen kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc9 -> IRQ 19 Mode:1 Active:1)
Jan  8 08:56:22 uberboxen kernel: 00:00:08[D] -> 2-19 -> IRQ 19
Jan  8 08:56:22 uberboxen kernel: Pin 2-17 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-18 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-19 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-16 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-18 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-19 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-16 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-17 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-19 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-16 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-17 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-18 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-19 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-16 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-17 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-18 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-16 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-17 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-18 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-19 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-16 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-17 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-18 already programmed
Jan  8 08:56:22 uberboxen kernel: Pin 2-19 already programmed
Jan  8 08:56:22 uberboxen kernel: PCI: Using ACPI for IRQ routing
Jan  8 08:56:22 uberboxen kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Jan  8 08:56:22 uberboxen kernel: Starting balanced_irq
Jan  8 08:56:22 uberboxen kernel: SGI XFS for Linux with no debug enabled
Jan  8 08:56:22 uberboxen kernel: Limiting direct PCI/PCI transfers.
Jan  8 08:56:22 uberboxen kernel: ACPI: Processor [CPU] (supports C1)
Jan  8 08:56:22 uberboxen kernel: ACPI: Processor [CPU1] (supports C1)
Jan  8 08:56:22 uberboxen kernel:     ACPI-0352: *** Error: Looking up [\_PR_.CPU0] in namespace, AE_NOT_FOUND
Jan  8 08:56:22 uberboxen kernel: search_node dff35a20 start_node dff35a20 return_node 00000000
Jan  8 08:56:22 uberboxen kernel:     ACPI-1120: *** Error: [NULL NAME], AE_NOT_FOUND
Jan  8 08:56:22 uberboxen kernel: ACPI: Thermal Zone [THRM] (16 C)
Jan  8 08:56:22 uberboxen kernel: pty: 256 Unix98 ptys configured
Jan  8 08:56:22 uberboxen kernel: Real Time Clock Driver v1.12
Jan  8 08:56:22 uberboxen kernel: Linux agpgart interface v0.100 (c) Dave Jones
Jan  8 08:56:22 uberboxen kernel: agpgart: Detected an Intel 440BX Chipset.
Jan  8 08:56:22 uberboxen kernel: agpgart: Maximum main memory to use for agp memory: 439M
Jan  8 08:56:22 uberboxen kernel: agpgart: AGP aperture is 256M @ 0xc0000000
Jan  8 08:56:22 uberboxen kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Jan  8 08:56:22 uberboxen kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan  8 08:56:22 uberboxen kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jan  8 08:56:22 uberboxen kernel: Using anticipatory io scheduler
Jan  8 08:56:22 uberboxen kernel: Floppy drive(s): fd0 is 1.44M
Jan  8 08:56:22 uberboxen kernel: FDC 0 is a post-1991 82077
Jan  8 08:56:22 uberboxen kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
Jan  8 08:56:22 uberboxen kernel: tulip0:  EEPROM default media type Autosense.
Jan  8 08:56:22 uberboxen kernel: tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Jan  8 08:56:22 uberboxen kernel: tulip0:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Jan  8 08:56:22 uberboxen kernel: eth0: Digital DS21143 Tulip rev 65 at 0xe0806000, 00:80:C8:F8:4E:9D, IRQ 17.
Jan  8 08:56:22 uberboxen kernel: tulip1:  EEPROM default media type Autosense.
Jan  8 08:56:22 uberboxen kernel: tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Jan  8 08:56:22 uberboxen kernel: tulip1:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
Jan  8 08:56:22 uberboxen kernel: eth1: Digital DS21143 Tulip rev 65 at 0xe085d000, 00:80:C8:F8:4E:9E, IRQ 18.
Jan  8 08:56:22 uberboxen kernel: tulip2:  EEPROM default media type Autosense.
Jan  8 08:56:22 uberboxen kernel: tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Jan  8 08:56:22 uberboxen kernel: tulip2:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
Jan  8 08:56:22 uberboxen kernel: eth2: Digital DS21143 Tulip rev 65 at 0xe085f000, 00:80:C8:F8:4E:9F, IRQ 19.
Jan  8 08:56:22 uberboxen kernel: tulip3:  EEPROM default media type Autosense.
Jan  8 08:56:22 uberboxen kernel: tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Jan  8 08:56:22 uberboxen kernel: tulip3:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
Jan  8 08:56:22 uberboxen kernel: eth3: Digital DS21143 Tulip rev 65 at 0xe0861000, 00:80:C8:F8:4E:A0, IRQ 16.
Jan  8 08:56:22 uberboxen kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan  8 08:56:22 uberboxen kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan  8 08:56:22 uberboxen kernel: PIIX4: IDE controller at PCI slot 0000:00:07.1
Jan  8 08:56:22 uberboxen kernel: PIIX4: chipset revision 1
Jan  8 08:56:22 uberboxen kernel: PIIX4: not 100%% native mode: will probe irqs later
Jan  8 08:56:22 uberboxen kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Jan  8 08:56:22 uberboxen kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Jan  8 08:56:22 uberboxen kernel: hda: FUJITSU MPF3204AT, ATA DISK drive
Jan  8 08:56:22 uberboxen kernel: hdb: FUJITSU MPF3204AT, ATA DISK drive
Jan  8 08:56:22 uberboxen kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan  8 08:56:22 uberboxen kernel: hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
Jan  8 08:56:22 uberboxen kernel: hdd: WDC AC313000R, ATA DISK drive
Jan  8 08:56:22 uberboxen kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan  8 08:56:22 uberboxen kernel: hda: max request size: 128KiB
Jan  8 08:56:22 uberboxen kernel: hda: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=39714/16/63, UDMA(33)
Jan  8 08:56:22 uberboxen kernel:  hda: hda1 hda2 hda3 hda4
Jan  8 08:56:22 uberboxen kernel: hdb: max request size: 128KiB
Jan  8 08:56:22 uberboxen kernel: hdb: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=39714/16/63, UDMA(33)
Jan  8 08:56:22 uberboxen kernel:  hdb: hdb1 hdb2 hdb3
Jan  8 08:56:22 uberboxen kernel: hdd: max request size: 128KiB
Jan  8 08:56:22 uberboxen kernel: hdd: 25429824 sectors (13020 MB) w/512KiB Cache, CHS=25228/16/63, UDMA(33)
Jan  8 08:56:22 uberboxen kernel:  hdd: hdd1
Jan  8 08:56:22 uberboxen kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Jan  8 08:56:22 uberboxen kernel: Uniform CD-ROM driver Revision: 3.12
Jan  8 08:56:22 uberboxen kernel: mice: PS/2 mouse device common for all mice
Jan  8 08:56:22 uberboxen kernel: input: PC Speaker
Jan  8 08:56:22 uberboxen kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan  8 08:56:22 uberboxen kernel: input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
Jan  8 08:56:22 uberboxen kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan  8 08:56:22 uberboxen kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jan  8 08:56:22 uberboxen kernel: Creative EMU10K1 PCI Audio Driver, version 0.20a, 16:56:10 Jan  3 2004
Jan  8 08:56:22 uberboxen kernel: emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xe400-0xe41f, IRQ 19
Jan  8 08:56:22 uberboxen kernel: ac97_codec: AC97 Audio codec, id: CRY19 (Cirrus Logic CS4297A rev A)
Jan  8 08:56:22 uberboxen kernel: NET: Registered protocol family 2
Jan  8 08:56:22 uberboxen kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Jan  8 08:56:22 uberboxen kernel: TCP: Hash tables configured (established 32768 bind 32768)
Jan  8 08:56:22 uberboxen kernel: ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per conntrack
Jan  8 08:56:22 uberboxen kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jan  8 08:56:22 uberboxen kernel: NET: Registered protocol family 1
Jan  8 08:56:22 uberboxen kernel: NET: Registered protocol family 17
Jan  8 08:56:22 uberboxen kernel: XFS mounting filesystem hdb1
Jan  8 08:56:22 uberboxen kernel: Ending clean XFS mount for filesystem: hdb1
Jan  8 08:56:22 uberboxen kernel: VFS: Mounted root (xfs filesystem) readonly.
Jan  8 08:56:22 uberboxen kernel: Freeing unused kernel memory: 356k freed
Jan  8 08:56:22 uberboxen kernel: XFS mounting filesystem hdb2
Jan  8 08:56:22 uberboxen kernel: Ending clean XFS mount for filesystem: hdb2
Jan  8 08:56:22 uberboxen kernel: XFS mounting filesystem hda1
Jan  8 08:56:22 uberboxen kernel: Ending clean XFS mount for filesystem: hda1
Jan  8 08:56:22 uberboxen kernel: XFS mounting filesystem hdb3
Jan  8 08:56:22 uberboxen kernel: Ending clean XFS mount for filesystem: hdb3
Jan  8 08:56:22 uberboxen kernel: XFS mounting filesystem hdd1
Jan  8 08:56:22 uberboxen kernel: Ending clean XFS mount for filesystem: hdd1
Jan  8 08:56:22 uberboxen kernel: piix4-smbus 0000:00:07.3: Found 0000:00:07.3 device
Jan  8 08:56:22 uberboxen kernel: registering 0-004c
Jan  8 08:56:22 uberboxen kernel: registering 1-0290


#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y

#
# General setup
#
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_IPRANGE is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_HELPER is not set
# CONFIG_IP_NF_MATCH_STATE is not set
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
# CONFIG_IP_NF_FILTER is not set
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_FTP=y
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_TARGET_LOG is not set
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_PIIX4=m
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=y
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=y
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_AD1980 is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y





-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
