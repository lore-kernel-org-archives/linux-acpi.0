From: PSI-Systems <PSI-Systems-hi6Y0CQ0nG0@public.gmane.org>
Subject: ACPI does not work since acpi-20021022-2.4.20-pre11.diff
Date: Mon, 4 Nov 2002 00:00:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211040000.58206.PSI-Systems@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

and its still in the newest rc1-release!

please can anyone help me in fixing this?

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff7a000 (ACPI data)
 BIOS-e820: 000000001ff7a000 - 000000001ff7c000 (ACPI NVS)
 BIOS-e820: 000000001ff7c000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 130912
zone(0): 4096 pages.
zone(1): 126816 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 IBM                        ) @ 0x000f7060
ACPI: XSDT (v001 IBM    TP-1G    00000.04160) @ 0x1ff6ee48
ACPI: FADT (v001 IBM    TP-1G    00000.04160) @ 0x1ff6ee8c
ACPI: SSDT (v001 IBM    TP-1G    00000.04160) @ 0x1ff6ef40
ACPI: ECDT (v001 IBM    TP-1G    00000.04160) @ 0x1ff79f87
ACPI: BOOT (v001 IBM    TP-1G    00000.04160) @ 0x1ff79fd8
ACPI: DSDT (v001 IBM    TP-1G    00000.04160) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: BOOT_IMAGE=Linux ro root=307 resume=/dev/hda8 
root=/dev/hda7 devfs=onl
y video=radeonfb:1400x1050-32@60 hdc=ide-scsi
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1199.016 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2392.06 BogoMIPS
Memory: 514784k/523648k available (1779k kernel code, 8476k reserved, 558k 
data, 156k init,
 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
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
ACPI: Subsystem revision 20021101
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
    ACPI-0508: *** Info: GPE Block0 defined as GPE0 to GPE15
    ACPI-0508: *** Info: GPE Block1 defined as GPE16 to GPE31
ACPI: Found ECDT
ACPI: Could not use ECDT

thx
Sandro




-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
