From: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>
Subject: Kernel Oops when loading battery module
Date: Sat, 7 Dec 2002 01:30:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021207003056.GC8072@homerelay.wiesner-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

Today I updated from kernel 2.4.20-pre5 with acpi-20020829-2.4.20-pre5
to kernel 2.4.20 with the new acpi-20021205-2.4.20 patch (no other
patches applied).

Unfortunately I have some problems with ACPI now. My system is a Dell
Inspiron 8200 with bios version A07. ACPI has been compiled as modules.

1. /proc/acpi/processor/CPU0/performance now reports wrong speeds:
| state count:             2
| active state:            P0
| states:
|   *P0:                  258 MHz, 0 mW, 0 uS
|    P1:                  0 MHz, 0 mW, 0 uS

This should be 1600 for P0 and 1200 for P1.

2. /proc/acpi/thermal_zone/THM/temperature reports a constant
   temperature of 25 °C. (The special module i8k still shows the correct
   value varying between about 50 and 65 C)

3. the worst problem: when loading the battery module, i get:

--- snip ---
Dec  6 22:54:05 matrix kernel:     ACPI-0189: *** Warning: Buffer created with zero length in AML
Dec  6 22:54:05 matrix kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010
Dec  6 22:54:05 matrix kernel:  printing eip:
Dec  6 22:54:05 matrix kernel: c0189f01
Dec  6 22:54:05 matrix kernel: *pde = 00000000
Dec  6 22:54:05 matrix kernel: Oops: 0002
Dec  6 22:54:05 matrix kernel: CPU:    0
Dec  6 22:54:05 matrix kernel: EIP:    0010:[<c0189f01>]    Not tainted
Dec  6 22:54:05 matrix kernel: EFLAGS: 00010246
Dec  6 22:54:05 matrix kernel: eax: 00000000   ebx: 00000000   ecx: c12df540   edx: cbd7cf00
Dec  6 22:54:05 matrix kernel: esi: cd654c00   edi: cff344c0   ebp: cbd7cf00   esp: cb643b8c
Dec  6 22:54:05 matrix kernel: ds: 0018   es: 0018   ss: 0018
Dec  6 22:54:05 matrix kernel: Process modprobe (pid: 335, stackpage=cb643000)
Dec  6 22:54:05 matrix kernel: Stack: cd654c00 00000001 00000000 00000000 00000000 00000000 00000000 00000001 
Dec  6 22:54:05 matrix kernel:        cbd7cf00 cca61f00 cd6545b4 00000000 c018a089 cbd7cf00 cbd7cf00 00000000 
Dec  6 22:54:05 matrix kernel:        00000000 c0193f32 cca61f00 cb643be8 00000003 00000000 cd6545b4 cd654400 
Dec  6 22:54:05 matrix kernel: Call Trace:    [<c018a089>] [<c0193f32>] [<c0193fca>] [<c018aa0c>] [<c018b099>]
Dec  6 22:54:05 matrix kernel:   [<c019ab74>] [<c01a2f94>] [<c01a3157>] [<c01a18a8>] [<c01a2ee5>] [<c01a06d5>]
Dec  6 22:54:05 matrix kernel:   [<c01a2f94>] [<c019b1f8>] [<c018c2c5>] [<c019bc5c>] [<d4b720d6>] [<c01975b8>]
Dec  6 22:54:05 matrix kernel:   [<c0197549>] [<c01973a1>] [<c01a18a8>] [<c01a1a48>] [<d4b720d6>] [<c01990f8>]
Dec  6 22:54:05 matrix kernel:   [<d4b720d6>] [<d4b710df>] [<d4b720d6>] [<d4b720c8>] [<d4b71495>] [<d4b72805>]
Dec  6 22:54:05 matrix kernel:   [<d4b729a0>] [<d4b71e93>] [<d4b72803>] [<d4b7280e>] [<d4b729a0>] [<c01a457b>]
Dec  6 22:54:05 matrix kernel:   [<d4b729a0>] [<c01a464d>] [<d4b729a0>] [<c01a4244>] [<d4b729a0>] [<d4b729a0>]
Dec  6 22:54:05 matrix kernel:   [<c01a4838>] [<c01a45f0>] [<d4b729a0>] [<d4b71fcc>] [<d4b729a0>] [<c011b5cb>]
Dec  6 22:54:05 matrix kernel:   [<d4b71060>] [<d4b71060>] [<c0107433>]
Dec  6 22:54:05 matrix kernel: 
Dec  6 22:54:05 matrix kernel: Code: 89 50 10 89 3c 24 e8 84 1a 01 00 c7 04 24 37 00 00 00 e8 c8 
--- snip ---

The system is still running, but lsmod shows that the battery module
hangs in the state "(initialising)".

Here are some more kernel messages from booting which might be
interesting:

