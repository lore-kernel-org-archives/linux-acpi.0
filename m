From: Christian Axelsson <smiler-pw/8oln/LLv0Dx+PQ6IoOQ@public.gmane.org>
Subject: Acer Travermate 8005 and battery info
Date: Thu, 30 Sep 2004 00:45:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <415B3AF6.8020702@lanil.mine.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050709000107030608010302"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050709000107030608010302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hey

Ive got a my new acer 8000 laptop and Im having some problems with 
getting battery status info.
Here are outputs from /proc/acpi/battery/BAT1/state with AC-adapter 
plugged in and without:
=============================================================
   % cat /proc/acpi/battery/BAT1/state 

   present:                 yes
   capacity state:          ok
   charging state:          charging
   present rate:            0 mA
   remaining capacity:      3706 mAh
   present voltage:         0 mV

% cat /proc/acpi/battery/BAT1/state
   present:                 yes
   capacity state:          ok
   charging state:          discharging
   present rate:            0 mA
   remaining capacity:      3720 mAh
   present voltage:         0 mV
============================================================
To compare, here is the same output from my friends ibm r51:
============================================================
   % cat /proc/acpi/battery/BAT0/state
   present:                 yes
   capacity state:          ok
   charging state:          charging
   present rate:            30159 mW
   remaining capacity:      3840 mWh
   present voltage:         11640 mV

   % cat /proc/acpi/battery/BAT0/state
   present:                 yes
   capacity state:          ok
   charging state:          discharging
   present rate:            20414 mW
   remaining capacity:      4350 mWh
   present voltage:         11101 mV
=============================================================

As you note my present rate and present voltage doesnt seem to be 
detected. This make trouble for userspace apps to read and calculate
correct status. What info do you need from me?

Regards
--
Christian Axelsson
smiler-pw/8oln/LLv0Dx+PQ6IoOQ@public.gmane.org

--------------050709000107030608010302
Content-Type: text/plain;
 name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.9-rc2-mm4
