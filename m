From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: two (little) problems wit 2.6.15-git7 one with build, one with
 acpi
Date: Thu, 12 Jan 2006 23:15:28 -0800
Message-ID: <20060112231528.025c3a0b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Hemmann, Volker Armin" <volker.armin.hemmann-PElL+NAm/YuR48VH7yJHcw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Volker, I think the `make install' thing is fixed, or will soon be.

If the resume problem doesn't get fixed within the next few days, pleas=
e
raise a report at bugzilla.kernel.org.

This is a regression wrt 2.6.15, so we're keen to fix it.

Thanks.


Begin forwarded message:

Date: Thu, 12 Jan 2006 21:04:35 +0100
=46rom: "Hemmann, Volker Armin" <volker.armin.hemmann-PElL+NAm/YuR48VH7yJHcw@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: two (little) problems wit 2.6.15-git7 one with build, one with=
 acpi


Hi,

I used the git-kernel ebuild to get the -git7 sources and build a kerne=
l.

the first problem occured while installing:
make oldconfig (with a config from 2.6.15-rc7) worked fine, but when I =
did=20
'make all modules_install install' like always, I got an error,=20
that /lib/modules/2.6.15-git7 does not exists.
make install or make modules_install alone worked fine, so I did not ca=
re much=20
and rebooted.

After reboot I tried this:
echo mem > /sys/power/state

the box went off, no fans turning, keyboard dead, monitor in standby=20
(usb-mouse lights were still on), and on hitting the power button, the=20
harddrive spun up.=20
But than it hanged.=20
Well, it had never come back from this, keyboard dead no lights there, =
monitor=20
in standby and so on, but this time was much worse.

Usually everything starts to work again, when I hit the reset button, b=
ut with=20
git7 nothing happend. Keyboard still dead, monitor still in deep standb=
y,=20
only the harddisk light flashed for a moment. I tried the reset button=20
several times with the same result everytime: except the drives flashin=
g=20
their lights, nothing happened.

Ok, I thought and pushed the power button for some seconds. The box tur=
ned=20
off, I turned it on with the power button and nothing happened. The har=
ddisk=20
flashed for a moment, but monitor was still 'dead' and no reaction to a=
ny=20
heyboard key.=20
I had to pull the plug and only after that my computer booted again.

hardware:
Amd64 'Venice' 3200+ (power scaling works fine with it)
Asrock 939DualSataII
Audigy2 Value
Terratec Tv+
Asus Geforce 6600 passiv cooled (the nvidia driver was not loaded, nor =
X=20
running) in PCIE slot
Leadtec Geforce 5200 in the AGP slot.
usb mouse
ps/2 keyboard
Enermax PSU.
Monitor is connected to the PCIE card.

