From: Dieter Rohlfing <u490248-uKKRHEr75Vc@public.gmane.org>
Subject: Laptop does not reboot
Date: Thu, 26 Feb 2004 21:41:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <403E59FF.990E2CD0@imail.de>
Reply-To: u490248-uKKRHEr75Vc@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
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

Hello everybody,

I already posted my problem to debian-laptop (without success), but
somebody suggested to post it on this mailing list. So, here I am.

My laptop: Dell Inspiron 7500, BIOS revision A11, power management
disabled.

Linux: plain kernel 2.4.25 without any patches, Debian Woody 3.0R1

I installed Debian Woody 3.0R1 one week ago and - as far as I can see -
the system works. Before I had Debian Potato 2.2R4 (plain kernel 2.2.20
without any patches, both acpi and apm off).

My problem: the laptop does not reboot. When I request 'shutdown -r',
the system terminates all applications in my current run-level, properly
runs through run-level 6 and as last message it says 'rebooting ...'.
Then the LED of the built-in CDROM blinks, and the backlight of the LCD
goes off.

Up to this point everything is normal and the same with kernel 2.2.20.
Under 2.2.20 - when the laptop is rebooting - the backlight goes on
after 2 or 3 seconds, the BIOS info screen appears and then my lilo boot
menu comes up.

Under 2.4.25 nothing happens: the backlight stays off, the power LED is
on and the harddisk is still running. The laptop doesn't react on any
key, not even the famous ctrl-alt-del. Unfortunately, the laptop doesn't
have a reset button. :-(((

The only thing I can do: permently push down the power button for about
15 seconds, then the laptop goes off. After a short period I can push
the power button again, and then the laptop begins to boot.

Here is, what dmesg shows about the booting process:

kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
kernel: Loaded 23027 symbols from /boot/sysmap.linux-2.4.25-orig.test.
kernel: Symbols match kernel version 2.4.25.
kernel: No module symbols loaded.
kernel: Linux version 2.4.25 (root-xTE1z6Ssw50@public.gmane.org) (gcc version 2.95.4 20011002
        (Debian prerelease)) #3 Mon Feb 23 22:32:44 CET 2004
kernel: BIOS-provided physical RAM map:
kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
kernel:  BIOS-e820: 00000000000ea000 - 0000000000100000 (reserved)
kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
kernel:  BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
kernel:  BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
kernel: 0MB HIGHMEM available.
kernel: 255MB LOWMEM available.
kernel: ACPI: have wakeup address 0xc0001000
kernel: On node 0 totalpages: 65520
kernel: zone(0): 4096 pages.
kernel: zone(1): 61424 pages.
kernel: zone(2): 0 pages.
kernel: ACPI disabled because your bios is from 2000 and too old
kernel: You can enable it with acpi=force
kernel: Dell Inspiron 7500 machine detected. Disabling APM idle calls.
kernel: Dell Inspiron with broken BIOS detected.
        Refusing to enable the local APIC.
kernel: Kernel command line: BOOT_IMAGE=5 ro root=30f ramdisk_size=8192
        reboot=h,c acpi=off pci=noacpi apm=off video=atyfb:font:SUN12x22
kernel: Initializing CPU#0
kernel: Detected 601.373 MHz processor.
kernel: Console: colour dummy device 80x25
kernel: Calibrating delay loop... 1199.30 BogoMIPS
kernel: Memory: 255340k/262080k available (1972k kernel code,
        6352k reserved, 841k data, 168k init, 0k highmem)
kernel: Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
kernel: Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
kernel: Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
kernel: CPU: L2 cache: 256K
kernel: CPU:     After generic, caps: 0383f9ff 00000000 00000000
00000000
kernel: CPU:             Common caps: 0383f9ff 00000000 00000000
00000000
kernel: CPU: Intel Pentium III (Coppermine) stepping 03
kernel: Enabling fast FPU save and restore... done.
kernel: Enabling unmasked SIMD FPU exception support... done.
kernel: Checking 'hlt' instruction... OK.
kernel: POSIX conformance testing by UNIFIX
kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
kernel: mtrr: detected mtrr type: Intel
kernel: ACPI: Subsystem revision 20040116
kernel: ACPI: Interpreter disabled.
kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=1
kernel: PCI: Using configuration type 1
kernel: PCI: Probing PCI hardware
kernel: PCI: Probing PCI hardware (bus 00)
kernel: PCI: Using IRQ router PIIX/ICH [8086/7110] at 00:07.0
kernel: PCI: Found IRQ 11 for device 00:04.0
kernel: PCI: Sharing IRQ 11 with 00:04.1
kernel: PCI: Sharing IRQ 11 with 01:00.0
kernel: PCI: Cannot allocate resource region 4 of device 00:07.1
kernel: Limiting direct PCI/PCI transfers.
kernel: Linux NET4.0 for Linux 2.4
kernel: Based upon Swansea University Computer Society NET3.039
kernel: Initializing RT netlink socket
kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
kernel: Starting kswapd

Last, but not least, the relevant kernel configs:

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_M486=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_HOTPLUG_PCI=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PNP=y

I've deleted the remaining lines, because I think it's not relevant. As
you can see, I played with some kernel options. Among those were:
acpi=on/off/force/ht, apm=on/off, reboot=[cbhw],
pci=bios/nobios/conf1/conf2/nosort/biosirq/noacpi. But whatever
combination I tried, I never had success with rebooting the laptop. The
only way to get a working reboot is with a kernel 2.2.x. Other 2.4.x
kernels (x=18,20,22,24,25) always failed to reboot the machine.

I hope, you can help me. If you need any further information, please ask
me. TIA.

Dieter Rohlfing

-- 
Every mail not from this mailing list will be deleted.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
