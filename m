From: Thomas Estaben <tom-GJzCDJVA6d1BDgjK7y7TUQ@public.gmane.org>
Subject: Acpi Problem
Date: Mon, 2 Dec 2002 11:20:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212021120.13300.tom@supinfo.com>
Reply-To: tom-GJzCDJVA6d1BDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello All,

I tried your latest acpi sources, using 2.4.20+patch and 2.5.50. But it does 
not work.
This is the acpi messages i have in dmesg:

Linux version 2.4.20-rc4-ac1 (root@Slrko) (gcc version 3.2.1) #3 Sun Dec 1 
17:49:48 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff50000 (usable)
 BIOS-e820: 000000001ff50000 - 000000001ff6a000 (ACPI data)
 BIOS-e820: 000000001ff6a000 - 000000001ff7c000 (ACPI NVS)
 BIOS-e820: 000000001ff7c000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 130896
zone(0): 4096 pages.
zone(1): 126800 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 IBM                        ) @ 0x000f7010
ACPI: XSDT (v001 IBM    TP-1I    00000.08208) @ 0x1ff5f3a8
ACPI: FADT (v001 IBM    TP-1I    00000.08208) @ 0x1ff5f3f4
ACPI: SSDT (v001 IBM    TP-1I    00000.08208) @ 0x1ff5f4a8
ACPI: ECDT (v001 IBM    TP-1I    00000.08208) @ 0x1ff69f55
ACPI: TCPA (v001 IBM    TP-1I    00000.08208) @ 0x1ff69fa6
ACPI: BOOT (v001 IBM    TP-1I    00000.08208) @ 0x1ff69fd8
ACPI: DSDT (v001 IBM    TP-1I    00000.08208) @ 0x00000000
ACPI: BIOS passes blacklist
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: root=/dev/hda1
Initializing CPU#0
Detected 1798.510 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3591.37 BogoMIPS
Memory: 511856k/523584k available (1610k kernel code, 9164k reserved, 530k 
data, 108k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=64254 max_file_pages=0 max_inodes=0 max_dentries=64254
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021122
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
    ACPI-0511: *** Info: GPE Block0 defined as GPE0 to GPE15
    ACPI-0511: *** Info: GPE Block1 defined as GPE16 to GPE31
ACPI: Found ECDT
ACPI: Could not use ECDT

Acpi is quite unusable. Is this a hardware problem? or is my machine not yet 
supported?

Thanks in advance for your response.



					Thomas


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