here is my some config output:
grep ^C .config
CONFIG_X86_64=3Dy
CONFIG_64BIT=3Dy
CONFIG_X86=3Dy
CONFIG_SEMAPHORE_SLEEPERS=3Dy
CONFIG_MMU=3Dy
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_EXPERIMENTAL=3Dy
CONFIG_CLEAN_COMPILE=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_UID16=3Dy
CONFIG_VM86=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_DOUBLEFAULT=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_CC_ALIGN_FUNCTIONS=3D0
CONFIG_CC_ALIGN_LABELS=3D0
CONFIG_CC_ALIGN_LOOPS=3D0
CONFIG_CC_ALIGN_JUMPS=3D0
CONFIG_SLAB=3Dy
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_KMOD=3Dy
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_DEFAULT_CFQ=3Dy
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_MK8=3Dy
CONFIG_X86_L1_CACHE_BYTES=3D64
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_X86_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_MTRR=3Dy
CONFIG_PREEMPT_VOLUNTARY=3Dy
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=3Dy
CONFIG_HPET_TIMER=3Dy
CONFIG_X86_PM_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_DUMMY_IOMMU=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_AMD=3Dy
CONFIG_PHYSICAL_START=3D0x100000
CONFIG_SECCOMP=3Dy
CONFIG_HZ_250=3Dy
CONFIG_HZ=3D250
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_ISA_DMA_API=3Dy
CONFIG_PM=3Dy
CONFIG_PM_LEGACY=3Dy
CONFIG_SOFTWARE_SUSPEND=3Dy
CONFIG_PM_STD_PARTITION=3D""
CONFIG_ACPI=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_SLEEP_PROC_SLEEP=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_VIDEO=3Dy
CONFIG_ACPI_HOTKEY=3Dm
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ACPI_TOSHIBA=3Dy
CONFIG_ACPI_BLACKLIST_YEAR=3D2001
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_ACPI_CONTAINER=3Dm
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
CONFIG_X86_POWERNOW_K8=3Dy
CONFIG_X86_POWERNOW_K8_ACPI=3Dy
CONFIG_X86_ACPI_CPUFREQ=3Dy
CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_UNORDERED_IO=3Dy
CONFIG_PCIEPORTBUS=3Dy
CONFIG_PCI_MSI=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm
CONFIG_IA32_EMULATION=3Dy
CONFIG_IA32_AOUT=3Dy
CONFIG_COMPAT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_FIB_HASH=3Dy
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
CONFIG_TCP_CONG_BIC=3Dy
CONFIG_BT=3Dm
CONFIG_BT_L2CAP=3Dm
CONFIG_BT_SCO=3Dm
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_HIDP=3Dm
CONFIG_BT_HCIUSB=3Dm
CONFIG_BT_HCIUSB_SCO=3Dy
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIBCM203X=3Dm
CONFIG_BT_HCIBPA10X=3Dm
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIVHCI=3Dm
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_COUNT=3D4
CONFIG_BLK_DEV_RAM_SIZE=3D4096
CONFIG_CDROM_PKTCDVD=3Dm
CONFIG_CDROM_PKTCDVD_BUFFERS=3D16
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
CONFIG_IDE_GENERIC=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_ALI15X3=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_SCSI=3Dy
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_CHR_DEV_SG=3Dm
CONFIG_SCSI_SPI_ATTRS=3Dy
CONFIG_SCSI_FC_ATTRS=3Dy
CONFIG_SCSI_AIC7XXX=3Dm
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D32
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_TUN=3Dm
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
CONFIG_NET_TULIP=3Dy
CONFIG_ULI526X=3Dm
CONFIG_INPUT=3Dy
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D960
CONFIG_INPUT_EVDEV=3Dy
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_LIBPS2=3Dy
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
CONFIG_HW_RANDOM=3Dm
CONFIG_NVRAM=3Dm
CONFIG_RTC=3Dy
CONFIG_AGP=3Dm
CONFIG_AGP_AMD64=3Dm
CONFIG_HPET=3Dy
CONFIG_HPET_MMAP=3Dy
CONFIG_HANGCHECK_TIMER=3Dm
CONFIG_I2C=3Dm
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ALGOPCA=3Dm
CONFIG_I2C_ALI1535=3Dm
CONFIG_I2C_ALI1563=3Dm
CONFIG_I2C_ALI15X3=3Dm
CONFIG_I2C_ISA=3Dm
CONFIG_SENSORS_EEPROM=3Dm
CONFIG_HWMON=3Dy
CONFIG_HWMON_VID=3Dm
CONFIG_SENSORS_W83781D=3Dm
CONFIG_SENSORS_W83792D=3Dm
CONFIG_SENSORS_W83L785TS=3Dm
CONFIG_SENSORS_W83627HF=3Dm
CONFIG_SENSORS_W83627EHF=3Dm
CONFIG_VIDEO_DEV=3Dm
CONFIG_VIDEO_BT848=3Dm
CONFIG_VIDEO_TUNER=3Dm
CONFIG_VIDEO_BUF=3Dm
CONFIG_VIDEO_BTCX=3Dm
CONFIG_VIDEO_IR=3Dm
CONFIG_VIDEO_TVEEPROM=3Dm
CONFIG_FB=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
CONFIG_FB_VESA=3Dy
CONFIG_VIDEO_SELECT=3Dy
CONFIG_VGA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_SOUND=3Dy
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=3Dy
CONFIG_SND_SUPPORT_OLD_API=3Dy
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_AC97_BUS=3Dm
CONFIG_SND_MPU401=3Dm
CONFIG_SND_EMU10K1=3Dm
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB=3Dy
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_OHCI_HCD=3Dm
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_STORAGE=3Dm
CONFIG_USB_HID=3Dy
CONFIG_USB_HIDINPUT=3Dy
CONFIG_USB_MON=3Dy
CONFIG_EXT2_FS=3Dy
CONFIG_REISERFS_FS=3Dy
CONFIG_INOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dm
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_RAMFS=3Dy
CONFIG_RELAYFS_FS=3Dm
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
CONFIG_NLS_ASCII=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_15=3Dy
CONFIG_NLS_UTF8=3Dy
CONFIG_PRINTK_TIME=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_LOG_BUF_SHIFT=3D18
CONFIG_DETECT_SOFTLOCKUP=3Dy
CONFIG_DEBUG_MUTEXES=3Dy
CONFIG_INIT_DEBUG=3Dy
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC16=3Dm
CONFIG_CRC32=3Dy
CONFIG_LIBCRC32C=3Dm
CONFIG_ZLIB_INFLATE=3Dm

