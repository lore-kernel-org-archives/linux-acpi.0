From: Michael Wahlbrink <linux.wali-Mmb7MZpHnFY@public.gmane.org>
Subject: ACPI and my IBM Thinkpad R32
Date: Fri, 14 Feb 2003 17:07:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030214170712.6e70c356.linux.wali@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi,
here comes an ACPI-Newbie with some (perhaps stupid) questions ;-)
I've got an IBM Thinkpad R32 (Type 2658-DCG) and tried to get linux working on it. Ok all is set up excl. powersave etc.. (the ACPI) stuff. I've tried a vanilla 2.4.19 kernel enabled acpi and got some informations about battery temperature etc in /proc/acpi/ . Then I've read an article about linux and ACPI in the german ct'.  ...And so I've found this project... Ok, I patched a 2.4.20 and a 2.4.21-pre3 kernel with the ACPI-patches from sf. Now I got no readable Information in /proc .. :-( Now I get the following messages about acpi when booting up (kernel 2.4.12-pre3 with patch):

Linux version 2.4.21-pre3-acpi (root@flat-eric) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Thu Feb 13 16:29:32 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ff70000 (usable)
 BIOS-e820: 000000000ff70000 - 000000000ff7a000 (ACPI data)
 BIOS-e820: 000000000ff7a000 - 000000000ff7c000 (ACPI NVS)
 BIOS-e820: 000000000ff7c000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
255MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65392
zone(0): 4096 pages.
zone(1): 61296 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 IBM                        ) @ 0x000f7120
ACPI: XSDT (v001 IBM    TP-1M    00000.08240) @ 0x0ff733f8
ACPI: FADT (v001 IBM    TP-1M    00000.08240) @ 0x0ff73444
ACPI: SSDT (v001 IBM    TP-1M    00000.08240) @ 0x0ff734f8
ACPI: ECDT (v001 IBM    TP-1M    00000.08240) @ 0x0ff79f55
ACPI: TCPA (v001 IBM    TP-1M    00000.08240) @ 0x0ff79fa6
ACPI: BOOT (v001 IBM    TP-1M    00000.08240) @ 0x0ff79fd8
ACPI: DSDT (v001 IBM    TP-1M    00000.08240) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: BOOT_IMAGE=Test ro root=308 video=radeonfb:1024x768
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1599.857 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3191.60 BogoMIPS
Memory: 255436k/261568k available (1738k kernel code, 5744k reserved, 723k data, 112k init, 0k highmem)
[...SNIP...]
ACPI: Subsystem revision 20030122
PCI: PCI BIOS revision 2.10 entry at 0xfd91e, last bus=5
PCI: Using configuration type 1
 tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.......................................................................................................................................................
..................................................................................................
Table [DSDT] - 934 Objects with 53 Devices 249 Methods 15 Regions
Parsing all Control Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c03a061c
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
ACPI: Found ECDT
ACPI: Could not use ECDT
evxfevnt-0118 [06] acpi_disable          : ACPI mode disabled
 utalloc-0967 [05] ut_dump_allocations   : No outstanding allocations.
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
[...SNIP...]
Hm, what's going wrong here, whats to do to get it fixed (2.5.xx or a newer patch or another config??). If you need more configuration details, please ask. I can also test some other configurations or versions (its at the moment a test mashine). So thank you for reading this mail ;-) and hopefully answering some newbiequestions....

regards
micha 

-- 
Michael Wahlbrink    | Woeschhalde 32
                     | 78052 Villingen Schwenningen
linux.wali-Mmb7MZpHnFY@public.gmane.org    | Germany


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