--- snip ---
Dec  6 22:53:22 matrix kernel: klogd 1.4.1, log source = /proc/kmsg started.
Dec  6 22:53:22 matrix kernel: Cannot find map file.
Dec  6 22:53:22 matrix kernel: Loaded 728 symbols from 37 modules.
Dec  6 22:53:22 matrix kernel: Linux version 2.4.20 (root@matrix) (gcc version 3.1) #2 Fre Dez 6 22:43:52 CET 2002
Dec  6 22:53:22 matrix kernel: BIOS-provided physical RAM map:
Dec  6 22:53:22 matrix kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Dec  6 22:53:22 matrix kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Dec  6 22:53:22 matrix kernel:  BIOS-e820: 0000000000100000 - 000000000ffe2800 (usable)
Dec  6 22:53:22 matrix kernel:  BIOS-e820: 000000000ffe2800 - 0000000010000000 (reserved)
Dec  6 22:53:22 matrix kernel:  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
Dec  6 22:53:22 matrix kernel:  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
Dec  6 22:53:22 matrix kernel: 255MB LOWMEM available.
Dec  6 22:53:22 matrix kernel: ACPI: have wakeup address 0xc0001000
Dec  6 22:53:22 matrix kernel: On node 0 totalpages: 65506
Dec  6 22:53:22 matrix kernel: zone(0): 4096 pages.
Dec  6 22:53:22 matrix kernel: zone(1): 61410 pages.
Dec  6 22:53:22 matrix kernel: zone(2): 0 pages.
Dec  6 22:53:22 matrix kernel: ACPI: RSDP (v000 DELL                       ) @ 0x000fde50
Dec  6 22:53:22 matrix kernel: ACPI: RSDT (v001 DELL    CPi R   10194.02588) @ 0x000fde64
Dec  6 22:53:22 matrix kernel: ACPI: FADT (v001 DELL    CPi R   10194.02588) @ 0x000fde90
Dec  6 22:53:22 matrix kernel: ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000
Dec  6 22:53:22 matrix kernel: ACPI: BIOS passes blacklist
Dec  6 22:53:22 matrix kernel: ACPI: MADT not present
Dec  6 22:53:22 matrix kernel: Dell Inspiron with broken BIOS detected. Refusing to enable the local APIC.
Dec  6 22:53:22 matrix kernel: Kernel command line: BOOT_IMAGE=Linux ro root=302 hdb=ide-scsi video=vesa:mtrr
Dec  6 22:53:22 matrix kernel: ide_setup: hdb=ide-scsi
Dec  6 22:53:22 matrix kernel: Initializing CPU#0
Dec  6 22:53:22 matrix kernel: Detected 1595.319 MHz processor.
Dec  6 22:53:23 matrix kernel: Console: colour dummy device 80x25
Dec  6 22:53:23 matrix kernel: Calibrating delay loop... 3185.04 BogoMIPS
Dec  6 22:53:23 matrix kernel: Memory: 256676k/262024k available (1319k kernel code, 4960k reserved, 418k data, 112k init, 0k highmem)
Dec  6 22:53:23 matrix kernel: Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Dec  6 22:53:23 matrix kernel: Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Dec  6 22:53:23 matrix kernel: Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Dec  6 22:53:23 matrix kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Dec  6 22:53:23 matrix kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec  6 22:53:23 matrix kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
Dec  6 22:53:23 matrix kernel: CPU: L2 cache: 512K
Dec  6 22:53:23 matrix kernel: Intel machine check architecture supported.
Dec  6 22:53:23 matrix kernel: Intel machine check reporting enabled on CPU#0.
Dec  6 22:53:23 matrix kernel: CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
Dec  6 22:53:23 matrix kernel: CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
Dec  6 22:53:23 matrix kernel: CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
Dec  6 22:53:23 matrix kernel: Enabling fast FPU save and restore... done.
Dec  6 22:53:23 matrix kernel: Enabling unmasked SIMD FPU exception support... done.
Dec  6 22:53:23 matrix kernel: Checking 'hlt' instruction... OK.
Dec  6 22:53:23 matrix kernel: POSIX conformance testing by UNIFIX
Dec  6 22:53:23 matrix kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
Dec  6 22:53:23 matrix kernel: mtrr: detected mtrr type: Intel
Dec  6 22:53:23 matrix kernel: ACPI: Subsystem revision 20021205
Dec  6 22:53:23 matrix kernel: PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=2
Dec  6 22:53:23 matrix kernel: PCI: Using configuration type 1
Dec  6 22:53:23 matrix kernel: ......................................................................................................................................................................    ACPI-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
Dec  6 22:53:23 matrix kernel:     ACPI-0263: *** Info: GPE Block1 defined as GPE16 to GPE31
Dec  6 22:53:23 matrix kernel: ................................................................................................................................<6>ACPI: Interpreter enabled
Dec  6 22:53:23 matrix kernel: ACPI: Using PIC for interrupt routing
Dec  6 22:53:23 matrix kernel: ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
Dec  6 22:53:23 matrix kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Dec  6 22:53:23 matrix kernel: PCI: Probing PCI hardware (bus 00)
Dec  6 22:53:23 matrix kernel: Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
Dec  6 22:53:23 matrix kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Dec  6 22:53:23 matrix kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
Dec  6 22:53:23 matrix kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7, enabled at IRQ 11)
Dec  6 22:53:23 matrix kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
Dec  6 22:53:24 matrix kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
Dec  6 22:53:24 matrix kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Dec  6 22:53:24 matrix kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
Dec  6 22:53:24 matrix kernel: ACPI: Power Resource [PADA] (on)
Dec  6 22:53:24 matrix kernel: PCI: Probing PCI hardware
Dec  6 22:53:24 matrix kernel: PCI: Using ACPI for IRQ routing
Dec  6 22:53:24 matrix kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
--- snip ---

_All_ of the above still worked fine with the old kernel plus patch, so
some change in between must have introduced an incompatibility.

Please tell me if i can supply more information to find the error.
It would be great if ACPI would work again with the new kernel. :-)

Thanks

Markus Wiesner


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