and here my dmesg immediately after boot:

[    0.000000] Bootdata ok (command line is root=3D/dev/hda3 gentoo=3Dn=
odevfs=20
noexec=3Don nmi_watchdog=3D1)
[    0.000000] Linux version 2.6.15-git7 (root@energy) (gcc-Version 3.4=
=2E5=20
(Gentoo 3.4.5, ssp-3.4.5-1.0, pie-8.7.9)) #1 Thu Jan 12 20:30:31 CET 20=
06
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserve=
d)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
[    0.000000]  BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI da=
ta)
[    0.000000]  BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NV=
S)
[    0.000000]  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserve=
d)
[    0.000000] ACPI: RSDP (v000 ACPIAM                                )=
 @=20
0x00000000000f9b60
[    0.000000] ACPI: RSDT (v001 A M I  OEMRSDT  0x08000526 MSFT 0x00000=
097) @=20
0x000000003ffb0000
[    0.000000] ACPI: FADT (v002 A M I  OEMFACP  0x08000526 MSFT 0x00000=
097) @=20
0x000000003ffb0200
[    0.000000] ACPI: MADT (v001 A M I  OEMAPIC  0x08000526 MSFT 0x00000=
097) @=20
0x000000003ffb0390
[    0.000000] ACPI: OEMB (v001 A M I  AMI_OEM  0x08000526 MSFT 0x00000=
097) @=20
0x000000003ffc0040
[    0.000000] ACPI: DSDT (v001  939M2 939M2120 0x00000120 INTL 0x02002=
026) @=20
0x0000000000000000
[    0.000000] On node 0 totalpages: 257487
[    0.000000]   DMA zone: 3045 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 254442 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages, LIFO batch:0
[    0.000000]   HighMem zone: 0 pages, LIFO batch:0
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:15 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GS=
I 0-23
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec10000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 2, version 17, address 0xfec10000, GS=
I 24-39
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low leve=
l)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap:=20
40000000:bf7c0000)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: root=3D/dev/hda3 gentoo=3Dnodevfs n=
oexec=3Don=20
nmi_watchdog=3D1
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 3.579545 MHz PM timer.
[    0.000000] time.c: Detected 2000.112 MHz processor.
[   19.797661] time.c: Using PIT/TSC based timekeeping.
[   19.799744] Console: colour VGA+ 80x25
[   19.801832] Dentry cache hash table entries: 131072 (order: 8, 10485=
76=20
bytes)
[   19.803033] Inode-cache hash table entries: 65536 (order: 7, 524288 =
bytes)
[   19.812833] Memory: 1027960k/1048256k available (1967k kernel code, =
19616k=20
reserved, 927k data, 152k init)
[   19.891486] Calibrating delay using timer specific routine.. 4004.75=
=20
BogoMIPS (lpj=3D8009516)
[   19.891607] Mount-cache hash table entries: 256
[   19.891734] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64=20
bytes/line)
[   19.891783] CPU: L2 Cache: 512K (64 bytes/line)
[   19.891833] mtrr: v2.0 (20020519)
[   19.891878] CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 02
[   19.939935] activating NMI Watchdog ... done.
[   19.940014] Using local APIC timer interrupts.
[   19.989963] Detected 12.500 MHz APIC timer.
[   19.990014] testing NMI watchdog ... OK.
[   20.030297] NET: Registered protocol family 16
[   20.030359] ACPI: bus type pci registered
[   20.030408] PCI: Using configuration type 1
[   20.030726] ACPI: Subsystem revision 20050902
[   20.036257] ACPI: Interpreter enabled
[   20.036303] ACPI: Using IOAPIC for interrupt routing
[   20.036939] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   20.036986] PCI: Probing PCI hardware (bus 00)
[   20.039070] PCI quirk: region 0800-083f claimed by ali7101 ACPI
[   20.039434] Boot video device is 0000:01:00.0
[   20.039729] PCI: Transparent bridge - 0000:00:06.0
[   20.039803] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   20.051969] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[   20.052200] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HTT_._PRT]
[   20.056149] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB1._PRT]
[   20.056331] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB2._PRT]
[   20.056941] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 *7 10 11 1=
2 14=20
15)
[   20.057600] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 1=
2 14=20
15)
[   20.058256] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 1=
2 14=20
15), disabled.
[   20.058952] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 1=
2 14=20
15), disabled.
[   20.059661] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 1=
2 14=20
15)
[   20.060317] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 1=
2 14=20
15)
[   20.060976] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 1=
2 14=20
15)
[   20.061636] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12=
 14 15)=20
