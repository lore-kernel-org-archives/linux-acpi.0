From: David van Hoose <david.vanhoose-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: Re: Linux 2.4.23-pre8
Date: Fri, 24 Oct 2003 12:38:30 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F995586.3020408@comcast.net>
References: <Pine.LNX.4.44.0310241019050.1354-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010901030608070709030708"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0310241019050.1354-100000-IP5UegVbiV6sTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010901030608070709030708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> On 23 Oct 2003, Len Brown wrote:
> 
> 
>>David,
>>best if you can file a bug and attach the info there --
>>i sifted through my e-mail but i'm not sure which
>>one this e-mail refers to.
>>
>>thanks,
>>-Len
>>
>>Please file a bug at http://bugzilla.kernel.org/
>>Category: Power Management
>>Component: ACPI
>>
>>Please attach the output from dmidecode, available in /usr/sbin/, or
>>here:
>>http://www.nongnu.org/dmidecode/
>>
>>Please attach the output from acpidmp, available in /usr/sbin/, or in
>>here
>>http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz
>>
>>Please attach /proc/interrupts and the dmesg output showing the failure,
>>if possible.
> 
> 
> David already did it... its bug number 1283.
> 
> It seems the problem is caused by sharing USB interrupt with ACPI 
> interrupt.
> 
> However, it seems the correct thing to use is IRQ20 for the USB
> controller, not IRQ9, yes? 
> 
> David, what /proc/interrupts looks like in 2.6?

Attached config, boot messages, and interrupts for 2.6.0-test8-bk2.
The boot messages do not have any USB debug, but do have ACPI debug. 
Also, all of my USB ports work 100% of the time on 2.6 with ACPI enabled.

-David van Hoose

--------------010901030608070709030708
Content-Type: text/plain;
 name="config-2.6.0-test8-bk2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.6.0-test8-bk2"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=19
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
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
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_PPA=y
CONFIG_SCSI_IMM=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_IPCOMP=y
CONFIG_IPV6_TUNNEL=m
CONFIG_BRIDGE=m
CONFIG_NETFILTER=y
CONFIG_BRIDGE_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_AMANDA=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_NAT_AMANDA=y
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_IPV6_SCTP__=y
CONFIG_VLAN_8021Q=m
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_IPX=m
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_BONDING=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_NET_TULIP=y
CONFIG_TULIP=m
CONFIG_NET_PCI=y
CONFIG_SIS900=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_W83781D=m
CONFIG_HW_RANDOM=m
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_SIS=m
CONFIG_DRM=y
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
CONFIG_HANGCHECK_TIMER=m
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_USB_AUDIO=m
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_PRINTER=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=y
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m
CONFIG_USB_USBNET=m
CONFIG_USB_CDCETHER=y
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_TIGL=m
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_HFS_FS=m
CONFIG_EFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------010901030608070709030708
Content-Type: text/plain;
 name="dmesg-2.6.0-test8-bk2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.0-test8-bk2"

Linux version 2.6.0-test8-bk2 (root@aeon) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Oct 23 00:13:32 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5810
ACPI: RSDT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc0c0
ACPI: BOOT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   P4S8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS P4S8X    0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 128, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x14] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: ro root=LABEL=/ parport=auto nmi_watchdog=1
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2532.869 MHz processor.
Console: colour VGA+ 80x25
Memory: 513544k/524272k available (2443k kernel code, 9964k reserved, 1020k data, 164k init, 0k highmem)
Calibrating delay loop... 5013.50 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 221k freed
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178080
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0080
.... register #02: 02000000
.......     : arbitration: 02
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 001 01  0    0    0   0   0    1    1    71
 0b 001 01  0    0    0   0   0    1    1    79
 0c 001 01  0    0    0   0   0    1    1    81
 0d 001 01  0    0    0   0   0    1    1    89
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 001 01  1    1    0   1   0    1    1    A1
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:20
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2532.0814 MHz.
..... host bus clock speed is 133.0305 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf11b0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................................................................
Table [DSDT](id F004) - 326 Objects with 47 Devices 132 Methods 6 Regions
ACPI Namespace successfully loaded at root c05206fc
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xa9 -> IRQ 20 Mode:1 Active:1)
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E430 on int 9
Completing Region/Field/Buffer/Package initialization:........................................
Initialized 6/6 Regions 0/0 Fields 23/23 Buffers 11/11 Packages (334 nodes)
Executing all Device _STA and_INI methods:................................................
48 Devices found containing: 48 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f9680
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x96b0, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb1 -> IRQ 16 Mode:1 Active:1)
00:00:02[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
00:00:02[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
00:00:02[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc9 -> IRQ 19 Mode:1 Active:1)
00:00:02[D] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:00:03[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:03[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:00:03[D] -> 2-23 -> IRQ 23
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
acpi_processor-1626 [22] acpi_processor_get_inf: Invalid PBLK length [5]
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y080P0, ATA DISK drive
hdb: Maxtor 53073H6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdb: max request size: 128KiB
hdb: 60030432 sectors (30735 MB) w/2048KiB Cache, CHS=59554/16/63, UDMA(100)
 hdb: hdb1
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
scsi0 : Iomega VPI0 (ppa) interface
  Vendor: IOMEGA    Model: ZIP 100           Rev: D.09
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 6, lun 0,  type 0
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: irq 23, pci mem e081c000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: irq 20, pci mem e081e000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: irq 21, pci mem e0820000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ohci_hcd 0000:00:03.2: OHCI Host Controller
ohci_hcd 0000:00:03.2: irq 22, pci mem e0822000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.15:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 17
NET: Registered protocol family 15
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 164k freed
hub 2-0:1.0: new USB device on port 1, assigned address 2
hub 4-0:1.0: new USB device on port 1, assigned address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 1 alt 0 proto 2 vid 0x03F0 pid 0x2811
drivers/usb/core/usb.c: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:03.0-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda2, internal journal
Adding 1004020k swap on /dev/hda5.  Priority:-1 extents:1
intel8x0: clocking to 48000
agpgart: Detected SiS 648 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe0000000
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
microcode: No suitable data for cpu 0
kudzu: numerical sysctl 1 23 is obsolete.
Disabled Privacy Extensions on device c041cf40(lo)
sis900.c: v1.08.06 9/24/2002
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x9800, IRQ 19, 00:e0:18:9d:4f:d0.
eth0: Media Link On 100mbps full-duplex 
Linux Tulip driver version 1.1.13 (May 11, 2002)
eth1: ADMtek Comet rev 17 at 0x9400, 00:20:78:04:68:6F, IRQ 19.
eth0: no IPv6 routers present
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 16 19:03:09 PDT 2003
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode

--------------010901030608070709030708
Content-Type: text/plain;
 name="interrupts-2.6.0-test8-bk2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts-2.6.0-test8-bk2"

           CPU0       
  0:   78707157    IO-APIC-edge  timer
  1:      29897    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  7:          2    IO-APIC-edge  parport0
  8:          1    IO-APIC-edge  rtc
 14:     211399    IO-APIC-edge  ide0
 15:         14    IO-APIC-edge  ide1
 16:    6723115   IO-APIC-level  nvidia
 18:    1692610   IO-APIC-level  SiS SI7012
 19:      68412   IO-APIC-level  eth0
 20:     119285   IO-APIC-level  acpi, ohci_hcd
 21:          0   IO-APIC-level  ohci_hcd
 22:         79   IO-APIC-level  ohci_hcd
 23:          0   IO-APIC-level  ehci_hcd
NMI:   78707289 
LOC:   78708151 
ERR:          0
MIS:          0

--------------010901030608070709030708--



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
