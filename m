From: jeff <ritz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
Subject: RE: Kernel Oops when loading battery module
Date: Fri, 06 Dec 2002 20:25:51 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DF15C2F.3070406@canada.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

hi,

i have a dell inspiron 8100 and i am having the *exact* same problems as Markus Wiesner. regarding processor and temperature, everything he pointed out is the same for me. my kernel panic on the battery module is a little different in content but looks to be the very same thing. it all worked great for me with kernel 2.4.19 (and acpi 2.4.19 diff). my battery used to show up as BAT1 in /proc (odd maybe, because i only have one battery.. worked fine tho).


--------
Dec  6 15:34:35 localhost kernel: ACPI: AC Adapter [AC] (on-line)
Dec  6 15:34:58 localhost kernel: ACPI: Battery Slot [BAT0] (battery absent)
Dec  6 15:34:58 localhost kernel:     ACPI-0189: *** Warning: Buffer created with zero length in AML
Dec  6 15:34:58 localhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010
Dec  6 15:34:58 localhost kernel:  printing eip:
Dec  6 15:34:58 localhost kernel: c016bbfa
Dec  6 15:34:58 localhost kernel: *pde = 00000000
Dec  6 15:34:58 localhost kernel: Oops: 0002
Dec  6 15:34:58 localhost kernel: CPU:    0
Dec  6 15:34:58 localhost kernel: EIP:    0010:[acpi_ds_execute_arguments+138/280]    Not tainted
Dec  6 15:34:58 localhost kernel: EFLAGS: 00010246
Dec  6 15:34:58 localhost kernel: eax: 00000000   ebx: 00000000   ecx: c15b84e0   edx: c02ccc18
Dec  6 15:34:58 localhost kernel: esi: df9df800   edi: c15b7fe0   ebp: df8edac0   esp: de99bc24
Dec  6 15:34:58 localhost kernel: ds: 0018   es: 0018   ss: 0018
Dec  6 15:34:58 localhost kernel: Process modprobe (pid: 685, stackpage=de99b000)
Dec  6 15:34:58 localhost kernel: Stack: c15dcfa0 df8edac0 00000000 c15a7db4 c016bce7 df8edac0 df8edac0 00000000 
Dec  6 15:34:58 localhost kernel:        00000000 c0174084 c15dcfa0 c15a7db4 c15a7c00 c15a7c00 00000010 00000000 
Dec  6 15:34:58 localhost kernel:        c0174121 c15a7db4 c15a7c00 c15a7db4 00000000 c016c4c6 c15a7db4 c15a7c00 
Dec  6 15:34:58 localhost kernel: Call Trace:    [acpi_ds_get_buffer_arguments+35/52] [acpi_ex_resolve_node_to_value+148/240] [acpi_ex_resolve_to_value+65/80] [acpi_ds_resolve_operands+38/56] [acp
i_ds_exec_end_op+256/608]
Dec  6 15:34:58 localhost kernel:   [acpi_ps_parse_loop+1517/2392] [acpi_ut_update_object_reference+532/596] [acpi_ut_release_mutex+127/136] [acpi_ut_release_to_cache+137/148] [acpi_ds_delete_walk
_state+153/160] [acpi_ps_parse_aml+90/432]
Dec  6 15:34:58 localhost kernel:   [acpi_psx_execute+358/448] [acpi_ns_execute_control_method+83/112] [acpi_ns_evaluate_by_handle+134/176] [acpi_ns_evaluate_relative+181/208] [acpi_ut_update_obje
ct_reference+532/596] [acpi_ut_remove_reference+35/44]
Dec  6 15:34:58 localhost kernel:   [acpi_evaluate_object+276/480] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-238218/96] [ip_conntrack_ftp:__insmod_ip_conntrack
_ftp_O/lib/modules/2.4.20/kernel/net/i+-241453/96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-238218/96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modul
es/2.4.20/kernel/net/i+-238232/96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-240708/96]
Dec  6 15:34:58 localhost kernel:   [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-238574/96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kerne
l/net/i+-236344/96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-236341/96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-236344/
96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-236352/96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-236000/96]
Dec  6 15:34:58 localhost kernel:   [acpi_bus_driver_init+46/156] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-236000/96] [acpi_bus_attach+0/124] [acpi_bus_attach
+77/124] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-236000/96] [acpi_bus_walk+159/200]
Dec  6 15:34:58 localhost kernel:   [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-236000/96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kerne
l/net/i+-236000/96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-241560/96] [acpi_bus_register_driver+79/100] [acpi_bus_attach+0/124] [ip_conntrack_ftp:__insmod_i
p_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-236000/96]
Dec  6 15:34:58 localhost kernel:   [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-238326/96] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kerne
l/net/i+-236000/96] [sys_init_module+1285/1448] [ip_conntrack_ftp:__insmod_ip_conntrack_ftp_O/lib/modules/2.4.20/kernel/net/i+-241568/96] [system_call+51/56]
Dec  6 15:34:58 localhost kernel: 
Dec  6 15:34:58 localhost kernel: Code: 89 68 10 57 e8 1d e7 00 00 6a 37 e8 b2 e4 00 00 89 c7 83 c4 
--------