*9
[   20.062333] ACPI: PCI Interrupt Link [LNKP] (IRQs *3 4 5 6 7 10 11 1=
2 14=20
15)
[   20.062901] SCSI subsystem initialized
[   20.062976] usbcore: registered new driver usbfs
[   20.063046] usbcore: registered new driver hub
[   20.063124] PCI: Using ACPI for IRQ routing
[   20.063230] PCI: If a device doesn't work, try "pci=3Drouteirq".  If=
 it=20
helps, post a report
[   20.064045] PCI: Bridge: 0000:00:01.0
[   20.064089]   IO window: disabled.
[   20.064136]   MEM window: f2700000-fc7fffff
[   20.064182]   PREFETCH window: a7e00000-c7dfffff
[   20.064229] PCI: Bridge: 0000:00:02.0
[   20.064273]   IO window: disabled.
[   20.064318]   MEM window: fc800000-fc8fffff
[   20.064364]   PREFETCH window: disabled.
[   20.064410] PCI: Bridge: 0000:00:05.0
[   20.064454]   IO window: disabled.
[   20.064501]   MEM window: fc900000-fe9fffff
[   20.064548]   PREFETCH window: c7e00000-d7dfffff
[   20.064596] PCI: Bridge: 0000:00:06.0
[   20.064642]   IO window: d000-dfff
[   20.064689]   MEM window: fea00000-feafffff
[   20.064736]   PREFETCH window: d7e00000-d7efffff
[   20.064795] GSI 16 sharing vector 0xA9 and IRQ 16
[   20.064842] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, lo=
w) ->=20
IRQ 169
[   20.064933] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   20.064939] GSI 17 sharing vector 0xB1 and IRQ 17
[   20.064985] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, lo=
w) ->=20
IRQ 177
[   20.065074] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   20.065081] PCI: Setting latency timer of device 0000:00:05.0 to 64
[   20.065087] PCI: Setting latency timer of device 0000:00:06.0 to 64
[   20.065298] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:2=
8 ak=20
Exp $
[   20.065672] Total HugeTLB memory allocated, 0
[   20.065819] io scheduler noop registered
[   20.065897] io scheduler anticipatory registered
[   20.065975] io scheduler deadline registered
[   20.066057] io scheduler cfq registered
[   20.066832] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, lo=
w) ->=20
IRQ 169
[   20.066926] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   20.066948] assign_interrupt_mode Found MSI capability
[   20.067025] Allocate Port Service[0000:00:01.0:pcie00]
[   20.067055] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, lo=
w) ->=20
IRQ 177
[   20.067146] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   20.067181] assign_interrupt_mode Found MSI capability
[   20.067247] Allocate Port Service[0000:00:02.0:pcie00]
[   20.067332] ACPI: Power Button (FF) [PWRF]
[   20.067387] ACPI: Power Button (CM) [PWRB]
[   20.078956] Real Time Clock Driver v1.12
[   20.081149] serio: i8042 AUX port at 0x60,0x64 irq 12
[   20.081348] serio: i8042 KBD port at 0x60,0x64 irq 1
[   20.081468] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   20.081517] ide: Assuming 33MHz system bus speed for PIO modes; over=
ride=20
with idebus=3Dxx
[   20.081603] ALI15X3: IDE controller at PCI slot 0000:00:12.0
[   20.081658] GSI 18 sharing vector 0xD1 and IRQ 18
[   20.081705] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 19 (level, lo=
w) ->=20
IRQ 209
[   20.081801] ALI15X3: chipset revision 199
[   20.081847] ALI15X3: not 100% native mode: will probe irqs later
[   20.081904]     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DM=
A,=20
hdb:pio
[   20.082029]     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DM=
A,=20
hdd:pio
[   20.082152] Probing IDE interface ide0...
[   20.370787] hda: SAMSUNG SP1213N, ATA DISK drive
[   21.041445] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   21.041568] Probing IDE interface ide1...
[   21.776166] hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
[   22.446812] ide1 at 0x170-0x177,0x376 on irq 15
[   22.446993] hda: max request size: 512KiB
[   22.448873] hda: 234493056 sectors (120060 MB) w/8192KiB Cache,=20
CHS=3D16383/255/63, UDMA(100)
[   22.449407] hda: cache flushes supported
[   22.449482]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
[   22.488736] hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache=
,=20
UDMA(33)
[   22.489030] Uniform CD-ROM driver Revision: 3.20
[   22.490381] usbmon: debugfs is not available
[   22.490442] usbcore: registered new driver usbhid
[   22.490489] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   22.490573] mice: PS/2 mouse device common for all mice
[   22.490662] NET: Registered protocol family 2
[   22.530599] IP route cache hash table entries: 32768 (order: 6, 2621=
44=20
bytes)
[   22.530867] TCP established hash table entries: 131072 (order: 8, 10=
48576=20
bytes)
[   22.531699] TCP bind hash table entries: 65536 (order: 7, 524288 byt=
es)
[   22.532106] TCP: Hash tables configured (established 131072 bind 655=
36)
[   22.532155] TCP reno registered
[   22.532216] TCP bic registered
[   22.532272] NET: Registered protocol family 1
[   22.532322] NET: Registered protocol family 17
[   22.532370] powernow-k8: Found 1 AMD Athlon 64 / Opteron processors=20
(version 1.60.0)
[   22.532526] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x6 (1400 mV=
)
[   22.532575] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x8 (1350 mV=
)
[   22.532623] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xa (1300 mV=
)
[   22.532673] cpu_init done, current fid 0xc, vid 0x6
[   22.532818] ACPI wakeup devices:
[   22.532863]  HTT PS2K AC97 MC97  LAN USB0 USB1 USB2 UB20 PEB1 PEB2 P=
EB3
[   22.533265] ACPI: (supports S0 S1 S3 S4 S5)
[   22.554005] ReiserFS: hda3: found reiserfs format "3.6" with standar=
d=20
journal
[   22.760853] input: AT Translated Set 2 keyboard as /class/input/inpu=
t0
[   26.129529] ReiserFS: hda3: using ordered data mode
[   26.141918] ReiserFS: hda3: journal params: device hda3, size 8192, =
journal=20
first block 18, max trans len 1024, max batch 900, max commit age 30, m=
ax=20
trans age 30
[   26.143607] ReiserFS: hda3: checking transaction log (hda3)
[   26.200593] ReiserFS: hda3: replayed 7 transactions in 0 seconds
[   26.216745] ReiserFS: hda3: Using r5 hash to sort names
[   26.216807] VFS: Mounted root (reiserfs filesystem) readonly.
[   26.216951] Freeing unused kernel memory: 152k freed
[   29.633252] Adding 996020k swap on /dev/hda2.  Priority:-1 extents:1=
=20
across:996020k
[   30.069415] ReiserFS: hda3: Removing [344649 119965 0x0 SD]..done
[   30.069476] ReiserFS: hda3: Removing [344649 115674 0x0 SD]..done
[   30.069510] ReiserFS: hda3: Removing [344649 73948 0x0 SD]..done
[   30.069541] ReiserFS: hda3: There were 3 uncompleted unlinks/truncat=
es.=20
Completed
[   30.712913] uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005=
-7-29)
[   30.713136] GSI 19 sharing vector 0xD9 and IRQ 19
[   30.713140] ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, lo=
w) ->=20
IRQ 217
[   30.735403] eth0: ULi M5263 at pci0000:00:11.0, 00:13:8f:3f:bf:15, i=
rq 217.
[   30.750951] Linux video capture interface: v1.00
[   30.848128] bttv: driver version 0.9.16 loaded
[   30.848132] bttv: using 8 buffers with 2080k (520 pages) each for ca=
pture
[   30.848162] bttv: Bt8xx card found (0).
[   30.848176] GSI 20 sharing vector 0xE1 and IRQ 20
[   30.848179] ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 21 (level, lo=
w) ->=20
IRQ 225
[   30.848190] bttv0: Bt848 (rev 18) at 0000:04:06.0, irq: 225, latency=
: 32,=20
mmio: 0xd7eff000
[   30.848200] bttv0: using: Terratec TerraTV+ Version 1.0 (Bt848)/ Ter=
ra=20
TValue Version 1.0/ Vobis TV-Boostar [card=3D25,insmod option]
[   30.848232] bttv0: gpio: en=3D00000000, out=3D00000000 in=3D00ffffff=
 [init]