# Wed Sep 29 18:46:27 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

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
# CONFIG_X86_ELAN is not set
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
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
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
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_BKL is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_THINKPAD is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=y
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_YENTA=y
CONFIG_CARDBUS=y
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y

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

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
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
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
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
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
CONFIG_IEEE1394_SBP2=y
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=y
# CONFIG_IEEE1394_CMP is not set

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
# CONFIG_PACKET_MMAP is not set
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
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
# CONFIG_IP_NF_NAT is not set
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

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
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=y

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=m
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

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
CONFIG_INPUT_EVDEV=y
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
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

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
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_RTC_IRQ=y
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

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
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_RW_DETECT is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISER4_FS=y
CONFIG_REISER4_LARGE_KEY=y
# CONFIG_REISER4_CHECK is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# Caches
#
# CONFIG_CACHEFS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
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
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_POSIX is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
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
# CONFIG_NLS_ASCII is not set
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
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_4KSTACKS is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_SHA1 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_WHIRLPOOL is not set
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_BLOWFISH=y
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES_586=y
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------050709000107030608010302
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.9-rc2-mm4 (root@laptop) (gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #4 Wed Sep 29 18:47:30 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fee0000 (usable)
 BIOS-e820: 000000001fee0000 - 000000001feec000 (ACPI data)
 BIOS-e820: 000000001feec000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
510MB LOWMEM available.
On node 0 totalpages: 130784
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126688 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                  ) @ 0x000f6020
ACPI: RSDT (v001 ACER   TM8000   0x20020608  LTP 0x00000000) @ 0x1fee52ea
ACPI: FADT (v001 ACER   TM8000   0x20020608 PTL  0x00000050) @ 0x1feebf2c
ACPI: HPET (v001 ACER   TM8000   0x20020608 PTL  0x00000000) @ 0x1feebfa0
ACPI: BOOT (v001 ACER   TM8000   0x20020608  LTP 0x00000001) @ 0x1feebfd8
ACPI: DSDT (v001 ACER   TM8000   0x20020608 MSFT 0x0100000e) @ 0x00000000
ACPI: HPET id: 0x8086a201 base: 0x0
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda3 vga=791
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1794.185 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 513224k/523136k available (3326k kernel code, 9428k reserved, 1162k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3547.13 BogoMIPS (lpj=1773568)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000
CPU: After vendor identify, caps:  afe9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps:        afe9f9bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.80GHz stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd732, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *6)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *6)
ACPI: PCI Interrupt Link [LNKD] (IRQs *6)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 6) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
Simple Boot Flag at 0x37 set to 0x1
Machine check exception polling timer started.
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
Initializing Cryptographic API
vesafb: framebuffer at 0xd8000000, mapped to 0xe0880000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=84
vesafb: protected mode interface info at c000:588a
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (46 C)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855GM Chipset.
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: AGP aperture is 256M @ 0xe0000000
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe-l3A5Bk7waGM@public.gmane.org) and petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org
tg3.c:v3.10 (September 14, 2004)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 6 (level, low) -> IRQ 6
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:c0:9f:44:d4:77
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N080ATMR04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITADVD-RAM UJ-820S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ohci1394: $Rev: 1226 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d0218000-d02187ff]  Max Packet=[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1231 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 6 (level, low) -> IRQ 6
Yenta: CardBus bridge found at 0000:02:06.0 [1025:0051]
Yenta: ISA IRQ mask 0x08b8, PCI irq 6
Socket status: 30000006
ACPI: PCI interrupt 0000:02:06.1[A] -> GSI 6 (level, low) -> IRQ 6
Yenta: CardBus bridge found at 0000:02:06.1 [1025:0051]
Yenta: ISA IRQ mask 0x08b8, PCI irq 6
Socket status: 30000006
PCI: Enabling device 0000:02:06.3 (0080 -> 0082)
ACPI: PCI interrupt 0000:02:06.3[A] -> GSI 6 (level, low) -> IRQ 6
Yenta: CardBus bridge found at 0000:02:06.3 [1025:0051]
Yenta: ISA IRQ mask 0x08b8, PCI irq 6
Socket status: 30000410
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem 0xd0000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 6 (level, low) -> IRQ 6
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00001ca1bf]
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 6, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 6 (level, low) -> IRQ 6
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 6, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
usb 1-6: new high speed USB device using address 2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 6 (level, low) -> IRQ 6
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
hub 1-6:1.0: USB hub found
hub 1-6:1.0: 4 ports detected
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 6, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49517 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 with ALC202 at 0xd0000c00, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4087 buckets, 32696 max) - 176 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost-vhD3WmCyG/PR7s880joybQ@public.gmane.org>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
cpufreq: CPU0 - ACPI performance management activated.
cpufreq: *P0: 1800 MHz, 24000 mW, 10 uS
cpufreq:  P1: 1600 MHz, 20000 mW, 10 uS
cpufreq:  P2: 1400 MHz, 18000 mW, 10 uS
cpufreq:  P3: 1000 MHz, 16000 mW, 10 uS
cpufreq:  P4: 600 MHz, 12000 mW, 10 uS
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
GLAN MPCI T394 MDM0 USB1 USB2 USB3 
VFS: Mounted root (reiser4 filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding 506036k swap on /dev/hda2.  Priority:-1 extents:1
ieee80211_crypt: registered algorithm 'NULL'
ipw2200: Intel(R) PRO/Wireless 2200 Network Driver, 0.9
ipw2200: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
ipw2200: Calibration
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ipw2200: Calibration
ipw2200: I ipw_irq_tasklet RF_KILL_DONE
ipw2200: U ipw_rf_kill RF Kill active, rescheduling GPIO check
ipw2200: U ipw_rf_kill RF Kill active, rescheduling GPIO check
ipw2200: U ipw_rf_kill RF Kill no longer active, restarting device
ipw2200: Calibration
mtrr: 0xd8000000,0x8000000 overlaps existing 0xd8000000,0x200000
No module found in object

--------------050709000107030608010302
Content-Type: text/plain;
 name="acpidmp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpidmp"

RSDP "ACER" @ 0x000f6020
  0000: 52 53 44 20 50 54 52 20 3d 41 43 45 52 20 20 00  RSD PTR =ACER  .
  0010: ea 52 ee 1f                                      .R..

RSDT @ 0x1fee52ea
  0000: 52 53 44 54 30 00 00 00 01 46 41 43 45 52 20 20  RSDT0....FACER  
  0010: 54 4d 38 30 30 30 20 20 08 06 02 20 20 4c 54 50  TM8000  ...  LTP
  0020: 00 00 00 00 2c bf ee 1f a0 bf ee 1f d8 bf ee 1f  ....,...........

FACP @ 0x1feebf2c
  0000: 46 41 43 50 74 00 00 00 01 be 41 43 45 52 20 20  FACPt.....ACER  
  0010: 54 4d 38 30 30 30 20 20 08 06 02 20 50 54 4c 20  TM8000  ... PTL 
  0020: 50 00 00 00 c0 cf ef 1f 1a 53 ee 1f 00 00 09 00  P........S......
  0030: b2 00 00 00 f0 f1 f2 80 00 10 00 00 00 00 00 00  ................
  0040: 04 10 00 00 00 00 00 00 20 10 00 00 08 10 00 00  ........ .......
  0050: 28 10 00 00 00 00 00 00 04 02 01 04 08 00 00 85  (...............
  0060: 01 00 55 00 00 00 00 00 01 03 0d 00 32 00 00 00  ..U.........2...
  0070: 25 00 00 00                                      %...

DSDT @ 0x1fee531a
  0000: 44 53 44 54 12 6c 00 00 01 25 41 43 45 52 20 20  DSDT.l...%ACER  
  0010: 54 4d 38 30 30 30 20 20 08 06 02 20 4d 53 46 54  TM8000  ... MSFT
  0020: 0e 00 00 01 5b 80 50 4f 52 54 01 0a 80 0a 02 5b  ....[.PORT.....[
  0030: 81 10 50 4f 52 54 01 50 38 30 48 08 50 38 31 48  ..PORT.P80H.P81H
  0040: 08 5b 80 49 4f 5f 54 01 0b 00 08 0a 10 5b 81 0b  .[.IO_T......[..
  0050: 49 4f 5f 54 01 54 52 50 30 08 5b 80 4d 4e 56 53  IO_T.TRP0.[.MNVS
  0060: 00 0c 59 ce ee 1f 0a 60 5b 81 4c 0d 4d 4e 56 53  ..Y....`[.L.MNVS
  0070: 10 4f 53 59 53 10 53 4d 49 46 08 53 43 49 46 08  .OSYS.SMIF.SCIF.
  0080: 50 41 52 31 08 50 41 52 32 08 41 43 50 53 08 44  PAR1.PAR2.ACPS.D
  0090: 42 47 53 08 44 43 4b 53 04 43 44 43 4b 04 49 47  BGS.DCKS.CDCK.IG
  00a0: 44 53 08 53 4c 49 44 08 42 52 54 43 08 42 52 54  DS.SLID.BRTC.BRT
  00b0: 53 08 57 52 4b 46 08 53 57 32 4c 01 50 4e 43 53  S.WRKF.SW2L.PNCS
  00c0: 01 00 06 50 52 49 44 08 43 4d 41 50 08 43 4d 42  ...PRID.CMAP.CMB
  00d0: 50 08 4c 50 54 50 08 46 44 43 50 08 00 08 50 53  P.LPTP.FDCP...PS
  00e0: 32 46 08 00 10 41 43 54 54 08 50 53 56 54 08 54  2F...ACTT.PSVT.T
  00f0: 43 31 56 08 54 43 32 56 08 54 53 50 56 08 43 52  C1V.TC2V.TSPV.CR
  0100: 54 54 08 00 10 42 56 41 4c 20 44 4f 46 46 08 54  TT...BVAL DOFF.T
  0110: 4d 50 31 08 54 4d 50 32 08 53 56 43 52 08 54 4d  MP1.TMP2.SVCR.TM
  0120: 50 34 20 54 4d 50 35 20 43 53 54 45 10 4e 53 54  P4 TMP5 CSTE.NST
  0130: 45 10 53 53 54 45 10 43 41 44 4c 10 50 41 44 4c  E.SSTE.CADL.PADL
  0140: 10 42 43 41 50 08 10 4e 0a 5f 50 52 5f 5b 83 46  .BCAP..N._PR_[.F
  0150: 0a 43 50 55 30 00 10 10 00 00 06 08 5f 50 43 54  .CPU0......._PCT
  0160: 12 2c 02 11 14 0a 11 82 0c 00 01 08 00 00 b2 00  .,..............
  0170: 00 00 00 00 00 00 79 00 11 14 0a 11 82 0c 00 01  ......y.........
  0180: 08 00 00 b3 00 00 00 00 00 00 00 79 00 08 5f 50  ...........y.._P
  0190: 53 53 12 48 05 05 12 10 06 0b 08 07 0b c0 5d 0a  SS.H..........].
  01a0: 0a 0a 0a 0a 89 0a 00 12 10 06 0b 40 06 0b 20 4e  ...........@.. N
  01b0: 0a 0a 0a 0a 0a 8a 0a 01 12 10 06 0b 78 05 0b 50  ............x..P
  01c0: 46 0a 0a 0a 0a 0a 8b 0a 02 12 10 06 0b e8 03 0b  F...............
  01d0: 80 3e 0a 0a 0a 0a 0a 8c 0a 03 12 10 06 0b 58 02  .>............X.
  01e0: 0b e0 2e 0a 0a 0a 0a 0a 8d 0a 04 14 09 5f 50 50  ............._PP
  01f0: 43 00 a4 0a 00 08 5c 44 53 45 4e 0a 01 10 3b 5f  C.....\DSEN...;_
  0200: 53 49 5f 14 35 5f 4d 53 47 01 a0 17 68 70 01 5c  SI_.5_MSG...hp.\
  0210: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 4c  /._SB_PCI0LPC0BL
  0220: 32 37 a1 16 70 00 5c 2f 04 5f 53 42 5f 50 43 49  27..p.\/._SB_PCI
  0230: 30 4c 50 43 30 42 4c 32 37 08 5c 5f 53 30 5f 12  0LPC0BL27.\_S0_.
  0240: 06 02 0a 00 0a 00 08 5c 5f 53 33 5f 12 06 02 0a  .......\_S3_....
  0250: 05 0a 05 08 5c 5f 53 34 5f 12 06 02 0a 06 0a 06  ....\_S4_.......
  0260: 08 5c 5f 53 35 5f 12 06 02 0a 07 0a 07 14 4b 1b  .\_S5_........K.
  0270: 5f 50 54 53 01 70 68 5c 2e 5f 53 42 5f 53 54 41  _PTS.ph\._SB_STA
  0280: 54 70 0d 3e 3e 3e 3e 20 5f 50 54 53 20 2d 2d 2d  Tp.>>>> _PTS ---
  0290: 2d 2d 2d 2d 2d 2d 2d 2d 2d 00 5b 31 70 68 5b 31  ---------.[1ph[1
  02a0: 70 68 5c 2e 5f 53 42 5f 53 4c 45 45 70 0a 84 5c  ph\._SB_SLEEp..\
  02b0: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 43  /._SB_PCI0LPC0BC
  02c0: 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  MDp..\/._SB_PCI0
  02d0: 4c 50 43 30 53 4d 49 43 a0 25 7d 93 68 0a 03 93  LPC0SMIC.%}.h...
  02e0: 68 0a 04 00 70 0a 01 5c 2f 05 5f 53 42 5f 50 43  h...p..\/._SB_PC
  02f0: 49 30 4c 50 43 30 45 43 30 5f 41 50 57 52 a0 4a  I0LPC0EC0_APWR.J
  0300: 05 93 68 0a 03 70 0a e6 50 38 30 48 70 0a 80 5c  ..h..p..P80Hp..\
  0310: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 43  /._SB_PCI0LPC0BC
  0320: 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  MDp..\/._SB_PCI0
  0330: 4c 50 43 30 53 4d 49 43 70 0a 01 5c 2f 04 5f 53  LPC0SMICp..\/._S
  0340: 42 5f 50 43 49 30 4c 50 43 30 4c 56 33 37 5b 22  B_PCI0LPC0LV37["
  0350: 0a c8 70 0a e7 50 38 30 48 a0 41 07 93 68 0a 04  ..p..P80H.A..h..
  0360: 70 0a 01 5c 2e 5f 53 42 5f 53 34 57 50 70 0a 82  p..\._SB_S4WPp..
  0370: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 42  \/._SB_PCI0LPC0B
  0380: 43 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49  CMDp..\/._SB_PCI
  0390: 30 4c 50 43 30 53 4d 49 43 70 01 5c 2f 05 5f 53  0LPC0SMICp.\/._S
  03a0: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 50 46  B_PCI0LPC0EC0_PF
  03b0: 4c 47 70 01 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  LGp.\/._SB_PCI0L
  03c0: 50 43 30 45 43 30 5f 53 34 4c 44 a0 31 93 87 5c  PC0EC0_S4LD.1..\
  03d0: 5f 4f 53 5f 0a 27 86 5c 2e 5f 53 42 5f 42 41 54  _OS_.'.\._SB_BAT
  03e0: 31 0a 80 86 5c 2e 5f 53 42 5f 42 41 54 32 0a 80  1...\._SB_BAT2..
  03f0: 86 5c 2e 5f 53 42 5f 41 43 41 44 0a 00 a0 2b 93  .\._SB_ACAD...+.
  0400: 68 0a 05 70 01 5c 2f 05 5f 53 42 5f 50 43 49 30  h..p.\/._SB_PCI0
  0410: 4c 50 43 30 45 43 30 5f 53 35 4c 57 70 0a 00 5c  LPC0EC0_S5LWp..\
  0420: 2e 5f 53 42 5f 45 43 4f 4b 14 49 25 5f 57 41 4b  ._SB_ECOK.I%_WAK
  0430: 01 70 0d 3e 3e 3e 3e 20 5f 57 41 4b 20 2d 2d 2d  .p.>>>> _WAK ---
  0440: 2d 2d 2d 2d 2d 2d 2d 2d 2d 00 5b 31 70 68 5b 31  ---------.[1ph[1
  0450: 70 68 5c 2e 5f 53 42 5f 53 54 41 54 70 0a e0 50  ph\._SB_STATp..P
  0460: 38 30 48 70 5c 2e 5f 53 42 5f 57 4c 45 53 5c 2f  80Hp\._SB_WLES\/
  0470: 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30  ._SB_PCI0LPC0EC0
  0480: 5f 57 45 53 54 70 5c 2e 5f 53 42 5f 42 54 45 53  _WESTp\._SB_BTES
  0490: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45  \/._SB_PCI0LPC0E
  04a0: 43 30 5f 42 45 53 54 70 01 5c 2f 05 5f 53 42 5f  C0_BESTp.\/._SB_
  04b0: 50 43 49 30 4c 50 43 30 45 43 30 5f 57 42 49 4e  PCI0LPC0EC0_WBIN
  04c0: 70 0a e1 50 38 30 48 a0 3f 93 68 0a 03 70 0a e2  p..P80H.?.h..p..
  04d0: 50 38 30 48 70 0a 81 5c 2f 04 5f 53 42 5f 50 43  P80Hp..\/._SB_PC
  04e0: 49 30 4c 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04  I0LPC0BCMDp..\/.
  04f0: 5f 53 42 5f 50 43 49 30 4c 50 43 30 53 4d 49 43  _SB_PCI0LPC0SMIC
  0500: 70 0a e3 50 38 30 48 a0 1f 93 68 0a 04 70 0a 01  p..P80H...h..p..
  0510: 5c 2e 5f 53 42 5f 4f 4b 45 43 86 5c 2e 5f 53 42  \._SB_OKEC.\._SB
  0520: 5f 53 4c 50 42 0a 02 a0 42 0e 93 87 5c 5f 4f 53  _SLPB...B...\_OS
  0530: 5f 0a 14 70 0a e4 50 38 30 48 70 5c 2f 04 5f 53  _..p..P80Hp\/._S
  0540: 42 5f 50 43 49 30 4c 50 43 30 52 42 49 44 60 70  B_PCI0LPC0RBID`p
  0550: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44 45 30 42  \/._SB_PCI0IDE0B
  0560: 41 59 52 61 70 60 5c 2f 04 5f 53 42 5f 50 43 49  AYRap`\/._SB_PCI
  0570: 30 49 44 45 30 42 41 59 52 a0 43 06 92 93 60 61  0IDE0BAYR.C...`a
  0580: a0 4c 05 7d 93 61 0a 01 93 61 0a 02 00 a0 33 7b  .L.}.a...a....3{
  0590: 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53  .\/._SB_PCI0MYOS
  05a0: 0a 03 93 60 0a 03 00 86 5c 2f 05 5f 53 42 5f 50  ...`....\/._SB_P
  05b0: 43 49 30 49 44 45 30 53 45 43 4e 42 41 59 31 0a  CI0IDE0SECNBAY1.
  05c0: 03 a1 1b 86 5c 2f 05 5f 53 42 5f 50 43 49 30 49  ....\/._SB_PCI0I
  05d0: 44 45 30 53 45 43 4e 42 41 59 31 0a 01 a0 25 7d  DE0SECNBAY1...%}
  05e0: 93 60 0a 01 93 60 0a 02 00 86 5c 2f 05 5f 53 42  .`...`....\/._SB
  05f0: 5f 50 43 49 30 49 44 45 30 53 45 43 4e 42 41 59  _PCI0IDE0SECNBAY
  0600: 31 0a 00 70 0a e5 50 38 30 48 a0 31 93 87 5c 5f  1..p..P80H.1..\_
  0610: 4f 53 5f 0a 27 86 5c 2e 5f 53 42 5f 42 41 54 31  OS_.'.\._SB_BAT1
  0620: 0a 80 86 5c 2e 5f 53 42 5f 42 41 54 32 0a 80 86  ...\._SB_BAT2...
  0630: 5c 2e 5f 53 42 5f 41 43 41 44 0a 00 70 5c 2f 05  \._SB_ACAD..p\/.
  0640: 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f  _SB_PCI0LPC0EC0_
  0650: 41 43 44 46 5c 2e 5f 53 42 5f 41 43 53 54 a0 17  ACDF\._SB_ACST..
  0660: 93 87 5c 5f 4f 53 5f 0a 11 86 5c 2e 5f 53 42 5f  ..\_OS_...\._SB_
  0670: 53 4c 50 42 0a 02 70 0a 00 5c 2e 5f 53 42 5f 53  SLPB..p..\._SB_S
  0680: 4c 45 45 10 44 0c 5f 47 50 45 14 18 5f 4c 30 35  LEE.D._GPE.._L05
  0690: 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 44 4d  ..\/._SB_PCI0MDM
  06a0: 30 0a 02 14 4e 04 5f 4c 30 42 00 86 5c 2f 03 5f  0...N._L0B..\/._
  06b0: 53 42 5f 50 43 49 30 50 43 49 42 0a 00 a0 34 7d  SB_PCI0PCIB...4}
  06c0: 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53  .\/._SB_PCI0MYOS
  06d0: 0a 01 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59  ...\/._SB_PCI0MY
  06e0: 4f 53 0a 03 00 86 5c 2e 5f 53 42 5f 53 4c 50 42  OS....\._SB_SLPB
  06f0: 0a 02 14 18 5f 4c 30 33 00 86 5c 2f 03 5f 53 42  ...._L03..\/._SB
  0700: 5f 50 43 49 30 55 53 42 31 0a 02 14 18 5f 4c 30  _PCI0USB1...._L0
  0710: 34 00 86 5c 2f 03 5f 53 42 5f 50 43 49 30 55 53  4..\/._SB_PCI0US
  0720: 42 32 0a 02 14 18 5f 4c 30 43 00 86 5c 2f 03 5f  B2...._L0C..\/._
  0730: 53 42 5f 50 43 49 30 55 53 42 33 0a 02 14 0a 5f  SB_PCI0USB3...._
  0740: 45 31 38 00 5b 22 0a 01 10 89 4c 06 5f 53 42 5f  E18.["....L._SB_
  0750: 08 53 54 41 54 0a 00 08 44 31 53 54 0a 00 08 44  .STAT...D1ST...D
  0760: 31 53 4a 0a 01 08 4f 4b 45 43 0a 00 5b 82 82 06  1SJ...OKEC..[...
  0770: 05 50 43 49 30 08 4d 59 4f 53 0a 02 14 40 0d 5f  .PCI0.MYOS...@._
  0780: 49 4e 49 00 70 0a 01 5c 2e 5f 53 42 5f 44 31 53  INI.p..\._SB_D1S
  0790: 4a 70 0a 02 4d 59 4f 53 a0 41 06 93 87 5c 5f 4f  Jp..MYOS.A...\_O
  07a0: 53 5f 0a 14 70 0a 01 4d 59 4f 53 70 0b d0 07 4f  S_..p..MYOSp...O
  07b0: 53 59 53 70 0a 01 5c 2e 5f 53 42 5f 57 32 4b 46  SYSp..\._SB_W2KF
  07c0: a0 39 5b 12 5f 4f 53 49 60 a0 30 5c 5f 4f 53 49  .9[._OSI`.0\_OSI
  07d0: 0d 57 69 6e 64 6f 77 73 20 32 30 30 31 00 70 0a  .Windows 2001.p.
  07e0: 03 4d 59 4f 53 70 0b d1 07 4f 53 59 53 70 0a 03  .MYOSp...OSYSp..
  07f0: 5c 2e 5f 53 42 5f 57 32 4b 46 a1 42 05 a0 26 93  \._SB_W2KF.B..&.
  0800: 87 5c 5f 4f 53 5f 0a 11 70 0a 00 4d 59 4f 53 70  .\_OS_..p..MYOSp
  0810: 0b ce 07 4f 53 59 53 70 0a 00 5c 2e 5f 53 42 5f  ...OSYSp..\._SB_
  0820: 57 32 4b 46 a1 28 a0 26 93 87 5c 5f 4f 53 5f 0a  W2KF.(.&..\_OS_.
  0830: 27 70 0a 02 4d 59 4f 53 70 0b cf 07 4f 53 59 53  'p..MYOSp...OSYS
  0840: 70 0a 02 5c 2e 5f 53 42 5f 57 32 4b 46 08 5f 48  p..\._SB_W2KF._H
  0850: 49 44 0c 41 d0 0a 03 08 5f 41 44 52 0a 00 08 5f  ID.A...._ADR..._
  0860: 42 42 4e 0a 00 5b 80 48 42 55 53 02 0a 40 0a c0  BBN..[.HBUS..@..
  0870: 5b 81 4e 06 48 42 55 53 03 00 40 0c 00 07 48 45  [.N.HBUS..@...HE
  0880: 4e 41 01 00 04 50 4d 30 48 02 00 02 50 4d 31 4c  NA...PM0H...PM1L
  0890: 02 00 02 50 4d 31 48 02 00 02 50 4d 32 4c 02 00  ...PM1H...PM2L..
  08a0: 02 50 4d 32 48 02 00 02 50 4d 33 4c 02 00 02 50  .PM2H...PM3L...P
  08b0: 4d 33 48 02 00 02 50 4d 34 4c 02 00 02 50 4d 34  M3H...PM4L...PM4
  08c0: 48 02 00 02 50 4d 35 4c 02 00 02 50 4d 35 48 02  H...PM5L...PM5H.
  08d0: 00 02 50 4d 36 4c 02 00 02 50 4d 36 48 02 00 02  ..PM6L...PM6H...
  08e0: 08 42 55 46 30 11 46 20 0b 01 02 88 0e 00 02 0c  .BUF0.F ........
  08f0: 00 00 00 00 00 ff 00 00 00 00 01 00 87 18 00 01  ................
  0900: 0c 03 00 00 00 00 00 00 00 00 f7 0c 00 00 00 00  ................
  0910: 00 00 f8 0c 00 00 00 47 01 f8 0c f8 0c 01 08 87  .......G........
  0920: 18 00 01 0c 03 00 00 00 00 00 0d 00 00 ff ff 00  ................
  0930: 00 00 00 00 00 00 f3 00 00 00 87 18 00 00 0c 03  ................
  0940: 00 00 00 00 00 00 0a 00 ff ff 0b 00 00 00 00 00  ................
  0950: 00 00 02 00 00 87 18 00 00 0c 03 00 00 00 00 00  ................
  0960: 00 0c 00 ff 3f 0c 00 00 00 00 00 00 40 00 00 00  ....?.......@...
  0970: 87 18 00 00 0c 03 00 00 00 00 00 40 0c 00 ff 7f  ...........@....
  0980: 0c 00 00 00 00 00 00 40 00 00 00 87 18 00 00 0c  .......@........
  0990: 03 00 00 00 00 00 80 0c 00 ff bf 0c 00 00 00 00  ................
  09a0: 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00 00  ..@.............
  09b0: 00 c0 0c 00 ff ff 0c 00 00 00 00 00 00 40 00 00  .............@..
  09c0: 00 87 18 00 00 0c 03 00 00 00 00 00 00 0d 00 ff  ................
  09d0: 3f 0d 00 00 00 00 00 00 40 00 00 00 87 18 00 00  ?.......@.......
  09e0: 0c 03 00 00 00 00 00 40 0d 00 ff 7f 0d 00 00 00  .......@........
  09f0: 00 00 00 40 00 00 00 87 18 00 00 0c 03 00 00 00  ...@............
  0a00: 00 00 80 0d 00 ff bf 0d 00 00 00 00 00 00 40 00  ..............@.
  0a10: 00 00 87 18 00 00 0c 03 00 00 00 00 00 c0 0d 00  ................
  0a20: ff ff 0d 00 00 00 00 00 00 40 00 00 00 87 18 00  .........@......
  0a30: 00 0c 03 00 00 00 00 00 00 0e 00 ff 3f 0e 00 00  ............?...
  0a40: 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00 00  ....@...........
  0a50: 00 00 00 40 0e 00 ff 7f 0e 00 00 00 00 00 00 40  ...@...........@
  0a60: 00 00 00 87 18 00 00 0c 03 00 00 00 00 00 80 0e  ................
  0a70: 00 ff bf 0e 00 00 00 00 00 00 40 00 00 00 87 18  ..........@.....
  0a80: 00 00 0c 03 00 00 00 00 00 c0 0e 00 ff ff 0e 00  ................
  0a90: 00 00 00 00 00 40 00 00 00 87 18 00 00 0c 03 00  .....@..........
  0aa0: 00 00 00 00 00 0f 00 ff ff 0f 00 00 00 00 00 00  ................
  0ab0: 00 01 00 00 87 18 00 00 0c 03 00 00 00 00 00 00  ................
  0ac0: 00 00 ff ff bf fe 00 00 00 00 00 00 00 00 00 87  ................
  0ad0: 18 00 00 0c 03 00 00 00 00 00 00 00 00 00 00 00  ................
  0ae0: 00 00 00 00 00 00 00 00 00 00 79 00 14 42 3a 5f  ..........y..B:_
  0af0: 43 52 53 08 a0 16 50 4d 31 4c 8a 42 55 46 30 0a  CRS...PM1L.BUF0.
  0b00: 80 43 30 4c 4e 70 00 43 30 4c 4e a0 1a 93 50 4d  .C0LNp.C0LN...PM
  0b10: 31 4c 0a 01 8d 42 55 46 30 0b 78 03 43 30 52 57  1L...BUF0.x.C0RW
  0b20: 70 00 43 30 52 57 a0 16 50 4d 31 48 8a 42 55 46  p.C0RW..PM1H.BUF
  0b30: 30 0a 9b 43 34 4c 4e 70 00 43 34 4c 4e a0 1a 93  0..C4LNp.C4LN...
  0b40: 50 4d 31 48 0a 01 8d 42 55 46 30 0b 50 04 43 34  PM1H...BUF0.P.C4
  0b50: 52 57 70 00 43 34 52 57 a0 16 50 4d 32 4c 8a 42  RWp.C4RW..PM2L.B
  0b60: 55 46 30 0a b6 43 38 4c 4e 70 00 43 38 4c 4e a0  UF0..C8LNp.C8LN.
  0b70: 1a 93 50 4d 32 4c 0a 01 8d 42 55 46 30 0b 28 05  ..PM2L...BUF0.(.
  0b80: 43 38 52 57 70 00 43 38 52 57 a0 16 50 4d 32 48  C8RWp.C8RW..PM2H
  0b90: 8a 42 55 46 30 0a d1 43 43 4c 4e 70 00 43 43 4c  .BUF0..CCLNp.CCL
  0ba0: 4e a0 1a 93 50 4d 32 48 0a 01 8d 42 55 46 30 0b  N...PM2H...BUF0.
  0bb0: 00 06 43 43 52 57 70 00 43 43 52 57 a0 16 50 4d  ..CCRWp.CCRW..PM
  0bc0: 33 4c 8a 42 55 46 30 0a ec 44 30 4c 4e 70 00 44  3L.BUF0..D0LNp.D
  0bd0: 30 4c 4e a0 1a 93 50 4d 33 4c 0a 01 8d 42 55 46  0LN...PM3L...BUF
  0be0: 30 0b d8 06 44 30 52 57 70 00 44 30 52 57 a0 17  0...D0RWp.D0RW..
  0bf0: 50 4d 33 48 8a 42 55 46 30 0b 07 01 44 34 4c 4e  PM3H.BUF0...D4LN
  0c00: 70 00 44 34 4c 4e a0 1a 93 50 4d 33 48 0a 01 8d  p.D4LN...PM3H...
  0c10: 42 55 46 30 0b b0 07 44 34 52 57 70 00 44 34 52  BUF0...D4RWp.D4R
  0c20: 57 a0 17 50 4d 34 4c 8a 42 55 46 30 0b 22 01 44  W..PM4L.BUF0.".D
  0c30: 38 4c 4e 70 00 44 38 4c 4e a0 1a 93 50 4d 34 4c  8LNp.D8LN...PM4L
  0c40: 0a 01 8d 42 55 46 30 0b 88 08 44 38 52 57 70 00  ...BUF0...D8RWp.
  0c50: 44 38 52 57 a0 17 50 4d 34 48 8a 42 55 46 30 0b  D8RW..PM4H.BUF0.
  0c60: 3d 01 44 43 4c 4e 70 00 44 43 4c 4e a0 1a 93 50  =.DCLNp.DCLN...P
  0c70: 4d 34 48 0a 01 8d 42 55 46 30 0b 60 09 44 43 52  M4H...BUF0.`.DCR
  0c80: 57 70 00 44 43 52 57 a0 17 50 4d 35 4c 8a 42 55  Wp.DCRW..PM5L.BU
  0c90: 46 30 0b 58 01 45 30 4c 4e 70 00 45 30 4c 4e a0  F0.X.E0LNp.E0LN.
  0ca0: 1a 93 50 4d 35 4c 0a 01 8d 42 55 46 30 0b 38 0a  ..PM5L...BUF0.8.
  0cb0: 45 30 52 57 70 00 45 30 52 57 a0 17 50 4d 35 48  E0RWp.E0RW..PM5H
  0cc0: 8a 42 55 46 30 0b 73 01 45 34 4c 4e 70 00 45 34  .BUF0.s.E4LNp.E4
  0cd0: 4c 4e a0 1a 93 50 4d 35 48 0a 01 8d 42 55 46 30  LN...PM5H...BUF0
  0ce0: 0b 10 0b 45 34 52 57 70 00 45 34 52 57 a0 17 50  ...E4RWp.E4RW..P
  0cf0: 4d 36 4c 8a 42 55 46 30 0b 8e 01 45 38 4c 4e 70  M6L.BUF0...E8LNp
  0d00: 00 45 38 4c 4e a0 1a 93 50 4d 36 4c 0a 01 8d 42  .E8LN...PM6L...B
  0d10: 55 46 30 0b e8 0b 45 38 52 57 70 00 45 38 52 57  UF0...E8RWp.E8RW
  0d20: a0 17 50 4d 36 48 8a 42 55 46 30 0b a9 01 45 43  ..PM6H.BUF0...EC
  0d30: 4c 4e 70 00 45 43 4c 4e a0 1a 93 50 4d 36 48 0a  LNp.ECLN...PM6H.
  0d40: 01 8d 42 55 46 30 0b c0 0c 45 43 52 57 70 00 45  ..BUF0...ECRWp.E
  0d50: 43 52 57 a0 17 50 4d 30 48 8a 42 55 46 30 0b c4  CRW..PM0H.BUF0..
  0d60: 01 46 30 4c 4e 70 00 46 30 4c 4e a0 1a 93 50 4d  .F0LNp.F0LN...PM
  0d70: 30 48 0a 01 8d 42 55 46 30 0b 98 0d 46 30 52 57  0H...BUF0...F0RW
  0d80: 70 00 46 30 52 57 8a 42 55 46 30 0b d3 01 4d 31  p.F0RW.BUF0...M1
  0d90: 4d 4e 8a 42 55 46 30 0b d7 01 4d 31 4d 58 8a 42  MN.BUF0...M1MX.B
  0da0: 55 46 30 0b df 01 4d 31 4c 4e 77 0c 00 00 00 02  UF0...M1LNw.....
  0db0: 5c 2f 04 5f 53 42 5f 50 43 49 30 4d 42 55 53 44  \/._SB_PCI0MBUSD
  0dc0: 52 42 33 4d 31 4d 4e 72 74 4d 31 4d 58 4d 31 4d  RB3M1MNrtM1MXM1M
  0dd0: 4e 00 0a 01 4d 31 4c 4e 7a 7b 5c 2f 04 5f 53 42  N...M1LNz{\/._SB
  0de0: 5f 50 43 49 30 4c 50 43 30 4d 54 53 45 0b 80 03  _PCI0LPC0MTSE...
  0df0: 00 0a 07 60 a0 45 09 7b 60 0a 04 00 8a 42 55 46  ...`.E.{`....BUF
  0e00: 30 0b ee 01 4d 32 4d 4e 8a 42 55 46 30 0b f2 01  0...M2MN.BUF0...
  0e10: 4d 32 4d 58 8a 42 55 46 30 0b fa 01 4d 32 4c 4e  M2MX.BUF0...M2LN
  0e20: 70 0c 00 00 d0 fe 4d 32 4d 4e 70 0c ff 03 d0 fe  p.....M2MNp.....
  0e30: 4d 32 4d 58 70 0b 00 04 4d 32 4c 4e a0 19 93 60  M2MXp...M2LN...`
  0e40: 0a 05 70 0c 00 10 d0 fe 4d 32 4d 4e 70 0c ff 13  ..p.....M2MNp...
  0e50: d0 fe 4d 32 4d 58 a0 19 93 60 0a 06 70 0c 00 20  ..M2MX...`..p.. 
  0e60: d0 fe 4d 32 4d 4e 70 0c ff 23 d0 fe 4d 32 4d 58  ..M2MNp..#..M2MX
  0e70: a0 19 93 60 0a 07 70 0c 00 30 d0 fe 4d 32 4d 4e  ...`..p..0..M2MN
  0e80: 70 0c ff 33 d0 fe 4d 32 4d 58 a4 42 55 46 30 14  p..3..M2MX.BUF0.
  0e90: 45 0e 5f 50 52 54 00 a4 12 4c 0d 07 12 1e 04 0c  E._PRT...L......
  0ea0: ff ff 01 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49  ......\/._SB_PCI
  0eb0: 30 4c 50 43 30 4c 4e 4b 41 0a 00 12 1e 04 0c ff  0LPC0LNKA.......
  0ec0: ff 1d 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  0ed0: 4c 50 43 30 4c 4e 4b 41 0a 00 12 1e 04 0c ff ff  LPC0LNKA........
  0ee0: 1d 00 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  0ef0: 50 43 30 4c 4e 4b 44 0a 00 12 1e 04 0c ff ff 1d  PC0LNKD.........
  0f00: 00 0a 02 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  ...\/._SB_PCI0LP
  0f10: 43 30 4c 4e 4b 43 0a 00 12 1e 04 0c ff ff 1d 00  C0LNKC..........
  0f20: 0a 03 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  0f30: 30 4c 4e 4b 48 0a 00 12 1e 04 0c ff ff 1f 00 0a  0LNKH...........
  0f40: 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  0f50: 4c 4e 4b 43 0a 00 12 1e 04 0c ff ff 1f 00 0a 01  LNKC............
  0f60: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c  \/._SB_PCI0LPC0L
  0f70: 4e 4b 42 0a 00 5b 82 33 4d 42 55 53 08 5f 41 44  NKB..[.3MBUS._AD
  0f80: 52 0a 01 5b 80 4d 42 55 53 02 0a 40 0a c0 5b 81  R..[.MBUS..@..[.
  0f90: 1a 4d 42 55 53 03 44 52 42 30 08 44 52 42 31 08  .MBUS.DRB0.DRB1.
  0fa0: 44 52 42 32 08 44 52 42 33 08 5b 82 4c 9b 41 47  DRB2.DRB3.[.L.AG
  0fb0: 50 5f 08 5f 41 44 52 0c 00 00 01 00 08 5f 50 52  P_._ADR......_PR
  0fc0: 54 12 1f 01 12 1c 04 0b ff ff 0a 00 5c 2f 04 5f  T...........\/._
  0fd0: 53 42 5f 50 43 49 30 4c 50 43 30 4c 4e 4b 41 0a  SB_PCI0LPC0LNKA.
  0fe0: 00 5b 82 45 98 56 47 41 5f 08 5f 41 44 52 0a 00  .[.E.VGA_._ADR..
  0ff0: 08 53 57 49 54 0a 01 08 43 52 54 41 0a 00 08 4c  .SWIT...CRTA...L
  1000: 43 44 41 0a 01 08 54 56 30 41 0a 00 08 44 56 49  CDA...TV0A...DVI
  1010: 41 0a 00 08 54 4f 47 46 0a 00 08 4c 53 54 46 0a  A...TOGF...LSTF.
  1020: 00 08 57 44 41 53 0a 01 14 09 5f 53 54 41 00 a4  ..WDAS...._STA..
  1030: 0a 0f 08 5f 50 53 43 0a 00 08 55 53 42 46 0a 00  ..._PSC...USBF..
  1040: 14 0d 5f 50 53 30 00 70 0a 00 5f 50 53 43 14 0d  .._PS0.p.._PSC..
  1050: 5f 50 53 33 00 70 0a 03 5f 50 53 43 14 10 5f 44  _PS3.p.._PSC.._D
  1060: 4f 53 01 70 7b 68 0a 03 00 53 57 49 54 14 1e 5f  OS.p{h...SWIT.._
  1070: 44 4f 44 00 a4 12 16 04 0c 00 01 01 00 0c 10 01  DOD.............
  1080: 01 00 0c 00 02 01 00 0c 10 02 01 00 5b 82 4e 04  ............[.N.
  1090: 43 52 54 5f 08 5f 41 44 52 0b 00 01 14 14 5f 44  CRT_._ADR....._D
  10a0: 43 53 00 a0 08 43 52 54 41 a4 0a 1f a1 04 a4 0a  CS...CRTA.......
  10b0: 1d 14 14 5f 44 47 53 00 a0 08 43 52 54 41 a4 0a  ..._DGS...CRTA..
  10c0: 01 a1 04 a4 0a 00 14 15 5f 44 53 53 01 70 0d 43  ........_DSS.p.C
  10d0: 52 54 20 2d 2d 5f 44 53 53 00 5b 31 5b 82 4e 04  RT --_DSS.[1[.N.
  10e0: 44 56 49 5f 08 5f 41 44 52 0b 10 02 14 14 5f 44  DVI_._ADR....._D
  10f0: 43 53 00 a0 08 44 56 49 41 a4 0a 1f a1 04 a4 0a  CS...DVIA.......
  1100: 1d 14 14 5f 44 47 53 00 a0 08 44 56 49 41 a4 0a  ..._DGS...DVIA..
  1110: 01 a1 04 a4 0a 00 14 15 5f 44 53 53 01 70 0d 44  ........_DSS.p.D
  1120: 56 49 20 2d 2d 5f 44 53 53 00 5b 31 5b 82 4d 04  VI --_DSS.[1[.M.
  1130: 54 56 30 5f 08 5f 41 44 52 0b 00 02 14 14 5f 44  TV0_._ADR....._D
  1140: 43 53 00 a0 08 54 56 30 41 a4 0a 1f a1 04 a4 0a  CS...TV0A.......
  1150: 1d 14 14 5f 44 47 53 00 a0 08 54 56 30 41 a4 0a  ..._DGS...TV0A..
  1160: 01 a1 04 a4 0a 00 14 14 5f 44 53 53 01 70 0d 54  ........_DSS.p.T
  1170: 56 20 2d 2d 5f 44 53 53 00 5b 31 5b 82 44 05 4c  V --_DSS.[1[.D.L
  1180: 43 44 5f 08 5f 41 44 52 0b 10 01 14 14 5f 44 43  CD_._ADR....._DC
  1190: 53 00 a0 08 4c 43 44 41 a4 0a 1f a1 04 a4 0a 1d  S...LCDA........
  11a0: 14 1a 5f 44 47 53 00 70 4c 43 44 41 60 a0 08 4c  .._DGS.pLCDA`..L
  11b0: 43 44 41 a4 0a 01 a1 04 a4 0a 00 14 15 5f 44 53  CDA.........._DS
  11c0: 53 01 70 0d 4c 43 44 20 2d 2d 5f 44 53 53 00 5b  S.p.LCD --_DSS.[
  11d0: 31 14 40 54 53 57 49 48 00 70 0a 97 5c 2f 04 5f  1.-7g1mw+NsIEfhvxM+mQhndA@public.gmane.org\/._
  11e0: 53 42 5f 50 43 49 30 4c 50 43 30 42 43 4d 44 70  SB_PCI0LPC0BCMDp
  11f0: 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  1200: 30 53 4d 49 43 70 5c 2e 5f 53 42 5f 44 41 54 53  0SMICp\._SB_DATS
  1210: 57 44 41 53 70 57 44 41 53 50 38 30 48 47 45 54  WDASpWDASP80HGET
  1220: 44 a0 43 12 93 57 44 41 53 0a 0f 75 54 4f 47 46  D.C..WDAS..uTOGF
  1230: a0 0f 94 54 4f 47 46 0a 07 70 0a 01 54 4f 47 46  ...TOGF..p..TOGF
  1240: 70 54 4f 47 46 61 a0 21 93 61 0a 01 70 0a 01 4c  pTOGFa.!.a..p..L
  1250: 43 44 41 70 0a 00 43 52 54 41 70 0a 00 54 56 30  CDAp..CRTAp..TV0
  1260: 41 70 0a 00 44 56 49 41 a1 4c 0d a0 21 93 61 0a  Ap..DVIA.L..!.a.
  1270: 02 70 0a 01 4c 43 44 41 70 0a 01 43 52 54 41 70  .p..LCDAp..CRTAp
  1280: 0a 00 54 56 30 41 70 0a 00 44 56 49 41 a1 47 0b  ..TV0Ap..DVIA.G.
  1290: a0 21 93 61 0a 03 70 0a 01 4c 43 44 41 70 0a 00  .!.a..p..LCDAp..
  12a0: 43 52 54 41 70 0a 00 54 56 30 41 70 0a 01 44 56  CRTAp..TV0Ap..DV
  12b0: 49 41 a1 42 09 a0 21 93 61 0a 04 70 0a 01 4c 43  IA.B..!.a..p..LC
  12c0: 44 41 70 0a 00 43 52 54 41 70 0a 01 54 56 30 41  DAp..CRTAp..TV0A
  12d0: 70 0a 00 44 56 49 41 a1 4d 06 a0 21 93 61 0a 05  p..DVIA.M..!.a..
  12e0: 70 0a 00 4c 43 44 41 70 0a 01 43 52 54 41 70 0a  p..LCDAp..CRTAp.
  12f0: 00 54 56 30 41 70 0a 00 44 56 49 41 a1 48 04 a0  .TV0Ap..DVIA.H..
  1300: 21 93 61 0a 06 70 0a 00 4c 43 44 41 70 0a 00 43  !.a..p..LCDAp..C
  1310: 52 54 41 70 0a 00 54 56 30 41 70 0a 01 44 56 49  RTAp..TV0Ap..DVI
  1320: 41 a1 23 a0 21 93 61 0a 07 70 0a 00 4c 43 44 41  A.#.!.a..p..LCDA
  1330: 70 0a 00 43 52 54 41 70 0a 01 54 56 30 41 70 0a  p..CRTAp..TV0Ap.
  1340: 00 44 56 49 41 a0 49 0d 93 57 44 41 53 0a 0d 75  .DVIA.I..WDAS..u
  1350: 54 4f 47 46 a0 0f 94 54 4f 47 46 0a 05 70 0a 01  TOGF...TOGF..p..
  1360: 54 4f 47 46 70 54 4f 47 46 61 a0 21 93 61 0a 01  TOGFpTOGFa.!.a..
  1370: 70 0a 01 4c 43 44 41 70 0a 00 43 52 54 41 70 0a  p..LCDAp..CRTAp.
  1380: 00 54 56 30 41 70 0a 00 44 56 49 41 a1 42 09 a0  .TV0Ap..DVIA.B..
  1390: 21 93 61 0a 02 70 0a 01 4c 43 44 41 70 0a 00 43  !.a..p..LCDAp..C
  13a0: 52 54 41 70 0a 00 54 56 30 41 70 0a 01 44 56 49  RTAp..TV0Ap..DVI
  13b0: 41 a1 4d 06 a0 21 93 61 0a 03 70 0a 01 4c 43 44  A.M..!.a..p..LCD
  13c0: 41 70 0a 00 43 52 54 41 70 0a 01 54 56 30 41 70  Ap..CRTAp..TV0Ap
  13d0: 0a 00 44 56 49 41 a1 48 04 a0 21 93 61 0a 04 70  ..DVIA.H..!.a..p
  13e0: 0a 00 4c 43 44 41 70 0a 00 43 52 54 41 70 0a 00  ..LCDAp..CRTAp..
  13f0: 54 56 30 41 70 0a 01 44 56 49 41 a1 23 a0 21 93  TV0Ap..DVIA.#.!.
  1400: 61 0a 05 70 0a 00 4c 43 44 41 70 0a 00 43 52 54  a..p..LCDAp..CRT
  1410: 41 70 0a 01 54 56 30 41 70 0a 00 44 56 49 41 a0  Ap..TV0Ap..DVIA.
  1420: 49 0d 93 57 44 41 53 0a 0b 75 54 4f 47 46 a0 0f  I..WDAS..uTOGF..
  1430: 94 54 4f 47 46 0a 05 70 0a 01 54 4f 47 46 70 54  .TOGF..p..TOGFpT
  1440: 4f 47 46 61 a0 21 93 61 0a 01 70 0a 01 4c 43 44  OGFa.!.a..p..LCD
  1450: 41 70 0a 00 43 52 54 41 70 0a 00 54 56 30 41 70  Ap..CRTAp..TV0Ap
  1460: 0a 00 44 56 49 41 a1 42 09 a0 21 93 61 0a 02 70  ..DVIA.B..!.a..p
  1470: 0a 01 4c 43 44 41 70 0a 01 43 52 54 41 70 0a 00  ..LCDAp..CRTAp..
  1480: 54 56 30 41 70 0a 00 44 56 49 41 a1 4d 06 a0 21  TV0Ap..DVIA.M..!
  1490: 93 61 0a 03 70 0a 01 4c 43 44 41 70 0a 00 43 52  .a..p..LCDAp..CR
  14a0: 54 41 70 0a 00 54 56 30 41 70 0a 01 44 56 49 41  TAp..TV0Ap..DVIA
  14b0: a1 48 04 a0 21 93 61 0a 04 70 0a 00 4c 43 44 41  .H..!.a..p..LCDA
  14c0: 70 0a 01 43 52 54 41 70 0a 00 54 56 30 41 70 0a  p..CRTAp..TV0Ap.
  14d0: 00 44 56 49 41 a1 23 a0 21 93 61 0a 05 70 0a 00  .DVIA.#.!.a..p..
  14e0: 4c 43 44 41 70 0a 00 43 52 54 41 70 0a 00 54 56  LCDAp..CRTAp..TV
  14f0: 30 41 70 0a 01 44 56 49 41 a0 4f 08 93 57 44 41  0Ap..DVIA.O..WDA
  1500: 53 0a 09 75 54 4f 47 46 a0 0f 94 54 4f 47 46 0a  S..uTOGF...TOGF.
  1510: 03 70 0a 01 54 4f 47 46 70 54 4f 47 46 61 a0 21  .p..TOGFpTOGFa.!
  1520: 93 61 0a 01 70 0a 01 4c 43 44 41 70 0a 00 43 52  .a..p..LCDAp..CR
  1530: 54 41 70 0a 00 54 56 30 41 70 0a 00 44 56 49 41  TAp..TV0Ap..DVIA
  1540: a1 48 04 a0 21 93 61 0a 02 70 0a 01 4c 43 44 41  .H..!.a..p..LCDA
  1550: 70 0a 00 43 52 54 41 70 0a 00 54 56 30 41 70 0a  p..CRTAp..TV0Ap.
  1560: 01 44 56 49 41 a1 23 a0 21 93 61 0a 03 70 0a 00  .DVIA.#.!.a..p..
  1570: 4c 43 44 41 70 0a 00 43 52 54 41 70 0a 00 54 56  LCDAp..CRTAp..TV
  1580: 30 41 70 0a 01 44 56 49 41 a0 41 0e 91 93 57 44  0Ap..DVIA.A...WD
  1590: 41 53 0a 05 93 57 44 41 53 0a 07 75 54 4f 47 46  AS...WDAS..uTOGF
  15a0: a0 0f 94 54 4f 47 46 0a 05 70 0a 01 54 4f 47 46  ...TOGF..p..TOGF
  15b0: 70 54 4f 47 46 61 a0 21 93 61 0a 01 70 0a 01 4c  pTOGFa.!.a..p..L
  15c0: 43 44 41 70 0a 00 43 52 54 41 70 0a 00 54 56 30  CDAp..CRTAp..TV0
  15d0: 41 70 0a 00 44 56 49 41 a1 42 09 a0 21 93 61 0a  Ap..DVIA.B..!.a.
  15e0: 02 70 0a 01 4c 43 44 41 70 0a 01 43 52 54 41 70  .p..LCDAp..CRTAp
  15f0: 0a 00 54 56 30 41 70 0a 00 44 56 49 41 a1 4d 06  ..TV0Ap..DVIA.M.
  1600: a0 21 93 61 0a 03 70 0a 01 4c 43 44 41 70 0a 00  .!.a..p..LCDAp..
  1610: 43 52 54 41 70 0a 01 54 56 30 41 70 0a 00 44 56  CRTAp..TV0Ap..DV
  1620: 49 41 a1 48 04 a0 21 93 61 0a 04 70 0a 00 4c 43  IA.H..!.a..p..LC
  1630: 44 41 70 0a 01 43 52 54 41 70 0a 00 54 56 30 41  DAp..CRTAp..TV0A
  1640: 70 0a 00 44 56 49 41 a1 23 a0 21 93 61 0a 05 70  p..DVIA.#.!.a..p
  1650: 0a 00 4c 43 44 41 70 0a 00 43 52 54 41 70 0a 01  ..LCDAp..CRTAp..
  1660: 54 56 30 41 70 0a 00 44 56 49 41 a0 40 09 92 94  TV0Ap..DVIA.@...
  1670: 57 44 41 53 0a 03 75 54 4f 47 46 a0 0f 94 54 4f  WDAS..uTOGF...TO
  1680: 47 46 0a 03 70 0a 01 54 4f 47 46 70 54 4f 47 46  GF..p..TOGFpTOGF
  1690: 61 a0 21 93 61 0a 01 70 0a 01 4c 43 44 41 70 0a  a.!.a..p..LCDAp.
  16a0: 00 43 52 54 41 70 0a 00 54 56 30 41 70 0a 00 44  .CRTAp..TV0Ap..D
  16b0: 56 49 41 a1 48 04 a0 21 93 61 0a 02 70 0a 01 4c  VIA.H..!.a..p..L
  16c0: 43 44 41 70 0a 01 43 52 54 41 70 0a 00 54 56 30  CDAp..CRTAp..TV0
  16d0: 41 70 0a 00 44 56 49 41 a1 23 a0 21 93 61 0a 03  Ap..DVIA.#.!.a..
  16e0: 70 0a 00 4c 43 44 41 70 0a 01 43 52 54 41 70 0a  p..LCDAp..CRTAp.
  16f0: 00 54 56 30 41 70 0a 00 44 56 49 41 86 5c 2f 04  .TV0Ap..DVIA.\/.
  1700: 5f 53 42 5f 50 43 49 30 41 47 50 5f 56 47 41 5f  _SB_PCI0AGP_VGA_
  1710: 0a 80 14 45 25 47 45 54 44 00 70 0a 98 5c 2f 04  ...E%GETD.p..\/.
  1720: 5f 53 42 5f 50 43 49 30 4c 50 43 30 42 43 4d 44  _SB_PCI0LPC0BCMD
  1730: 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  1740: 43 30 53 4d 49 43 70 5c 2e 5f 53 42 5f 44 49 53  C0SMICp\._SB_DIS
  1750: 44 60 a0 41 07 93 57 44 41 53 0a 0f a0 0c 93 60  D`.A..WDAS.....`
  1760: 0a 07 70 0a 07 54 4f 47 46 a0 0c 93 60 0a 06 70  ..p..TOGF...`..p
  1770: 0a 06 54 4f 47 46 a0 0c 93 60 0a 05 70 0a 05 54  ..TOGF...`..p..T
  1780: 4f 47 46 a0 0c 93 60 0a 04 70 0a 04 54 4f 47 46  OGF...`..p..TOGF
  1790: a0 0c 93 60 0a 03 70 0a 03 54 4f 47 46 a0 0c 93  ...`..p..TOGF...
  17a0: 60 0a 02 70 0a 02 54 4f 47 46 a0 0c 93 60 0a 01  `..p..TOGF...`..
  17b0: 70 0a 01 54 4f 47 46 a0 0c 93 60 0a 00 70 0a 00  p..TOGF...`..p..
  17c0: 54 4f 47 46 a0 47 05 93 57 44 41 53 0a 0d a0 0c  TOGF.G..WDAS....
  17d0: 93 60 0a 07 70 0a 05 54 4f 47 46 a0 0c 93 60 0a  .`..p..TOGF...`.
  17e0: 06 70 0a 04 54 4f 47 46 a0 0c 93 60 0a 04 70 0a  .p..TOGF...`..p.
  17f0: 03 54 4f 47 46 a0 0c 93 60 0a 03 70 0a 02 54 4f  .TOGF...`..p..TO
  1800: 47 46 a0 0c 93 60 0a 01 70 0a 01 54 4f 47 46 a0  GF...`..p..TOGF.
  1810: 0c 93 60 0a 00 70 0a 00 54 4f 47 46 a0 47 05 93  ..`..p..TOGF.G..
  1820: 57 44 41 53 0a 0b a0 0c 93 60 0a 06 70 0a 05 54  WDAS.....`..p..T
  1830: 4f 47 46 a0 0c 93 60 0a 05 70 0a 04 54 4f 47 46  OGF...`..p..TOGF
  1840: a0 0c 93 60 0a 03 70 0a 03 54 4f 47 46 a0 0c 93  ...`..p..TOGF...
  1850: 60 0a 02 70 0a 02 54 4f 47 46 a0 0c 93 60 0a 01  `..p..TOGF...`..
  1860: 70 0a 01 54 4f 47 46 a0 0c 93 60 0a 00 70 0a 00  p..TOGF...`..p..
  1870: 54 4f 47 46 a0 3c 93 57 44 41 53 0a 09 a0 0c 93  TOGF.<.WDAS.....
  1880: 60 0a 06 70 0a 03 54 4f 47 46 a0 0c 93 60 0a 03  `..p..TOGF...`..
  1890: 70 0a 02 54 4f 47 46 a0 0c 93 60 0a 01 70 0a 01  p..TOGF...`..p..
  18a0: 54 4f 47 46 a0 0c 93 60 0a 00 70 0a 00 54 4f 47  TOGF...`..p..TOG
  18b0: 46 a0 48 07 91 93 57 44 41 53 0a 05 93 57 44 41  F.H...WDAS...WDA
  18c0: 53 0a 07 a0 0c 93 60 0a 07 70 0a 05 54 4f 47 46  S.....`..p..TOGF
  18d0: a0 0c 93 60 0a 05 70 0a 04 54 4f 47 46 a0 0c 93  ...`..p..TOGF...
  18e0: 60 0a 04 70 0a 03 54 4f 47 46 a0 0c 93 60 0a 02  `..p..TOGF...`..
  18f0: 70 0a 02 54 4f 47 46 a0 0c 93 60 0a 01 70 0a 01  p..TOGF...`..p..
  1900: 54 4f 47 46 a0 0c 93 60 0a 00 70 0a 00 54 4f 47  TOGF...`..p..TOG
  1910: 46 a0 0f 93 54 4f 47 46 4c 53 54 46 75 54 4f 47  F...TOGFLSTFuTOG
  1920: 46 70 54 4f 47 46 4c 53 54 46 a0 3d 92 94 57 44  FpTOGFLSTF.=..WD
  1930: 41 53 0a 03 a0 0c 93 60 0a 05 70 0a 03 54 4f 47  AS.....`..p..TOG
  1940: 46 a0 0c 93 60 0a 02 70 0a 02 54 4f 47 46 a0 0c  F...`..p..TOGF..
  1950: 93 60 0a 01 70 0a 01 54 4f 47 46 a0 0c 93 60 0a  .`..p..TOGF...`.
  1960: 00 70 0a 00 54 4f 47 46 5b 82 4f 10 50 43 49 42  .p..TOGF[.O.PCIB
  1970: 08 5f 41 44 52 0c 00 00 1e 00 5b 82 1b 47 4c 41  ._ADR.....[..GLA
  1980: 4e 08 5f 41 44 52 0c 00 00 02 00 08 5f 50 52 57  N._ADR......_PRW
  1990: 12 06 02 0a 0b 0a 05 5b 82 1b 4d 50 43 49 08 5f  .......[..MPCI._
  19a0: 41 44 52 0c 00 00 04 00 08 5f 50 52 57 12 06 02  ADR......_PRW...
  19b0: 0a 0b 0a 04 5b 82 1b 54 33 39 34 08 5f 41 44 52  ....[..T394._ADR
  19c0: 0c 00 00 07 00 08 5f 50 52 57 12 06 02 0a 0b 0a  ......_PRW......
  19d0: 04 14 47 0a 5f 50 52 54 00 a4 12 4e 09 05 12 1e  ..G._PRT...N....
  19e0: 04 0c ff ff 02 00 0a 00 5c 2f 04 5f 53 42 5f 50  ........\/._SB_P
  19f0: 43 49 30 4c 50 43 30 4c 4e 4b 44 0a 00 12 1e 04  CI0LPC0LNKD.....
  1a00: 0c ff ff 04 00 0a 00 5c 2f 04 5f 53 42 5f 50 43  .......\/._SB_PC
  1a10: 49 30 4c 50 43 30 4c 4e 4b 45 0a 00 12 1e 04 0c  I0LPC0LNKE......
  1a20: ff ff 04 00 0a 01 5c 2f 04 5f 53 42 5f 50 43 49  ......\/._SB_PCI
  1a30: 30 4c 50 43 30 4c 4e 4b 46 0a 00 12 1e 04 0c ff  0LPC0LNKF.......
  1a40: ff 06 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  1a50: 4c 50 43 30 4c 4e 4b 43 0a 00 12 1e 04 0c ff ff  LPC0LNKC........
  1a60: 07 00 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ....\/._SB_PCI0L
  1a70: 50 43 30 4c 4e 4b 42 0a 00 5b 82 86 aa 02 4c 50  PC0LNKB..[....LP
  1a80: 43 30 08 5f 41 44 52 0c 00 00 1f 00 14 0a 44 45  C0._ADR.......DE
  1a90: 43 44 04 70 68 5b 31 5b 80 52 45 47 53 02 0a 40  CD.ph[1[.REGS..@
  1aa0: 0a c0 5b 81 48 05 52 45 47 53 03 50 4d 42 41 10  ..[.H.REGS.PMBA.
  1ab0: 00 40 0b 47 50 42 41 10 00 40 3b 50 4f 53 44 01  .@.GPBA..@;POSD.
  1ac0: 00 07 4d 54 53 45 10 00 08 00 40 06 43 4d 41 44  ..MTSE....@.CMAD
  1ad0: 03 00 01 43 4d 42 44 03 00 01 4c 50 54 44 02 00  ...CMBD...LPTD..
  1ae0: 02 46 44 44 44 01 00 23 45 43 4f 31 01 45 43 4f  .FDDD..#ECO1.ECO
  1af0: 32 01 45 4c 50 54 01 45 46 44 44 01 5b 80 50 49  2.ELPT.EFDD.[.PI
  1b00: 52 58 02 0a 60 0a 0c 5b 81 33 50 49 52 58 03 01  RX..`..[.3PIRX..
  1b10: 01 00 50 49 52 41 08 50 49 52 42 08 50 49 52 43  ..PIRA.PIRB.PIRC
  1b20: 08 50 49 52 44 08 00 20 50 49 52 45 08 50 49 52  .PIRD.. PIRE.PIR
  1b30: 46 08 50 49 52 47 08 50 49 52 48 08 5b 82 45 06  F.PIRG.PIRH.[.E.
  1b40: 54 49 4d 52 08 5f 48 49 44 0c 41 d0 01 00 08 42  TIMR._HID.A....B
  1b50: 55 46 30 11 15 0a 12 47 01 40 00 40 00 01 04 47  UF0....G.@.@...G
  1b60: 01 50 00 50 00 10 04 79 00 08 42 55 46 31 11 18  .P.P...y..BUF1..
  1b70: 0a 15 47 01 40 00 40 00 01 04 47 01 50 00 50 00  ..G.@.@...G.P.P.
  1b80: 10 04 22 01 00 79 00 14 1b 5f 43 52 53 08 a0 0f  .."..y..._CRS...
  1b90: 7b 4d 54 53 45 0b 00 02 00 a4 42 55 46 30 a4 42  {MTSE.....BUF0.B
  1ba0: 55 46 31 5b 82 45 0a 49 50 49 43 08 5f 48 49 44  UF1[.E.IPIC._HID
  1bb0: 0b 41 d0 08 5f 43 52 53 11 41 09 0a 8d 47 01 20  .A.._CRS.A...G. 
  1bc0: 00 20 00 01 02 47 01 24 00 24 00 01 02 47 01 28  . ...G.$.$...G.(
  1bd0: 00 28 00 01 02 47 01 2c 00 2c 00 01 02 47 01 30  .(...G.,.,...G.0
  1be0: 00 30 00 01 02 47 01 34 00 34 00 01 02 47 01 38  .0...G.4.4...G.8
  1bf0: 00 38 00 01 02 47 01 3c 00 3c 00 01 02 47 01 a0  .8...G.<.<...G..
  1c00: 00 a0 00 01 02 47 01 a4 00 a4 00 01 02 47 01 a8  .....G.......G..
  1c10: 00 a8 00 01 02 47 01 ac 00 ac 00 01 02 47 01 b0  .....G.......G..
  1c20: 00 b0 00 01 02 47 01 b4 00 b4 00 01 02 47 01 b8  .....G.......G..
  1c30: 00 b8 00 01 02 47 01 bc 00 bc 00 01 02 47 01 d0  .....G.......G..
  1c40: 04 d0 04 01 02 22 04 00 79 00 5b 82 45 05 52 54  ....."..y.[.E.RT
  1c50: 43 5f 08 5f 48 49 44 0c 41 d0 0b 00 08 42 55 46  C_._HID.A....BUF
  1c60: 30 11 0d 0a 0a 47 01 70 00 70 00 01 08 79 00 08  0....G.p.p...y..
  1c70: 42 55 46 31 11 10 0a 0d 47 01 70 00 70 00 01 08  BUF1....G.p.p...
  1c80: 22 00 01 79 00 14 1b 5f 43 52 53 08 a0 0f 7b 4d  "..y..._CRS...{M
  1c90: 54 53 45 0b 00 02 00 a4 42 55 46 30 a4 42 55 46  TSE.....BUF0.BUF
  1ca0: 31 5b 82 25 4d 41 54 48 08 5f 48 49 44 0c 41 d0  1[.%MATH._HID.A.
  1cb0: 0c 04 08 5f 43 52 53 11 10 0a 0d 47 01 f0 00 f0  ..._CRS....G....
  1cc0: 00 01 01 22 00 20 79 00 5b 82 46 04 44 4d 41 43  ...". y.[.F.DMAC
  1cd0: 08 5f 48 49 44 0c 41 d0 02 00 08 5f 43 52 53 11  ._HID.A...._CRS.
  1ce0: 30 0a 2d 47 01 00 00 00 00 01 20 47 01 81 00 81  0.-G...... G....
  1cf0: 00 01 0f 47 01 90 00 90 00 01 02 47 01 93 00 93  ...G.......G....
  1d00: 00 01 0d 47 01 c0 00 c0 00 01 20 2a 10 01 79 00  ...G...... *..y.
  1d10: 5b 82 40 1b 4d 42 52 44 08 5f 48 49 44 0c 41 d0  [.@.MBRD._HID.A.
  1d20: 0c 02 08 5f 55 49 44 0a 1f 08 5f 43 52 53 11 43  ..._UID..._CRS.C
  1d30: 19 0b 8e 01 47 01 10 00 10 00 01 10 47 01 24 00  ....G.......G.$.
  1d40: 24 00 01 02 47 01 28 00 28 00 01 02 47 01 2c 00  $...G.(.(...G.,.
  1d50: 2c 00 01 02 47 01 2e 00 2e 00 01 02 47 01 30 00  ,...G.......G.0.
  1d60: 30 00 01 02 47 01 34 00 34 00 01 02 47 01 38 00  0...G.4.4...G.8.
  1d70: 38 00 01 02 47 01 3c 00 3c 00 01 02 47 01 50 00  8...G.<.<...G.P.
  1d80: 50 00 01 04 47 01 61 00 61 00 01 01 47 01 63 00  P...G.a.a...G.c.
  1d90: 63 00 01 01 47 01 65 00 65 00 01 01 47 01 67 00  c...G.e.e...G.g.
  1da0: 67 00 01 01 47 01 72 00 72 00 01 06 47 01 80 00  g...G.r.r...G...
  1db0: 80 00 01 01 47 01 90 00 90 00 01 10 47 01 92 00  ....G.......G...
  1dc0: 92 00 01 01 47 01 a4 00 a4 00 01 02 47 01 a8 00  ....G.......G...
  1dd0: a8 00 01 02 47 01 ac 00 ac 00 01 02 47 01 b0 00  ....G.......G...
  1de0: b0 00 01 06 47 01 b2 00 b2 00 01 02 47 01 b8 00  ....G.......G...
  1df0: b8 00 01 02 47 01 bc 00 bc 00 01 02 47 01 00 06  ....G.......G...
  1e00: 00 06 01 10 47 01 00 07 00 07 01 10 47 01 00 08  ....G.......G...
  1e10: 00 08 01 10 47 01 00 10 00 10 01 80 47 01 80 11  ....G.......G...
  1e20: 80 11 01 40 47 01 c0 01 c0 01 01 10 47 01 4e 00  ...@G.......G.N.
  1e30: 4e 00 01 02 47 01 68 00 68 00 01 01 47 01 6c 00  N...G.h.h...G.l.
  1e40: 6c 00 01 01 47 01 00 fe 00 fe 00 01 47 01 d0 04  l...G.......G...
  1e50: d0 04 01 02 47 01 10 06 10 06 01 10 47 01 68 00  ....G.......G.h.
  1e60: 68 00 01 01 47 01 6c 00 6c 00 01 01 86 09 00 01  h...G.l.l.......
  1e70: 00 00 c1 fe 00 00 01 00 86 09 00 00 00 00 80 ff  ................
  1e80: 00 00 40 00 86 09 00 00 00 00 f0 ff 00 00 10 00  ..@.............
  1e90: 86 09 00 01 00 00 00 00 00 00 0a 00 86 09 00 00  ................
  1ea0: 00 00 0e 00 00 00 02 00 86 09 00 00 00 f8 0d 00  ................
  1eb0: 00 08 00 00 86 09 00 01 00 00 10 00 00 00 00 00  ................
  1ec0: 79 00 5b 82 26 46 57 48 44 08 5f 48 49 44 0c 25  y.[.&FWHD._HID.%
  1ed0: d4 08 00 08 5f 43 52 53 11 11 0a 0e 86 09 00 00  ...._CRS........
  1ee0: 00 00 80 ff 00 00 80 00 79 00 5b 82 41 0c 48 50  ........y.[.A.HP
  1ef0: 45 54 08 5f 48 49 44 0c 41 d0 01 03 08 42 55 46  ET._HID.A....BUF
  1f00: 30 11 17 0a 14 22 01 00 22 00 01 86 09 00 00 00  0...."..".......
  1f10: 00 d0 fe 00 04 00 00 79 00 14 36 5f 53 54 41 00  .......y..6_STA.
  1f20: 7a 7b 4d 54 53 45 0b 80 03 00 0a 07 60 a0 13 93  z{MTSE......`...
  1f30: 4f 53 59 53 0b d1 07 a0 09 7b 60 0a 04 00 a4 0a  OSYS.....{`.....
  1f40: 0f a1 0b a0 09 7b 60 0a 04 00 a4 0a 0b a4 0a 00  .....{`.........
  1f50: 14 4c 05 5f 43 52 53 08 7a 7b 4d 54 53 45 0b 80  .L._CRS.z{MTSE..
  1f60: 03 00 0a 07 60 a0 42 04 7b 60 0a 04 00 8a 42 55  ....`.B.{`....BU
  1f70: 46 30 0a 0a 48 50 54 30 a0 0f 93 60 0a 05 70 0c  F0..HPT0...`..p.
  1f80: 00 10 d0 fe 48 50 54 30 a0 0f 93 60 0a 06 70 0c  ....HPT0...`..p.
  1f90: 00 20 d0 fe 48 50 54 30 a0 0f 93 60 0a 07 70 0c  . ..HPT0...`..p.
  1fa0: 00 30 d0 fe 48 50 54 30 a4 42 55 46 30 5b 82 45  .0..HPT0.BUF0[.E
  1fb0: 0a 4c 4e 4b 41 08 5f 48 49 44 0c 41 d0 0c 0f 08  .LNKA._HID.A....
  1fc0: 5f 55 49 44 0a 01 14 0d 5f 44 49 53 08 70 0a 80  _UID...._DIS.p..
  1fd0: 50 49 52 41 08 5f 50 52 53 11 09 0a 06 23 40 00  PIRA._PRS....#@.
  1fe0: 18 79 00 14 3a 5f 43 52 53 08 08 52 54 4c 41 11  .y..:_CRS..RTLA.
  1ff0: 09 0a 06 23 00 00 18 79 00 8b 52 54 4c 41 0a 01  ...#...y..RTLA..
  2000: 49 52 51 30 70 00 49 52 51 30 79 0a 01 7b 50 49  IRQ0p.IRQ0y..{PI
  2010: 52 41 0a 0f 00 49 52 51 30 a4 52 54 4c 41 14 1c  RA...IRQ0.RTLA..
  2020: 5f 53 52 53 09 8b 68 0a 01 49 52 51 30 82 49 52  _SRS..h..IRQ0.IR
  2030: 51 30 60 76 60 70 60 50 49 52 41 14 18 5f 53 54  Q0`v`p`PIRA.._ST
  2040: 41 08 a0 0c 7b 50 49 52 41 0a 80 00 a4 0a 09 a1  A...{PIRA.......
  2050: 04 a4 0a 0b 5b 82 45 0a 4c 4e 4b 42 08 5f 48 49  ....[.E.LNKB._HI
  2060: 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 02 14 0d 5f  D.A...._UID...._
  2070: 44 49 53 08 70 0a 80 50 49 52 42 08 5f 50 52 53  DIS.p..PIRB._PRS
  2080: 11 09 0a 06 23 00 04 18 79 00 14 3a 5f 43 52 53  ....#...y..:_CRS
  2090: 08 08 52 54 4c 42 11 09 0a 06 23 00 00 18 79 00  ..RTLB....#...y.
  20a0: 8b 52 54 4c 42 0a 01 49 52 51 30 70 00 49 52 51  .RTLB..IRQ0p.IRQ
  20b0: 30 79 0a 01 7b 50 49 52 42 0a 0f 00 49 52 51 30  0y..{PIRB...IRQ0
  20c0: a4 52 54 4c 42 14 1c 5f 53 52 53 09 8b 68 0a 01  .RTLB.._SRS..h..
  20d0: 49 52 51 30 82 49 52 51 30 60 76 60 70 60 50 49  IRQ0.IRQ0`v`p`PI
  20e0: 52 42 14 18 5f 53 54 41 08 a0 0c 7b 50 49 52 42  RB.._STA...{PIRB
  20f0: 0a 80 00 a4 0a 09 a1 04 a4 0a 0b 5b 82 45 0a 4c  ...........[.E.L
  2100: 4e 4b 43 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55  NKC._HID.A...._U
  2110: 49 44 0a 03 14 0d 5f 44 49 53 08 70 0a 80 50 49  ID...._DIS.p..PI
  2120: 52 43 08 5f 50 52 53 11 09 0a 06 23 40 00 18 79  RC._PRS....#@..y
  2130: 00 14 3a 5f 43 52 53 08 08 52 54 4c 43 11 09 0a  ..:_CRS..RTLC...
  2140: 06 23 00 00 18 79 00 8b 52 54 4c 43 0a 01 49 52  .#...y..RTLC..IR
  2150: 51 30 70 00 49 52 51 30 79 0a 01 7b 50 49 52 43  Q0p.IRQ0y..{PIRC
  2160: 0a 0f 00 49 52 51 30 a4 52 54 4c 43 14 1c 5f 53  ...IRQ0.RTLC.._S
  2170: 52 53 09 8b 68 0a 01 49 52 51 30 82 49 52 51 30  RS..h..IRQ0.IRQ0
  2180: 60 76 60 70 60 50 49 52 43 14 18 5f 53 54 41 08  `v`p`PIRC.._STA.
  2190: a0 0c 7b 50 49 52 43 0a 80 00 a4 0a 09 a1 04 a4  ..{PIRC.........
  21a0: 0a 0b 5b 82 45 0a 4c 4e 4b 44 08 5f 48 49 44 0c  ..[.E.LNKD._HID.
  21b0: 41 d0 0c 0f 08 5f 55 49 44 0a 04 14 0d 5f 44 49  A...._UID...._DI
  21c0: 53 08 70 0a 80 50 49 52 44 08 5f 50 52 53 11 09  S.p..PIRD._PRS..
  21d0: 0a 06 23 40 00 18 79 00 14 3a 5f 43 52 53 08 08  ..#@..y..:_CRS..
  21e0: 52 54 4c 44 11 09 0a 06 23 00 00 18 79 00 8b 52  RTLD....#...y..R
  21f0: 54 4c 44 0a 01 49 52 51 30 70 00 49 52 51 30 79  TLD..IRQ0p.IRQ0y
  2200: 0a 01 7b 50 49 52 44 0a 0f 00 49 52 51 30 a4 52  ..{PIRD...IRQ0.R
  2210: 54 4c 44 14 1c 5f 53 52 53 09 8b 68 0a 01 49 52  TLD.._SRS..h..IR
  2220: 51 30 82 49 52 51 30 60 76 60 70 60 50 49 52 44  Q0.IRQ0`v`p`PIRD
  2230: 14 18 5f 53 54 41 08 a0 0c 7b 50 49 52 44 0a 80  .._STA...{PIRD..
  2240: 00 a4 0a 09 a1 04 a4 0a 0b 5b 82 45 0a 4c 4e 4b  .........[.E.LNK
  2250: 45 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44  E._HID.A...._UID
  2260: 0a 05 14 0d 5f 44 49 53 08 70 0a 80 50 49 52 45  ...._DIS.p..PIRE
  2270: 08 5f 50 52 53 11 09 0a 06 23 00 04 18 79 00 14  ._PRS....#...y..
  2280: 3a 5f 43 52 53 08 08 52 54 4c 45 11 09 0a 06 23  :_CRS..RTLE....#
  2290: 00 00 18 79 00 8b 52 54 4c 45 0a 01 49 52 51 30  ...y..RTLE..IRQ0
  22a0: 70 00 49 52 51 30 79 0a 01 7b 50 49 52 45 0a 0f  p.IRQ0y..{PIRE..
  22b0: 00 49 52 51 30 a4 52 54 4c 45 14 1c 5f 53 52 53  .IRQ0.RTLE.._SRS
  22c0: 09 8b 68 0a 01 49 52 51 30 82 49 52 51 30 60 76  ..h..IRQ0.IRQ0`v
  22d0: 60 70 60 50 49 52 45 14 18 5f 53 54 41 08 a0 0c  `p`PIRE.._STA...
  22e0: 7b 50 49 52 45 0a 80 00 a4 0a 09 a1 04 a4 0a 0b  {PIRE...........
  22f0: 5b 82 45 0a 4c 4e 4b 46 08 5f 48 49 44 0c 41 d0  [.E.LNKF._HID.A.
  2300: 0c 0f 08 5f 55 49 44 0a 06 14 0d 5f 44 49 53 08  ..._UID...._DIS.
  2310: 70 0a 80 50 49 52 46 08 5f 50 52 53 11 09 0a 06  p..PIRF._PRS....
  2320: 23 00 04 18 79 00 14 3a 5f 43 52 53 08 08 52 54  #...y..:_CRS..RT
  2330: 4c 46 11 09 0a 06 23 00 00 18 79 00 8b 52 54 4c  LF....#...y..RTL
  2340: 46 0a 01 49 52 51 30 70 00 49 52 51 30 79 0a 01  F..IRQ0p.IRQ0y..
  2350: 7b 50 49 52 46 0a 0f 00 49 52 51 30 a4 52 54 4c  {PIRF...IRQ0.RTL
  2360: 46 14 1c 5f 53 52 53 09 8b 68 0a 01 49 52 51 30  F.._SRS..h..IRQ0
  2370: 82 49 52 51 30 60 76 60 70 60 50 49 52 46 14 18  .IRQ0`v`p`PIRF..
  2380: 5f 53 54 41 08 a0 0c 7b 50 49 52 46 0a 80 00 a4  _STA...{PIRF....
  2390: 0a 09 a1 04 a4 0a 0b 5b 82 45 0a 4c 4e 4b 47 08  .......[.E.LNKG.
  23a0: 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 07  _HID.A...._UID..
  23b0: 14 0d 5f 44 49 53 08 70 0a 80 50 49 52 47 08 5f  .._DIS.p..PIRG._
  23c0: 50 52 53 11 09 0a 06 23 40 00 18 79 00 14 3a 5f  PRS....#@..y..:_
  23d0: 43 52 53 08 08 52 54 4c 47 11 09 0a 06 23 00 00  CRS..RTLG....#..
  23e0: 18 79 00 8b 52 54 4c 47 0a 01 49 52 51 30 70 00  .y..RTLG..IRQ0p.
  23f0: 49 52 51 30 79 0a 01 7b 50 49 52 47 0a 0f 00 49  IRQ0y..{PIRG...I
  2400: 52 51 30 a4 52 54 4c 47 14 1c 5f 53 52 53 09 8b  RQ0.RTLG.._SRS..
  2410: 68 0a 01 49 52 51 30 82 49 52 51 30 60 76 60 70  h..IRQ0.IRQ0`v`p
  2420: 60 50 49 52 47 14 18 5f 53 54 41 08 a0 0c 7b 50  `PIRG.._STA...{P
  2430: 49 52 47 0a 80 00 a4 0a 09 a1 04 a4 0a 0b 5b 82  IRG...........[.
  2440: 45 0a 4c 4e 4b 48 08 5f 48 49 44 0c 41 d0 0c 0f  E.LNKH._HID.A...
  2450: 08 5f 55 49 44 0a 08 14 0d 5f 44 49 53 08 70 0a  ._UID...._DIS.p.
  2460: 80 50 49 52 48 08 5f 50 52 53 11 09 0a 06 23 00  .PIRH._PRS....#.
  2470: 04 18 79 00 14 3a 5f 43 52 53 08 08 52 54 4c 48  ..y..:_CRS..RTLH
  2480: 11 09 0a 06 23 00 00 18 79 00 8b 52 54 4c 48 0a  ....#...y..RTLH.
  2490: 01 49 52 51 30 70 00 49 52 51 30 79 0a 01 7b 50  .IRQ0p.IRQ0y..{P
  24a0: 49 52 48 0a 0f 00 49 52 51 30 a4 52 54 4c 48 14  IRH...IRQ0.RTLH.
  24b0: 1c 5f 53 52 53 09 8b 68 0a 01 49 52 51 30 82 49  ._SRS..h..IRQ0.I
  24c0: 52 51 30 60 76 60 70 60 50 49 52 48 14 18 5f 53  RQ0`v`p`PIRH.._S
  24d0: 54 41 08 a0 0c 7b 50 49 52 48 0a 80 00 a4 0a 09  TA...{PIRH......
  24e0: a1 04 a4 0a 0b 5b 80 47 50 4f 58 01 0b 80 11 0a  .....[.GPOX.....
  24f0: 40 5b 81 4a 06 47 50 4f 58 13 00 38 00 01 49 4f  @[.J.GPOX..8..IO
  2500: 32 35 01 00 01 49 4f 32 37 01 00 34 4c 56 31 36  25...IO27..4LV16
  2510: 01 4c 56 31 37 01 00 06 00 01 4c 56 32 35 01 00  .LV17.....LV25..
  2520: 01 4c 56 32 37 01 00 4c 05 00 01 42 4c 32 35 01  .LV27..L...BL25.
  2530: 00 01 42 4c 32 37 01 00 44 0e 52 42 49 44 02 4c  ..BL27..D.RBID.L
  2540: 56 33 34 01 4c 56 33 35 01 4c 56 33 36 01 4c 56  V34.LV35.LV36.LV
  2550: 33 37 01 4c 56 33 38 01 4c 56 33 39 01 5b 80 50  37.LV38.LV39.[.P
  2560: 4d 49 4f 01 0b 00 10 0a 51 5b 81 46 07 50 4d 49  MIO.....Q[.F.PMI
  2570: 4f 12 01 03 00 00 48 14 00 03 50 4d 45 53 01 00  O.....H...PMES..
  2580: 0c 00 03 50 4d 45 45 01 00 04 47 50 49 30 01 47  ...PMEE...GPI0.G
  2590: 50 49 31 01 47 50 49 32 01 47 50 49 33 01 47 50  PI1.GPI2.GPI3.GP
  25a0: 49 34 01 47 50 49 35 01 47 50 49 36 01 47 50 49  I4.GPI5.GPI6.GPI
  25b0: 37 01 47 50 49 38 01 47 50 49 39 01 47 50 49 41  7.GPI8.GPI9.GPIA
  25c0: 01 47 50 49 42 01 47 50 49 43 01 47 50 49 44 01  .GPIB.GPIC.GPID.
  25d0: 47 50 49 45 01 47 50 49 46 01 00 06 47 50 45 45  GPIE.GPIF...GPEE
  25e0: 01 5b 82 37 4b 42 43 5f 08 5f 48 49 44 0c 41 d0  .[.7KBC_._HID.A.
  25f0: 03 03 08 5f 43 52 53 11 18 0a 15 47 01 60 00 60  ..._CRS....G.`.`
  2600: 00 01 01 47 01 64 00 64 00 01 01 22 02 00 79 00  ...G.d.d..."..y.
  2610: 14 09 5f 53 54 41 00 a4 0a 0f 5b 82 4d 04 4d 4f  .._STA....[.M.MO
  2620: 55 45 08 5f 48 49 44 0c 24 4d 37 80 08 5f 43 49  UE._HID.$M7.._CI
  2630: 44 0c 41 d0 0f 13 08 5f 43 52 53 11 08 0a 05 22  D.A...._CRS...."
  2640: 00 10 79 00 14 24 5f 53 54 41 00 a0 0d 93 87 5c  ..y..$_STA.....\
  2650: 5f 4f 53 5f 0a 14 a4 0a 00 a1 0f a0 08 50 53 32  _OS_.........PS2
  2660: 46 a4 0a 0f a1 04 a4 0a 00 5b 82 45 05 4d 4f 55  F........[.E.MOU
  2670: 32 08 5f 48 49 44 0c 41 d0 0f 13 08 5f 43 52 53  2._HID.A...._CRS
  2680: 11 08 0a 05 22 00 10 79 00 14 36 5f 53 54 41 00  ...."..y..6_STA.
  2690: a0 24 93 87 5c 5f 4f 53 5f 0a 14 a0 0e 50 53 32  .$..\_OS_....PS2
  26a0: 46 70 50 53 32 46 60 a4 0a 0f a1 0a 70 50 53 32  FpPS2F`.....pPS2
  26b0: 46 60 a4 0a 00 a1 0a 70 50 53 32 46 60 a4 0a 00  F`.....pPS2F`...
  26c0: 5b 82 83 0d 01 53 49 4f 5f 08 5f 48 49 44 0c 41  [....SIO_._HID.A
  26d0: d0 0a 05 5b 80 53 49 49 4f 01 0a 4e 0a 02 5b 81  ...[.SIIO..N..[.
  26e0: 10 53 49 49 4f 01 49 4e 44 58 08 44 41 54 41 08  .SIIO.INDX.DATA.
  26f0: 5b 01 4e 33 39 33 00 14 13 53 45 54 44 09 70 0a  [.N393...SETD.p.
  2700: 07 49 4e 44 58 70 68 44 41 54 41 14 14 52 45 41  .INDXphDATA..REA
  2710: 44 09 70 68 49 4e 44 58 70 44 41 54 41 60 a4 60  D.phINDXpDATA`.`
  2720: 14 12 57 52 49 54 0a 70 68 49 4e 44 58 70 69 44  ..WRIT.phINDXpiD
  2730: 41 54 41 14 2d 4c 44 52 53 03 5b 23 4e 33 39 33  ATA.-LDRS.[#N393
  2740: ff ff 70 0a 07 49 4e 44 58 70 68 44 41 54 41 70  ..p..INDXphDATAp
  2750: 69 49 4e 44 58 70 6a 44 41 54 41 5b 27 4e 33 39  iINDXpjDATA['N39
  2760: 33 14 2f 4c 44 52 47 02 5b 23 4e 33 39 33 ff ff  3./LDRG.[#N393..
  2770: 70 0a 07 49 4e 44 58 70 68 44 41 54 41 70 69 49  p..INDXphDATApiI
  2780: 4e 44 58 70 44 41 54 41 60 5b 27 4e 33 39 33 a4  NDXpDATA`['N393.
  2790: 60 14 2a 52 43 46 36 01 5b 23 4e 33 39 33 ff ff  `.*RCF6.[#N393..
  27a0: 70 0a 26 49 4e 44 58 70 44 41 54 41 60 7b 60 68  p.&INDXpDATA`{`h
  27b0: 60 5b 27 4e 33 39 33 a4 7f 60 68 00 14 4f 13 50  `['N393..`h..O.P
  27c0: 44 52 53 02 a0 42 13 5c 2f 04 5f 53 42 5f 50 43  DRS..B.\/._SB_PC
  27d0: 49 30 4c 50 43 30 50 4f 53 44 a0 32 93 68 0a 00  I0LPC0POSD.2.h..
  27e0: a0 0a 93 69 0b f0 03 70 0a 00 60 a1 0c a0 0a 93  ...i...p..`.....
  27f0: 69 0b 70 03 70 0a 01 60 70 60 5c 2f 04 5f 53 42  i.p.p..`p`\/._SB
  2800: 5f 50 43 49 30 4c 50 43 30 46 44 44 44 a1 46 0e  _PCI0LPC0FDDD.F.
  2810: a0 3f 93 68 0a 01 a0 0a 93 69 0b 78 03 70 0a 00  .?.h.....i.x.p..
  2820: 60 a1 19 a0 0a 93 69 0b 78 02 70 0a 01 60 a1 0c  `.....i.x.p..`..
  2830: a0 0a 93 69 0b bc 03 70 0a 02 60 70 60 5c 2f 04  ...i...p..`p`\/.
  2840: 5f 53 42 5f 50 43 49 30 4c 50 43 30 4c 50 54 44  _SB_PCI0LPC0LPTD
  2850: a1 43 0a a0 0a 93 69 0b f8 03 70 0a 00 60 a1 4d  .C....i...p..`.M
  2860: 05 a0 0a 93 69 0b f8 02 70 0a 01 60 a1 4f 04 a0  ....i...p..`.O..
  2870: 0a 93 69 0b 20 02 70 0a 02 60 a1 41 04 a0 0a 93  ..i. .p..`.A....
  2880: 69 0b 28 02 70 0a 03 60 a1 33 a0 0a 93 69 0b 38  i.(.p..`.3...i.8
  2890: 02 70 0a 04 60 a1 26 a0 0a 93 69 0b e8 02 70 0a  .p..`.&...i...p.
  28a0: 05 60 a1 19 a0 0a 93 69 0b 38 03 70 0a 06 60 a1  .`.....i.8.p..`.
  28b0: 0c a0 0a 93 69 0b e8 03 70 0a 07 60 a0 1a 93 68  ....i...p..`...h
  28c0: 0a 02 70 60 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  ..p`\/._SB_PCI0L
  28d0: 50 43 30 43 4d 42 44 a1 1c a0 1a 93 68 0a 03 70  PC0CMBD.....h..p
  28e0: 60 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  `\/._SB_PCI0LPC0
  28f0: 43 4d 41 44 a4 0a 01 a1 04 a4 0a 00 5b 82 40 2a  CMAD........[.@*
  2900: 45 43 50 5f 08 5f 48 49 44 0c 41 d0 04 01 08 5f  ECP_._HID.A...._
  2910: 55 49 44 0a 03 14 3f 5f 53 54 41 00 70 4c 44 52  UID...?_STA.pLDR
  2920: 47 0a 01 0a f0 60 7a 60 0a 05 60 a0 24 90 52 43  G....`z`..`.$.RC
  2930: 46 36 0a 02 91 93 60 0a 04 93 60 0a 07 79 4c 44  F6....`...`..yLD
  2940: 52 47 0a 01 0a 30 0a 01 61 72 0a 0d 61 61 a4 61  RG...0..ar..aa.a
  2950: a1 04 a4 0a 00 14 10 5f 50 53 30 00 4c 44 52 53  ......._PS0.LDRS
  2960: 0a 01 0a 30 0a 01 14 10 5f 50 53 33 00 4c 44 52  ...0...._PS3.LDR
  2970: 53 0a 01 0a 30 0a 00 14 48 0c 5f 50 52 53 00 a4  S...0...H._PRS..
  2980: 11 4f 0b 0a bb 30 47 01 78 03 78 03 08 08 47 01  .O...0G.x.x...G.
  2990: 78 07 78 07 08 08 22 80 00 2a 08 00 30 47 01 78  x.x..."..*..0G.x
  29a0: 02 78 02 08 08 47 01 78 06 78 06 08 08 22 20 00  .x...G.x.x..." .
  29b0: 2a 08 00 30 47 01 78 03 78 03 08 08 47 01 78 07  *..0G.x.x...G.x.
  29c0: 78 07 08 08 22 20 00 2a 08 00 30 47 01 78 02 78  x..." .*..0G.x.x
  29d0: 02 08 08 47 01 78 06 78 06 08 08 22 80 00 2a 08  ...G.x.x..."..*.
  29e0: 00 30 47 01 78 03 78 03 08 08 47 01 78 07 78 07  .0G.x.x...G.x.x.
  29f0: 08 08 22 80 00 2a 02 00 30 47 01 78 02 78 02 08  .."..*..0G.x.x..
  2a00: 08 47 01 78 06 78 06 08 08 22 20 00 2a 02 00 30  .G.x.x..." .*..0
  2a10: 47 01 78 03 78 03 08 08 47 01 78 07 78 07 08 08  G.x.x...G.x.x...
  2a20: 22 20 00 2a 02 00 30 47 01 78 02 78 02 08 08 47  " .*..0G.x.x...G
  2a30: 01 78 06 78 06 08 08 22 80 00 2a 02 00 38 79 00  .x.x..."..*..8y.
  2a40: 14 10 5f 44 49 53 00 4c 44 52 53 0a 01 0a 30 0a  .._DIS.LDRS...0.
  2a50: 00 14 40 0e 5f 43 52 53 00 08 44 43 52 53 11 1b  ..@._CRS..DCRS..
  2a60: 0a 18 47 01 78 03 78 03 08 08 47 01 78 07 78 07  ..G.x.x...G.x.x.
  2a70: 08 08 22 80 00 2a 08 00 79 00 70 4c 44 52 47 0a  .."..*..y.pLDRG.
  2a80: 01 0a 60 61 70 4c 44 52 47 0a 01 0a 61 60 70 60  ..`apLDRG...a`p`
  2a90: 88 44 43 52 53 0a 02 00 70 60 88 44 43 52 53 0a  .DCRS...p`.DCRS.
  2aa0: 0a 00 70 60 88 44 43 52 53 0a 04 00 70 60 88 44  ..p`.DCRS...p`.D
  2ab0: 43 52 53 0a 0c 00 70 61 88 44 43 52 53 0a 03 00  CRS...pa.DCRS...
  2ac0: 70 61 88 44 43 52 53 0a 05 00 72 61 0a 04 61 70  pa.DCRS...ra..ap
  2ad0: 61 88 44 43 52 53 0a 0b 00 70 61 88 44 43 52 53  a.DCRS...pa.DCRS
  2ae0: 0a 0d 00 79 0a 01 4c 44 52 47 0a 01 0a 70 60 70  ...y..LDRG...p`p
  2af0: 60 88 44 43 52 53 0a 11 00 7a 60 0a 08 61 70 61  `.DCRS...z`..apa
  2b00: 88 44 43 52 53 0a 12 00 79 0a 01 4c 44 52 47 0a  .DCRS...y..LDRG.
  2b10: 01 0a 74 60 70 60 88 44 43 52 53 0a 14 00 7a 60  ..t`p`.DCRS...z`
  2b20: 0a 08 61 70 61 88 44 43 52 53 0a 15 00 a4 44 43  ..apa.DCRS....DC
  2b30: 52 53 14 4b 06 5f 53 52 53 01 8c 68 0a 02 41 44  RS.K._SRS..h..AD
  2b40: 52 4c 8c 68 0a 03 41 44 52 4d 8b 68 0a 11 49 52  RL.h..ADRM.h..IR
  2b50: 51 4d 8b 68 0a 14 44 4d 41 4d 82 49 52 51 4d 60  QM.h..DMAM.IRQM`
  2b60: 76 60 82 44 4d 41 4d 61 76 61 4c 44 52 53 0a 01  v`.DMAMavaLDRS..
  2b70: 0a 70 60 4c 44 52 53 0a 01 0a 74 61 4c 44 52 53  .p`LDRS...taLDRS
  2b80: 0a 01 0a 60 41 44 52 4d 4c 44 52 53 0a 01 0a 61  ...`ADRMLDRS...a
  2b90: 41 44 52 4c 4c 44 52 53 0a 01 0a 30 0a 01 5b 82  ADRLLDRS...0..[.
  2ba0: 4f 21 45 50 50 5f 08 5f 48 49 44 0c 41 d0 04 00  O!EPP_._HID.A...
  2bb0: 08 5f 55 49 44 0a 02 14 3f 5f 53 54 41 00 70 4c  ._UID...?_STA.pL
  2bc0: 44 52 47 0a 01 0a f0 60 7a 60 0a 05 60 a0 24 90  DRG....`z`..`.$.
  2bd0: 52 43 46 36 0a 02 91 93 60 0a 02 93 60 0a 03 79  RCF6....`...`..y
  2be0: 4c 44 52 47 0a 01 0a 30 0a 01 61 72 0a 0d 61 61  LDRG...0..ar..aa
  2bf0: a4 61 a1 04 a4 0a 00 14 10 5f 50 53 30 00 4c 44  .a......._PS0.LD
  2c00: 52 53 0a 01 0a 30 0a 01 14 10 5f 50 53 33 00 4c  RS...0...._PS3.L
  2c10: 44 52 53 0a 01 0a 30 0a 00 14 48 08 5f 50 52 53  DRS...0...H._PRS
  2c20: 00 a4 11 4f 07 0a 7b 30 47 01 78 03 78 03 08 08  ...O..{0G.x.x...
  2c30: 47 01 78 07 78 07 08 08 22 80 00 30 47 01 78 02  G.x.x..."..0G.x.
  2c40: 78 02 08 08 47 01 78 06 78 06 08 08 22 20 00 30  x...G.x.x..." .0
  2c50: 47 01 78 03 78 03 08 08 47 01 78 07 78 07 08 08  G.x.x...G.x.x...
  2c60: 22 20 00 30 47 01 78 02 78 02 08 08 47 01 78 06  " .0G.x.x...G.x.
  2c70: 78 06 08 08 22 80 00 30 47 01 78 01 78 01 08 08  x..."..0G.x.x...
  2c80: 47 01 78 05 78 05 08 08 22 80 00 30 47 01 78 01  G.x.x..."..0G.x.
  2c90: 78 01 08 08 47 01 78 05 78 05 08 08 22 20 00 38  x...G.x.x..." .8
  2ca0: 79 00 14 10 5f 44 49 53 00 4c 44 52 53 0a 01 0a  y..._DIS.LDRS...
  2cb0: 30 0a 00 14 48 0b 5f 43 52 53 00 08 44 43 52 53  0...H._CRS..DCRS
  2cc0: 11 18 0a 15 47 01 78 03 78 03 08 08 47 01 78 07  ....G.x.x...G.x.
  2cd0: 78 07 08 08 22 80 00 79 00 70 4c 44 52 47 0a 01  x..."..y.pLDRG..
  2ce0: 0a 60 61 70 4c 44 52 47 0a 01 0a 61 60 70 60 88  .`apLDRG...a`p`.
  2cf0: 44 43 52 53 0a 02 00 70 60 88 44 43 52 53 0a 0a  DCRS...p`.DCRS..
  2d00: 00 70 60 88 44 43 52 53 0a 04 00 70 60 88 44 43  .p`.DCRS...p`.DC
  2d10: 52 53 0a 0c 00 70 61 88 44 43 52 53 0a 03 00 70  RS...pa.DCRS...p
  2d20: 61 88 44 43 52 53 0a 05 00 72 61 0a 04 61 70 61  a.DCRS...ra..apa
  2d30: 88 44 43 52 53 0a 0b 00 70 61 88 44 43 52 53 0a  .DCRS...pa.DCRS.
  2d40: 0d 00 79 0a 01 4c 44 52 47 0a 01 0a 70 60 70 60  ..y..LDRG...p`p`
  2d50: 88 44 43 52 53 0a 11 00 7a 60 0a 08 61 70 61 88  .DCRS...z`..apa.
  2d60: 44 43 52 53 0a 12 00 a4 44 43 52 53 14 42 05 5f  DCRS....DCRS.B._
  2d70: 53 52 53 01 8c 68 0a 02 41 44 52 4c 8c 68 0a 03  SRS..h..ADRL.h..
  2d80: 41 44 52 4d 8b 68 0a 11 49 52 51 4d 82 49 52 51  ADRM.h..IRQM.IRQ
  2d90: 4d 60 76 60 4c 44 52 53 0a 01 0a 70 60 4c 44 52  M`v`LDRS...p`LDR
  2da0: 53 0a 01 0a 60 41 44 52 4d 4c 44 52 53 0a 01 0a  S...`ADRMLDRS...
  2db0: 61 41 44 52 4c 4c 44 52 53 0a 01 0a 30 0a 01 5b  aADRLLDRS...0..[
  2dc0: 82 43 25 4c 50 54 42 08 5f 48 49 44 0c 41 d0 04  .C%LPTB._HID.A..
  2dd0: 00 08 5f 55 49 44 0a 01 14 3a 5f 53 54 41 00 70  .._UID...:_STA.p
  2de0: 4c 44 52 47 0a 01 0a f0 60 7a 60 0a 05 60 a0 1f  LDRG....`z`..`..
  2df0: 90 52 43 46 36 0a 02 93 60 0a 01 79 4c 44 52 47  .RCF6...`..yLDRG
  2e00: 0a 01 0a 30 0a 01 61 72 0a 0d 61 61 a4 61 a1 04  ...0..ar..aa.a..
  2e10: a4 0a 00 14 10 5f 50 53 30 00 4c 44 52 53 0a 01  ....._PS0.LDRS..
  2e20: 0a 30 0a 01 14 10 5f 50 53 33 00 4c 44 52 53 0a  .0...._PS3.LDRS.
  2e30: 01 0a 30 0a 00 14 48 08 5f 50 52 53 00 a4 11 4f  ..0...H._PRS...O
  2e40: 07 0a 7b 30 47 01 78 03 78 03 08 08 47 01 78 07  ..{0G.x.x...G.x.
  2e50: 78 07 08 08 22 80 00 30 47 01 78 02 78 02 08 08  x..."..0G.x.x...
  2e60: 47 01 78 06 78 06 08 08 22 20 00 30 47 01 78 03  G.x.x..." .0G.x.
  2e70: 78 03 08 08 47 01 78 07 78 07 08 08 22 20 00 30  x...G.x.x..." .0
  2e80: 47 01 78 02 78 02 08 08 47 01 78 06 78 06 08 08  G.x.x...G.x.x...
  2e90: 22 80 00 30 47 01 bc 03 bc 03 04 04 47 01 bc 07  "..0G.......G...
  2ea0: bc 07 04 04 22 80 00 30 47 01 bc 03 bc 03 04 04  ...."..0G.......
  2eb0: 47 01 bc 07 bc 07 04 04 22 20 00 38 79 00 14 10  G......." .8y...
  2ec0: 5f 44 49 53 00 4c 44 52 53 0a 01 0a 30 0a 00 14  _DIS.LDRS...0...
  2ed0: 41 0f 5f 43 52 53 00 08 44 43 52 53 11 18 0a 15  A._CRS..DCRS....
  2ee0: 47 01 78 03 78 03 08 08 47 01 78 07 78 07 08 08  G.x.x...G.x.x...
  2ef0: 22 80 00 79 00 70 4c 44 52 47 0a 01 0a 60 61 70  "..y.pLDRG...`ap
  2f00: 4c 44 52 47 0a 01 0a 61 60 70 60 88 44 43 52 53  LDRG...a`p`.DCRS
  2f10: 0a 02 00 70 60 88 44 43 52 53 0a 0a 00 70 60 88  ...p`.DCRS...p`.
  2f20: 44 43 52 53 0a 04 00 70 60 88 44 43 52 53 0a 0c  DCRS...p`.DCRS..
  2f30: 00 70 61 88 44 43 52 53 0a 03 00 70 61 88 44 43  .pa.DCRS...pa.DC
  2f40: 52 53 0a 05 00 72 61 0a 04 61 70 61 88 44 43 52  RS...ra..apa.DCR
  2f50: 53 0a 0b 00 70 61 88 44 43 52 53 0a 0d 00 a0 0a  S...pa.DCRS.....
  2f60: 7b 60 0a 04 00 70 0a 04 60 a1 05 70 0a 08 60 70  {`...p..`..p..`p
  2f70: 60 88 44 43 52 53 0a 06 00 70 60 88 44 43 52 53  `.DCRS...p`.DCRS
  2f80: 0a 07 00 70 60 88 44 43 52 53 0a 0e 00 70 60 88  ...p`.DCRS...p`.
  2f90: 44 43 52 53 0a 0f 00 79 0a 01 4c 44 52 47 0a 01  DCRS...y..LDRG..
  2fa0: 0a 70 60 70 60 88 44 43 52 53 0a 11 00 7a 60 0a  .p`p`.DCRS...z`.
  2fb0: 08 61 70 61 88 44 43 52 53 0a 12 00 a4 44 43 52  .apa.DCRS....DCR
  2fc0: 53 14 42 05 5f 53 52 53 01 8c 68 0a 02 41 44 52  S.B._SRS..h..ADR
  2fd0: 4c 8c 68 0a 03 41 44 52 4d 8b 68 0a 11 49 52 51  L.h..ADRM.h..IRQ
  2fe0: 4d 82 49 52 51 4d 60 76 60 4c 44 52 53 0a 01 0a  M.IRQM`v`LDRS...
  2ff0: 70 60 4c 44 52 53 0a 01 0a 60 41 44 52 4d 4c 44  p`LDRS...`ADRMLD
  3000: 52 53 0a 01 0a 61 41 44 52 4c 4c 44 52 53 0a 01  RS...aADRLLDRS..
  3010: 0a 30 0a 01 5b 82 43 25 4c 50 54 5f 08 5f 48 49  .0..[.C%LPT_._HI
  3020: 44 0c 41 d0 04 00 08 5f 55 49 44 0a 00 14 3a 5f  D.A...._UID...:_
  3030: 53 54 41 00 70 4c 44 52 47 0a 01 0a f0 60 7a 60  STA.pLDRG....`z`
  3040: 0a 05 60 a0 1f 90 52 43 46 36 0a 02 93 60 0a 00  ..`...RCF6...`..
  3050: 79 4c 44 52 47 0a 01 0a 30 0a 01 61 72 0a 0d 61  yLDRG...0..ar..a
  3060: 61 a4 61 a1 04 a4 0a 00 14 10 5f 50 53 30 00 4c  a.a......._PS0.L
  3070: 44 52 53 0a 01 0a 30 0a 01 14 10 5f 50 53 33 00  DRS...0...._PS3.
  3080: 4c 44 52 53 0a 01 0a 30 0a 00 14 48 08 5f 50 52  LDRS...0...H._PR
  3090: 53 00 a4 11 4f 07 0a 7b 30 47 01 78 03 78 03 08  S...O..{0G.x.x..
  30a0: 08 47 01 78 07 78 07 08 08 22 80 00 30 47 01 78  .G.x.x..."..0G.x
  30b0: 02 78 02 08 08 47 01 78 06 78 06 08 08 22 20 00  .x...G.x.x..." .
  30c0: 30 47 01 78 03 78 03 08 08 47 01 78 07 78 07 08  0G.x.x...G.x.x..
  30d0: 08 22 20 00 30 47 01 78 02 78 02 08 08 47 01 78  ." .0G.x.x...G.x
  30e0: 06 78 06 08 08 22 80 00 30 47 01 bc 03 bc 03 04  .x..."..0G......
  30f0: 04 47 01 bc 07 bc 07 04 04 22 80 00 30 47 01 bc  .G......."..0G..
  3100: 03 bc 03 04 04 47 01 bc 07 bc 07 04 04 22 20 00  .....G......." .
  3110: 38 79 00 14 10 5f 44 49 53 00 4c 44 52 53 0a 01  8y..._DIS.LDRS..
  3120: 0a 30 0a 00 14 41 0f 5f 43 52 53 00 08 44 43 52  .0...A._CRS..DCR
  3130: 53 11 18 0a 15 47 01 78 03 78 03 08 08 47 01 78  S....G.x.x...G.x
  3140: 07 78 07 08 08 22 80 00 79 00 70 4c 44 52 47 0a  .x..."..y.pLDRG.
  3150: 01 0a 60 61 70 4c 44 52 47 0a 01 0a 61 60 70 60  ..`apLDRG...a`p`
  3160: 88 44 43 52 53 0a 02 00 70 60 88 44 43 52 53 0a  .DCRS...p`.DCRS.
  3170: 0a 00 70 60 88 44 43 52 53 0a 04 00 70 60 88 44  ..p`.DCRS...p`.D
  3180: 43 52 53 0a 0c 00 70 61 88 44 43 52 53 0a 03 00  CRS...pa.DCRS...
  3190: 70 61 88 44 43 52 53 0a 05 00 72 61 0a 04 61 70  pa.DCRS...ra..ap
  31a0: 61 88 44 43 52 53 0a 0b 00 70 61 88 44 43 52 53  a.DCRS...pa.DCRS
  31b0: 0a 0d 00 a0 0a 7b 60 0a 04 00 70 0a 04 60 a1 05  .....{`...p..`..
  31c0: 70 0a 08 60 70 60 88 44 43 52 53 0a 06 00 70 60  p..`p`.DCRS...p`
  31d0: 88 44 43 52 53 0a 07 00 70 60 88 44 43 52 53 0a  .DCRS...p`.DCRS.
  31e0: 0e 00 70 60 88 44 43 52 53 0a 0f 00 79 0a 01 4c  ..p`.DCRS...y..L
  31f0: 44 52 47 0a 01 0a 70 60 70 60 88 44 43 52 53 0a  DRG...p`p`.DCRS.
  3200: 11 00 7a 60 0a 08 61 70 61 88 44 43 52 53 0a 12  ..z`..apa.DCRS..
  3210: 00 a4 44 43 52 53 14 42 05 5f 53 52 53 01 8c 68  ..DCRS.B._SRS..h
  3220: 0a 02 41 44 52 4c 8c 68 0a 03 41 44 52 4d 8b 68  ..ADRL.h..ADRM.h
  3230: 0a 11 49 52 51 4d 82 49 52 51 4d 60 76 60 4c 44  ..IRQM.IRQM`v`LD
  3240: 52 53 0a 01 0a 70 60 4c 44 52 53 0a 01 0a 60 41  RS...p`LDRS...`A
  3250: 44 52 4d 4c 44 52 53 0a 01 0a 61 41 44 52 4c 4c  DRMLDRS...aADRLL
  3260: 44 52 53 0a 01 0a 30 0a 01 5b 82 49 1b 43 4f 4d  DRS...0..[.I.COM
  3270: 41 08 5f 48 49 44 0c 41 d0 05 01 08 5f 55 49 44  A._HID.A...._UID
  3280: 0a 00 14 26 5f 53 54 41 00 a0 1a 52 43 46 36 0a  ...&_STA...RCF6.
  3290: 08 79 4c 44 52 47 0a 03 0a 30 0a 01 61 72 0a 0d  .yLDRG...0..ar..
  32a0: 61 61 a4 61 a1 04 a4 0a 00 14 10 5f 50 53 30 00  aa.a......._PS0.
  32b0: 4c 44 52 53 0a 03 0a 30 0a 01 14 10 5f 50 53 33  LDRS...0...._PS3
  32c0: 00 4c 44 52 53 0a 03 0a 30 0a 00 14 40 07 5f 50  .LDRS...0...@._P
  32d0: 52 53 00 a4 11 47 06 0a 63 30 47 01 f8 03 f8 03  RS...G..c0G.....
  32e0: 08 08 22 10 00 30 47 01 f8 02 f8 02 08 08 22 08  .."..0G.......".
  32f0: 00 30 47 01 e8 03 e8 03 08 08 22 10 00 30 47 01  .0G......."..0G.
  3300: e8 02 e8 02 08 08 22 08 00 30 47 01 f8 03 f8 03  ......"..0G.....
  3310: 08 08 22 08 00 30 47 01 f8 02 f8 02 08 08 22 10  .."..0G.......".
  3320: 00 30 47 01 e8 03 e8 03 08 08 22 08 00 30 47 01  .0G......."..0G.
  3330: e8 02 e8 02 08 08 22 10 00 38 79 00 14 10 5f 44  ......"..8y..._D
  3340: 49 53 00 4c 44 52 53 0a 03 0a 30 0a 00 14 43 08  IS.LDRS...0...C.
  3350: 5f 43 52 53 00 08 44 43 52 53 11 10 0a 0d 47 01  _CRS..DCRS....G.
  3360: f8 03 f8 03 08 08 22 10 00 79 00 70 4c 44 52 47  ......"..y.pLDRG
  3370: 0a 03 0a 60 61 70 4c 44 52 47 0a 03 0a 61 60 70  ...`apLDRG...a`p
  3380: 60 88 44 43 52 53 0a 02 00 70 60 88 44 43 52 53  `.DCRS...p`.DCRS
  3390: 0a 04 00 70 61 88 44 43 52 53 0a 03 00 70 61 88  ...pa.DCRS...pa.
  33a0: 44 43 52 53 0a 05 00 79 0a 01 4c 44 52 47 0a 03  DCRS...y..LDRG..
  33b0: 0a 70 60 70 60 88 44 43 52 53 0a 09 00 7a 60 0a  .p`p`.DCRS...z`.
  33c0: 08 61 70 61 88 44 43 52 53 0a 0a 00 a4 44 43 52  .apa.DCRS....DCR
  33d0: 53 14 42 05 5f 53 52 53 01 8c 68 0a 02 41 44 52  S.B._SRS..h..ADR
  33e0: 4c 8c 68 0a 03 41 44 52 4d 8b 68 0a 09 49 52 51  L.h..ADRM.h..IRQ
  33f0: 4d 82 49 52 51 4d 60 76 60 4c 44 52 53 0a 03 0a  M.IRQM`v`LDRS...
  3400: 70 60 4c 44 52 53 0a 03 0a 60 41 44 52 4d 4c 44  p`LDRS...`ADRMLD
  3410: 52 53 0a 03 0a 61 41 44 52 4c 4c 44 52 53 0a 03  RS...aADRLLDRS..
  3420: 0a 30 0a 01 5b 82 4f 36 46 49 52 5f 14 25 5f 48  .0..[.O6FIR_.%_H
  3430: 49 44 00 a0 16 91 93 4d 59 4f 53 0a 01 93 4d 59  ID.....MYOS...MY
  3440: 4f 53 0a 03 a4 0c 3a 63 60 01 a1 07 a4 0c 3a 63  OS....:c`.....:c
  3450: 60 01 08 5f 55 49 44 0a 00 14 36 5f 53 54 41 00  `.._UID...6_STA.
  3460: 70 4c 44 52 47 0a 02 0a 74 60 a0 20 90 52 43 46  pLDRG...t`. .RCF
  3470: 36 0a 04 92 93 60 0a 04 79 4c 44 52 47 0a 02 0a  6....`..yLDRG...
  3480: 30 0a 01 61 72 0a 0d 61 61 a4 61 a1 04 a4 0a 00  0..ar..aa.a.....
  3490: 14 10 5f 50 53 30 00 4c 44 52 53 0a 02 0a 30 0a  .._PS0.LDRS...0.
  34a0: 01 14 10 5f 50 53 33 00 4c 44 52 53 0a 02 0a 30  ..._PS3.LDRS...0
  34b0: 0a 00 14 49 17 5f 50 52 53 00 a4 11 40 17 0b 6b  ...I._PRS...@..k
  34c0: 01 30 47 01 f8 03 f8 03 08 08 22 10 00 2a 01 00  .0G......."..*..
  34d0: 30 47 01 f8 02 f8 02 08 08 22 08 00 2a 01 00 30  0G......."..*..0
  34e0: 47 01 e8 03 e8 03 08 08 22 10 00 2a 01 00 30 47  G......."..*..0G
  34f0: 01 e8 02 e8 02 08 08 22 08 00 2a 01 00 30 47 01  ......."..*..0G.
  3500: f8 03 f8 03 08 08 22 08 00 2a 01 00 30 47 01 f8  ......"..*..0G..
  3510: 02 f8 02 08 08 22 10 00 2a 01 00 30 47 01 e8 03  ....."..*..0G...
  3520: e8 03 08 08 22 08 00 2a 01 00 30 47 01 e8 02 e8  ...."..*..0G....
  3530: 02 08 08 22 10 00 2a 01 00 30 47 01 f8 03 f8 03  ..."..*..0G.....
  3540: 08 08 22 10 00 2a 02 00 30 47 01 f8 02 f8 02 08  .."..*..0G......
  3550: 08 22 08 00 2a 02 00 30 47 01 e8 03 e8 03 08 08  ."..*..0G.......
  3560: 22 10 00 2a 02 00 30 47 01 e8 02 e8 02 08 08 22  "..*..0G......."
  3570: 08 00 2a 02 00 30 47 01 f8 03 f8 03 08 08 22 08  ..*..0G.......".
  3580: 00 2a 02 00 30 47 01 f8 02 f8 02 08 08 22 10 00  .*..0G......."..
  3590: 2a 02 00 30 47 01 e8 03 e8 03 08 08 22 08 00 2a  *..0G......."..*
  35a0: 02 00 30 47 01 e8 02 e8 02 08 08 22 10 00 2a 02  ..0G......."..*.
  35b0: 00 30 47 01 f8 03 f8 03 08 08 22 10 00 2a 08 00  .0G......."..*..
  35c0: 30 47 01 f8 02 f8 02 08 08 22 08 00 2a 08 00 30  0G......."..*..0
  35d0: 47 01 e8 03 e8 03 08 08 22 10 00 2a 08 00 30 47  G......."..*..0G
  35e0: 01 e8 02 e8 02 08 08 22 08 00 2a 08 00 30 47 01  ......."..*..0G.
  35f0: f8 03 f8 03 08 08 22 08 00 2a 08 00 30 47 01 f8  ......"..*..0G..
  3600: 02 f8 02 08 08 22 10 00 2a 08 00 30 47 01 e8 03  ....."..*..0G...
  3610: e8 03 08 08 22 08 00 2a 08 00 30 47 01 e8 02 e8  ...."..*..0G....
  3620: 02 08 08 22 10 00 2a 08 00 38 79 00 14 26 5f 44  ..."..*..8y..&_D
  3630: 49 53 00 4c 44 52 53 0a 02 0a 30 0a 00 70 0a 00  IS.LDRS...0..p..
  3640: 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 45  \/._SB_PCI0LPC0E
  3650: 43 4f 31 14 4b 0a 5f 43 52 53 00 08 44 43 52 53  CO1.K._CRS..DCRS
  3660: 11 13 0a 10 47 01 f8 02 f8 02 08 08 22 08 00 2a  ....G......."..*
  3670: 01 00 79 00 70 4c 44 52 47 0a 02 0a 60 61 70 4c  ..y.pLDRG...`apL
  3680: 44 52 47 0a 02 0a 61 60 70 60 88 44 43 52 53 0a  DRG...a`p`.DCRS.
  3690: 02 00 70 60 88 44 43 52 53 0a 04 00 70 61 88 44  ..p`.DCRS...pa.D
  36a0: 43 52 53 0a 03 00 70 61 88 44 43 52 53 0a 05 00  CRS...pa.DCRS...
  36b0: 79 0a 01 4c 44 52 47 0a 02 0a 70 60 70 60 88 44  y..LDRG...p`p`.D
  36c0: 43 52 53 0a 09 00 7a 60 0a 08 61 70 61 88 44 43  CRS...z`..apa.DC
  36d0: 52 53 0a 0a 00 79 0a 01 4c 44 52 47 0a 02 0a 74  RS...y..LDRG...t
  36e0: 60 70 60 88 44 43 52 53 0a 0c 00 7a 60 0a 08 61  `p`.DCRS...z`..a
  36f0: 70 61 88 44 43 52 53 0a 0d 00 a4 44 43 52 53 14  pa.DCRS....DCRS.
  3700: 45 09 5f 53 52 53 01 70 0a 01 5c 2f 04 5f 53 42  E._SRS.p..\/._SB
  3710: 5f 50 43 49 30 4c 50 43 30 45 43 4f 31 8c 68 0a  _PCI0LPC0ECO1.h.
  3720: 02 41 44 52 4c 8c 68 0a 03 41 44 52 4d 8b 68 0a  .ADRL.h..ADRM.h.
  3730: 09 49 52 51 4d 8b 68 0a 0c 44 4d 41 4d 82 49 52  .IRQM.h..DMAM.IR
  3740: 51 4d 60 76 60 82 44 4d 41 4d 61 76 61 4c 44 52  QM`v`.DMAMavaLDR
  3750: 53 0a 02 0a 70 60 4c 44 52 53 0a 02 0a 74 61 4c  S...p`LDRS...taL
  3760: 44 52 53 0a 02 0a 60 41 44 52 4d 4c 44 52 53 0a  DRS...`ADRMLDRS.
  3770: 02 0a 61 41 44 52 4c 50 44 52 53 0a 02 72 79 41  ..aADRLPDRS..ryA
  3780: 44 52 4d 0a 08 00 41 44 52 4c 00 4c 44 52 53 0a  DRM...ADRL.LDRS.
  3790: 02 0a 30 0a 01 5b 82 41 d3 45 43 30 5f 08 5f 48  ..0..[.A.EC0_._H
  37a0: 49 44 0c 41 d0 0c 09 08 5f 43 52 53 11 15 0a 12  ID.A...._CRS....
  37b0: 47 01 62 00 62 00 01 01 47 01 66 00 66 00 01 01  G.b.b...G.f.f...
  37c0: 79 00 08 5f 47 50 45 0a 1d 08 4f 53 45 4a 0a 00  y.._GPE...OSEJ..
  37d0: 14 49 0c 5f 52 45 47 02 a0 41 0c 93 68 0a 03 70  .I._REG..A..h..p
  37e0: 69 5c 2e 5f 53 42 5f 4f 4b 45 43 70 69 5c 2e 5f  i\._SB_OKECpi\._
  37f0: 53 42 5f 45 43 4f 4b a0 45 04 7d 93 5c 2f 03 5f  SB_ECOK.E.}.\/._
  3800: 53 42 5f 50 43 49 30 4d 59 4f 53 0a 03 93 5c 2f  SB_PCI0MYOS...\/
  3810: 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 01 00  ._SB_PCI0MYOS...
  3820: a0 1c 69 70 0a 01 5c 2f 05 5f 53 42 5f 50 43 49  ..ip..\/._SB_PCI
  3830: 30 4c 50 43 30 45 43 30 5f 52 47 35 37 70 5c 2e  0LPC0EC0_RG57p\.
  3840: 5f 53 42 5f 57 4c 45 53 5c 2f 05 5f 53 42 5f 50  _SB_WLES\/._SB_P
  3850: 43 49 30 4c 50 43 30 45 43 30 5f 57 45 53 54 70  CI0LPC0EC0_WESTp
  3860: 5c 2e 5f 53 42 5f 42 54 45 53 5c 2f 05 5f 53 42  \._SB_BTES\/._SB
  3870: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 42 45 53  _PCI0LPC0EC0_BES
  3880: 54 70 01 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  Tp.\/._SB_PCI0LP
  3890: 43 30 45 43 30 5f 57 42 49 4e 5b 80 45 52 41 4d  C0EC0_WBIN[.ERAM
  38a0: 03 0a 00 0a ff 5b 81 46 2c 45 52 41 4d 01 00 20  .....[.F,ERAM.. 
  38b0: 43 4d 43 4d 08 43 4d 44 31 08 43 4d 44 32 08 43  CMCM.CMD1.CMD2.C
  38c0: 4d 44 33 08 00 40 08 53 4d 50 52 08 53 4d 53 54  MD3..@.SMPR.SMST
  38d0: 08 53 4d 41 44 08 53 4d 43 4d 08 53 4d 44 30 40  .SMAD.SMCM.SMD0@
  38e0: 10 42 43 4e 54 08 53 4d 41 41 08 42 41 54 44 10  .BCNT.SMAA.BATD.
  38f0: 41 43 44 46 01 00 07 00 04 46 50 52 31 01 53 34  ACDF.....FPR1.S4
  3900: 4c 44 01 53 35 4c 57 01 50 46 4c 47 01 00 08 54  LD.S5LW.PFLG...T
  3910: 4d 53 53 02 00 02 42 41 4e 4b 04 00 08 56 46 41  MSS...BANK...VFA
  3920: 4e 01 00 07 52 4c 30 31 01 52 44 30 31 01 52 46  N...RL01.RD01.RF
  3930: 30 31 01 52 50 30 31 01 52 42 30 31 01 52 43 30  01.RP01.RB01.RC0
  3940: 31 01 00 01 52 37 30 31 01 52 38 30 31 01 52 4d  1...R701.R801.RM
  3950: 30 31 01 52 49 30 31 01 00 01 00 01 00 01 52 41  01.RI01.......RA
  3960: 30 31 01 52 52 30 31 01 52 4c 31 30 01 52 44 31  01.RR01.RL10.RD1
  3970: 30 01 52 46 31 30 01 52 50 31 30 01 52 42 31 30  0.RF10.RP10.RB10
  3980: 01 52 43 31 30 01 00 01 52 37 31 30 01 52 38 31  .RC10...R710.R81
  3990: 30 01 52 4d 31 30 01 52 49 31 30 01 00 01 00 01  0.RM10.RI10.....
  39a0: 00 01 52 41 31 30 01 52 52 31 30 01 4c 49 44 45  ..RA10.RR10.LIDE
  39b0: 01 44 42 32 45 01 52 50 54 45 01 57 50 30 31 01  .DB2E.RPTE.WP01.
  39c0: 57 42 30 31 01 57 43 30 31 01 00 01 57 37 30 31  WB01.WC01...W701
  39d0: 01 57 38 30 31 01 57 4d 30 31 01 57 49 30 31 01  .W801.WM01.WI01.
  39e0: 00 01 00 01 00 01 57 41 30 31 01 57 52 30 31 01  ......WA01.WR01.
  39f0: 4c 49 44 53 01 44 42 32 53 01 52 50 54 53 01 57  LIDS.DB2S.RPTS.W
  3a00: 50 31 30 01 57 42 31 30 01 57 43 31 30 01 00 01  P10.WB10.WC10...
  3a10: 57 37 31 30 01 57 38 31 30 01 57 4d 31 30 01 57  W710.W810.WM10.W
  3a20: 49 31 30 01 00 01 00 01 00 01 57 41 31 30 01 57  I10.......WA10.W
  3a30: 52 31 30 01 00 01 42 41 59 45 01 45 46 44 45 01  R10...BAYE.EFDE.
  3a40: 50 52 44 45 01 42 52 42 45 01 41 44 49 4d 01 00  PRDE.BRBE.ADIM..
  3a50: 01 57 37 42 45 01 57 38 42 45 01 50 4d 45 45 01  .W7BE.W8BE.PMEE.
  3a60: 49 4e 54 45 01 00 01 00 01 00 01 00 01 44 42 33  INTE.........DB3
  3a70: 45 01 00 10 00 01 42 41 59 53 01 45 46 44 53 01  E.....BAYS.EFDS.
  3a80: 50 52 44 53 01 42 52 42 53 01 43 52 54 53 01 00  PRDS.BRBS.CRTS..
  3a90: 01 57 37 42 53 01 57 38 42 53 01 44 50 45 4d 01  .W7BS.W8BS.DPEM.
  3aa0: 44 49 4e 54 01 00 01 00 01 00 01 00 01 44 42 33  DINT.........DB3
  3ab0: 53 01 00 18 52 47 35 37 08 43 54 4d 50 08 52 47  S...RG57.CTMP.RG
  3ac0: 35 39 08 52 47 35 41 08 52 47 35 42 08 46 53 50  59.RG5A.RG5B.FSP
  3ad0: 44 10 00 08 57 45 53 54 01 42 45 53 54 01 57 42  D...WEST.BEST.WB
  3ae0: 49 4e 01 00 05 00 01 46 41 4e 43 01 00 4e 07 4d  IN.....FANC..N.M
  3af0: 42 49 44 08 4d 42 54 53 01 4d 42 54 46 01 00 06  BID.MBTS.MBTF...
  3b00: 4d 42 54 43 01 00 27 42 41 31 43 08 4d 42 56 47  MBTC..'BA1C.MBVG
  3b10: 10 4d 43 55 52 10 00 20 53 42 49 44 08 53 42 54  .MCUR.. SBID.SBT
  3b20: 53 01 53 42 54 46 01 00 06 53 42 54 43 01 00 27  S.SBTF...SBTC..'
  3b30: 42 41 32 43 08 41 42 56 47 10 41 43 55 52 10 00  BA2C.ABVG.ACUR..
  3b40: 48 1b 4d 42 52 4d 10 00 28 41 42 52 4d 10 00 20  H.MBRM..(ABRM.. 
  3b50: 45 42 50 4c 01 00 0f 00 06 41 50 57 52 01 00 19  EBPL.....APWR...
  3b60: 44 42 50 4c 08 00 40 08 47 51 4b 53 07 5b 81 0e  DBPL..@.GQKS.[..
  3b70: 45 52 41 4d 01 00 40 0e 53 4d 57 30 10 5b 81 0e  ERAM..@.SMW0.[..
  3b80: 45 52 41 4d 01 00 40 0e 53 4d 42 30 08 5b 81 0f  ERAM..@.SMB0.[..
  3b90: 45 52 41 4d 01 00 40 0e 46 4c 44 30 40 04 5b 81  ERAM..@.FLD0@.[.
  3ba0: 0f 45 52 41 4d 01 00 40 0e 46 4c 44 31 40 08 5b  .ERAM..@.FLD1@.[
  3bb0: 81 0f 45 52 41 4d 01 00 40 0e 46 4c 44 32 40 0c  ..ERAM..@.FLD2@.
  3bc0: 5b 81 0f 45 52 41 4d 01 00 40 0e 46 4c 44 33 40  [..ERAM..@.FLD3@
  3bd0: 10 5b 01 4d 55 54 30 00 14 4f 14 53 4d 52 44 04  .[.MUT0..O.SMRD.
  3be0: a0 0f 92 5c 2e 5f 53 42 5f 4f 4b 45 43 a4 0a ff  ...\._SB_OKEC...
  3bf0: a0 17 92 93 68 0a 07 a0 10 92 93 68 0a 09 a0 09  ....h......h....
  3c00: 92 93 68 0a 0b a4 0a 19 5b 23 4d 55 54 30 ff ff  ..h.....[#MUT0..
  3c10: 70 0a 04 60 a2 4d 06 94 60 0a 01 7b 53 4d 53 54  p..`.M..`..{SMST
  3c20: 0a 40 53 4d 53 54 70 6a 53 4d 43 4d 70 69 53 4d  .@SMSTpjSMCMpiSM
  3c30: 41 44 70 68 53 4d 50 52 70 0a 00 63 a2 37 92 7b  ADphSMPRp..c.7.{
  3c40: 53 4d 53 54 0a bf 61 5b 22 0a 02 75 63 a0 26 93  SMST..a["..uc.&.
  3c50: 63 0a 32 7b 53 4d 53 54 0a 40 53 4d 53 54 70 6a  c.2{SMST.@SMSTpj
  3c60: 53 4d 43 4d 70 69 53 4d 41 44 70 68 53 4d 50 52  SMCMpiSMADphSMPR
  3c70: 70 0a 00 63 a0 09 93 61 0a 80 70 0a 00 60 a1 03  p..c...a..p..`..
  3c80: 76 60 a0 09 60 70 7b 61 0a 1f 00 60 a1 43 09 a0  v`..`p{a...`.C..
  3c90: 0b 93 68 0a 07 70 53 4d 42 30 6b a0 0b 93 68 0a  ..h..pSMB0k...h.
  3ca0: 09 70 53 4d 57 30 6b a0 48 07 93 68 0a 0b 70 42  .pSMW0k.H..h..pB
  3cb0: 43 4e 54 63 7a 0b 00 01 0a 03 62 a0 07 94 63 62  CNTcz.....b...cb
  3cc0: 70 62 63 a0 0b 95 63 0a 09 70 46 4c 44 30 62 a1  pbc...c..pFLD0b.
  3cd0: 23 a0 0b 95 63 0a 11 70 46 4c 44 31 62 a1 15 a0  #...c..pFLD1b...
  3ce0: 0b 95 63 0a 19 70 46 4c 44 32 62 a1 07 70 46 4c  ..c..pFLD2b..pFL
  3cf0: 44 33 62 75 63 70 11 02 63 64 76 63 70 00 65 a2  D3bucp..cdvcp.e.
  3d00: 15 94 63 65 47 42 46 45 62 65 71 66 50 42 46 45  ..ceGBFEbeqfPBFE
  3d10: 64 65 66 75 65 50 42 46 45 64 65 0a 00 70 64 6b  defuePBFEde..pdk
  3d20: 5b 27 4d 55 54 30 a4 60 14 4f 0d 53 4d 57 52 04  ['MUT0.`.O.SMWR.
  3d30: a0 0f 92 5c 2e 5f 53 42 5f 4f 4b 45 43 a4 0a ff  ...\._SB_OKEC...
  3d40: a0 17 92 93 68 0a 06 a0 10 92 93 68 0a 08 a0 09  ....h......h....
  3d50: 92 93 68 0a 0a a4 0a 19 5b 23 4d 55 54 30 ff ff  ..h.....[#MUT0..
  3d60: 70 0a 04 60 a2 41 09 94 60 0a 01 a0 0b 93 68 0a  p..`.A..`.....h.
  3d70: 06 70 6b 53 4d 42 30 a0 0b 93 68 0a 08 70 6b 53  .pkSMB0...h..pkS
  3d80: 4d 57 30 a0 0b 93 68 0a 0a 70 6b 53 4d 44 30 7b  MW0...h..pkSMD0{
  3d90: 53 4d 53 54 0a 40 53 4d 53 54 70 6a 53 4d 43 4d  SMST.@SMSTpjSMCM
  3da0: 70 69 53 4d 41 44 70 68 53 4d 50 52 70 0a 00 63  piSMADphSMPRp..c
  3db0: a2 37 92 7b 53 4d 53 54 0a bf 61 5b 22 0a 02 75  .7.{SMST..a["..u
  3dc0: 63 a0 26 93 63 0a 32 7b 53 4d 53 54 0a 40 53 4d  c.&.c.2{SMST.@SM
  3dd0: 53 54 70 6a 53 4d 43 4d 70 69 53 4d 41 44 70 68  STpjSMCMpiSMADph
  3de0: 53 4d 50 52 70 0a 00 63 a0 09 93 61 0a 80 70 0a  SMPRp..c...a..p.
  3df0: 00 60 a1 03 76 60 a0 09 60 70 7b 61 0a 1f 00 60  .`..v`..`p{a...`
  3e00: 5b 27 4d 55 54 30 a4 60 14 13 42 50 4f 4c 01 70  ['MUT0.`..BPOL.p
  3e10: 68 44 42 50 4c 70 0a 01 45 42 50 4c 08 45 43 55  hDBPLp..EBPL.ECU
  3e20: 53 0a 00 08 42 41 54 4f 0a 00 08 42 41 54 4e 0a  S...BATO...BATN.
  3e30: 00 08 42 41 54 46 0a c0 14 45 06 5f 51 30 39 00  ..BATF...E._Q09.
  3e40: a0 4c 04 93 87 5c 5f 4f 53 5f 0a 14 86 5c 2e 5f  .L...\_OS_...\._
  3e50: 53 42 5f 42 41 54 31 0a 80 86 5c 2e 5f 53 42 5f  SB_BAT1...\._SB_
  3e60: 42 41 54 31 0a 00 86 5c 2e 5f 53 42 5f 42 41 54  BAT1...\._SB_BAT
  3e70: 32 0a 80 86 5c 2e 5f 53 42 5f 42 41 54 32 0a 00  2...\._SB_BAT2..
  3e80: 86 5c 2e 5f 53 42 5f 41 43 41 44 0a 00 a0 10 93  .\._SB_ACAD.....
  3e90: 87 5c 5f 4f 53 5f 0a 14 42 50 4f 4c 0a 3c 14 46  .\_OS_..BPOL.<.F
  3ea0: 09 5f 51 32 30 00 a0 4e 08 7b 53 4d 53 54 0a 40  ._Q20..N.{SMST.@
  3eb0: 00 70 53 4d 41 41 60 a0 4d 07 93 60 0a 14 53 45  .pSMAA`.M..`..SE
  3ec0: 4c 45 a0 16 7b 0a 40 42 41 54 46 00 86 5c 2e 5f  LE..{.@BATF..\._
  3ed0: 53 42 5f 42 41 54 31 0a 81 a0 16 7b 0a 80 42 41  SB_BAT1....{..BA
  3ee0: 54 46 00 86 5c 2e 5f 53 42 5f 42 41 54 32 0a 81  TF..\._SB_BAT2..
  3ef0: a0 16 7b 0a 02 42 41 54 46 00 86 5c 2e 5f 53 42  ..{..BATF..\._SB
  3f00: 5f 41 43 41 44 0a 00 86 5c 2e 5f 53 42 5f 42 41  _ACAD...\._SB_BA
  3f10: 54 31 0a 80 86 5c 2e 5f 53 42 5f 42 41 54 32 0a  T1...\._SB_BAT2.
  3f20: 80 70 42 41 54 44 42 41 54 4f 7b 53 4d 53 54 0a  .pBATDBATO{SMST.
  3f30: bf 53 4d 53 54 14 48 11 53 45 4c 45 00 70 42 41  .SMST.H.SELE.pBA
  3f40: 54 44 42 41 54 4e 70 0a 00 42 41 54 46 a0 14 7b  TDBATNp..BATF..{
  3f50: 0a c0 42 41 54 4e 00 7d 42 41 54 46 0a 01 42 41  ..BATN.}BATF..BA
  3f60: 54 46 a0 15 7b 0b 00 03 42 41 54 4e 00 7d 42 41  TF..{...BATN.}BA
  3f70: 54 46 0a 04 42 41 54 46 7b 42 41 54 4e 0a 01 60  TF..BATF{BATN..`
  3f80: 7b 42 41 54 4f 0a 01 61 a0 0e 60 7d 42 41 54 46  {BATO..a..`}BATF
  3f90: 0b 00 01 42 41 54 46 a1 0d 7b 42 41 54 46 0b ff  ...BATF..{BATF..
  3fa0: fe 42 41 54 46 a0 11 80 93 60 61 00 7d 42 41 54  .BATF....`a.}BAT
  3fb0: 46 0a 40 42 41 54 46 7b 42 41 54 4e 0a 02 60 7b  F.@BATF{BATN..`{
  3fc0: 42 41 54 4f 0a 02 61 a0 0e 60 7d 42 41 54 46 0b  BATO..a..`}BATF.
  3fd0: 00 02 42 41 54 46 a1 0d 7b 42 41 54 46 0b ff fd  ..BATF..{BATF...
  3fe0: 42 41 54 46 a0 11 80 93 60 61 00 7d 42 41 54 46  BATF....`a.}BATF
  3ff0: 0a 80 42 41 54 46 7b 42 41 54 4e 0a c0 60 7b 42  ..BATF{BATN..`{B
  4000: 41 54 4f 0a c0 61 a0 11 80 93 60 61 00 7d 42 41  ATO..a....`a.}BA
  4010: 54 46 0a 02 42 41 54 46 a0 35 7b 0a 01 42 41 54  TF..BATF.5{..BAT
  4020: 46 00 a0 2b 7b 0a 04 42 41 54 46 00 a0 14 7b 42  F..+{..BATF...{B
  4030: 41 54 4e 0a 20 00 7d 42 41 54 46 0a 10 42 41 54  ATN. .}BATF..BAT
  4040: 46 a1 0c 7d 42 41 54 46 0a 20 42 41 54 46 14 31  F..}BATF. BATF.1
  4050: 5f 51 30 44 00 70 0d 53 6c 65 65 70 20 42 75 74  _Q0D.p.Sleep But
  4060: 74 6f 6e 20 51 75 65 72 79 3a 20 46 6e 2b 46 34  ton Query: Fn+F4
  4070: 00 5b 31 86 5c 2e 5f 53 42 5f 53 4c 50 42 0a 80  .[1.\._SB_SLPB..
  4080: 14 1d 5f 51 30 45 00 5c 2f 05 5f 53 42 5f 50 43  .._Q0E.\/._SB_PC
  4090: 49 30 41 47 50 5f 56 47 41 5f 53 57 49 48 14 4c  I0AGP_VGA_SWIH.L
  40a0: 04 5f 51 31 33 00 70 0d 42 72 69 67 68 74 6e 65  ._Q13.p.Brightne
  40b0: 73 73 20 55 70 3a 20 46 6e 2b 2d 3e 00 5b 31 70  ss Up: Fn+->.[1p
  40c0: 0a 8c 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  40d0: 30 42 43 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f 50  0BCMDp..\/._SB_P
  40e0: 43 49 30 4c 50 43 30 53 4d 49 43 14 4e 04 5f 51  CI0LPC0SMIC.N._Q
  40f0: 31 32 00 70 0d 42 72 69 67 68 74 6e 65 73 73 20  12.p.Brightness 
  4100: 44 6f 77 6e 3a 20 46 6e 2b 3c 2d 00 5b 31 70 0a  Down: Fn+<-.[1p.
  4110: 8d 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  4120: 42 43 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f 50 43  BCMDp..\/._SB_PC
  4130: 49 30 4c 50 43 30 53 4d 49 43 14 34 5f 51 38 30  I0LPC0SMIC.4_Q80
  4140: 00 70 0d 54 65 6d 70 65 72 61 74 75 72 65 20 69  .p.Temperature i
  4150: 6e 63 72 65 61 73 69 6e 67 3a 20 5f 51 38 30 00  ncreasing: _Q80.
  4160: 5b 31 86 5c 2e 5f 54 5a 5f 54 48 52 4d 0a 80 14  [1.\._TZ_THRM...
  4170: 34 5f 51 38 31 00 70 0d 54 65 6d 70 65 72 61 74  4_Q81.p.Temperat
  4180: 75 72 65 20 64 65 63 72 65 61 73 69 6e 67 3a 20  ure decreasing: 
  4190: 5f 51 38 31 00 5b 31 86 5c 2e 5f 54 5a 5f 54 48  _Q81.[1.\._TZ_TH
  41a0: 52 4d 0a 80 5b 02 45 4a 54 31 14 4d 31 5f 51 38  RM..[.EJT1.M1_Q8
  41b0: 41 00 5b 01 4d 55 54 30 00 5b 01 4d 55 54 31 00  A.[.MUT0.[.MUT1.
  41c0: 70 0d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  p.--------------
  41d0: 2d 2d 2d 2d 5f 51 30 78 38 41 20 2d 2d 2d 2d 2d  ----_Q0x8A -----
  41e0: 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  ----------------
  41f0: 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d  ----------------
  4200: 2d 00 5b 31 a0 19 4c 49 44 45 70 0a 01 4c 49 44  -.[1..LIDEp..LID
  4210: 45 86 5c 2e 5f 53 42 5f 4c 49 44 5f 0a 80 a0 49  E.\._SB_LID_...I
  4220: 2a 44 42 32 45 70 0d 2d 2d 2d 2d 2d 2d 2d 2d 20  *DB2Ep.-------- 
  4230: 44 65 76 69 63 65 20 52 2d 42 61 79 20 45 76 65  Device R-Bay Eve
  4240: 6e 74 20 2d 2d 2d 2d 2d 2d 00 5b 31 70 0a 01 44  nt ------.[1p..D
  4250: 42 32 45 70 0a b1 50 38 30 48 a0 4d 26 7d 93 5c  B2Ep..P80H.M&}.\
  4260: 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 01  /._SB_PCI0MYOS..
  4270: 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53  .\/._SB_PCI0MYOS
  4280: 0a 03 00 a0 44 1b 44 42 32 53 70 0a b2 50 38 30  ....D.DB2Sp..P80
  4290: 48 70 0d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 20 44  Hp.----------- D
  42a0: 65 76 69 63 65 20 42 61 79 20 43 68 61 6e 67 65  evice Bay Change
  42b0: 20 53 74 61 74 75 73 20 2d 2d 2d 2d 2d 2d 2d 2d   Status --------
  42c0: 2d 2d 20 49 4e 20 00 5b 31 70 5c 2f 04 5f 53 42  -- IN .[1p\/._SB
  42d0: 5f 50 43 49 30 4c 50 43 30 52 42 49 44 60 70 60  _PCI0LPC0RBID`p`
  42e0: 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44 45 30 42  \/._SB_PCI0IDE0B
  42f0: 41 59 52 a0 26 93 60 0a 00 70 0a b4 50 38 30 48  AYR.&.`..p..P80H
  4300: 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  4310: 43 30 4c 56 33 37 5b 22 0a c8 a1 4d 11 70 0a b5  C0LV37["...M.p..
  4320: 50 38 30 48 70 0a 00 5c 2f 04 5f 53 42 5f 50 43  P80Hp..\/._SB_PC
  4330: 49 30 4c 50 43 30 4c 56 33 37 5b 22 0a 64 70 0a  I0LPC0LV37[".dp.
  4340: 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  4350: 4c 56 33 39 5b 22 0a c8 70 0a 01 5c 2f 04 5f 53  LV39["..p..\/._S
  4360: 42 5f 50 43 49 30 4c 50 43 30 4c 56 33 39 5b 22  B_PCI0LPC0LV39["
  4370: 0b c4 09 5b 22 0a c8 5b 22 0a c8 5b 22 0a 64 70  ...["..["..[".dp
  4380: 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44 45  ..\/._SB_PCI0IDE
  4390: 30 53 53 49 47 70 0a 01 5c 2f 04 5f 53 42 5f 50  0SSIGp..\/._SB_P
  43a0: 43 49 30 49 44 45 30 55 44 43 31 70 0a 02 5c 2f  CI0IDE0UDC1p..\/
  43b0: 04 5f 53 42 5f 50 43 49 30 49 44 45 30 55 44 54  ._SB_PCI0IDE0UDT
  43c0: 31 7d 5c 2f 04 5f 53 42 5f 50 43 49 30 49 44 45  1}\/._SB_PCI0IDE
  43d0: 30 46 53 43 42 0a 04 5c 2f 04 5f 53 42 5f 50 43  0FSCB..\/._SB_PC
  43e0: 49 30 49 44 45 30 46 53 43 42 70 0b 03 e3 5c 2f  I0IDE0FSCBp...\/
  43f0: 04 5f 53 42 5f 50 43 49 30 49 44 45 30 49 54 4d  ._SB_PCI0IDE0ITM
  4400: 31 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 49  1p..\/._SB_PCI0I
  4410: 44 45 30 53 53 49 47 86 5c 2f 05 5f 53 42 5f 50  DE0SSIG.\/._SB_P
  4420: 43 49 30 49 44 45 30 53 45 43 4e 42 41 59 31 0a  CI0IDE0SECNBAY1.
  4430: 00 70 0a b6 50 38 30 48 a1 4f 08 70 0a b7 50 38  .p..P80H.O.p..P8
  4440: 30 48 70 0d 2d 2d 2d 2d 2d 2d 2d 2d 20 44 65 76  0Hp.-------- Dev
  4450: 69 63 65 20 42 61 79 20 45 76 65 6e 74 20 2d 2d  ice Bay Event --
  4460: 2d 2d 2d 2d 20 4f 55 54 20 00 5b 31 70 5c 2f 04  ---- OUT .[1p\/.
  4470: 5f 53 42 5f 50 43 49 30 49 44 45 30 42 41 59 52  _SB_PCI0IDE0BAYR
  4480: 60 70 0a 01 5c 2f 04 5f 53 42 5f 50 43 49 30 4c  `p..\/._SB_PCI0L
  4490: 50 43 30 4c 56 33 37 5b 22 0a c8 a0 2c 7d 93 60  PC0LV37["...,}.`
  44a0: 0a 01 93 60 0a 02 00 86 5c 2f 05 5f 53 42 5f 50  ...`....\/._SB_P
  44b0: 43 49 30 49 44 45 30 53 45 43 4e 42 41 59 31 0a  CI0IDE0SECNBAY1.
  44c0: 01 70 0a b8 50 38 30 48 5b 80 53 4d 49 30 01 0c  .p..P80H[.SMI0..
  44d0: 00 fe 00 00 0c 02 00 00 00 5b 81 0b 53 4d 49 30  .........[..SMI0
  44e0: 00 53 4d 49 43 08 5b 80 53 4d 49 31 00 0c bd ce  .SMIC.[.SMI1....
  44f0: ef 1f 0c 90 00 00 00 5b 81 16 53 4d 49 31 00 42  .......[..SMI1.B
  4500: 43 4d 44 08 44 49 44 5f 20 49 4e 46 4f 40 40 5b  CMD.DID_ INFO@@[
  4510: 81 10 53 4d 49 31 00 01 01 00 00 28 49 4e 46 5f  ..SMI1.....(INF_
  4520: 08 5b 82 1b 4d 44 4d 30 08 5f 41 44 52 0c 06 00  .[..MDM0._ADR...
  4530: 1f 00 08 5f 50 52 57 12 06 02 0a 05 0a 03 5b 82  ..._PRW.......[.
  4540: 86 14 01 49 44 45 30 08 5f 41 44 52 0c 01 00 1f  ...IDE0._ADR....
  4550: 00 5b 80 50 43 49 5f 02 0a 00 0a 58 5b 81 44 04  .[.PCI_....X[.D.
  4560: 50 43 49 5f 03 00 18 00 07 53 49 44 45 01 00 40  PCI_.....SIDE..@
  4570: 1f 00 01 45 49 4f 52 01 00 0d 45 53 49 44 01 00  ...EIOR...ESID..
  4580: 20 55 4d 41 30 01 55 4d 41 31 01 55 4d 41 32 01   UMA0.UMA1.UMA2.
  4590: 55 4d 41 33 01 00 4c 06 50 53 49 47 02 53 53 49  UMA3..L.PSIG.SSI
  45a0: 47 02 5b 81 45 06 50 43 49 5f 03 00 40 20 49 54  G.[.E.PCI_..@ IT
  45b0: 4d 30 10 49 54 4d 31 10 53 49 54 30 04 53 49 54  M0.ITM1.SIT0.SIT
  45c0: 31 04 00 18 55 44 43 30 02 55 44 43 31 02 00 0c  1...UDC0.UDC1...
  45d0: 55 44 54 30 08 55 44 54 31 08 00 40 04 49 43 46  UDT0.UDT1..@.ICF
  45e0: 30 02 49 43 46 31 02 43 42 38 30 04 00 02 57 50  0.ICF1.CB80...WP
  45f0: 50 45 01 00 01 46 53 43 42 04 54 52 49 50 02 54  PE...FSCB.TRIP.T
  4600: 52 49 53 02 46 41 54 53 04 08 54 49 4d 30 12 11  RIS.FATS..TIM0..
  4610: 01 12 0e 05 0a 78 0a b4 0a f0 0b 86 01 0b 58 02  .....x........X.
  4620: 08 54 49 4d 31 12 0c 01 12 09 03 0a 78 0a 96 0b  .TIM1.......x...
  4630: fe 01 08 54 49 4d 32 12 11 01 12 0e 06 0a 18 0a  ...TIM2.........
  4640: 1e 0a 2d 0a 3c 0a 5a 0a 78 08 41 54 30 31 11 0a  ..-.<.Z.x.AT01..
  4650: 0a 07 03 00 00 00 00 00 ef 08 41 54 30 32 11 0a  ..........AT02..
  4660: 0a 07 00 00 00 00 00 00 90 08 41 54 30 33 11 0a  ..........AT03..
  4670: 0a 07 00 00 00 00 00 00 c6 08 41 54 30 34 11 0a  ..........AT04..
  4680: 0a 07 00 00 00 00 00 00 91 08 41 54 41 30 11 03  ..........ATA0..
  4690: 0a 1d 08 41 54 41 31 11 03 0a 1d 08 41 54 41 32  ...ATA1.....ATA2
  46a0: 11 03 0a 1d 08 41 54 41 33 11 03 0a 1d 08 41 54  .....ATA3.....AT
  46b0: 41 42 11 03 0a 0e 08 43 4d 44 43 0a 00 08 42 41  AB.....CMDC...BA
  46c0: 59 52 0a 00 14 1e 5f 49 4e 49 00 70 5c 2f 04 5f  YR...._INI.p\/._
  46d0: 53 42 5f 50 43 49 30 4c 50 43 30 52 42 49 44 42  SB_PCI0LPC0RBIDB
  46e0: 41 59 52 14 47 05 47 54 46 42 0b 77 43 4d 44 43  AYR.G.GTFB.wCMDC
  46f0: 0a 38 60 5b 13 41 54 41 42 60 0a 38 43 4d 44 58  .8`[.ATAB`.8CMDX
  4700: 77 43 4d 44 43 0a 07 60 8c 41 54 41 42 72 60 0a  wCMDC..`.ATABr`.
  4710: 01 00 41 30 30 31 8c 41 54 41 42 72 60 0a 05 00  ..A001.ATABr`...
  4720: 41 30 30 35 70 68 43 4d 44 58 70 69 41 30 30 31  A005phCMDXpiA001
  4730: 70 6a 41 30 30 35 75 43 4d 44 43 5b 01 47 54 46  pjA005uCMDC[.GTF
  4740: 4d 00 14 4e 20 47 54 46 5f 0b 5b 23 47 54 46 4d  M..N GTF_.[#GTFM
  4750: ff ff 8a 6a 0a 00 50 49 4f 30 8a 6a 0a 04 44 4d  ...j..PIO0.j..DM
  4760: 41 30 8a 6a 0a 08 50 49 4f 31 8a 6a 0a 0c 44 4d  A0.j..PIO1.j..DM
  4770: 41 31 8a 6a 0a 10 43 48 4e 46 70 0a 00 43 4d 44  A1.j..CHNFp..CMD
  4780: 43 08 49 44 30 30 0a 80 08 49 44 34 39 0b 00 0c  C.ID00...ID49...
  4790: 08 49 44 35 39 0a 00 08 49 44 35 33 0a 04 08 49  .ID59...ID53...I
  47a0: 44 36 33 0b 00 0f 08 49 44 38 38 0b 00 0f 08 49  D63....ID88....I
  47b0: 52 44 59 0a 01 08 50 49 4f 54 0a 00 08 44 4d 41  RDY...PIOT...DMA
  47c0: 54 0a 00 a0 4e 06 93 87 69 0b 00 02 8c 69 0a 00  T...N...i....i..
  47d0: 49 42 30 30 70 49 42 30 30 49 44 30 30 8b 69 0a  IB00pIB00ID00.i.
  47e0: 62 49 57 34 39 70 49 57 34 39 49 44 34 39 8b 69  bIW49pIW49ID49.i
  47f0: 0a 6a 49 57 35 33 70 49 57 35 33 49 44 35 33 8b  .jIW53pIW53ID53.
  4800: 69 0a 7e 49 57 36 33 70 49 57 36 33 49 44 36 33  i.~IW63pIW63ID63
  4810: 8b 69 0a 76 49 57 35 39 70 49 57 35 39 49 44 35  .i.vIW59pIW59ID5
  4820: 39 8b 69 0a b0 49 57 38 38 70 49 57 38 38 49 44  9.i..IW88pIW88ID
  4830: 38 38 a1 06 a4 41 54 41 42 70 0a a0 67 a0 48 05  88...ATABp..g.H.
  4840: 68 70 0a b0 67 7b 43 48 4e 46 0a 08 49 52 44 59  hp..g{CHNF..IRDY
  4850: a0 12 7b 43 48 4e 46 0a 10 00 70 50 49 4f 31 50  ..{CHNF...pPIO1P
  4860: 49 4f 54 a1 0a 70 50 49 4f 30 50 49 4f 54 a0 27  IOT..pPIO0PIOT.'
  4870: 7b 43 48 4e 46 0a 04 00 a0 12 7b 43 48 4e 46 0a  {CHNF.....{CHNF.
  4880: 10 00 70 44 4d 41 31 44 4d 41 54 a1 0a 70 44 4d  ..pDMA1DMAT..pDM
  4890: 41 30 44 4d 41 54 a1 28 7b 43 48 4e 46 0a 02 49  A0DMAT.({CHNF..I
  48a0: 52 44 59 70 50 49 4f 30 50 49 4f 54 a0 12 7b 43  RDYpPIO0PIOT..{C
  48b0: 48 4e 46 0a 01 00 70 44 4d 41 30 44 4d 41 54 a0  HNF...pDMA0DMAT.
  48c0: 36 90 7b 49 44 35 33 0a 04 00 7b 49 44 38 38 0a  6.{ID53...{ID88.
  48d0: ff 00 70 0a 00 61 7b 49 44 38 38 0a ff 62 a2 07  ..p..a{ID88..b..
  48e0: 7a 62 61 00 75 61 76 61 47 54 46 42 41 54 30 31  zba.uavaGTFBAT01
  48f0: 7d 0a 40 61 00 67 a0 37 49 52 44 59 70 89 83 88  }.@a.g.7IRDYp...
  4900: 54 49 4d 30 0a 00 00 04 50 49 4f 54 00 0a 00 0a  TIM0....PIOT....
  4910: 00 61 a0 08 93 61 ff 70 0a 04 61 74 0a 04 61 61  .a...a.p..at..aa
  4920: 47 54 46 42 41 54 30 31 7d 0a 08 61 00 67 a1 17  GTFBAT01}..a.g..
  4930: a0 15 7b 49 44 34 39 0b 00 04 00 47 54 46 42 41  ..{ID49....GTFBA
  4940: 54 30 31 0a 01 67 5b 27 47 54 46 4d a4 41 54 41  T01..g['GTFM.ATA
  4950: 42 14 25 52 41 54 41 01 8c 68 0a 00 43 4d 44 4e  B.%RATA..h..CMDN
  4960: 77 43 4d 44 4e 0a 38 60 5b 13 68 0a 08 60 52 45  wCMDN.8`[.h..`RE
  4970: 54 42 a4 52 45 54 42 08 52 45 47 46 0a 01 14 12  TB.RETB.REGF....
  4980: 5f 52 45 47 02 a0 0b 93 68 0a 02 70 69 52 45 47  _REG....h..piREG
  4990: 46 08 42 41 59 44 0a 00 14 09 5f 53 54 41 00 a4  F.BAYD...._STA..
  49a0: 0a 0f 14 48 1b 47 54 4d 5f 06 70 11 03 0a 14 60  ...H.GTM_.p....`
  49b0: 8a 60 0a 00 50 49 4f 30 8a 60 0a 04 44 4d 41 30  .`..PIO0.`..DMA0
  49c0: 8a 60 0a 08 50 49 4f 31 8a 60 0a 0c 44 4d 41 31  .`..PIO1.`..DMA1
  49d0: 8a 60 0a 10 46 4c 41 47 a0 15 91 7b 68 0a 08 00  .`..FLAG...{h...
  49e0: 92 7b 68 0a 01 00 70 0b 84 03 50 49 4f 30 a1 23  .{h...p...PIO0.#
  49f0: 72 7a 7b 68 0b 00 03 00 0a 08 00 7a 7b 68 0b 00  rz{h.......z{h..
  4a00: 30 00 0a 0c 00 61 77 74 0a 09 61 00 0a 1e 50 49  0....awt..a...PI
  4a10: 4f 30 a0 3b 7b 68 0b 00 40 00 a0 15 91 7b 68 0a  O0.;{h..@....{h.
  4a20: 80 00 92 7b 68 0a 10 00 70 0b 84 03 50 49 4f 31  ...{h...p...PIO1
  4a30: a1 1d 72 7b 69 0a 03 00 7a 7b 69 0a 0c 00 0a 02  ..r{i...z{i.....
  4a40: 00 61 77 74 0a 09 61 00 0a 1e 50 49 4f 31 a1 0a  .awt..a...PIO1..
  4a50: 70 50 49 4f 30 50 49 4f 31 a0 38 7b 6a 0a 01 00  pPIO0PIO1.8{j...
  4a60: a0 0d 7b 6d 0a 01 00 70 0a 08 44 4d 41 30 a1 23  ..{m...p..DMA0.#
  4a70: 74 0a 04 7b 6b 0a 03 00 61 a0 0e 7b 6c 0a 01 00  t..{k...a..{l...
  4a80: 77 61 0a 0f 44 4d 41 30 a1 09 77 61 0a 1e 44 4d  wa..DMA0..wa..DM
  4a90: 41 30 a1 0a 70 50 49 4f 30 44 4d 41 30 a0 40 05  A0..pPIO0DMA0.@.
  4aa0: 7b 68 0b 00 40 00 a0 3c 7b 6a 0a 02 00 a0 0d 7b  {h..@..<{j.....{
  4ab0: 6d 0a 02 00 70 0a 08 44 4d 41 31 a1 27 74 0a 04  m...p..DMA1.'t..
  4ac0: 7a 7b 6b 0a 30 00 0a 04 00 61 a0 0e 7b 6c 0a 02  z{k.0....a..{l..
  4ad0: 00 77 61 0a 0f 44 4d 41 31 a1 09 77 61 0a 1e 44  .wa..DMA1..wa..D
  4ae0: 4d 41 31 a1 0a 70 50 49 4f 31 44 4d 41 31 a1 0a  MA1..pPIO1DMA1..
  4af0: 70 44 4d 41 30 44 4d 41 31 70 00 46 4c 41 47 a0  pDMA0DMA1p.FLAG.
  4b00: 11 7b 68 0a 01 00 7d 46 4c 41 47 0a 10 46 4c 41  .{h...}FLAG..FLA
  4b10: 47 a0 11 7b 6a 0a 01 00 7d 46 4c 41 47 0a 01 46  G..{j...}FLAG..F
  4b20: 4c 41 47 a0 11 7b 68 0a 02 00 7d 46 4c 41 47 0a  LAG..{h...}FLAG.
  4b30: 02 46 4c 41 47 a0 11 7b 6a 0a 02 00 7d 46 4c 41  .FLAG..{j...}FLA
  4b40: 47 0a 04 46 4c 41 47 a0 11 7b 68 0a 20 00 7d 46  G..FLAG..{h. .}F
  4b50: 4c 41 47 0a 08 46 4c 41 47 a4 60 14 41 52 53 54  LAG..FLAG.`.ARST
  4b60: 4d 53 03 70 11 03 0a 18 67 8a 67 0a 00 49 54 4d  MS.p....g.g..ITM
  4b70: 5f 8a 67 0a 04 53 49 54 5f 8a 67 0a 08 55 44 43  _.g..SIT_.g..UDC
  4b80: 5f 8a 67 0a 0c 55 44 54 5f 8a 67 0a 10 49 43 46  _.g..UDT_.g..ICF
  4b90: 5f 8a 67 0a 14 41 31 30 30 70 0a 01 57 50 50 45  _.g..A100p..WPPE
  4ba0: 8a 68 0a 00 50 49 4f 30 8a 68 0a 04 44 4d 41 30  .h..PIO0.h..DMA0
  4bb0: 8a 68 0a 08 50 49 4f 31 8a 68 0a 0c 44 4d 41 31  .h..PIO1.h..DMA1
  4bc0: 8a 68 0a 10 46 4c 41 47 70 46 4c 41 47 64 70 0b  .h..FLAGpFLAGdp.
  4bd0: 00 40 60 08 57 34 39 4d 0a 00 08 57 35 33 4d 0a  .@`.W49M...W53M.
  4be0: 00 08 57 36 32 4d 0a 00 08 57 36 34 4d 0a 00 08  ..W62M...W64M...
  4bf0: 57 38 38 4d 0a 00 a0 41 08 93 87 69 0b 00 02 8a  W88M...A...i....
  4c00: 69 0a 00 57 30 30 41 8a 69 0a 62 57 34 39 41 8a  i..W00A.i.bW49A.
  4c10: 69 0a 6a 57 35 33 41 8a 69 0a 7c 57 36 32 41 8a  i.jW53A.i.|W62A.
  4c20: 69 0a 80 57 36 34 41 8a 69 0a b0 57 38 38 41 70  i..W64A.i..W88Ap
  4c30: 57 34 39 41 57 34 39 4d 70 57 35 33 41 57 35 33  W49AW49MpW53AW53
  4c40: 4d 70 57 36 32 41 57 36 32 4d 70 57 36 34 41 57  MpW62AW62MpW64AW
  4c50: 36 34 4d 70 57 38 38 41 57 38 38 4d a0 0b 57 30  64MpW88AW88M..W0
  4c60: 30 41 7d 60 0b 00 80 60 a0 0f 92 7b 57 30 30 41  0A}`...`...{W00A
  4c70: 0a 80 00 7d 60 0a 04 60 a1 24 70 0a 00 57 34 39  ...}`..`.$p..W49
  4c80: 4d 70 0a 00 57 35 33 4d 70 0a 00 57 36 32 4d 70  Mp..W53Mp..W62Mp
  4c90: 0a 00 57 36 34 4d 70 0a 00 57 38 38 4d 08 57 34  ..W64Mp..W88M.W4
  4ca0: 39 53 0a 00 08 57 35 33 53 0a 00 08 57 36 32 53  9S...W53S...W62S
  4cb0: 0a 00 08 57 36 34 53 0a 00 08 57 38 38 53 0a 00  ...W64S...W88S..
  4cc0: a0 41 08 93 87 6a 0b 00 02 8a 6a 0a 00 57 30 30  .A...j....j..W00
  4cd0: 42 8a 6a 0a 62 57 34 39 42 8a 6a 0a 6a 57 35 33  B.j.bW49B.j.jW53
  4ce0: 42 8a 6a 0a 7c 57 36 32 42 8a 6a 0a 80 57 36 34  B.j.|W62B.j..W64
  4cf0: 42 8a 6a 0a b0 57 38 38 42 70 57 34 39 42 57 34  B.j..W88BpW49BW4
  4d00: 39 53 70 57 35 33 42 57 35 33 53 70 57 36 32 42  9SpW53BW53SpW62B
  4d10: 57 36 32 53 70 57 36 34 42 57 36 34 53 70 57 38  W62SpW64BW64SpW8
  4d20: 38 42 57 38 38 53 a0 0b 57 30 30 42 7d 60 0b 00  8BW88S..W00B}`..
  4d30: 80 60 a0 0f 92 7b 57 30 30 42 0a 80 00 7d 60 0a  .`...{W00B...}`.
  4d40: 40 60 a1 24 70 0a 00 57 34 39 53 70 0a 00 57 35  @`.$p..W49Sp..W5
  4d50: 33 53 70 0a 00 57 36 32 53 70 0a 00 57 36 34 53  3Sp..W62Sp..W64S
  4d60: 70 0a 00 57 38 38 53 70 0a 00 41 31 30 30 a0 40  p..W88Sp..A100.@
  4d70: 05 7b 0a 38 57 38 38 4d 00 a0 1e 7b 0a 20 57 38  .{.8W88M...{. W8
  4d80: 38 4d 00 70 0a 08 44 4d 41 30 7d 41 31 30 30 0c  8M.p..DMA0}A100.
  4d90: 10 00 10 00 41 31 30 30 a1 26 a0 1b 7b 0a 10 57  ....A100.&..{..W
  4da0: 38 38 4d 00 70 0a 1e 44 4d 41 30 7d 41 31 30 30  88M.p..DMA0}A100
  4db0: 0a 10 41 31 30 30 a1 08 70 0a 2d 44 4d 41 30 a1  ..A100..p.-DMA0.
  4dc0: 46 04 a0 43 04 7b 0a 07 57 38 38 4d 00 7d 0b 00  F..C.{..W88M.}..
  4dd0: 01 41 31 30 30 41 31 30 30 a0 10 7b 0a 04 57 38  .A100A100..{..W8
  4de0: 38 4d 00 70 0a 3c 44 4d 41 30 a1 1b a0 10 7b 0a  8M.p.<DMA0....{.
  4df0: 02 57 38 38 4d 00 70 0a 5a 44 4d 41 30 a1 08 70  .W88M.p.ZDMA0..p
  4e00: 0a 78 44 4d 41 30 a0 40 05 7b 0a 3f 57 38 38 53  .xDMA0.@.{.?W88S
  4e10: 00 a0 1e 7b 0a 20 57 38 38 53 00 70 0a 08 44 4d  ...{. W88S.p..DM
  4e20: 41 31 7d 41 31 30 30 0c 20 00 20 00 41 31 30 30  A1}A100. . .A100
  4e30: a1 26 a0 1b 7b 0a 10 57 38 38 53 00 70 0a 1e 44  .&..{..W88S.p..D
  4e40: 4d 41 31 7d 41 31 30 30 0a 20 41 31 30 30 a1 08  MA1}A100. A100..
  4e50: 70 0a 2d 44 4d 41 31 a0 15 90 7b 57 34 39 4d 0b  p.-DMA1...{W49M.
  4e60: 00 08 00 7b 64 0a 02 00 7d 60 0a 02 60 a0 0e 95  ...{d...}`..`...
  4e70: 50 49 4f 30 0b 84 03 7d 60 0a 01 60 a0 15 90 7b  PIO0...}`..`...{
  4e80: 57 34 39 53 0b 00 08 00 7b 64 0a 08 00 7d 60 0a  W49S....{d...}`.
  4e90: 20 60 a0 0e 95 50 49 4f 31 0b 84 03 7d 60 0a 10   `...PIO1...}`..
  4ea0: 60 a0 0c 7b 64 0a 01 00 70 50 49 4f 30 61 a1 07  `..{d...pPIO0a..
  4eb0: 70 44 4d 41 30 61 a0 0b 92 95 61 0a f0 7d 60 0a  pDMA0a....a..}`.
  4ec0: 08 60 a1 42 04 a0 37 7b 57 35 33 4d 0a 02 00 a0  .`.B..7{W53M....
  4ed0: 15 90 7b 57 36 34 4d 0a 02 00 92 94 61 0a 78 7d  ..{W64M.....a.x}
  4ee0: 60 0b 01 23 60 a1 17 a0 15 90 7b 57 36 34 4d 0a  `..#`.....{W64M.
  4ef0: 01 00 92 94 61 0a b4 7d 60 0b 01 21 60 a1 07 7d  ....a..}`..!`..}
  4f00: 60 0b 01 10 60 70 60 49 54 4d 5f 70 00 60 a0 0c  `...`p`ITM_p.`..
  4f10: 7b 64 0a 04 00 70 50 49 4f 31 61 a1 07 70 44 4d  {d...pPIO1a..pDM
  4f20: 41 31 61 a0 41 06 7b 64 0a 10 00 a0 11 92 95 61  A1a.A.{d.......a
  4f30: 0a f0 7d 0a 80 49 54 4d 5f 49 54 4d 5f a1 47 04  ..}..ITM_ITM_.G.
  4f40: 7d 0a 10 49 54 4d 5f 49 54 4d 5f a0 33 7b 57 35  }..ITM_ITM_.3{W5
  4f50: 33 53 0a 02 00 a0 13 90 7b 57 36 34 53 0a 02 00  3S......{W64S...
  4f60: 92 94 61 0a 78 70 0a 0b 60 a1 15 a0 13 90 7b 57  ..a.xp..`.....{W
  4f70: 36 34 53 0a 01 00 92 94 61 0a b4 70 0a 09 60 a1  64S.....a..p..`.
  4f80: 05 70 0a 04 60 70 60 53 49 54 5f 70 0a 00 60 a0  .p..`p`SIT_p..`.
  4f90: 14 90 7b 0a 3f 57 38 38 4d 00 7b 64 0a 01 00 7d  ..{.?W88M.{d...}
  4fa0: 60 0a 01 60 a0 0b 7b 64 0a 04 00 7d 60 0a 02 60  `..`..{d...}`..`
  4fb0: 70 60 55 44 43 5f 70 0a 00 60 a0 45 04 7b 64 0a  p`UDC_p..`.E.{d.
  4fc0: 01 00 a0 19 95 44 4d 41 30 0a 1e 7d 41 31 30 30  .....DMA0..}A100
  4fd0: 0b 00 10 41 31 30 30 7d 60 0a 01 60 a1 23 a0 11  ...A100}`..`.#..
  4fe0: 95 44 4d 41 30 0a 3c 78 44 4d 41 30 0a 0f 00 61  .DMA0.<xDMA0...a
  4ff0: a1 0a 78 44 4d 41 30 0a 1e 00 61 74 0a 04 61 60  ..xDMA0...at..a`
  5000: a0 4e 04 7b 64 0a 04 00 a0 19 95 44 4d 41 31 0a  .N.{d......DMA1.
  5010: 1e 7d 41 31 30 30 0b 00 20 41 31 30 30 7d 60 0a  .}A100.. A100}`.
  5020: 10 60 a1 2c a0 11 95 44 4d 41 31 0a 3c 78 44 4d  .`.,...DMA1.<xDM
  5030: 41 31 0a 0f 00 61 a1 0a 78 44 4d 41 31 0a 1e 00  A1...a..xDMA1...
  5040: 61 74 0a 04 61 61 79 61 0a 04 61 7d 60 61 60 70  at..aaya..a}`a`p
  5050: 60 55 44 54 5f 70 0a 00 60 a0 0d 95 44 4d 41 30  `UDT_p..`...DMA0
  5060: 0a 3c 7d 60 0a 01 60 a0 0d 95 44 4d 41 31 0a 3c  .<}`..`...DMA1.<
  5070: 7d 60 0a 02 60 70 60 49 43 46 5f a4 67 14 49 0f  }`..`p`ICF_.g.I.
  5080: 47 54 46 30 07 70 11 0a 0a 07 03 00 00 00 00 a0  GTF0.p..........
  5090: ef 67 8c 67 0a 01 4d 4f 44 45 a0 2f 7b 6a 0a 01  .g.g..MODE./{j..
  50a0: 00 a0 0d 7b 6e 0a 01 00 70 0a 45 4d 4f 44 45 a1  ...{n...p.EMODE.
  50b0: 1a 7b 6b 0a 03 60 a0 0b 7b 6c 0a 01 00 72 60 0a  .{k..`..{l...r`.
  50c0: 02 60 7d 60 0a 40 4d 4f 44 45 a1 3e 72 7a 7b 68  .`}`.@MODE.>rz{h
  50d0: 0b 00 03 00 0a 08 00 7a 7b 68 0b 00 30 00 0a 0c  .......z{h..0...
  50e0: 00 60 a0 0d 92 95 60 0a 05 70 0a 22 4d 4f 44 45  .`....`..p."MODE
  50f0: a1 18 a0 0d 92 95 60 0a 03 70 0a 21 4d 4f 44 45  ......`..p.!MODE
  5100: a1 08 70 0a 20 4d 4f 44 45 73 67 67 66 a0 24 91  ..p. MODEsggf.$.
  5110: 7b 68 0a 08 00 92 7b 68 0a 01 00 a0 0d 7b 68 0a  {h....{h.....{h.
  5120: 02 00 70 0a 00 4d 4f 44 45 a1 08 70 0a 08 4d 4f  ..p..MODE..p..MO
  5130: 44 45 a1 3e 72 7a 7b 68 0b 00 03 00 0a 08 00 7a  DE.>rz{h.......z
  5140: 7b 68 0b 00 30 00 0a 0c 00 60 a0 0d 92 95 60 0a  {h..0....`....`.
  5150: 05 70 0a 0c 4d 4f 44 45 a1 18 a0 0d 92 95 60 0a  .p..MODE......`.
  5160: 03 70 0a 0b 4d 4f 44 45 a1 08 70 0a 0a 4d 4f 44  .p..MODE..p..MOD
  5170: 45 73 66 67 65 a4 65 08 42 30 34 5f 11 03 0a 04  Esfge.e.B04_....
  5180: 08 42 32 30 5f 11 03 0a 04 08 42 34 30 5f 11 03  .B20_.....B40_..
  5190: 0a 04 5b 82 4f 17 50 52 49 4d 08 5f 41 44 52 0a  ..[.O.PRIM._ADR.
  51a0: 00 08 5f 50 53 43 0a 00 14 0d 5f 50 53 30 00 70  .._PSC...._PS0.p
  51b0: 0a 00 5f 50 53 43 14 0d 5f 50 53 33 00 70 0a 03  .._PSC.._PS3.p..
  51c0: 5f 50 53 43 14 3b 5f 47 54 4d 00 70 11 04 0a 14  _PSC.;_GTM.p....
  51d0: 00 60 70 5e 5e 47 54 4d 5f 5e 5e 49 54 4d 30 5e  .`p^^GTM_^^ITM0^
  51e0: 5e 53 49 54 30 5e 5e 55 44 43 30 5e 5e 55 44 54  ^SIT0^^UDC0^^UDT
  51f0: 30 5e 5e 49 43 46 30 5e 5e 46 53 43 42 60 a4 60  0^^ICF0^^FSCB`.`
  5200: 14 4e 0e 5f 53 54 4d 03 70 47 54 46 5f 0a 00 69  .N._STM.pGTF_..i
  5210: 68 41 54 41 30 70 47 54 46 5f 0a 01 6a 68 41 54  hATA0pGTF_..jhAT
  5220: 41 31 70 5e 5e 53 54 4d 53 68 69 6a 60 8a 60 0a  A1p^^STMShij`.`.
  5230: 00 49 54 4d 5f 8a 60 0a 04 53 49 54 5f 8a 60 0a  .ITM_.`..SIT_.`.
  5240: 08 55 44 43 5f 8a 60 0a 0c 55 44 54 5f 8a 60 0a  .UDC_.`..UDT_.`.
  5250: 10 49 43 46 5f 70 49 54 4d 5f 5e 5e 49 54 4d 30  .ICF_pITM_^^ITM0
  5260: 70 53 49 54 5f 5e 5e 53 49 54 30 70 55 44 43 5f  pSIT_^^SIT0pUDC_
  5270: 5e 5e 55 44 43 30 70 55 44 54 5f 5e 5e 55 44 54  ^^UDC0pUDT_^^UDT
  5280: 30 8a 60 0a 14 41 31 30 30 7d 7b 5e 5e 43 42 38  0.`..A100}{^^CB8
  5290: 30 0a 0c 00 7a 7b 0a 30 41 31 30 30 00 0a 04 00  0...z{.0A100....
  52a0: 5e 5e 43 42 38 30 7d 7b 5e 5e 46 53 43 42 0a 0c  ^^CB80}{^^FSCB..
  52b0: 00 7a 7b 0b 00 30 41 31 30 30 00 0a 0c 00 5e 5e  .z{..0A100....^^
  52c0: 46 53 43 42 7d 7b 5e 5e 46 41 54 53 0a 0c 00 7a  FSCB}{^^FATS...z
  52d0: 7b 0c 00 00 30 00 41 31 30 30 00 0a 14 00 5e 5e  {...0.A100....^^
  52e0: 46 41 54 53 70 49 43 46 5f 5e 5e 49 43 46 30 5b  FATSpICF_^^ICF0[
  52f0: 82 22 4d 41 53 54 08 5f 41 44 52 0a 00 08 48 31  ."MAST._ADR...H1
  5300: 35 46 00 14 0f 5f 47 54 46 00 a4 52 41 54 41 41  5F..._GTF..RATAA
  5310: 54 41 30 5b 82 4a 2f 53 45 43 4e 08 5f 41 44 52  TA0[.J/SECN._ADR
  5320: 0a 01 08 46 41 53 54 0a 63 14 14 5f 53 54 41 00  ...FAST.c.._STA.
  5330: a0 08 45 53 49 44 a4 0a 0f a1 04 a4 0a 08 08 5f  ..ESID........._
  5340: 50 53 43 0a 00 14 0d 5f 50 53 30 00 70 0a 00 5f  PSC...._PS0.p.._
  5350: 50 53 43 14 0d 5f 50 53 33 00 70 0a 03 5f 50 53  PSC.._PS3.p.._PS
  5360: 43 14 44 04 5f 47 54 4d 00 70 11 04 0a 14 00 60  C.D._GTM.p.....`
  5370: 70 5e 5e 46 53 43 42 61 7a 61 0a 02 61 70 5e 5e  p^^FSCBaza..ap^^
  5380: 47 54 4d 5f 5e 5e 49 54 4d 31 5e 5e 53 49 54 31  GTM_^^ITM1^^SIT1
  5390: 5e 5e 55 44 43 31 5e 5e 55 44 54 31 5e 5e 49 43  ^^UDC1^^UDT1^^IC
  53a0: 46 31 61 60 a4 60 14 4e 0e 5f 53 54 4d 03 70 47  F1a`.`.N._STM.pG
  53b0: 54 46 5f 0a 00 69 68 41 54 41 32 70 47 54 46 5f  TF_..ihATA2pGTF_
  53c0: 0a 01 6a 68 41 54 41 33 70 5e 5e 53 54 4d 53 68  ..jhATA3p^^STMSh
  53d0: 69 6a 60 8a 60 0a 00 49 54 4d 5f 8a 60 0a 04 53  ij`.`..ITM_.`..S
  53e0: 49 54 5f 8a 60 0a 08 55 44 43 5f 8a 60 0a 0c 55  IT_.`..UDC_.`..U
  53f0: 44 54 5f 8a 60 0a 10 49 43 46 5f 70 49 54 4d 5f  DT_.`..ICF_pITM_
  5400: 5e 5e 49 54 4d 31 70 53 49 54 5f 5e 5e 53 49 54  ^^ITM1pSIT_^^SIT
  5410: 31 70 55 44 43 5f 5e 5e 55 44 43 31 70 55 44 54  1pUDC_^^UDC1pUDT
  5420: 5f 5e 5e 55 44 54 31 8a 60 0a 14 41 31 30 30 7d  _^^UDT1.`..A100}
  5430: 7b 5e 5e 43 42 38 30 0a 03 00 7a 7b 0a 30 41 31  {^^CB80...z{.0A1
  5440: 30 30 00 0a 02 00 5e 5e 43 42 38 30 7d 7b 5e 5e  00....^^CB80}{^^
  5450: 46 53 43 42 0a 03 00 7a 7b 0b 00 30 41 31 30 30  FSCB...z{..0A100
  5460: 00 0a 0a 00 5e 5e 46 53 43 42 7d 7b 5e 5e 46 41  ....^^FSCB}{^^FA
  5470: 54 53 0a 03 00 7a 7b 0c 00 00 30 00 41 31 30 30  TS...z{...0.A100
  5480: 00 0a 12 00 5e 5e 46 41 54 53 70 49 43 46 5f 5e  ....^^FATSpICF_^
  5490: 5e 49 43 46 31 5b 82 43 12 42 41 59 31 08 5f 41  ^ICF1[.C.BAY1._A
  54a0: 44 52 0a 00 08 48 31 35 46 00 08 45 4a 30 46 0a  DR...H15F..EJ0F.
  54b0: 00 14 0f 5f 47 54 46 00 a4 52 41 54 41 41 54 41  ..._GTF..RATAATA
  54c0: 32 14 4f 09 5f 53 54 41 00 a0 42 09 5c 2f 04 5f  2.O._STA..B.\/._
  54d0: 53 42 5f 50 43 49 30 49 44 45 30 45 53 49 44 5c  SB_PCI0IDE0ESID\
  54e0: 2f 05 5f 53 42 5f 50 43 49 30 49 44 45 30 53 45  /._SB_PCI0IDE0SE
  54f0: 43 4e 43 42 41 59 70 5e 5e 42 46 4c 47 60 a0 2e  CNCBAYp^^BFLG`..
  5500: 93 5e 5e 42 4e 55 4d 0a 01 a0 23 7b 60 0a 01 00  .^^BNUM...#{`...
  5510: a0 17 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  5520: 30 4c 56 33 37 a4 0a 08 a1 04 a4 0a 0f a1 2e a0  0LV37...........
  5530: 27 93 5e 5e 42 4e 55 4d 0a 02 a0 17 5c 2f 04 5f  '.^^BNUM....\/._
  5540: 53 42 5f 50 43 49 30 4c 50 43 30 4c 56 33 37 a4  SB_PCI0LPC0LV37.
  5550: 0a 08 a1 04 a4 0a 0f a1 04 a4 0a 08 a1 04 a4 0a  ................
  5560: 08 14 48 05 5f 45 4a 30 01 a0 40 05 68 70 0a 01  ..H._EJ0..@.hp..
  5570: 5e 5e 5e 53 53 49 47 5b 22 0a 32 70 0b 00 c0 5e  ^^^SSIG[".2p...^
  5580: 5e 5e 49 54 4d 31 70 0a 01 5c 2f 04 5f 53 42 5f  ^^ITM1p..\/._SB_
  5590: 50 43 49 30 4c 50 43 30 4c 56 33 37 5b 22 0a c8  PCI0LPC0LV37["..
  55a0: 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  55b0: 43 30 4c 56 33 39 5b 22 0a c8 08 42 4e 55 4d 0a  C0LV39["...BNUM.
  55c0: 00 08 42 46 4c 47 0a 00 14 46 04 43 42 41 59 00  ..BFLG...F.CBAY.
  55d0: 70 0a 00 42 4e 55 4d 70 0a 00 42 46 4c 47 70 5c  p..BNUMp..BFLGp\
  55e0: 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30 52 42  /._SB_PCI0LPC0RB
  55f0: 49 44 60 a0 1b 7d 93 60 0a 01 93 60 0a 02 00 75  ID`..}.`...`...u
  5600: 42 4e 55 4d 7d 42 46 4c 47 0a 01 42 46 4c 47 14  BNUM}BFLG..BFLG.
  5610: 4a 05 5f 50 53 30 00 a0 4b 04 7b 93 5f 50 53 43  J._PS0..K.{._PSC
  5620: 0a 03 93 5c 2e 5f 53 42 5f 53 54 41 54 0a 03 00  ...\._SB_STAT...
  5630: 70 0a 89 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  5640: 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f 53 42 5f  C0BCMDp..\/._SB_
  5650: 50 43 49 30 4c 50 43 30 53 4d 49 43 70 0a b0 50  PCI0LPC0SMICp..P
  5660: 38 30 48 70 0a 00 5f 50 53 43 14 14 5f 50 53 33  80Hp.._PSC.._PS3
  5670: 00 70 0a 03 5f 50 53 43 70 0a b3 50 38 30 48 08  .p.._PSCp..P80H.
  5680: 5f 50 53 43 0a 00 5b 82 4c 06 55 53 42 31 08 5f  _PSC..[.L.USB1._
  5690: 41 44 52 0c 00 00 1d 00 5b 80 55 53 42 4f 02 0a  ADR.....[.USBO..
  56a0: c4 0a 04 5b 81 0b 55 53 42 4f 01 52 53 45 4e 02  ...[..USBO.RSEN.
  56b0: 08 5f 50 52 57 12 06 02 0a 03 0a 03 14 37 5f 50  ._PRW........7_P
  56c0: 53 57 01 a0 18 68 70 0a 03 5c 2f 04 5f 53 42 5f  SW...hp..\/._SB_
  56d0: 50 43 49 30 55 53 42 31 52 53 45 4e a1 17 70 0a  PCI0USB1RSEN..p.
  56e0: 00 5c 2f 04 5f 53 42 5f 50 43 49 30 55 53 42 31  .\/._SB_PCI0USB1
  56f0: 52 53 45 4e 5b 82 4c 06 55 53 42 32 08 5f 41 44  RSEN[.L.USB2._AD
  5700: 52 0c 01 00 1d 00 5b 80 55 53 42 4f 02 0a c4 0a  R.....[.USBO....
  5710: 04 5b 81 0b 55 53 42 4f 01 52 53 45 4e 02 08 5f  .[..USBO.RSEN.._
  5720: 50 52 57 12 06 02 0a 04 0a 03 14 37 5f 50 53 57  PRW........7_PSW
  5730: 01 a0 18 68 70 0a 03 5c 2f 04 5f 53 42 5f 50 43  ...hp..\/._SB_PC
  5740: 49 30 55 53 42 32 52 53 45 4e a1 17 70 0a 00 5c  I0USB2RSEN..p..\
  5750: 2f 04 5f 53 42 5f 50 43 49 30 55 53 42 32 52 53  /._SB_PCI0USB2RS
  5760: 45 4e 5b 82 4c 06 55 53 42 33 08 5f 41 44 52 0c  EN[.L.USB3._ADR.
  5770: 02 00 1d 00 5b 80 55 53 42 4f 02 0a c4 0a 04 5b  ....[.USBO.....[
  5780: 81 0b 55 53 42 4f 01 52 53 45 4e 02 08 5f 50 52  ..USBO.RSEN.._PR
  5790: 57 12 06 02 0a 0c 0a 03 14 37 5f 50 53 57 01 a0  W........7_PSW..
  57a0: 18 68 70 0a 03 5c 2f 04 5f 53 42 5f 50 43 49 30  .hp..\/._SB_PCI0
  57b0: 55 53 42 33 52 53 45 4e a1 17 70 0a 00 5c 2f 04  USB3RSEN..p..\/.
  57c0: 5f 53 42 5f 50 43 49 30 55 53 42 33 52 53 45 4e  _SB_PCI0USB3RSEN
  57d0: 5b 82 4f 05 4c 49 44 5f 08 5f 48 49 44 0c 41 d0  [.O.LID_._HID.A.
  57e0: 0c 0d 08 4c 53 54 53 0a 00 14 47 04 5f 4c 49 44  ...LSTS...G._LID
  57f0: 00 a0 32 5c 2e 5f 53 42 5f 4f 4b 45 43 a0 1e 5c  ..2\._SB_OKEC..\
  5800: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43  /._SB_PCI0LPC0EC
  5810: 30 5f 4c 49 44 53 70 00 4c 53 54 53 a1 07 70 01  0_LIDSp.LSTS..p.
  5820: 4c 53 54 53 a1 07 70 00 4c 53 54 53 a4 4c 53 54  LSTS..p.LSTS.LST
  5830: 53 5b 82 47 0b 41 43 41 44 08 5f 48 49 44 0d 41  S[.G.ACAD._HID.A
  5840: 43 50 49 30 30 30 33 00 08 5f 50 43 4c 12 07 01  CPI0003.._PCL...
  5850: 5c 5f 53 42 5f 08 41 43 57 54 0a 00 14 4d 08 5f  \_SB_.ACWT...M._
  5860: 50 53 52 00 70 5c 2e 5f 53 42 5f 41 43 53 54 41  PSR.p\._SB_ACSTA
  5870: 43 57 54 a0 2d 5c 2e 5f 53 42 5f 4f 4b 45 43 70  CWT.-\._SB_OKECp
  5880: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45  \/._SB_PCI0LPC0E
  5890: 43 30 5f 41 43 44 46 5c 2e 5f 53 42 5f 41 43 53  C0_ACDF\._SB_ACS
  58a0: 54 a0 3d 92 93 41 43 57 54 5c 2e 5f 53 42 5f 41  T.=..ACWT\._SB_A
  58b0: 43 53 54 70 0a 8b 5c 2f 04 5f 53 42 5f 50 43 49  CSTp..\/._SB_PCI
  58c0: 30 4c 50 43 30 42 43 4d 44 70 0a 00 5c 2f 04 5f  0LPC0BCMDp..\/._
  58d0: 53 42 5f 50 43 49 30 4c 50 43 30 53 4d 49 43 a4  SB_PCI0LPC0SMIC.
  58e0: 5c 2e 5f 53 42 5f 41 43 53 54 14 10 56 54 4f 42  \._SB_ACST..VTOB
  58f0: 01 70 0a 01 60 79 60 68 60 a4 60 14 1b 42 54 4f  .p..`y`h`.`..BTO
  5900: 56 01 7a 68 0a 01 60 70 0a 00 61 a2 09 60 75 61  V.zh..`p..a..`ua
  5910: 7a 60 0a 01 60 a4 61 14 27 4d 4b 57 44 02 a0 0d  z`..`.a.'MKWD...
  5920: 7b 69 0a 80 00 70 0c 00 00 ff ff 60 a1 04 70 00  {i...p.....`..p.
  5930: 60 7d 60 68 60 7d 60 79 69 0a 08 00 60 a4 60 14  `}`h`}`yi...`.`.
  5940: 2e 50 4f 53 57 01 a0 23 7b 68 0b 00 80 00 a0 0c  .POSW..#{h......
  5950: 93 68 0b ff ff a4 0c ff ff ff ff a1 0e 80 68 60  .h............h`
  5960: 75 60 7b 60 0b ff ff 60 a4 60 a1 03 a4 68 14 13  u`{`...`.`...h..
  5970: 47 42 46 45 03 8c 68 69 54 49 44 58 70 54 49 44  GBFE..hiTIDXpTID
  5980: 58 6a 14 13 50 42 46 45 03 8c 68 69 54 49 44 58  Xj..PBFE..hiTIDX
  5990: 70 6a 54 49 44 58 14 46 06 49 54 4f 53 01 70 11  pjTIDX.F.ITOS.p.
  59a0: 0c 0a 09 30 00 00 00 00 00 00 00 00 60 70 11 14  ...0........`p..
  59b0: 0a 11 30 31 32 33 34 35 36 37 38 39 41 42 43 44  ..0123456789ABCD
  59c0: 45 46 00 67 70 0a 08 61 70 0a 00 62 70 0a 00 63  EF.gp..ap..bp..c
  59d0: a2 2a 61 76 61 7b 7a 68 79 61 0a 02 00 00 0a 0f  .*ava{zhya......
  59e0: 64 a0 05 64 70 ff 63 a0 13 63 47 42 46 45 67 64  d..dp.c..cGBFEgd
  59f0: 71 65 50 42 46 45 60 62 65 75 62 a4 60 5b 82 47  qePBFE`beub.`[.G
  5a00: 58 42 41 54 31 08 5f 48 49 44 0c 41 d0 0c 0a 08  XBAT1._HID.A....
  5a10: 5f 55 49 44 0a 01 08 5f 50 43 4c 12 07 01 5c 5f  _UID..._PCL...\_
  5a20: 53 42 5f 08 50 42 49 46 12 2c 0d 0a 01 0c ff ff  SB_.PBIF.,......
  5a30: ff ff 0c ff ff ff ff 0a 01 0c ff ff ff ff 0a fa  ................
  5a40: 0a 64 0a 0a 0a 19 0d 42 41 54 31 00 0d 20 00 0d  .d.....BAT1.. ..
  5a50: 20 00 0d 20 00 08 50 42 53 54 12 11 04 0a 00 0c   .. ..PBST......
  5a60: ff ff ff ff 0c ff ff ff ff 0b 10 27 08 42 41 53  ...........'.BAS
  5a70: 54 0a 00 08 46 41 53 54 0a 00 08 42 31 53 54 0a  T...FAST...B1ST.
  5a80: 0f 08 42 31 57 54 0a 00 14 4e 08 5f 53 54 41 00  ..B1WT...N._STA.
  5a90: a0 43 04 95 46 41 53 54 0a 10 75 46 41 53 54 a0  .C..FAST..uFAST.
  5aa0: 34 93 46 41 53 54 0a 10 70 0a 92 5c 2f 04 5f 53  4.FAST..p..\/._S
  5ab0: 42 5f 50 43 49 30 4c 50 43 30 42 43 4d 44 70 0a  B_PCI0LPC0BCMDp.
  5ac0: 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  5ad0: 53 4d 49 43 a0 34 5c 2e 5f 53 42 5f 4f 4b 45 43  SMIC.4\._SB_OKEC
  5ae0: a0 1f 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  5af0: 30 45 43 30 5f 4d 42 54 53 70 0a 1f 42 31 53 54  0EC0_MBTSp..B1ST
  5b00: a1 08 70 0a 0f 42 31 53 54 a1 08 70 0a 0f 42 31  ..p..B1ST..p..B1
  5b10: 53 54 a4 42 31 53 54 14 41 04 5f 42 49 46 00 a0  ST.B1ST.A._BIF..
  5b20: 2e 5c 2e 5f 53 42 5f 4f 4b 45 43 a0 1c 5c 2f 05  .\._SB_OKEC..\/.
  5b30: 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f  _SB_PCI0LPC0EC0_
  5b40: 4d 42 54 53 55 50 42 49 a1 05 49 56 42 49 a1 05  MBTSUPBI..IVBI..
  5b50: 49 56 42 49 a4 50 42 49 46 14 41 04 5f 42 53 54  IVBI.PBIF.A._BST
  5b60: 00 a0 2e 5c 2e 5f 53 42 5f 4f 4b 45 43 a0 1c 5c  ...\._SB_OKEC..\
  5b70: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43  /._SB_PCI0LPC0EC
  5b80: 30 5f 4d 42 54 53 55 50 42 53 a1 05 49 56 42 53  0_MBTSUPBS..IVBS
  5b90: a1 05 49 56 42 53 a4 50 42 53 54 14 46 21 55 50  ..IVBS.PBST.F!UP
  5ba0: 42 49 00 70 0b ff 1f 62 5c 2f 05 5f 53 42 5f 50  BI.p...b\/._SB_P
  5bb0: 43 49 30 4c 50 43 30 45 43 30 5f 53 4d 57 52 0a  CI0LPC0EC0_SMWR.
  5bc0: 08 0a 14 0a 01 62 5c 2f 05 5f 53 42 5f 50 43 49  .....b\/._SB_PCI
  5bd0: 30 4c 50 43 30 45 43 30 5f 53 4d 52 44 0a 09 0a  0LPC0EC0_SMRD...
  5be0: 14 0a 01 71 63 a0 35 93 62 7d 63 0b ff 0f 00 a0  ...qc.5.b}c.....
  5bf0: 2b 92 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43  +.\/._SB_PCI0LPC
  5c00: 30 45 43 30 5f 53 4d 52 44 0a 09 0a 16 0a 10 71  0EC0_SMRD......q
  5c10: 65 70 65 88 50 42 49 46 0a 02 00 a0 41 06 93 5c  epe.PBIF....A..\
  5c20: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43  /._SB_PCI0LPC0EC
  5c30: 30 5f 4d 42 49 44 0a 01 70 0b 30 11 88 50 42 49  0_MBID..p.0..PBI
  5c40: 46 0a 01 00 70 0b d0 39 88 50 42 49 46 0a 04 00  F...p..9.PBIF...
  5c50: 70 0d 30 31 5a 47 00 88 50 42 49 46 0a 09 00 70  p.01ZG..PBIF...p
  5c60: 0d 4c 49 4f 4e 00 88 50 42 49 46 0a 0b 00 70 0d  .LION..PBIF...p.
  5c70: 53 4d 50 20 00 88 50 42 49 46 0a 0c 00 a1 43 11  SMP ..PBIF....C.
  5c80: a0 42 06 93 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  .B..\/._SB_PCI0L
  5c90: 50 43 30 45 43 30 5f 4d 42 49 44 0a 02 70 0b 10  PC0EC0_MBID..p..
  5ca0: 0e 88 50 42 49 46 0a 01 00 70 0b d0 39 88 50 42  ..PBIF...p..9.PB
  5cb0: 49 46 0a 04 00 70 0d 30 32 5a 47 00 88 50 42 49  IF...p.02ZG..PBI
  5cc0: 46 0a 09 00 70 0d 4c 49 4f 4e 00 88 50 42 49 46  F...p.LION..PBIF
  5cd0: 0a 0b 00 70 0d 53 41 4e 59 4f 00 88 50 42 49 46  ...p.SANYO..PBIF
  5ce0: 0a 0c 00 a1 4d 0a a0 42 06 93 5c 2f 05 5f 53 42  ....M..B..\/._SB
  5cf0: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 4d 42 49  _PCI0LPC0EC0_MBI
  5d00: 44 0a 03 70 0b 30 11 88 50 42 49 46 0a 01 00 70  D..p.0..PBIF...p
  5d10: 0b d0 39 88 50 42 49 46 0a 04 00 70 0d 30 33 5a  ..9.PBIF...p.03Z
  5d20: 47 00 88 50 42 49 46 0a 09 00 70 0d 4c 49 4f 4e  G..PBIF...p.LION
  5d30: 00 88 50 42 49 46 0a 0b 00 70 0d 53 41 4e 59 4f  ..PBIF...p.SANYO
  5d40: 00 88 50 42 49 46 0a 0c 00 a1 47 04 70 0b 30 11  ..PBIF....G.p.0.
  5d50: 88 50 42 49 46 0a 01 00 70 0b d0 39 88 50 42 49  .PBIF...p..9.PBI
  5d60: 46 0a 04 00 70 0d 30 31 5a 47 00 88 50 42 49 46  F...p.01ZG..PBIF
  5d70: 0a 09 00 70 0d 4c 49 4f 4e 00 88 50 42 49 46 0a  ...p.LION..PBIF.
  5d80: 0b 00 70 0d 53 4d 50 20 00 88 50 42 49 46 0a 0c  ..p.SMP ..PBIF..
  5d90: 00 70 0a 01 88 50 42 49 46 0a 00 00 a0 15 93 87  .p...PBIF.......
  5da0: 5c 5f 4f 53 5f 0a 27 70 0a 00 88 50 42 49 46 0a  \_OS_.'p...PBIF.
  5db0: 00 00 14 4c 12 55 50 42 53 00 70 5c 2f 05 5f 53  ...L.UPBS.p\/._S
  5dc0: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 4d 43  B_PCI0LPC0EC0_MC
  5dd0: 55 52 65 70 50 4f 53 57 65 88 50 42 53 54 0a 01  URepPOSWe.PBST..
  5de0: 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43  .p\/._SB_PCI0LPC
  5df0: 30 45 43 30 5f 4d 42 52 4d 88 50 42 53 54 0a 02  0EC0_MBRM.PBST..
  5e00: 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43  .p\/._SB_PCI0LPC
  5e10: 30 45 43 30 5f 4d 42 56 47 88 50 42 53 54 0a 03  0EC0_MBVG.PBST..
  5e20: 00 a0 3c 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  ..<\/._SB_PCI0LP
  5e30: 43 30 45 43 30 5f 4d 42 54 46 a0 23 5c 2f 05 5f  C0EC0_MBTF.#\/._
  5e40: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 41  SB_PCI0LPC0EC0_A
  5e50: 43 44 46 70 0a 00 88 50 42 53 54 0a 00 00 a1 40  CDFp...PBST....@
  5e60: 08 a0 4a 04 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  ..J.\/._SB_PCI0L
  5e70: 50 43 30 45 43 30 5f 4d 42 54 43 a0 23 5c 2f 05  PC0EC0_MBTC.#\/.
  5e80: 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f  _SB_PCI0LPC0EC0_
  5e90: 41 43 44 46 70 0a 02 88 50 42 53 54 0a 00 00 a1  ACDFp...PBST....
  5ea0: 0c 70 0a 00 88 50 42 53 54 0a 00 00 a1 32 a0 23  .p...PBST....2.#
  5eb0: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45  \/._SB_PCI0LPC0E
  5ec0: 43 30 5f 41 43 44 46 70 0a 00 88 50 42 53 54 0a  C0_ACDFp...PBST.
  5ed0: 00 00 a1 0c 70 0a 01 88 50 42 53 54 0a 00 00 14  ....p...PBST....
  5ee0: 4c 06 49 56 42 49 00 70 0c ff ff ff ff 88 50 42  L.IVBI.p......PB
  5ef0: 49 46 0a 01 00 70 0c ff ff ff ff 88 50 42 49 46  IF...p......PBIF
  5f00: 0a 02 00 70 0c ff ff ff ff 88 50 42 49 46 0a 04  ...p......PBIF..
  5f10: 00 70 0d 42 61 64 00 88 50 42 49 46 0a 09 00 70  .p.Bad..PBIF...p
  5f20: 0d 20 20 20 20 20 20 00 88 50 42 49 46 0a 0a 00  .      ..PBIF...
  5f30: 70 0d 42 61 64 00 88 50 42 49 46 0a 0b 00 70 0d  p.Bad..PBIF...p.
  5f40: 42 61 64 00 88 50 42 49 46 0a 0c 00 14 39 49 56  Bad..PBIF....9IV
  5f50: 42 53 00 70 0a 00 88 50 42 53 54 0a 00 00 70 0c  BS.p...PBST...p.
  5f60: ff ff ff ff 88 50 42 53 54 0a 01 00 70 0c ff ff  .....PBST...p...
  5f70: ff ff 88 50 42 53 54 0a 02 00 70 0b 10 27 88 50  ...PBST...p..'.P
  5f80: 42 53 54 0a 03 00 5b 82 4f 52 42 41 54 32 08 5f  BST...[.ORBAT2._
  5f90: 48 49 44 0c 41 d0 0c 0a 08 5f 55 49 44 0a 02 08  HID.A...._UID...
  5fa0: 5f 50 43 4c 12 07 01 5c 5f 53 42 5f 08 42 32 53  _PCL...\_SB_.B2S
  5fb0: 54 0a 0f 08 50 42 49 46 12 2c 0d 0a 01 0c ff ff  T...PBIF.,......
  5fc0: ff ff 0c ff ff ff ff 0a 01 0c ff ff ff ff 0a fa  ................
  5fd0: 0a 64 0a 0a 0a 19 0d 42 41 54 31 00 0d 20 00 0d  .d.....BAT1.. ..
  5fe0: 20 00 0d 20 00 08 50 42 53 54 12 11 04 0a 00 0c   .. ..PBST......
  5ff0: ff ff ff ff 0c ff ff ff ff 0b 10 27 14 4a 04 5f  ...........'.J._
  6000: 53 54 41 00 a0 34 5c 2e 5f 53 42 5f 4f 4b 45 43  STA..4\._SB_OKEC
  6010: a0 1f 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43  ..\/._SB_PCI0LPC
  6020: 30 45 43 30 5f 53 42 54 53 70 0a 1f 42 32 53 54  0EC0_SBTSp..B2ST
  6030: a1 08 70 0a 0f 42 32 53 54 a1 08 70 0a 0f 42 32  ..p..B2ST..p..B2
  6040: 53 54 a4 42 32 53 54 14 41 04 5f 42 49 46 00 a0  ST.B2ST.A._BIF..
  6050: 2e 5c 2e 5f 53 42 5f 4f 4b 45 43 a0 1c 5c 2f 05  .\._SB_OKEC..\/.
  6060: 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f  _SB_PCI0LPC0EC0_
  6070: 53 42 54 53 55 50 42 49 a1 05 49 56 42 49 a1 05  SBTSUPBI..IVBI..
  6080: 49 56 42 49 a4 50 42 49 46 14 41 04 5f 42 53 54  IVBI.PBIF.A._BST
  6090: 00 a0 2e 5c 2e 5f 53 42 5f 4f 4b 45 43 a0 1c 5c  ...\._SB_OKEC..\
  60a0: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43  /._SB_PCI0LPC0EC
  60b0: 30 5f 53 42 54 53 55 50 42 53 a1 05 49 56 42 53  0_SBTSUPBS..IVBS
  60c0: a1 05 49 56 42 53 a4 50 42 53 54 14 47 21 55 50  ..IVBS.PBST.G!UP
  60d0: 42 49 00 70 0b ff 2f 62 5c 2f 05 5f 53 42 5f 50  BI.p../b\/._SB_P
  60e0: 43 49 30 4c 50 43 30 45 43 30 5f 53 4d 57 52 0a  CI0LPC0EC0_SMWR.
  60f0: 08 0a 14 0a 01 62 5c 2f 05 5f 53 42 5f 50 43 49  .....b\/._SB_PCI
  6100: 30 4c 50 43 30 45 43 30 5f 53 4d 52 44 0a 09 0a  0LPC0EC0_SMRD...
  6110: 14 0a 01 71 63 a0 35 93 62 7d 63 0b ff 0f 00 a0  ...qc.5.b}c.....
  6120: 2b 92 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43  +.\/._SB_PCI0LPC
  6130: 30 45 43 30 5f 53 4d 52 44 0a 09 0a 16 0a 10 71  0EC0_SMRD......q
  6140: 65 70 65 88 50 42 49 46 0a 02 00 a0 41 06 93 5c  epe.PBIF....A..\
  6150: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43  /._SB_PCI0LPC0EC
  6160: 30 5f 53 42 49 44 0a 01 70 0b 30 11 88 50 42 49  0_SBID..p.0..PBI
  6170: 46 0a 01 00 70 0b d0 39 88 50 42 49 46 0a 04 00  F...p..9.PBIF...
  6180: 70 0d 30 31 5a 47 00 88 50 42 49 46 0a 09 00 70  p.01ZG..PBIF...p
  6190: 0d 4c 49 4f 4e 00 88 50 42 49 46 0a 0b 00 70 0d  .LION..PBIF...p.
  61a0: 53 4d 50 20 00 88 50 42 49 46 0a 0c 00 a1 44 11  SMP ..PBIF....D.
  61b0: a0 42 06 93 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  .B..\/._SB_PCI0L
  61c0: 50 43 30 45 43 30 5f 53 42 49 44 0a 02 70 0b 10  PC0EC0_SBID..p..
  61d0: 0e 88 50 42 49 46 0a 01 00 70 0b d0 39 88 50 42  ..PBIF...p..9.PB
  61e0: 49 46 0a 04 00 70 0d 30 32 5a 47 00 88 50 42 49  IF...p.02ZG..PBI
  61f0: 46 0a 09 00 70 0d 4c 49 4f 4e 00 88 50 42 49 46  F...p.LION..PBIF
  6200: 0a 0b 00 70 0d 53 41 4e 59 4f 00 88 50 42 49 46  ...p.SANYO..PBIF
  6210: 0a 0c 00 a1 4e 0a a0 42 06 93 5c 2f 05 5f 53 42  ....N..B..\/._SB
  6220: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 53 42 49  _PCI0LPC0EC0_SBI
  6230: 44 0a 03 70 0b 30 11 88 50 42 49 46 0a 01 00 70  D..p.0..PBIF...p
  6240: 0b d0 39 88 50 42 49 46 0a 04 00 70 0d 30 33 5a  ..9.PBIF...p.03Z
  6250: 47 00 88 50 42 49 46 0a 09 00 70 0d 4c 49 4f 4e  G..PBIF...p.LION
  6260: 00 88 50 42 49 46 0a 0b 00 70 0d 53 41 4e 59 4f  ..PBIF...p.SANYO
  6270: 00 88 50 42 49 46 0a 0c 00 a1 48 04 70 0b 10 0e  ..PBIF....H.p...
  6280: 88 50 42 49 46 0a 01 00 70 0b d0 39 88 50 42 49  .PBIF...p..9.PBI
  6290: 46 0a 04 00 70 0d 30 32 5a 47 00 88 50 42 49 46  F...p.02ZG..PBIF
  62a0: 0a 09 00 70 0d 4c 49 4f 4e 00 88 50 42 49 46 0a  ...p.LION..PBIF.
  62b0: 0b 00 70 0d 53 41 4e 59 4f 00 88 50 42 49 46 0a  ..p.SANYO..PBIF.
  62c0: 0c 00 70 0a 01 88 50 42 49 46 0a 00 00 a0 15 93  ..p...PBIF......
  62d0: 87 5c 5f 4f 53 5f 0a 27 70 0a 00 88 50 42 49 46  .\_OS_.'p...PBIF
  62e0: 0a 00 00 14 4c 12 55 50 42 53 00 70 5c 2f 05 5f  ....L.UPBS.p\/._
  62f0: 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 41  SB_PCI0LPC0EC0_A
  6300: 43 55 52 65 70 50 4f 53 57 65 88 50 42 53 54 0a  CURepPOSWe.PBST.
  6310: 01 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  ..p\/._SB_PCI0LP
  6320: 43 30 45 43 30 5f 41 42 52 4d 88 50 42 53 54 0a  C0EC0_ABRM.PBST.
  6330: 02 00 70 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  ..p\/._SB_PCI0LP
  6340: 43 30 45 43 30 5f 41 42 56 47 88 50 42 53 54 0a  C0EC0_ABVG.PBST.
  6350: 03 00 a0 3c 5c 2f 05 5f 53 42 5f 50 43 49 30 4c  ...<\/._SB_PCI0L
  6360: 50 43 30 45 43 30 5f 53 42 54 46 a0 23 5c 2f 05  PC0EC0_SBTF.#\/.
  6370: 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f  _SB_PCI0LPC0EC0_
  6380: 41 43 44 46 70 0a 00 88 50 42 53 54 0a 00 00 a1  ACDFp...PBST....
  6390: 40 08 a0 4a 04 5c 2f 05 5f 53 42 5f 50 43 49 30  @..J.\/._SB_PCI0
  63a0: 4c 50 43 30 45 43 30 5f 53 42 54 43 a0 23 5c 2f  LPC0EC0_SBTC.#\/
  63b0: 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43 30  ._SB_PCI0LPC0EC0
  63c0: 5f 41 43 44 46 70 0a 02 88 50 42 53 54 0a 00 00  _ACDFp...PBST...
  63d0: a1 0c 70 0a 00 88 50 42 53 54 0a 00 00 a1 32 a0  ..p...PBST....2.
  63e0: 23 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30  #\/._SB_PCI0LPC0
  63f0: 45 43 30 5f 41 43 44 46 70 0a 00 88 50 42 53 54  EC0_ACDFp...PBST
  6400: 0a 00 00 a1 0c 70 0a 01 88 50 42 53 54 0a 00 00  .....p...PBST...
  6410: 14 4c 06 49 56 42 49 00 70 0c ff ff ff ff 88 50  .L.IVBI.p......P
  6420: 42 49 46 0a 01 00 70 0c ff ff ff ff 88 50 42 49  BIF...p......PBI
  6430: 46 0a 02 00 70 0c ff ff ff ff 88 50 42 49 46 0a  F...p......PBIF.
  6440: 04 00 70 0d 42 61 64 00 88 50 42 49 46 0a 09 00  ..p.Bad..PBIF...
  6450: 70 0d 20 20 20 20 20 20 00 88 50 42 49 46 0a 0a  p.      ..PBIF..
  6460: 00 70 0d 42 61 64 00 88 50 42 49 46 0a 0b 00 70  .p.Bad..PBIF...p
  6470: 0d 42 61 64 00 88 50 42 49 46 0a 0c 00 14 39 49  .Bad..PBIF....9I
  6480: 56 42 53 00 70 0a 00 88 50 42 53 54 0a 00 00 70  VBS.p...PBST...p
  6490: 0c ff ff ff ff 88 50 42 53 54 0a 01 00 70 0c ff  ......PBST...p..
  64a0: ff ff ff 88 50 42 53 54 0a 02 00 70 0b 10 27 88  ....PBST...p..'.
  64b0: 50 42 53 54 0a 03 00 10 40 6a 5c 5f 54 5a 5f 08  PBST....@j\_TZ_.
  64c0: 54 50 4c 5f 0b a0 0c 08 54 41 43 31 0b 0e 0d 08  TPL_....TAC1....
  64d0: 54 41 43 30 0b 54 0d 08 54 50 41 53 0b 44 0e 08  TAC0.T..TPAS.D..
  64e0: 54 50 43 5f 0b 94 0e 08 54 50 54 4d 0b 3c 0c 08  TPC_....TPTM.<..
  64f0: 54 42 53 45 0b ac 0a 08 4c 54 4d 50 0b a0 0c 08  TBSE....LTMP....
  6500: 54 56 41 52 11 08 0a 05 00 20 1f 0c 1f 8c 54 56  TVAR..... ....TV
  6510: 41 52 0a 00 50 4c 43 59 8b 54 56 41 52 0a 01 43  AR..PLCY.TVAR..C
  6520: 54 4f 53 8b 54 56 41 52 0a 03 43 54 48 59 5b 82  TOS.TVAR..CTHY[.
  6530: 43 06 46 41 4e 30 08 5f 48 49 44 0c 41 d0 0c 0b  C.FAN0._HID.A...
  6540: 08 5f 55 49 44 0a 01 08 5f 50 52 30 12 06 01 50  ._UID..._PR0...P
  6550: 46 4e 30 14 1f 5f 50 53 30 00 70 0d 4c 6f 77 20  FN0.._PS0.p.Low 
  6560: 53 70 65 65 64 20 46 41 4e 20 2d 20 5f 50 53 30  Speed FAN - _PS0
  6570: 00 5b 31 14 1f 5f 50 53 33 00 70 0d 4c 6f 77 20  .[1.._PS3.p.Low 
  6580: 53 70 65 65 64 20 46 41 4e 20 2d 20 5f 50 53 33  Speed FAN - _PS3
  6590: 00 5b 31 5b 84 45 1f 50 46 4e 30 00 00 00 08 46  .[1[.E.PFN0....F
  65a0: 4e 53 31 0a 00 08 46 46 53 54 0a 01 14 0e 5f 53  NS1...FFST...._S
  65b0: 54 41 00 70 46 4e 53 31 61 a4 61 14 43 0c 5f 4f  TA.pFNS1a.a.C._O
  65c0: 4e 5f 00 70 0a 01 46 4e 53 31 a0 38 5c 2f 03 5f  N_.p..FNS1.8\/._
  65d0: 54 5a 5f 50 46 4e 31 46 4e 53 32 70 0d 46 41 4e  TZ_PFN1FNS2p.FAN
  65e0: 20 31 20 28 48 69 67 68 20 73 70 65 65 64 20 61   1 (High speed a
  65f0: 6c 72 65 61 64 79 20 74 75 72 6e 20 6f 6e 29 20  lready turn on) 
  6600: 00 5b 31 a1 42 04 a0 3f 5c 2e 5f 53 42 5f 4f 4b  .[1.B..?\._SB_OK
  6610: 45 43 70 0a b4 5c 2f 05 5f 53 42 5f 50 43 49 30  ECp..\/._SB_PCI0
  6620: 4c 50 43 30 45 43 30 5f 46 53 50 44 70 0a 01 5c  LPC0EC0_FSPDp..\
  6630: 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45 43  /._SB_PCI0LPC0EC
  6640: 30 5f 46 50 52 31 a0 38 7d 93 5c 2f 03 5f 53 42  0_FPR1.8}.\/._SB
  6650: 5f 50 43 49 30 4d 59 4f 53 0a 01 93 5c 2f 03 5f  _PCI0MYOS...\/._
  6660: 53 42 5f 50 43 49 30 4d 59 4f 53 0a 03 00 5c 2f  SB_PCI0MYOS...\/
  6670: 03 5f 54 5a 5f 54 48 52 4d 5f 53 43 50 0a 01 14  ._TZ_THRM_SCP...
  6680: 4a 10 5f 4f 46 46 00 70 0a 00 46 4e 53 31 a0 4d  J._OFF.p..FNS1.M
  6690: 05 93 87 5c 5f 4f 53 5f 0a 14 a0 41 05 5c 2e 5f  ...\_OS_...A.\._
  66a0: 53 42 5f 4f 4b 45 43 a0 29 5c 2f 03 5f 54 5a 5f  SB_OKEC.)\/._TZ_
  66b0: 50 46 4e 31 46 4e 53 32 70 01 5c 2f 05 5f 53 42  PFN1FNS2p.\/._SB
  66c0: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 46 50 52  _PCI0LPC0EC0_FPR
  66d0: 31 a1 1a 70 00 5c 2f 05 5f 53 42 5f 50 43 49 30  1..p.\/._SB_PCI0
  66e0: 4c 50 43 30 45 43 30 5f 46 50 52 31 a1 44 06 a0  LPC0EC0_FPR1.D..
  66f0: 39 95 46 46 53 54 0a 02 70 0a 86 5c 2f 04 5f 53  9.FFST..p..\/._S
  6700: 42 5f 50 43 49 30 4c 50 43 30 42 43 4d 44 70 0a  B_PCI0LPC0BCMDp.
  6710: 00 5c 2f 04 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  6720: 53 4d 49 43 75 46 46 53 54 a1 27 a0 25 5c 2e 5f  SMICuFFST.'.%\._
  6730: 53 42 5f 4f 4b 45 43 70 0a 00 5c 2f 05 5f 53 42  SB_OKECp..\/._SB
  6740: 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 46 50 52  _PCI0LPC0EC0_FPR
  6750: 31 a0 38 7d 93 5c 2f 03 5f 53 42 5f 50 43 49 30  1.8}.\/._SB_PCI0
  6760: 4d 59 4f 53 0a 01 93 5c 2f 03 5f 53 42 5f 50 43  MYOS...\/._SB_PC
  6770: 49 30 4d 59 4f 53 0a 03 00 5c 2f 03 5f 54 5a 5f  I0MYOS...\/._TZ_
  6780: 54 48 52 4d 5f 53 43 50 0a 01 5b 82 49 06 46 41  THRM_SCP..[.I.FA
  6790: 4e 31 08 5f 48 49 44 0c 41 d0 0c 0b 08 5f 55 49  N1._HID.A...._UI
  67a0: 44 0a 02 08 5f 50 52 30 12 0a 02 50 46 4e 30 50  D..._PR0...PFN0P
  67b0: 46 4e 31 14 20 5f 50 53 30 00 70 0d 48 69 67 68  FN1. _PS0.p.High
  67c0: 20 53 70 65 65 64 20 46 41 4e 20 2d 20 5f 50 53   Speed FAN - _PS
  67d0: 30 00 5b 31 14 20 5f 50 53 33 00 70 0d 48 69 67  0.[1. _PS3.p.Hig
  67e0: 68 20 53 70 65 65 64 20 46 41 4e 20 2d 20 5f 50  h Speed FAN - _P
  67f0: 53 33 00 5b 31 5b 84 4c 16 50 46 4e 31 00 00 00  S3.[1[.L.PFN1...
  6800: 08 46 4e 53 32 0a 00 14 0b 5f 53 54 41 00 a4 46  .FNS2...._STA..F
  6810: 4e 53 32 14 47 08 5f 4f 4e 5f 00 70 0a 01 46 4e  NS2.G._ON_.p..FN
  6820: 53 32 a0 3f 5c 2e 5f 53 42 5f 4f 4b 45 43 70 0a  S2.?\._SB_OKECp.
  6830: ff 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  6840: 45 43 30 5f 46 53 50 44 70 0a 01 5c 2f 05 5f 53  EC0_FSPDp..\/._S
  6850: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 46 50  B_PCI0LPC0EC0_FP
  6860: 52 31 a0 38 7d 93 5c 2f 03 5f 53 42 5f 50 43 49  R1.8}.\/._SB_PCI
  6870: 30 4d 59 4f 53 0a 01 93 5c 2f 03 5f 53 42 5f 50  0MYOS...\/._SB_P
  6880: 43 49 30 4d 59 4f 53 0a 03 00 5c 2f 03 5f 54 5a  CI0MYOS...\/._TZ
  6890: 5f 54 48 52 4d 5f 53 43 50 0a 01 14 47 0c 5f 4f  _THRM_SCP...G._O
  68a0: 46 46 00 70 00 46 4e 53 32 70 0a 00 46 4e 53 32  FF.p.FNS2p..FNS2
  68b0: a0 41 05 5c 2f 03 5f 54 5a 5f 50 46 4e 30 46 4e  .A.\/._TZ_PFN0FN
  68c0: 53 31 a0 3f 5c 2e 5f 53 42 5f 4f 4b 45 43 70 0a  S1.?\._SB_OKECp.
  68d0: b4 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30  .\/._SB_PCI0LPC0
  68e0: 45 43 30 5f 46 53 50 44 70 0a 01 5c 2f 05 5f 53  EC0_FSPDp..\/._S
  68f0: 42 5f 50 43 49 30 4c 50 43 30 45 43 30 5f 46 50  B_PCI0LPC0EC0_FP
  6900: 52 31 a1 27 a0 25 5c 2e 5f 53 42 5f 4f 4b 45 43  R1.'.%\._SB_OKEC
  6910: 70 0a 00 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50  p..\/._SB_PCI0LP
  6920: 43 30 45 43 30 5f 46 50 52 31 a0 38 7d 93 5c 2f  C0EC0_FPR1.8}.\/
  6930: 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a 01 93  ._SB_PCI0MYOS...
  6940: 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 59 4f 53 0a  \/._SB_PCI0MYOS.
  6950: 03 00 5c 2f 03 5f 54 5a 5f 54 48 52 4d 5f 53 43  ..\/._TZ_THRM_SC
  6960: 50 0a 01 5b 85 43 1f 54 48 52 4d 08 5f 41 4c 30  P..[.C.THRM._AL0
  6970: 12 06 01 46 41 4e 31 14 0b 5f 41 43 30 00 a4 54  ...FAN1.._AC0..T
  6980: 41 43 30 08 5f 41 4c 31 12 06 01 46 41 4e 30 14  AC0._AL1...FAN0.
  6990: 0b 5f 41 43 31 00 a4 54 41 43 31 14 0b 5f 43 52  ._AC1..TAC1.._CR
  69a0: 54 00 a4 54 50 43 5f 14 0b 5f 50 53 56 00 a4 54  T..TPC_.._PSV..T
  69b0: 50 41 53 08 5f 54 53 50 0a 64 14 4d 0d 5f 54 4d  PAS._TSP.d.M._TM
  69c0: 50 00 a0 4b 0c 5c 2e 5f 53 42 5f 4f 4b 45 43 70  P..K.\._SB_OKECp
  69d0: 5c 2f 05 5f 53 42 5f 50 43 49 30 4c 50 43 30 45  \/._SB_PCI0LPC0E
  69e0: 43 30 5f 43 54 4d 50 61 70 0d 42 65 66 6f 72 65  C0_CTMPap.Before
  69f0: 20 44 6f 74 68 61 6e 20 54 65 6d 70 65 72 61 74   Dothan Temperat
  6a00: 75 72 65 20 66 69 78 2d 75 70 20 69 73 20 2d 2d  ure fix-up is --
  6a10: 2d 20 00 5b 31 70 61 5b 31 70 7b 72 44 4f 46 46  - .[1pa[1p{rDOFF
  6a20: 61 00 0a ff 00 61 70 0d 41 66 74 65 72 20 44 6f  a....ap.After Do
  6a30: 74 68 61 6e 20 54 65 6d 70 65 72 61 74 75 72 65  than Temperature
  6a40: 20 66 69 78 2d 75 70 20 69 73 20 2d 2d 2d 2d 20   fix-up is ---- 
  6a50: 00 5b 31 70 61 5b 31 70 0d 43 75 72 72 65 6e 74  .[1pa[1p.Current
  6a60: 20 54 65 6d 70 65 72 61 74 75 72 65 20 69 73 20   Temperature is 
  6a70: 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 2d 20 00 5b 31 70  ----------- .[1p
  6a80: 61 5b 31 72 77 61 0a 0a 00 54 42 53 45 61 a1 07  a[1rwa...TBSEa..
  6a90: 70 4c 54 4d 50 61 a4 61 08 5f 50 53 4c 12 0c 01  pLTMPa.a._PSL...
  6aa0: 5c 2e 5f 50 52 5f 43 50 55 30 08 5f 54 43 31 0a  \._PR_CPU0._TC1.
  6ab0: 02 08 5f 54 43 32 0a 03 14 4f 09 5f 53 43 50 01  .._TC2...O._SCP.
  6ac0: 70 00 50 4c 43 59 a0 47 04 5c 2f 03 5f 54 5a 5f  p.PLCY.G.\/._TZ_
  6ad0: 50 46 4e 30 46 4e 53 31 a0 23 93 5c 2f 03 5f 54  PFN0FNS1.#.\/._T
  6ae0: 5a 5f 50 46 4e 31 46 4e 53 32 0a 00 70 0b 22 0d  Z_PFN1FNS2..p.".
  6af0: 54 41 43 31 70 0b 86 0d 54 41 43 30 a1 11 70 0b  TAC1p...TAC0..p.
  6b00: 22 0d 54 41 43 31 70 0b 40 0d 54 41 43 30 a1 34  ".TAC1p.@.TAC0.4
  6b10: a0 20 5c 2f 03 5f 54 5a 5f 50 46 4e 31 46 4e 53  . \/._TZ_PFN1FNS
  6b20: 32 70 0b 22 0d 54 41 43 31 70 0b 40 0d 54 41 43  2p.".TAC1p.@.TAC
  6b30: 30 a1 11 70 0b 40 0d 54 41 43 31 70 0b 86 0d 54  0..p.@.TAC1p...T
  6b40: 41 43 30 70 0b 44 0e 54 50 41 53 86 5c 2e 5f 54  AC0p.D.TPAS.\._T
  6b50: 5a 5f 54 48 52 4d 0a 81 5b 82 0f 53 4c 50 42 08  Z_THRM..[..SLPB.
  6b60: 5f 48 49 44 0c 41 d0 0c 0e 5b 80 45 58 43 4f 01  _HID.A...[.EXCO.
  6b70: 0a 72 0a 02 5b 81 10 45 58 43 4f 01 49 4e 44 58  .r..[..EXCO.INDX
  6b80: 08 44 41 54 41 08 5b 86 4a 08 49 4e 44 58 44 41  .DATA.[.J.INDXDA
  6b90: 54 41 01 00 40 10 41 43 53 54 01 45 43 4f 4b 01  TA..@.ACST.ECOK.
  6ba0: 57 4c 45 53 01 42 54 45 53 01 57 32 4b 46 02 53  WLES.BTES.W2KF.S
  6bb0: 34 57 50 01 46 4c 41 37 01 4c 53 46 47 01 4c 44  4WP.FLA7.LSFG.LD
  6bc0: 31 30 01 50 53 32 4d 01 44 49 53 44 03 4f 56 52  10.PS2M.DISD.OVR
  6bd0: 4c 01 00 01 53 4c 45 45 08 42 50 46 47 08 50 57  L...SLEE.BPFG.PW
  6be0: 53 54 08 44 41 54 53 08 43 4d 32 36 08 43 4d 32  ST.DATS.CM26.CM2
  6bf0: 37 08 43 4d 32 38 10 43 4d 32 41 10 46 34 46 47  7.CM28.CM2A.F4FG
  6c00: 01 00 1f 43 4d 33 30 08 43 4d 33 31 08 43 4d 33  ...CM30.CM31.CM3
  6c10: 32 08                                            2.

FACS @ 0x1fefcfc0
  0000: 46 41 43 53 40 00 00 00 d1 13 00 00 00 00 00 00  FACS@...........
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

HPET @ 0x1feebfa0
  0000: 48 50 45 54 38 00 00 00 01 5b 41 43 45 52 20 20  HPET8....[ACER  
  0010: 54 4d 38 30 30 30 20 20 08 06 02 20 50 54 4c 20  TM8000  ... PTL 
  0020: 00 00 00 00 01 a2 86 80 00 00 00 00 00 00 00 00  ................
  0030: 00 00 d0 fe 00 80 00 00                          ........

BOOT @ 0x1feebfd8
  0000: 42 4f 4f 54 28 00 00 00 01 27 41 43 45 52 20 20  BOOT(....'ACER  
  0010: 54 4d 38 30 30 30 20 20 08 06 02 20 20 4c 54 50  TM8000  ...  LTP
  0020: 01 00 00 00 37 00 00 00                          ....7...


--------------050709000107030608010302
Content-Type: text/plain;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode"

# dmidecode 2.4
SMBIOS 2.31 present.
27 structures occupying 1207 bytes.
Table at 0x000DF810.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: ACER   
		Version: 3A15
		Release Date: 06/08/2004
		Address: 0xE5240
		Runtime Size: 110016 bytes
		ROM Size: 512 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			3.5"/720 KB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			Smart battery is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: Acer
		Product Name: TravelMate 8000
		Version: Rev 1                   
		Serial Number: LXT420606343402B0AEF00
		UUID: 6001307E-25F5-D811-BCD0-00C09F44D477
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: Acer
		Product Name: TravelMate 8000
		Version: Rev 1.0                 
		Serial Number: LXT420606343402B0AEF00
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: Acer
		Type: Notebook
		Lock: Not Present
		Version: Rev.1                   
		Serial Number: LXT420606343402B0AEF00
		Asset Tag: ................................     
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00001234
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: uFCPGA2
		Type: Central Processor
		Family: Unknown
		Manufacturer: Intel
		ID: D6 06 00 00 BF F9 E9 AF
		Version: Intel(R) Pentium(R) M processor
		Voltage: 1.2 V
		External Clock: 400 MHz
		Max Speed: 1800 MHz
		Current Speed: 1800 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x0008
		L2 Cache Handle: 0x0009
		L3 Cache Handle: Not Provided
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 5, 20 bytes.
	Memory Controller Information
		Error Detecting Method: None
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 1024 MB
		Maximum Total Memory Size: 2048 MB
		Supported Speeds:
			60 ns
		Supported Memory Types:
			DIMM
		Memory Module Voltage: 3.3 V
		Associated Memory Slots: 2
			0x0006
			0x0007
		Enabled Error Correcting Capabilities:
			None
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM 1
		Bank Connections: 0 1
		Current Speed: 75 ns
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM 2
		Bank Connections: 2 3
		Current Speed: 75 ns
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 32 KB
		Maximum Size: 32 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Asynchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x0009
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 2048 KB
		Maximum Size: 2048 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: LPT 1
		Internal Connector Type: None
		External Reference Designator: Parallel
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: U28
		Internal Connector Type: None
		External Reference Designator: PS/2 Mouse
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x000C
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCMCIA socket 0
		Type: 32-bit PC Card (PCMCIA)
		Current Usage: Unknown
		Length: Long
		ID: Adapter 0, Socket 0
		Characteristics:
			5.0 V is provided
			3.3 V is provided
			PC Card-16 is supported
			Cardbus is supported
			Modem ring resume is supported
			PME signal is supported
			Hot-plug devices are supported
Handle 0x000D
	DMI type 10, 10 bytes.
	On Board Device 1 Information
		Type: Video
		Status: Disabled
		Description: ATI M11
	On Board Device 2 Information
		Type: Sound
		Status: Disabled
		Description: AC97 Audio
	On Board Device 3 Information
		Type: Other
		Status: Disabled
		Description: TI TSB43AB21 IEEE-1394 Controller
Handle 0x000E
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: SMBIOS 2.3
		String 2: Customer Reference Platform
Handle 0x000F
	DMI type 12, 5 bytes.
	System Configuration Options
		Option 1: No Jumper On This Platform.
Handle 0x0010
	DMI type 15, 29 bytes.
	System Event Log
		Area Length: 0 bytes
		Header Start Offset: 0x0000
		Header Length: 16 bytes
		Data Start Offset: 0x0010
		Access Method: Memory-mapped physical 32-bit address
		Access Address: 0x00000000
		Status: Invalid, Not Full
		Change Token: 0x00000000
		Header Format: Type 1
		Supported Log Type Descriptors: 3
		Descriptor 1: POST error
		Data Format 1: POST results bitmap
		Descriptor 2: Single-bit ECC memory error
		Data Format 2: Multiple-event
		Descriptor 3: Multi-bit ECC memory error
		Data Format 3: Multiple-event
Handle 0x0011
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 3 GB
		Error Information Handle: Not Provided
		Number Of Devices: 2
Handle 0x0012
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0011
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: DIMM 0
		Bank Locator: Bank 0, 1
		Type: SRAM
		Type Detail: Synchronous
		Speed: 333 MHz (3.0 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0013
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0011
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: DIMM 1
		Bank Locator: Bank 2, 3
		Type: SRAM
		Type Detail: Synchronous
		Speed: 333 MHz (3.0 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0014
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x0011
		Partition Width: 0
Handle 0x0015
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x0012
		Memory Array Mapped Address Handle: 0x0014
		Partition Row Position: 1
		Interleave Position: 1
Handle 0x0016
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00010000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x0013
		Memory Array Mapped Address Handle: 0x0014
		Partition Row Position: 1
		Interleave Position: 1
Handle 0x0017
	DMI type 21, 7 bytes.
	Built-in Pointing Device
		Type: Mouse
		Interface: PS/2
		Buttons: 2
Handle 0x0018
	DMI type 22, 26 bytes.
	Portable Battery
		Location: Right Side
		Manufacturer: Sanyo
		Name: Sanyo
		Chemistry: Lithium Ion
		Design Capacity: 4400 mWh
		Design Voltage: 14800 mV
		SBDS Version: Bat123
		Maximum Error: 6%
		SBDS Serial Number: 04D2
		SBDS Manufacture Date: 1985-08-25
		OEM-specific Information: 0x00000000
Handle 0x0019
	DMI type 32, 20 bytes.
	System Boot Information
		Status: <OUT OF SPEC>
Handle 0x001A
	DMI type 127, 4 bytes.
	End Of Table

--------------050709000107030608010302--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