my kernel (2.4.20) boot with all acpi *except battery*:


--------
Dec  6 15:46:12 localhost kernel: Inspecting /boot/System.map-2.4.20
Dec  6 15:46:12 localhost kernel: Loaded 17457 symbols from /boot/System.map-2.4.20.
Dec  6 15:46:12 localhost kernel: Symbols match kernel version 2.4.20.
Dec  6 15:46:12 localhost kernel: Loaded 112 symbols from 17 modules.
Dec  6 15:46:12 localhost kernel: Linux version 2.4.20 (root@crazy) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Fri Dec 6 15:44:26 CST 2002
Dec  6 15:46:12 localhost kernel: BIOS-provided physical RAM map:
Dec  6 15:46:12 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Dec  6 15:46:12 localhost kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Dec  6 15:46:12 localhost kernel:  BIOS-e820: 0000000000100000 - 000000001ffea800 (usable)
Dec  6 15:46:12 localhost kernel:  BIOS-e820: 000000001ffea800 - 0000000020000000 (reserved)
Dec  6 15:46:12 localhost kernel:  BIOS-e820: 00000000feea0000 - 00000000fef00000 (reserved)
Dec  6 15:46:12 localhost kernel:  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
Dec  6 15:46:12 localhost kernel: 511MB LOWMEM available.
Dec  6 15:46:12 localhost kernel: ACPI: have wakeup address 0xc0001000
Dec  6 15:46:12 localhost kernel: On node 0 totalpages: 131050
Dec  6 15:46:12 localhost kernel: zone(0): 4096 pages.
Dec  6 15:46:12 localhost kernel: zone(1): 126954 pages.
Dec  6 15:46:12 localhost kernel: zone(2): 0 pages.
Dec  6 15:46:12 localhost kernel: ACPI: RSDP (v000 DELL                       ) @ 0x000fde50
Dec  6 15:46:12 localhost kernel: ACPI: RSDT (v001 DELL    CPi R   10194.02588) @ 0x000fde64
Dec  6 15:46:12 localhost kernel: ACPI: FADT (v001 DELL    CPi R   10194.02588) @ 0x000fde90
Dec  6 15:46:12 localhost kernel: ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000
Dec  6 15:46:12 localhost kernel: ACPI: BIOS passes blacklist
Dec  6 15:46:12 localhost kernel: Kernel command line: BOOT_IMAGE=Debian ro root=301
Dec  6 15:46:12 localhost kernel: Initializing CPU#0
Dec  6 15:46:12 localhost kernel: Detected 996.688 MHz processor.
Dec  6 15:46:12 localhost kernel: Console: colour VGA+ 80x25
Dec  6 15:46:12 localhost kernel: Calibrating delay loop... 1985.74 BogoMIPS
Dec  6 15:46:12 localhost kernel: Memory: 516132k/524200k available (1211k kernel code, 7680k reserved, 489k data, 92k init, 0k highmem)
Dec  6 15:46:12 localhost kernel: Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Dec  6 15:46:12 localhost kernel: Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Dec  6 15:46:12 localhost kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Dec  6 15:46:12 localhost kernel: Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Dec  6 15:46:12 localhost kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec  6 15:46:12 localhost kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec  6 15:46:12 localhost kernel: Intel machine check architecture supported.
Dec  6 15:46:12 localhost kernel: Intel machine check reporting enabled on CPU#0.
Dec  6 15:46:12 localhost kernel: CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
Dec  6 15:46:12 localhost kernel: CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
Dec  6 15:46:12 localhost kernel: CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Dec  6 15:46:12 localhost kernel: Enabling fast FPU save and restore... done.
Dec  6 15:46:12 localhost kernel: Enabling unmasked SIMD FPU exception support... done.
Dec  6 15:46:12 localhost kernel: Checking 'hlt' instruction... OK.
Dec  6 15:46:12 localhost kernel: POSIX conformance testing by UNIFIX
Dec  6 15:46:12 localhost kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
Dec  6 15:46:12 localhost kernel: mtrr: detected mtrr type: Intel
Dec  6 15:46:12 localhost kernel: ACPI: Subsystem revision 20021205
Dec  6 15:46:12 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xfc06e, last bus=8
Dec  6 15:46:12 localhost kernel: PCI: Using configuration type 1
Dec  6 15:46:12 localhost kernel: .............................................................................................................................................................    A
CPI-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
Dec  6 15:46:12 localhost kernel:     ACPI-0263: *** Info: GPE Block1 defined as GPE16 to GPE31
Dec  6 15:46:12 localhost kernel: ......................................................................................................<6>ACPI: Interpreter enabled
Dec  6 15:46:12 localhost kernel: ACPI: Using PIC for interrupt routing
Dec  6 15:46:12 localhost kernel: ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
Dec  6 15:46:12 localhost kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Dec  6 15:46:12 localhost kernel: PCI: Probing PCI hardware (bus 00)
Dec  6 15:46:12 localhost kernel: Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
Dec  6 15:46:12 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Dec  6 15:46:12 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
Dec  6 15:46:12 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *5 7)
Dec  6 15:46:12 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 11, disabled)
Dec  6 15:46:12 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 *10 11)
Dec  6 15:46:12 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Dec  6 15:46:12 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
Dec  6 15:46:12 localhost kernel: ACPI: Power Resource [PADA] (on)
Dec  6 15:46:12 localhost kernel: PCI: Probing PCI hardware
Dec  6 15:46:12 localhost kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
Dec  6 15:46:12 localhost kernel: PCI: Using ACPI for IRQ routing
Dec  6 15:46:12 localhost kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Dec  6 15:46:12 localhost kernel: Linux NET4.0 for Linux 2.4
Dec  6 15:46:12 localhost kernel: Based upon Swansea University Computer Society NET3.039
Dec  6 15:46:12 localhost kernel: Initializing RT netlink socket
Dec  6 15:46:12 localhost kernel: Starting kswapd
Dec  6 15:46:12 localhost kernel: Journalled Block Device driver loaded
Dec  6 15:46:12 localhost kernel: ACPI: AC Adapter [AC] (on-line)
Dec  6 15:46:12 localhost kernel: ACPI: Lid Switch [LID]
Dec  6 15:46:12 localhost kernel: ACPI: Power Button (CM) [PBTN]
Dec  6 15:46:12 localhost kernel: ACPI: Sleep Button (CM) [SBTN]
Dec  6 15:46:12 localhost kernel: ACPI: Processor [CPU0] (supports C1 C2, 2 performance states)
Dec  6 15:46:12 localhost kernel: ACPI: Thermal Zone [THM] (25 C)
Dec  6 15:46:12 localhost kernel: pty: 256 Unix98 ptys configured
Dec  6 15:46:12 localhost kernel: Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org)
Dec  6 15:46:12 localhost kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Dec  6 15:46:12 localhost kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec  6 15:46:12 localhost kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Dec  6 15:46:12 localhost kernel: Real Time Clock Driver v1.10e
Dec  6 15:46:12 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Dec  6 15:46:12 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec  6 15:46:12 localhost kernel: ICH2M: IDE controller on PCI bus 00 dev f9
Dec  6 15:46:12 localhost kernel: ICH2M: chipset revision 3
Dec  6 15:46:12 localhost kernel: ICH2M: not 100%% native mode: will probe irqs later
Dec  6 15:46:12 localhost kernel:     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
Dec  6 15:46:12 localhost kernel:     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
Dec  6 15:46:12 localhost kernel: hda: HITACHI_DK23CA-30, ATA DISK drive
Dec  6 15:46:12 localhost kernel: hdb: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
Dec  6 15:46:12 localhost kernel: hdc: MATSHITA CD-RW UJDA330, ATAPI CD/DVD-ROM drive
Dec  6 15:46:12 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec  6 15:46:12 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec  6 15:46:12 localhost kernel: blk: queue c02e8b24, I/O limit 4095Mb (mask 0xffffffff)
Dec  6 15:46:12 localhost kernel: hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63, UDMA(100)
--------


i apologize for all this output.. i'm not sure what would be helpful.
thanks for any help!


jeff h



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
