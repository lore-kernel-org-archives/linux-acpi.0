From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: new test of 2.6.0 some things work some don't
Date: Sun, 21 Dec 2003 16:38:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031221143856.GH3587@luna.mooo.com>
References: <200312202153.32514.vherried@insight.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200312202153.32514.vherried-rEckef8uG3NTGrOy2lmfZw@public.gmane.org>
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

On Sat, Dec 20, 2003 at 09:53:29PM -0500, Vince Herried wrote:
> I got  2.6.0  (with no patches)
> kind of working on a Dell laptop Lattitude C810
> 
> s1 causes the power light to flash, the display goes out
> can't seem to get to resume.  
> 
> s2 doesn't seem to do anything
> 

AFAIK most bioses don't support that one.

> s3 the power light goes off and I think the display drivers shut down but I 
> think the back light stays on  (all white screen).
> 

Don't know how stable S1 and S3 are supposed to be by now but I know
that they at list used to be problematic.

> s4 seems to work.
> 

Thats done mostly in software, there are actually three implementations
for that running around (2 in the kernel and one as a patch). They
probably should converge at some point.

> anyone care to see my dsdt
> 
> 
> I'm runnin RedHat 9 and my 2.4 kernel
> (at least according to RedHat)
> CONFIG_EXT3_FS=m
> but I couldn't get 2.6.0 to mount /boot or use initrd.
> re-compile with above=y was able to get it to mount /boot
> 

You have to compile the file system type of your boot and root
partitions into the kernel since the kernel doesn't have access to the
modules at this point to load them. (actually the file system of your
root partition and /lib/modules which is probably on your root file
system will probably be enough since I don't think the kernel actually
accesses the boot partition itself).
This is true as long as you don't use initrd, in which case the modules
sit in the initrd and thus can be accessed before root is mounted,
although I can't think of a case where you would want to unmount your
root partition regularly, so you're probably safe compiling it in
anyway.

> but I don't get module support
> lsmod fails
> 

2.6 has a different driver model, so you need a different version
of insmod (it coexists with the 2.4, usually by calling it if you are
using a 2.4 kernel). Don't know how the redhat package for that is
called. Under debian its module-init-tools, could be similar.