[   31.849191] bttv0: tea5757: read timeout
[   31.849195] bttv0: using tuner=3D5
[   31.849199] bttv0: i2c: checking for MSP34xx @ 0x80... not found
[   31.851340] bttv0: i2c: checking for TDA9875 @ 0xb0... not found
[   31.853465] bttv0: i2c: checking for TDA7432 @ 0x8a... not found
[   31.855590] bttv0: i2c: checking for TDA9887 @ 0x86... not found
[   31.877691] tuner 0-0060: All bytes are equal. It is not a TEA5767
[   31.877695] tuner 0-0060: chip found @ 0xc0 (bt848 #0 [sw])
[   31.877924] tuner 0-0060: type set to 5 (Philips PAL_BG (FI1216 and=20
compatibles))
[   31.913914] bttv0: registered device video0
[   31.913987] bttv0: registered device vbi0
[   32.079354] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (=
OHCI)=20
Driver (PCI)
[   32.079573] GSI 21 sharing vector 0xE9 and IRQ 21
[   32.079577] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 20 (level, lo=
w) ->=20
IRQ 233
[   32.079738] ohci_hcd 0000:00:13.0: OHCI Host Controller
[   32.080164] ohci_hcd 0000:00:13.0: new USB bus registered, assigned =
bus=20
number 1
[   32.080177] ohci_hcd 0000:00:13.0: irq 233, io mem 0xfebfe000
[   32.135065] usb usb1: configuration #1 chosen from 1 choice
[   32.135155] hub 1-0:1.0: USB hub found
[   32.135164] hub 1-0:1.0: 3 ports detected
[   32.236631] ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 21 (level, lo=
w) ->=20
IRQ 225
[   32.236734] ohci_hcd 0000:00:13.1: OHCI Host Controller
[   32.237052] ohci_hcd 0000:00:13.1: new USB bus registered, assigned =
bus=20
number 2
[   32.237060] ohci_hcd 0000:00:13.1: irq 225, io mem 0xfebfd000
[   32.294697] usb usb2: configuration #1 chosen from 1 choice
[   32.294793] hub 2-0:1.0: USB hub found
[   32.294802] hub 2-0:1.0: 3 ports detected
[   32.396317] GSI 22 sharing vector 0x32 and IRQ 22
[   32.396321] ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 22 (level, lo=
w) ->=20
IRQ 50
[   32.396420] ohci_hcd 0000:00:13.2: OHCI Host Controller
[   32.396744] ohci_hcd 0000:00:13.2: new USB bus registered, assigned =
bus=20
number 3
[   32.396756] ohci_hcd 0000:00:13.2: irq 50, io mem 0xfebfc000
[   32.454393] usb usb3: configuration #1 chosen from 1 choice
[   32.454490] hub 3-0:1.0: USB hub found
[   32.454499] hub 3-0:1.0: 3 ports detected
[   32.491984] usb 1-1: new full speed USB device using ohci_hcd and ad=
dress 2
[   32.656685] usb 1-1: configuration #1 chosen from 1 choice
[   32.662707] hub 1-1:1.0: USB hub found
[   32.665666] hub 1-1:1.0: 4 ports detected
[   32.670069] GSI 23 sharing vector 0x3A and IRQ 23
[   32.670073] ACPI: PCI Interrupt 0000:00:13.3[D] -> GSI 23 (level, lo=
w) ->=20
IRQ 58
[   32.670237] ehci_hcd 0000:00:13.3: EHCI Host Controller
[   32.670272] ehci_hcd 0000:00:13.3: debug port 1
[   32.691949] ehci_hcd 0000:00:13.3: new USB bus registered, assigned =
bus=20
number 4
[   32.691962] ehci_hcd 0000:00:13.3: irq 58, io mem 0xfebff800
[   32.691971] ehci_hcd 0000:00:13.3: USB 2.0 started, EHCI 1.00, drive=
r 10=20
Dec 2004
[   32.692240] usb usb4: configuration #1 chosen from 1 choice
[   32.692339] hub 4-0:1.0: USB hub found
[   32.692347] hub 4-0:1.0: 8 ports detected
[   32.792485] usb 1-1: USB disconnect, address 2
[   33.498105] usb 1-1: new full speed USB device using ohci_hcd and ad=
dress 3
[   33.662785] usb 1-1: configuration #1 chosen from 1 choice
[   33.668814] hub 1-1:1.0: USB hub found
[   33.671766] hub 1-1:1.0: 4 ports detected
[   34.011116] usb 1-1.3: new low speed USB device using ohci_hcd and a=
ddress=20
4
[   34.115921] usb 1-1.3: configuration #1 chosen from 1 choice
[   34.130936] input: HID 062a:0000 as /class/input/input1
[   34.130964] input: USB HID v1.10 Mouse [HID 062a:0000] on=20
usb-0000:00:13.0-1.3
[   38.228262] ReiserFS: hda5: found reiserfs format "3.6" with standar=
d=20
journal
[   41.280914] ReiserFS: hda5: using ordered data mode
[   41.299904] ReiserFS: hda5: journal params: device hda5, size 8192, =
journal=20
first block 18, max trans len 1024, max batch 900, max commit age 30, m=
ax=20
trans age 30
[   41.301469] ReiserFS: hda5: checking transaction log (hda5)
[   41.374824] ReiserFS: hda5: Using r5 hash to sort names
[   45.469640] ACPI: PCI Interrupt 0000:04:07.0[A] -> GSI 22 (level, lo=
w) ->=20
IRQ 50
[   45.473199] Audigy2 value: Special config.
[   52.782409] uli526x: eth0 NIC Link is Up 100 Mbps Full duplex
[   53.165707] ali1563: SMBus control =3D 0403
[   53.174133] ali1563_probe: Returning 0


If you want more information, or if I should try something, please mail=
 me.


Gl=FCck Auf
Volker
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