> where should I look for help?
> here is my .config
> 
>  #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_CLEAN_COMPILE=y
> CONFIG_STANDALONE=y
> CONFIG_BROKEN_ON_SMP=y
> 
> #
> # General setup
> #
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_LOG_BUF_SHIFT=14
> # CONFIG_IKCONFIG is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> CONFIG_MODVERSIONS=y
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> CONFIG_M686=y
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_PPRO_FENCE=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_HPET_TIMER is not set
> # CONFIG_HPET_EMULATE_RTC is not set
> # CONFIG_SMP is not set
> # CONFIG_PREEMPT is not set
> # CONFIG_X86_UP_APIC is not set
> CONFIG_X86_TSC=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_NONFATAL is not set
> # CONFIG_TOSHIBA is not set
> CONFIG_I8K=y
> CONFIG_MICROCODE=m
> CONFIG_X86_MSR=m
> CONFIG_X86_CPUID=y
> CONFIG_EDD=m
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> 
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> CONFIG_SOFTWARE_SUSPEND=y
> CONFIG_PM_DISK=y
> CONFIG_PM_DISK_PARTITION=""
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
> CONFIG_ACPI_AC=m
> CONFIG_ACPI_BATTERY=m
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_FAN=m
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_THERMAL=m
> CONFIG_ACPI_ASUS=m
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_ACPI_RELAXED_AML=y
> 
> #
> # APM (Advanced Power Management) BIOS Support
> #
> CONFIG_APM=y
> CONFIG_APM_IGNORE_USER_SUSPEND=y
> CONFIG_APM_DO_ENABLE=y
> CONFIG_APM_CPU_IDLE=y
> # CONFIG_APM_DISPLAY_BLANK is not set
> CONFIG_APM_RTC_IS_GMT=y
> # CONFIG_APM_ALLOW_INTS is not set
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> # CONFIG_CPU_FREQ_PROC_INTF is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_TABLE=y
> 
> #
> # CPUFreq processor drivers
> #
> CONFIG_X86_ACPI_CPUFREQ=m
> # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
> # CONFIG_X86_POWERNOW_K6 is not set
> # CONFIG_X86_POWERNOW_K7 is not set
> # CONFIG_X86_POWERNOW_K8 is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> CONFIG_X86_SPEEDSTEP_CENTRINO=y
> # CONFIG_X86_SPEEDSTEP_ICH is not set
> # CONFIG_X86_SPEEDSTEP_SMI is not set
> # CONFIG_X86_P4_CLOCKMOD is not set
> # CONFIG_X86_LONGRUN is not set
> # CONFIG_X86_LONGHAUL is not set
> 
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> # CONFIG_PCI_LEGACY_PROC is not set
> CONFIG_PCI_NAMES=y
> CONFIG_ISA=y
> CONFIG_EISA=y
> # CONFIG_EISA_VLB_PRIMING is not set
> CONFIG_EISA_PCI_EISA=y
> CONFIG_EISA_VIRTUAL_ROOT=y
> CONFIG_EISA_NAMES=y
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> CONFIG_HOTPLUG=y
> 
> #
> # PCMCIA/CardBus support
> #
> CONFIG_PCMCIA=m
> # CONFIG_YENTA is not set
> CONFIG_I82092=m
> CONFIG_I82365=m
> CONFIG_TCIC=m
> CONFIG_PCMCIA_PROBE=y
> 
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_AOUT=m
> CONFIG_BINFMT_MISC=m
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_FW_LOADER=y
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_CML1=m
> CONFIG_PARPORT_SERIAL=m
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> CONFIG_PARPORT_PC_PCMCIA=m
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_PARPORT_1284=y
> 
> #
> # Plug and Play support
> #
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG is not set
> 
> #
> # Protocols
> #
> CONFIG_ISAPNP=y
> # CONFIG_PNPBIOS is not set
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=m
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> CONFIG_BLK_DEV_NBD=m
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> # CONFIG_LBD is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECS=m
> CONFIG_BLK_DEV_IDECD=m
> CONFIG_BLK_DEV_IDETAPE=m
> CONFIG_BLK_DEV_IDEFLOPPY=y
> CONFIG_BLK_DEV_IDESCSI=m
> # CONFIG_IDE_TASK_IOCTL is not set
> # CONFIG_IDE_TASKFILE_IO is not set
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_BLK_DEV_CMD640=y
> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=y
> # CONFIG_BLK_DEV_OPTI621 is not set
> CONFIG_BLK_DEV_RZ1000=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_IDEDMA_PCI_WIP is not set
> CONFIG_BLK_DEV_ADMA=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> CONFIG_BLK_DEV_ALI15X3=y
> # CONFIG_WDC_ALI15X3 is not set
> CONFIG_BLK_DEV_AMD74XX=m
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> CONFIG_BLK_DEV_CS5530=y
> CONFIG_BLK_DEV_HPT34X=y
> CONFIG_BLK_DEV_HPT366=y
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_DMA_NONPCI is not set
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI=m
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=m
> CONFIG_CHR_DEV_ST=m
> CONFIG_CHR_DEV_OSST=m
> CONFIG_BLK_DEV_SR=m
> CONFIG_BLK_DEV_SR_VENDOR=y
> CONFIG_CHR_DEV_SG=m
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> CONFIG_SCSI_REPORT_LUNS=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AHA1740 is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_SATA is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # PCMCIA SCSI adapter support
> #
> CONFIG_PCMCIA_AHA152X=m
> CONFIG_PCMCIA_FDOMAIN=m
> CONFIG_PCMCIA_NINJA_SCSI=m
> CONFIG_PCMCIA_QLOGIC=m
> 
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> CONFIG_IEEE1394=m
> 
> #
> # Subsystem Options
> #
> # CONFIG_IEEE1394_VERBOSEDEBUG is not set
> # CONFIG_IEEE1394_OUI_DB is not set
> 
> #
> # Device Drivers
> #
> # CONFIG_IEEE1394_PCILYNX is not set
> CONFIG_IEEE1394_OHCI1394=m
> 
> #
> # Protocol Drivers
> #
> CONFIG_IEEE1394_VIDEO1394=m
> CONFIG_IEEE1394_SBP2=m
> CONFIG_IEEE1394_SBP2_PHYS_DMA=y
> CONFIG_IEEE1394_ETH1394=m
> CONFIG_IEEE1394_DV1394=m
> CONFIG_IEEE1394_RAWIO=m
> CONFIG_IEEE1394_CMP=m
> CONFIG_IEEE1394_AMDTP=m
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Networking support
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK_DEV=y
> CONFIG_UNIX=y
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_FWMARK=y
> CONFIG_IP_ROUTE_NAT=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_TOS=y
> CONFIG_IP_ROUTE_VERBOSE=y
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE=m
> CONFIG_NET_IPGRE_BROADCAST=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> # CONFIG_ARPD is not set
> # CONFIG_INET_ECN is not set
> CONFIG_SYN_COOKIES=y
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> 
> #
> # IP: Virtual Server Configuration
> #
> CONFIG_IP_VS=m
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=16
> 
> #
> # IPVS transport protocol load balancing support
> #
> # CONFIG_IP_VS_PROTO_TCP is not set
> # CONFIG_IP_VS_PROTO_UDP is not set
> # CONFIG_IP_VS_PROTO_ESP is not set
> # CONFIG_IP_VS_PROTO_AH is not set
> 
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=m
> CONFIG_IP_VS_WRR=m
> CONFIG_IP_VS_LC=m
> CONFIG_IP_VS_WLC=m
> CONFIG_IP_VS_LBLC=m
> CONFIG_IP_VS_LBLCR=m
> CONFIG_IP_VS_DH=m
> CONFIG_IP_VS_SH=m
> # CONFIG_IP_VS_SED is not set
> # CONFIG_IP_VS_NQ is not set
> 
> #
> # IPVS application helper
> #
> CONFIG_IPV6=m
> # CONFIG_IPV6_PRIVACY is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=m
> CONFIG_IP_NF_FTP=m
> CONFIG_IP_NF_IRC=m
> CONFIG_IP_NF_TFTP=m
> CONFIG_IP_NF_AMANDA=m
> CONFIG_IP_NF_QUEUE=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_LIMIT=m
> # CONFIG_IP_NF_MATCH_IPRANGE is not set
> CONFIG_IP_NF_MATCH_MAC=m
> CONFIG_IP_NF_MATCH_PKTTYPE=m
> CONFIG_IP_NF_MATCH_MARK=m
> CONFIG_IP_NF_MATCH_MULTIPORT=m
> CONFIG_IP_NF_MATCH_TOS=m
> # CONFIG_IP_NF_MATCH_RECENT is not set
> CONFIG_IP_NF_MATCH_ECN=m
> CONFIG_IP_NF_MATCH_DSCP=m
> CONFIG_IP_NF_MATCH_AH_ESP=m
> CONFIG_IP_NF_MATCH_LENGTH=m
> CONFIG_IP_NF_MATCH_TTL=m
> CONFIG_IP_NF_MATCH_TCPMSS=m
> CONFIG_IP_NF_MATCH_HELPER=m
> CONFIG_IP_NF_MATCH_STATE=m
> CONFIG_IP_NF_MATCH_CONNTRACK=m
> CONFIG_IP_NF_MATCH_OWNER=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> # CONFIG_IP_NF_TARGET_NETMAP is not set
> # CONFIG_IP_NF_TARGET_SAME is not set
> # CONFIG_IP_NF_NAT_LOCAL is not set
> CONFIG_IP_NF_NAT_SNMP_BASIC=m
> CONFIG_IP_NF_NAT_IRC=m
> CONFIG_IP_NF_NAT_FTP=m
> CONFIG_IP_NF_NAT_TFTP=m
> CONFIG_IP_NF_NAT_AMANDA=m
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_TARGET_TOS=m
> CONFIG_IP_NF_TARGET_ECN=m
> CONFIG_IP_NF_TARGET_DSCP=m
> CONFIG_IP_NF_TARGET_MARK=m
> # CONFIG_IP_NF_TARGET_CLASSIFY is not set
> CONFIG_IP_NF_TARGET_LOG=m
> CONFIG_IP_NF_TARGET_ULOG=m
> CONFIG_IP_NF_TARGET_TCPMSS=m
> CONFIG_IP_NF_ARPTABLES=m
> CONFIG_IP_NF_ARPFILTER=m
> # CONFIG_IP_NF_ARP_MANGLE is not set
> CONFIG_IP_NF_COMPAT_IPCHAINS=m
> CONFIG_IP_NF_COMPAT_IPFWADM=m
> 
> #
> # IPv6: Netfilter Configuration
> #
> # CONFIG_IP6_NF_QUEUE is not set
> CONFIG_IP6_NF_IPTABLES=m
> CONFIG_IP6_NF_MATCH_LIMIT=m
> CONFIG_IP6_NF_MATCH_MAC=m
> CONFIG_IP6_NF_MATCH_RT=m
> CONFIG_IP6_NF_MATCH_OPTS=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> CONFIG_IP6_NF_MATCH_HL=m
> CONFIG_IP6_NF_MATCH_MULTIPORT=m
> CONFIG_IP6_NF_MATCH_OWNER=m
> CONFIG_IP6_NF_MATCH_MARK=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_MATCH_AHESP=m
> CONFIG_IP6_NF_MATCH_LENGTH=m
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_LOG=m
> CONFIG_IP6_NF_MANGLE=m
> CONFIG_IP6_NF_TARGET_MARK=m
> CONFIG_XFRM=y
> # CONFIG_XFRM_USER is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=m
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_VLAN_8021Q is not set
> CONFIG_LLC=y
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=m
> CONFIG_BONDING=m
> CONFIG_EQUALIZER=m
> CONFIG_TUN=m
> CONFIG_ETHERTAP=m
> CONFIG_NET_SB1000=m
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=m
> CONFIG_HAPPYMEAL=m
> CONFIG_SUNGEM=m
> CONFIG_NET_VENDOR_3COM=y
> CONFIG_EL1=m
> CONFIG_EL2=m
> CONFIG_ELPLUS=m
> CONFIG_EL16=m
> CONFIG_EL3=m
> CONFIG_3C515=m
> CONFIG_VORTEX=m
> CONFIG_TYPHOON=m
> CONFIG_LANCE=m
> CONFIG_NET_VENDOR_SMC=y
> CONFIG_WD80x3=m
> CONFIG_ULTRA=m
> CONFIG_ULTRA32=m
> CONFIG_SMC9194=m
> CONFIG_NET_VENDOR_RACAL=y
> CONFIG_NI5010=m
> CONFIG_NI52=m
> CONFIG_NI65=m
> 
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> CONFIG_AT1700=m
> CONFIG_DEPCA=m
> CONFIG_HP100=m
> CONFIG_NET_ISA=y
> CONFIG_E2100=m
> CONFIG_EWRK3=m
> CONFIG_EEXPRESS=m
> CONFIG_EEXPRESS_PRO=m
> CONFIG_HPLAN_PLUS=m
> CONFIG_HPLAN=m
> CONFIG_LP486E=m
> CONFIG_ETH16I=m
> CONFIG_NE2000=m
> # CONFIG_ZNET is not set
> # CONFIG_SEEQ8005 is not set
> CONFIG_NET_PCI=y
> CONFIG_PCNET32=m
> CONFIG_AMD8111_ETH=m
> CONFIG_ADAPTEC_STARFIRE=m
> # CONFIG_ADAPTEC_STARFIRE_NAPI is not set
> CONFIG_AC3200=m
> CONFIG_APRICOT=m
> # CONFIG_B44 is not set
> CONFIG_CS89x0=m
> CONFIG_DGRS=m
> CONFIG_EEPRO100=m
> # CONFIG_EEPRO100_PIO is not set
> CONFIG_E100=m
> CONFIG_LNE390=m
> CONFIG_FEALNX=m
> CONFIG_NATSEMI=m
> CONFIG_NE2K_PCI=m
> CONFIG_NE3210=m
> CONFIG_ES3210=m
> CONFIG_8139CP=m
> CONFIG_8139TOO=m
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> CONFIG_8139TOO_8129=y
> # CONFIG_8139_OLD_RX_RESET is not set
> CONFIG_SIS900=m
> CONFIG_EPIC100=m
> CONFIG_SUNDANCE=m
> # CONFIG_SUNDANCE_MMIO is not set
> CONFIG_TLAN=m
> CONFIG_VIA_RHINE=m
> # CONFIG_VIA_RHINE_MMIO is not set
> CONFIG_NET_POCKET=y
> CONFIG_ATP=m
> CONFIG_DE600=m
> CONFIG_DE620=m
> 
> #
> # Ethernet (1000 Mbit)
> #
> CONFIG_ACENIC=m
> # CONFIG_ACENIC_OMIT_TIGON_I is not set
> CONFIG_DL2K=m
> CONFIG_E1000=m
> # CONFIG_E1000_NAPI is not set
> CONFIG_NS83820=m
> CONFIG_HAMACHI=m
> CONFIG_YELLOWFIN=m
> CONFIG_R8169=m
> # CONFIG_SIS190 is not set
> CONFIG_SK98LIN=m
> CONFIG_TIGON3=m
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> CONFIG_FDDI=y
> CONFIG_DEFXX=m
> CONFIG_SKFP=m
> # CONFIG_HIPPI is not set
> CONFIG_PLIP=m
> CONFIG_PPP=m
> CONFIG_PPP_MULTILINK=y
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_SYNC_TTY=m
> CONFIG_PPP_DEFLATE=m
> # CONFIG_PPP_BSDCOMP is not set
> CONFIG_PPPOE=m
> CONFIG_SLIP=m
> CONFIG_SLIP_COMPRESSED=y
> CONFIG_SLIP_SMART=y
> CONFIG_SLIP_MODE_SLIP6=y
> 
> #
> # Wireless LAN (non-hamradio)
> #
> CONFIG_NET_RADIO=y
> 
> #
> # Obsolete Wireless cards support (pre-802.11)
> #
> CONFIG_STRIP=m
> CONFIG_ARLAN=m
> CONFIG_WAVELAN=m
> CONFIG_PCMCIA_WAVELAN=m
> CONFIG_PCMCIA_NETWAVE=m
> 
> #
> # Wireless 802.11 Frequency Hopping cards support
> #
> CONFIG_PCMCIA_RAYCS=m
> 
> #
> # Wireless 802.11b ISA/PCI cards support
> #
> CONFIG_AIRO=m
> CONFIG_HERMES=m
> CONFIG_PLX_HERMES=m
> # CONFIG_TMD_HERMES is not set
> CONFIG_PCI_HERMES=m
> 
> #
> # Wireless 802.11b Pcmcia/Cardbus cards support
> #
> CONFIG_PCMCIA_HERMES=m
> CONFIG_AIRO_CS=m
> # CONFIG_PCMCIA_ATMEL is not set
> # CONFIG_PCMCIA_WL3501 is not set
> CONFIG_NET_WIRELESS=y
> 
> #
> # Token Ring devices
> #
> CONFIG_TR=y
> CONFIG_IBMTR=m
> CONFIG_IBMOL=m
> CONFIG_IBMLS=m
> CONFIG_3C359=m
> CONFIG_TMS380TR=m
> CONFIG_TMSPCI=m
> # CONFIG_SKISA is not set
> # CONFIG_PROTEON is not set
> CONFIG_ABYSS=m
> CONFIG_SMCTR=m
> CONFIG_NET_FC=y
> CONFIG_RCPCI=m
> CONFIG_SHAPER=m
> 
> #
> # Wan interfaces
> #
> CONFIG_WAN=y
> CONFIG_HOSTESS_SV11=m
> CONFIG_COSA=m
> # CONFIG_DSCC4 is not set
> # CONFIG_LANMEDIA is not set
> CONFIG_SEALEVEL_4021=m
> # CONFIG_SYNCLINK_SYNCPPP is not set
> # CONFIG_HDLC is not set
> CONFIG_DLCI=m
> CONFIG_DLCI_COUNT=24
> CONFIG_DLCI_MAX=8
> CONFIG_SDLA=m
> CONFIG_SBNI=m
> CONFIG_SBNI_MULTILINE=y
> 
> #
> # PCMCIA network device support
> #
> CONFIG_NET_PCMCIA=y
> CONFIG_PCMCIA_3C589=m
> CONFIG_PCMCIA_3C574=m
> CONFIG_PCMCIA_FMVJ18X=m
> CONFIG_PCMCIA_PCNET=m
> CONFIG_PCMCIA_NMCLAN=m
> CONFIG_PCMCIA_SMC91C92=m
> CONFIG_PCMCIA_XIRC2PS=m
> CONFIG_PCMCIA_AXNET=m
> CONFIG_PCMCIA_IBMTR=m
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> CONFIG_IRDA=m
> 
> #
> # IrDA protocols
> #
> CONFIG_IRLAN=m
> CONFIG_IRNET=m
> CONFIG_IRCOMM=m
> CONFIG_IRDA_ULTRA=y
> 
> #
> # IrDA options
> #
> CONFIG_IRDA_CACHE_LAST_LSAP=y
> CONFIG_IRDA_FAST_RR=y
> # CONFIG_IRDA_DEBUG is not set
> 
> #
> # Infrared-port device drivers
> #
> 
> #
> # SIR device drivers
> #
> CONFIG_IRTTY_SIR=m
> 
> #
> # Dongle support
> #
> CONFIG_DONGLE=y
> CONFIG_ESI_DONGLE=m
> CONFIG_ACTISYS_DONGLE=m
> CONFIG_TEKRAM_DONGLE=m
> 
> #
> # Old SIR device drivers
> #
> CONFIG_IRPORT_SIR=m
> 
> #
> # Old Serial dongle support
> #
> # CONFIG_DONGLE_OLD is not set
> 
> #
> # FIR device drivers
> #
> CONFIG_USB_IRDA=m
> CONFIG_NSC_FIR=m
> CONFIG_WINBOND_FIR=m
> CONFIG_TOSHIBA_FIR=m
> CONFIG_SMC_IRCC_FIR=m
> CONFIG_ALI_FIR=m
> CONFIG_VLSI_FIR=m
> # CONFIG_VIA_FIR is not set
> 
> #
> # Bluetooth support
> #
> # CONFIG_BT is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN_BOOL is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=m
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_SERIAL_NONSTANDARD=y
> CONFIG_COMPUTONE=m
> CONFIG_ROCKETPORT=m
> CONFIG_CYCLADES=m
> # CONFIG_CYZ_INTR is not set
> CONFIG_DIGIEPCA=m
> CONFIG_ESPSERIAL=m
> CONFIG_MOXA_INTELLIO=m
> CONFIG_MOXA_SMARTIO=m
> CONFIG_ISI=m
> CONFIG_SYNCLINK=m
> # CONFIG_SYNCLINKMP is not set
> CONFIG_N_HDLC=m
> CONFIG_RISCOM8=m
> CONFIG_SPECIALIX=m
> CONFIG_SPECIALIX_RTSCTS=y
> CONFIG_SX=m
> # CONFIG_RIO is not set
> CONFIG_STALDRV=y
> CONFIG_STALLION=m
> CONFIG_ISTALLION=m
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=m
> # CONFIG_SERIAL_8250_CS is not set
> # CONFIG_SERIAL_8250_ACPI is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=m
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=2048
> CONFIG_PRINTER=m
> CONFIG_LP_CONSOLE=y
> CONFIG_PPDEV=m
> CONFIG_TIPAR=m
> 
> #
> # I2C support
> #
> CONFIG_I2C=m
> CONFIG_I2C_CHARDEV=m
> 
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=m
> CONFIG_I2C_ALGOPCF=m
> 
> #
> # I2C Hardware Bus support
> #
> CONFIG_I2C_ALI1535=m
> CONFIG_I2C_ALI15X3=m
> CONFIG_I2C_AMD756=m
> # CONFIG_I2C_AMD8111 is not set
> CONFIG_I2C_ELEKTOR=m
> CONFIG_I2C_ELV=m
> CONFIG_I2C_I801=m
> # CONFIG_I2C_I810 is not set
> CONFIG_I2C_ISA=m
> # CONFIG_I2C_NFORCE2 is not set
> CONFIG_I2C_PHILIPSPAR=m
> CONFIG_I2C_PIIX4=m
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_SCx200_ACB is not set
> CONFIG_I2C_SIS5595=m
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> CONFIG_I2C_VELLEMAN=m
> CONFIG_I2C_VIA=m
> CONFIG_I2C_VIAPRO=m
> CONFIG_I2C_VOODOO3=m
> 
> #
> # I2C Hardware Sensors Chip support
> #
> CONFIG_I2C_SENSOR=m
> CONFIG_SENSORS_ADM1021=m
> CONFIG_SENSORS_EEPROM=m
> CONFIG_SENSORS_IT87=m
> CONFIG_SENSORS_LM75=m
> CONFIG_SENSORS_LM78=m
> # CONFIG_SENSORS_LM85 is not set
> CONFIG_SENSORS_VIA686A=m
> CONFIG_SENSORS_W83781D=m
> 
> #
> # Mice
> #
> CONFIG_BUSMOUSE=m
> # CONFIG_QIC02_TAPE is not set
> 
> #
> # IPMI
> #
> CONFIG_IPMI_HANDLER=m
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=m
> CONFIG_IPMI_KCS=m
> CONFIG_IPMI_WATCHDOG=m
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> CONFIG_NVRAM=m
> CONFIG_RTC=y
> CONFIG_DTLK=m
> CONFIG_R3964=m
> # CONFIG_APPLICOM is not set
> CONFIG_SONYPI=m
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=m
> CONFIG_AGP_ALI=m
> # CONFIG_AGP_ATI is not set
> CONFIG_AGP_AMD=m
> # CONFIG_AGP_AMD64 is not set
> CONFIG_AGP_INTEL=m
> # CONFIG_AGP_NVIDIA is not set
> CONFIG_AGP_SIS=m
> CONFIG_AGP_SWORKS=m
> CONFIG_AGP_VIA=m
> CONFIG_DRM=y
> CONFIG_DRM_TDFX=m
> CONFIG_DRM_GAMMA=m
> CONFIG_DRM_R128=m
> CONFIG_DRM_RADEON=m
> CONFIG_DRM_I810=m
> CONFIG_DRM_I830=m
> CONFIG_DRM_MGA=m
> # CONFIG_DRM_SIS is not set
> 
> #
> # PCMCIA character devices
> #
> CONFIG_SYNCLINK_CS=m
> CONFIG_MWAVE=m
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_HANGCHECK_TIMER is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
> 
> #
> # Graphics support
> #
> CONFIG_FB=y
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_IMSTT is not set
> CONFIG_FB_VGA16=m
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> CONFIG_FB_RIVA=m
> # CONFIG_FB_I810 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_VIRTUAL is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_MDA_CONSOLE=m
> CONFIG_DUMMY_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE is not set
> 
> #
> # Logo configuration
> #
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> # CONFIG_LOGO_LINUX_VGA16 is not set
> # CONFIG_LOGO_LINUX_CLUT224 is not set
> 
> #
> # Sound
> #
> CONFIG_SOUND=m
> 
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=m
> CONFIG_SND_SEQUENCER=m
> # CONFIG_SND_SEQ_DUMMY is not set
> # CONFIG_SND_OSSEMUL is not set
> # CONFIG_SND_RTCTIMER is not set
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> 
> #
> # Generic devices
> #
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
> 
> #
> # ISA devices
> #
> # CONFIG_SND_AD1816A is not set
> # CONFIG_SND_AD1848 is not set
> # CONFIG_SND_CS4231 is not set
> # CONFIG_SND_CS4232 is not set
> # CONFIG_SND_CS4236 is not set
> CONFIG_SND_ES968=m
> CONFIG_SND_ES1688=m
> CONFIG_SND_ES18XX=m
> # CONFIG_SND_GUSCLASSIC is not set
> # CONFIG_SND_GUSEXTREME is not set
> # CONFIG_SND_GUSMAX is not set
> # CONFIG_SND_INTERWAVE is not set
> # CONFIG_SND_INTERWAVE_STB is not set
> # CONFIG_SND_OPTI92X_AD1848 is not set
> # CONFIG_SND_OPTI92X_CS4231 is not set
> # CONFIG_SND_OPTI93X is not set
> # CONFIG_SND_SB8 is not set
> # CONFIG_SND_SB16 is not set
> # CONFIG_SND_SBAWE is not set
> # CONFIG_SND_WAVEFRONT is not set
> # CONFIG_SND_ALS100 is not set
> # CONFIG_SND_AZT2320 is not set
> # CONFIG_SND_CMI8330 is not set
> # CONFIG_SND_DT019X is not set
> # CONFIG_SND_OPL3SA2 is not set
> # CONFIG_SND_SGALAXY is not set
> # CONFIG_SND_SSCAPE is not set
> 
> #
> # PCI devices
> #
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> CONFIG_SND_EMU10K1=m
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> CONFIG_SND_MAESTRO3=m
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> CONFIG_SND_INTEL8X0=m
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VX222 is not set
> 
> #
> # ALSA USB devices
> #
> # CONFIG_SND_USB_AUDIO is not set
> 
> #
> # PCMCIA devices
> #
> # CONFIG_SND_VXPOCKET is not set
> # CONFIG_SND_VXP440 is not set
> 
> #
> # Open Sound System
> #
> CONFIG_SOUND_PRIME=m
> # CONFIG_SOUND_BT878 is not set
> # CONFIG_SOUND_CMPCI is not set
> # CONFIG_SOUND_EMU10K1 is not set
> # CONFIG_SOUND_FUSION is not set
> # CONFIG_SOUND_CS4281 is not set
> # CONFIG_SOUND_ES1370 is not set
> # CONFIG_SOUND_ES1371 is not set
> # CONFIG_SOUND_ESSSOLO1 is not set
> # CONFIG_SOUND_MAESTRO is not set
> CONFIG_SOUND_MAESTRO3=m
> # CONFIG_SOUND_ICH is not set
> # CONFIG_SOUND_SONICVIBES is not set
> # CONFIG_SOUND_TRIDENT is not set
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
> # CONFIG_SOUND_VIA82CXXX is not set
> # CONFIG_SOUND_OSS is not set
> # CONFIG_SOUND_TVMIXER is not set
> # CONFIG_SOUND_ALI5455 is not set
> # CONFIG_SOUND_FORTE is not set
> # CONFIG_SOUND_RME96XX is not set
> # CONFIG_SOUND_AD1980 is not set
> 
> #
> # USB support
> #
> CONFIG_USB=m
> # CONFIG_USB_DEBUG is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=m
> # CONFIG_USB_OHCI_HCD is not set
> # CONFIG_USB_UHCI_HCD is not set
> 
> #
> # USB Device Class drivers
> #
> CONFIG_USB_AUDIO=m
> # CONFIG_USB_BLUETOOTH_TTY is not set
> CONFIG_USB_MIDI=m
> CONFIG_USB_ACM=m
> CONFIG_USB_PRINTER=m
> CONFIG_USB_STORAGE=m
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_DATAFAB=y
> CONFIG_USB_STORAGE_FREECOM=y
> CONFIG_USB_STORAGE_ISD200=y
> CONFIG_USB_STORAGE_DPCM=y
> CONFIG_USB_STORAGE_HP8200e=y
> CONFIG_USB_STORAGE_SDDR09=y
> CONFIG_USB_STORAGE_SDDR55=y
> CONFIG_USB_STORAGE_JUMPSHOT=y
> 
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=m
> CONFIG_USB_HIDINPUT=y
> # CONFIG_HID_FF is not set
> # CONFIG_USB_HIDDEV is not set
> 
> #
> # USB HID Boot Protocol drivers
> #
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_XPAD is not set
> 
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=m
> CONFIG_USB_SCANNER=m
> CONFIG_USB_MICROTEK=m
> CONFIG_USB_HPUSBSCSI=m
> 
> #
> # USB Multimedia devices
> #
> CONFIG_USB_DABUSB=m
> 
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
> 
> #
> # USB Network adaptors
> #
> CONFIG_USB_CATC=m
> CONFIG_USB_KAWETH=m
> CONFIG_USB_PEGASUS=m
> CONFIG_USB_RTL8150=m
> CONFIG_USB_USBNET=m
> 
> #
> # USB Host-to-Host Cables
> #
> CONFIG_USB_AN2720=y
> CONFIG_USB_BELKIN=y
> CONFIG_USB_GENESYS=y
> CONFIG_USB_NET1080=y
> CONFIG_USB_PL2301=y
> 
> #
> # Intelligent USB Devices/Gadgets
> #
> CONFIG_USB_ARMLINUX=y
> CONFIG_USB_EPSON2888=y
> CONFIG_USB_ZAURUS=y
> CONFIG_USB_CDCETHER=y
> 
> #
> # USB Network Adapters
> #
> CONFIG_USB_AX8817X=y
> 
> #
> # USB port drivers
> #
> CONFIG_USB_USS720=m
> 
> #
> # USB Serial Converter support
> #
> CONFIG_USB_SERIAL=m
> CONFIG_USB_SERIAL_GENERIC=y
> CONFIG_USB_SERIAL_BELKIN=m
> CONFIG_USB_SERIAL_WHITEHEAT=m
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
> CONFIG_USB_SERIAL_EMPEG=m
> CONFIG_USB_SERIAL_FTDI_SIO=m
> CONFIG_USB_SERIAL_VISOR=m
> CONFIG_USB_SERIAL_IPAQ=m
> CONFIG_USB_SERIAL_IR=m
> CONFIG_USB_SERIAL_EDGEPORT=m
> CONFIG_USB_SERIAL_EDGEPORT_TI=m
> CONFIG_USB_SERIAL_KEYSPAN_PDA=m
> CONFIG_USB_SERIAL_KEYSPAN=m
> CONFIG_USB_SERIAL_KEYSPAN_MPR=y
> # CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
> CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
> CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
> # CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
> CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
> CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
> CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
> CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
> CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
> CONFIG_USB_SERIAL_KLSI=m
> CONFIG_USB_SERIAL_KOBIL_SCT=m
> CONFIG_USB_SERIAL_MCT_U232=m
> CONFIG_USB_SERIAL_PL2303=m
> # CONFIG_USB_SERIAL_SAFE is not set
> CONFIG_USB_SERIAL_CYBERJACK=m
> CONFIG_USB_SERIAL_XIRCOM=m
> CONFIG_USB_SERIAL_OMNINET=m
> CONFIG_USB_EZUSB=y
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI26 is not set
> CONFIG_USB_TIGL=m
> CONFIG_USB_AUERSWALD=m
> CONFIG_USB_RIO500=m
> CONFIG_USB_BRLVGER=m
> CONFIG_USB_LCD=m
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_GADGET is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_JBD=y
> CONFIG_JBD_DEBUG=y
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=m
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=y
> # CONFIG_XFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_QUOTA=y
> CONFIG_QFMT_V1=m
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS_FS=m
> CONFIG_AUTOFS4_FS=y
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_ZISOFS_FS=y
> CONFIG_UDF_FS=m
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_NTFS_FS=m
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> # CONFIG_DEVFS_FS is not set
> CONFIG_DEVPTS_FS=y
> # CONFIG_DEVPTS_FS_XATTR is not set
> CONFIG_TMPFS=y
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> 
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V4 is not set
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_V4 is not set
> # CONFIG_NFSD_TCP is not set
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=m
> CONFIG_SUNRPC=m
> # CONFIG_SUNRPC_GSS is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_INTERMEZZO_FS is not set
> # CONFIG_AFS_FS is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> # CONFIG_LDM_PARTITION is not set
> # CONFIG_NEC98_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_EFI_PARTITION is not set
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=m
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=m
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=m
> 
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_DEBUG_INFO is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_FRAME_POINTER is not set
> 
> #
> # Security options
> #
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
> 
> #
> # Library routines
> #
> CONFIG_CRC32=m
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=m
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_PC=y
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
