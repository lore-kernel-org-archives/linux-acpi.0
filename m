From: mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: [Solved] Re: power-off
Date: Mon, 31 May 2004 18:16:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040531161637.GA3236@zimen.sk>
References: <Pine.LNX.4.60.0405282142510.4440@frog.athome>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0405282142510.4440-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

salut

  :) Yes !

  now, it works wery well for me.

  I played with kernel configuration, i found this:
 =20
  I guess, Problem was in "Enhanced RTC driver". If i have this driver
  inside a kernel (or like module), my laptop will never poweroff().
  last message was like this:
  		...
		call_power_off()  =20
		...HANG...
	=09
	=09

 =20
  (also i have inserted HPET timer inside kernel, not like module)


  Is this some unresolved dependency with RTC ?
  Can i have both timers ? (RTC, HPET )
 =20

  Thanks a lot.


  				mizu

 =20
On Fri, May 28, 2004 at 09:44:18PM +0200, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Salut Mizu,
> I forward you a mail, that I sent Emma, with my settings.
>=20
> please give them a try.
>   hartwig felger
>=20
> Hartwig Felger informatics
>=20
> - --=20
> 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.
>=20
> - ---------- Forwarded message ----------
> Date: Thu, 27 May 2004 17:27:58 +0200 (CEST)
> From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
> To: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
> Subject: power-off
>=20
> Salut Emma,
> as I asked you in the mail on the list, do you have the latest BIOS R01-C=
0O?
>=20
> I attached you my .config file. As I also recently patched my kernel with=
=20
> swsusp2, pwcx and packet-cdvdrw you will want to run
>  make oldconfig
> on an vanilla 2.6.6 kernel. If it does not let you shutdown your notebook=
,=20
> than it will be a problem with your software, but not the kernel, or acpi.
>=20
> Just let me know, how you story continues...
>   hartwig felger
>=20
> Hartwig Felger informatics
>=20
> - - -- 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.
> - -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>=20
> iD8DBQFAtgkG9bBoTzOf1pMRArl2AKDYY/QD7sKsspJTLA0j7bMcx0Eb/wCeLe2R
> Ixw4Q+QT+LhtZWlHqPGksWA=3D
> =3D6d1v
> - -----END PGP SIGNATURE-----
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>=20
> iD8DBQFAt5aX9bBoTzOf1pMRAi3AAKCOHCR0Yived3OfMVhdoFP8wpOg8gCghppJ
> 6XeMFlU7QEWJbAuhW5uMvo0=3D
> =3DMatN
> -----END PGP SIGNATURE-----

Content-Description: for 2.6.6
> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=3Dy
> CONFIG_MMU=3Dy
> CONFIG_UID16=3Dy
> CONFIG_GENERIC_ISA_DMA=3Dy
>=20
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=3Dy
> # CONFIG_CLEAN_COMPILE is not set
> # CONFIG_STANDALONE is not set
> CONFIG_BROKEN=3Dy
> CONFIG_BROKEN_ON_SMP=3Dy
>=20
> #
> # General setup
> #
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_AUDIT=3Dy
> CONFIG_AUDITSYSCALL=3Dy
> CONFIG_LOG_BUF_SHIFT=3D16
> CONFIG_HOTPLUG=3Dy
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_IOSCHED_NOOP=3Dy
> CONFIG_IOSCHED_AS=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
> CONFIG_IOSCHED_CFQ=3Dy
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>=20
> #
> # Loadable module support
> #
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> CONFIG_MODULE_FORCE_UNLOAD=3Dy
> CONFIG_OBSOLETE_MODPARM=3Dy
> CONFIG_MODVERSIONS=3Dy
> CONFIG_KMOD=3Dy
>=20
> #
> # Processor type and features
> #
> CONFIG_X86_PC=3Dy
> # CONFIG_X86_ELAN is not set
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
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> CONFIG_MPENTIUM4=3Dy
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=3Dy
> CONFIG_X86_XADD=3Dy
> CONFIG_X86_L1_CACHE_SHIFT=3D7
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_X86_WP_WORKS_OK=3Dy
> CONFIG_X86_INVLPG=3Dy
> CONFIG_X86_BSWAP=3Dy
> CONFIG_X86_POPAD_OK=3Dy
> CONFIG_X86_GOOD_APIC=3Dy
> CONFIG_X86_INTEL_USERCOPY=3Dy
> CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
> CONFIG_HPET_TIMER=3Dy
> # CONFIG_HPET_EMULATE_RTC is not set
> # CONFIG_SMP is not set
> # CONFIG_PREEMPT is not set
> # CONFIG_X86_UP_APIC is not set
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCE_NONFATAL=3Dy
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=3Dm
> CONFIG_X86_MSR=3Dm
> CONFIG_X86_CPUID=3Dm
>=20
> #
> # Firmware Drivers
> #
> CONFIG_EDD=3Dy
> CONFIG_NOHIGHMEM=3Dy
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=3Dy
> # CONFIG_EFI is not set
> # CONFIG_REGPARM is not set
>=20
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=3Dy
> # CONFIG_SOFTWARE_SUSPEND is not set
>=20
> #
> # Software Suspend 2
> #
> CONFIG_SOFTWARE_SUSPEND2=3Dy
>=20
> #
> # Image Storage (you need at least one writer)
> #
> CONFIG_SOFTWARE_SUSPEND_SWAPWRITER=3Dy
> # CONFIG_SOFTWARE_SUSPEND_NULLWRITER is not set
>=20
> #
> # Page Transformers
> #
> CONFIG_SOFTWARE_SUSPEND_LZF_COMPRESSION=3Dy
> # CONFIG_SOFTWARE_SUSPEND_GZIP_COMPRESSION is not set
> # CONFIG_SOFTWARE_SUSPEND_NULLTRANSFORMER is not set
>=20
> #
> # General Options
> #
> CONFIG_SOFTWARE_SUSPEND_DEBUG=3Dy
> # CONFIG_SOFTWARE_SUSPEND_VARIATION_ANALYSIS is not set
> # CONFIG_SOFTWARE_SUSPEND2_DUMP is not set
> # CONFIG_SOFTWARE_SUSPEND_KEEP_IMAGE is not set
> # CONFIG_SOFTWARE_SUSPEND_RELAXED_PROC is not set
> CONFIG_SOFTWARE_SUSPEND_DEFAULT_RESUME2=3D"/dev/hda3"
> # CONFIG_PM_DISK is not set
>=20
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_BOOT=3Dy
> CONFIG_ACPI_INTERPRETER=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_SLEEP_PROC_FS=3Dy
> CONFIG_ACPI_AC=3Dm
> CONFIG_ACPI_BATTERY=3Dm
> CONFIG_ACPI_BUTTON=3Dm
> CONFIG_ACPI_FAN=3Dm
> CONFIG_ACPI_PROCESSOR=3Dm
> CONFIG_ACPI_THERMAL=3Dm
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_DEBUG=3Dy
> CONFIG_ACPI_BUS=3Dy
> CONFIG_ACPI_EC=3Dy
> CONFIG_ACPI_POWER=3Dy
> CONFIG_ACPI_PCI=3Dy
> CONFIG_ACPI_SYSTEM=3Dy
> CONFIG_X86_PM_TIMER=3Dy
>=20
> #
> # APM (Advanced Power Management) BIOS Support
> #
> CONFIG_APM=3Dy
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> CONFIG_APM_DO_ENABLE=3Dy
> # CONFIG_APM_CPU_IDLE is not set
> # CONFIG_APM_DISPLAY_BLANK is not set
> # CONFIG_APM_RTC_IS_GMT is not set
> # CONFIG_APM_ALLOW_INTS is not set
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
>=20
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=3Dy
> # CONFIG_CPU_FREQ_PROC_INTF is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
> CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
> # CONFIG_CPU_FREQ_24_API is not set
> CONFIG_CPU_FREQ_TABLE=3Dy
>=20
> #
> # CPUFreq processor drivers
> #
> CONFIG_X86_ACPI_CPUFREQ=3Dm
> # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
> # CONFIG_X86_POWERNOW_K6 is not set
> # CONFIG_X86_POWERNOW_K7 is not set
> # CONFIG_X86_POWERNOW_K8 is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> # CONFIG_X86_SPEEDSTEP_ICH is not set
> # CONFIG_X86_SPEEDSTEP_SMI is not set
> CONFIG_X86_P4_CLOCKMOD=3Dm
> CONFIG_X86_SPEEDSTEP_LIB=3Dm
> # CONFIG_X86_LONGRUN is not set
> # CONFIG_X86_LONGHAUL is not set
>=20
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=3Dy
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=3Dy
> CONFIG_PCI_BIOS=3Dy
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_MMCONFIG=3Dy
> # CONFIG_PCI_LEGACY_PROC is not set
> CONFIG_PCI_NAMES=3Dy
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
>=20
> #
> # PCMCIA/CardBus support
> #
> CONFIG_PCMCIA=3Dm
> # CONFIG_PCMCIA_DEBUG is not set
> CONFIG_YENTA=3Dm
> CONFIG_CARDBUS=3Dy
> # CONFIG_I82092 is not set
> # CONFIG_TCIC is not set
>=20
> #
> # PCI Hotplug Support
> #
> CONFIG_HOTPLUG_PCI=3Dm
> # CONFIG_HOTPLUG_PCI_FAKE is not set
> # CONFIG_HOTPLUG_PCI_COMPAQ is not set
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> # CONFIG_HOTPLUG_PCI_PCIE is not set
> # CONFIG_HOTPLUG_PCI_SHPC is not set
>=20
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_BINFMT_AOUT=3Dy
> CONFIG_BINFMT_MISC=3Dy
>=20
> #
> # Device Drivers
> #
>=20
> #
> # Generic Driver Options
> #
> CONFIG_FW_LOADER=3Dm
> # CONFIG_DEBUG_DRIVER is not set
>=20
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
>=20
> #
> # Parallel port support
> #
> CONFIG_PARPORT=3Dy
> CONFIG_PARPORT_PC=3Dy
> CONFIG_PARPORT_PC_CML1=3Dm
> # CONFIG_PARPORT_SERIAL is not set
> CONFIG_PARPORT_PC_FIFO=3Dy
> CONFIG_PARPORT_PC_SUPERIO=3Dy
> # CONFIG_PARPORT_PC_PCMCIA is not set
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_PARPORT_1284=3Dy
>=20
> #
> # Plug and Play support
> #
>=20
> #
> # Block devices
> #
> # CONFIG_BLK_DEV_FD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=3Dm
> CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
> CONFIG_BLK_DEV_NBD=3Dm
> # CONFIG_BLK_DEV_CARMEL is not set
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_SIZE=3D4096
> CONFIG_BLK_DEV_INITRD=3Dy
> # CONFIG_LBD is not set
> CONFIG_CDROM_PKTCDVD=3Dm
> CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
> CONFIG_CDROM_PKTCDVD_WCACHE=3Dy
>=20
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=3Dy
> CONFIG_BLK_DEV_IDE=3Dy
>=20
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=3Dy
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECS=3Dm
> CONFIG_BLK_DEV_IDECD=3Dm
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> CONFIG_BLK_DEV_IDESCSI=3Dm
> CONFIG_IDE_TASK_IOCTL=3Dy
> CONFIG_IDE_TASKFILE_IO=3Dy
>=20
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_IDE_GENERIC=3Dy
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=3Dy
> CONFIG_IDEPCI_SHARE_IRQ=3Dy
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=3Dy
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=3Dy
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_ADMA=3Dy
> # CONFIG_BLK_DEV_AEC62XX is not set
> CONFIG_BLK_DEV_ALI15X3=3Dy
> # CONFIG_WDC_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
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
> CONFIG_BLK_DEV_IDEDMA=3Dy
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=3Dy
> # CONFIG_BLK_DEV_HD is not set
>=20
> #
> # SCSI device support
> #
> CONFIG_SCSI=3Dm
> CONFIG_SCSI_PROC_FS=3Dy
>=20
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dm
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=3Dm
> CONFIG_BLK_DEV_SR_VENDOR=3Dy
> CONFIG_CHR_DEV_SG=3Dm
>=20
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> CONFIG_SCSI_REPORT_LUNS=3Dy
> CONFIG_SCSI_CONSTANTS=3Dy
> # CONFIG_SCSI_LOGGING is not set
>=20
> #
> # SCSI Transport Attributes
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
>=20
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_SATA is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> CONFIG_SCSI_QLA2XXX=3Dm
> # CONFIG_SCSI_QLA21XX is not set
> # CONFIG_SCSI_QLA22XX is not set
> # CONFIG_SCSI_QLA2300 is not set
> # CONFIG_SCSI_QLA2322 is not set
> # CONFIG_SCSI_QLA6312 is not set
> # CONFIG_SCSI_QLA6322 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
>=20
> #
> # PCMCIA SCSI adapter support
> #
> CONFIG_PCMCIA_AHA152X=3Dm
> CONFIG_PCMCIA_FDOMAIN=3Dm
> CONFIG_PCMCIA_NINJA_SCSI=3Dm
> CONFIG_PCMCIA_QLOGIC=3Dm
>=20
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=3Dy
> # CONFIG_BLK_DEV_MD is not set
> CONFIG_BLK_DEV_DM=3Dm
> CONFIG_DM_CRYPT=3Dm
>=20
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
>=20
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_IEEE1394=3Dy
>=20
> #
> # Subsystem Options
> #
> # CONFIG_IEEE1394_VERBOSEDEBUG is not set
> CONFIG_IEEE1394_OUI_DB=3Dy
> CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=3Dy
> CONFIG_IEEE1394_CONFIG_ROM_IP1394=3Dy
>=20
> #
> # Device Drivers
> #
> # CONFIG_IEEE1394_PCILYNX is not set
> CONFIG_IEEE1394_OHCI1394=3Dm
>=20
> #
> # Protocol Drivers
> #
> CONFIG_IEEE1394_VIDEO1394=3Dm
> CONFIG_IEEE1394_SBP2=3Dm
> CONFIG_IEEE1394_SBP2_PHYS_DMA=3Dy
> CONFIG_IEEE1394_ETH1394=3Dm
> CONFIG_IEEE1394_DV1394=3Dm
> CONFIG_IEEE1394_RAWIO=3Dm
> CONFIG_IEEE1394_CMP=3Dm
> CONFIG_IEEE1394_AMDTP=3Dm
>=20
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
>=20
> #
> # Networking support
> #
> CONFIG_NET=3Dy
>=20
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_MMAP=3Dy
> # CONFIG_NETLINK_DEV is not set
> CONFIG_UNIX=3Dy
> CONFIG_NET_KEY=3Dm
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_FWMARK=3Dy
> CONFIG_IP_ROUTE_NAT=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_TOS=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=3Dm
> CONFIG_NET_IPGRE=3Dm
> CONFIG_NET_IPGRE_BROADCAST=3Dy
> CONFIG_IP_MROUTE=3Dy
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> CONFIG_ARPD=3Dy
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_INET_AH=3Dm
> CONFIG_INET_ESP=3Dm
> CONFIG_INET_IPCOMP=3Dm
>=20
> #
> # IP: Virtual Server Configuration
> #
> CONFIG_IP_VS=3Dm
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=3D12
>=20
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=3Dy
> CONFIG_IP_VS_PROTO_UDP=3Dy
> CONFIG_IP_VS_PROTO_ESP=3Dy
> CONFIG_IP_VS_PROTO_AH=3Dy
>=20
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=3Dm
> CONFIG_IP_VS_WRR=3Dm
> CONFIG_IP_VS_LC=3Dm
> CONFIG_IP_VS_WLC=3Dm
> CONFIG_IP_VS_LBLC=3Dm
> CONFIG_IP_VS_LBLCR=3Dm
> CONFIG_IP_VS_DH=3Dm
> CONFIG_IP_VS_SH=3Dm
> CONFIG_IP_VS_SED=3Dm
> CONFIG_IP_VS_NQ=3Dm
>=20
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=3Dm
> CONFIG_IPV6=3Dm
> CONFIG_IPV6_PRIVACY=3Dy
> CONFIG_INET6_AH=3Dm
> CONFIG_INET6_ESP=3Dm
> CONFIG_INET6_IPCOMP=3Dm
> CONFIG_IPV6_TUNNEL=3Dm
> CONFIG_NETFILTER=3Dy
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_BRIDGE_NETFILTER=3Dy
>=20
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=3Dm
> CONFIG_IP_NF_FTP=3Dm
> CONFIG_IP_NF_IRC=3Dm
> CONFIG_IP_NF_TFTP=3Dm
> # CONFIG_IP_NF_AMANDA is not set
> # CONFIG_IP_NF_QUEUE is not set
> CONFIG_IP_NF_IPTABLES=3Dm
> CONFIG_IP_NF_MATCH_LIMIT=3Dm
> CONFIG_IP_NF_MATCH_IPRANGE=3Dm
> CONFIG_IP_NF_MATCH_MAC=3Dm
> CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
> CONFIG_IP_NF_MATCH_MARK=3Dm
> CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
> CONFIG_IP_NF_MATCH_TOS=3Dm
> CONFIG_IP_NF_MATCH_RECENT=3Dm
> CONFIG_IP_NF_MATCH_ECN=3Dm
> CONFIG_IP_NF_MATCH_DSCP=3Dm
> CONFIG_IP_NF_MATCH_AH_ESP=3Dm
> CONFIG_IP_NF_MATCH_LENGTH=3Dm
> CONFIG_IP_NF_MATCH_TTL=3Dm
> CONFIG_IP_NF_MATCH_TCPMSS=3Dm
> CONFIG_IP_NF_MATCH_HELPER=3Dm
> CONFIG_IP_NF_MATCH_STATE=3Dm
> CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
> CONFIG_IP_NF_MATCH_OWNER=3Dm
> CONFIG_IP_NF_MATCH_PHYSDEV=3Dm
> CONFIG_IP_NF_FILTER=3Dm
> CONFIG_IP_NF_TARGET_REJECT=3Dm
> CONFIG_IP_NF_NAT=3Dm
> CONFIG_IP_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> CONFIG_IP_NF_TARGET_NETMAP=3Dm
> CONFIG_IP_NF_TARGET_SAME=3Dm
> CONFIG_IP_NF_NAT_LOCAL=3Dy
> CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
> CONFIG_IP_NF_NAT_IRC=3Dm
> CONFIG_IP_NF_NAT_FTP=3Dm
> CONFIG_IP_NF_NAT_TFTP=3Dm
> CONFIG_IP_NF_MANGLE=3Dm
> CONFIG_IP_NF_TARGET_TOS=3Dm
> CONFIG_IP_NF_TARGET_ECN=3Dm
> CONFIG_IP_NF_TARGET_DSCP=3Dm
> CONFIG_IP_NF_TARGET_MARK=3Dm
> CONFIG_IP_NF_TARGET_CLASSIFY=3Dm
> CONFIG_IP_NF_TARGET_LOG=3Dm
> CONFIG_IP_NF_TARGET_ULOG=3Dm
> CONFIG_IP_NF_TARGET_TCPMSS=3Dm
> CONFIG_IP_NF_ARPTABLES=3Dm
> CONFIG_IP_NF_ARPFILTER=3Dm
> CONFIG_IP_NF_ARP_MANGLE=3Dm
> # CONFIG_IP_NF_COMPAT_IPCHAINS is not set
> # CONFIG_IP_NF_COMPAT_IPFWADM is not set
> CONFIG_IP_NF_TARGET_NOTRACK=3Dm
> CONFIG_IP_NF_RAW=3Dm
>=20
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_IP6_NF_QUEUE=3Dm
> CONFIG_IP6_NF_IPTABLES=3Dm
> CONFIG_IP6_NF_MATCH_LIMIT=3Dm
> CONFIG_IP6_NF_MATCH_MAC=3Dm
> CONFIG_IP6_NF_MATCH_RT=3Dm
> CONFIG_IP6_NF_MATCH_OPTS=3Dm
> CONFIG_IP6_NF_MATCH_FRAG=3Dm
> CONFIG_IP6_NF_MATCH_HL=3Dm
> CONFIG_IP6_NF_MATCH_MULTIPORT=3Dm
> CONFIG_IP6_NF_MATCH_OWNER=3Dm
> CONFIG_IP6_NF_MATCH_MARK=3Dm
> CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
> CONFIG_IP6_NF_MATCH_AHESP=3Dm
> CONFIG_IP6_NF_MATCH_LENGTH=3Dm
> CONFIG_IP6_NF_MATCH_EUI64=3Dm
> CONFIG_IP6_NF_FILTER=3Dm
> CONFIG_IP6_NF_TARGET_LOG=3Dm
> CONFIG_IP6_NF_MANGLE=3Dm
> CONFIG_IP6_NF_TARGET_MARK=3Dm
> CONFIG_IP6_NF_RAW=3Dm
>=20
> #
> # Bridge: Netfilter Configuration
> #
> # CONFIG_BRIDGE_NF_EBTABLES is not set
> CONFIG_XFRM=3Dy
> CONFIG_XFRM_USER=3Dm
>=20
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IP_SCTP=3Dm
> CONFIG_SCTP_DBG_MSG=3Dy
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_HMAC_NONE is not set
> CONFIG_SCTP_HMAC_SHA1=3Dy
> # CONFIG_SCTP_HMAC_MD5 is not set
> # CONFIG_ATM is not set
> CONFIG_BRIDGE=3Dm
> CONFIG_VLAN_8021Q=3Dm
> # CONFIG_DECNET is not set
> CONFIG_LLC=3Dm
> CONFIG_LLC2=3Dm
> CONFIG_IPX=3Dm
> CONFIG_IPX_INTERN=3Dy
> CONFIG_ATALK=3Dm
> # CONFIG_DEV_APPLETALK is not set
> CONFIG_X25=3Dm
> CONFIG_LAPB=3Dm
> CONFIG_NET_DIVERT=3Dy
> # CONFIG_ECONET is not set
> CONFIG_WAN_ROUTER=3Dm
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
>=20
> #
> # QoS and/or fair queueing
> #
> CONFIG_NET_SCHED=3Dy
> CONFIG_NET_SCH_CBQ=3Dm
> CONFIG_NET_SCH_HTB=3Dm
> CONFIG_NET_SCH_HFSC=3Dm
> CONFIG_NET_SCH_CSZ=3Dm
> CONFIG_NET_SCH_PRIO=3Dm
> CONFIG_NET_SCH_RED=3Dm
> CONFIG_NET_SCH_SFQ=3Dm
> CONFIG_NET_SCH_TEQL=3Dm
> CONFIG_NET_SCH_TBF=3Dm
> CONFIG_NET_SCH_GRED=3Dm
> CONFIG_NET_SCH_DSMARK=3Dm
> # CONFIG_NET_SCH_DELAY is not set
> CONFIG_NET_SCH_INGRESS=3Dm
> CONFIG_NET_QOS=3Dy
> CONFIG_NET_ESTIMATOR=3Dy
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_TCINDEX=3Dm
> CONFIG_NET_CLS_ROUTE4=3Dm
> CONFIG_NET_CLS_ROUTE=3Dy
> CONFIG_NET_CLS_FW=3Dm
> CONFIG_NET_CLS_U32=3Dm
> CONFIG_NET_CLS_RSVP=3Dm
> CONFIG_NET_CLS_RSVP6=3Dm
> # CONFIG_NET_CLS_POLICE is not set
>=20
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_NETPOLL=3Dy
> CONFIG_NETPOLL_RX=3Dy
> CONFIG_NETPOLL_TRAP=3Dy
> CONFIG_NET_POLL_CONTROLLER=3Dy
> # CONFIG_HAMRADIO is not set
> CONFIG_IRDA=3Dm
>=20
> #
> # IrDA protocols
> #
> CONFIG_IRLAN=3Dm
> CONFIG_IRNET=3Dm
> CONFIG_IRCOMM=3Dm
> CONFIG_IRDA_ULTRA=3Dy
>=20
> #
> # IrDA options
> #
> CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
> CONFIG_IRDA_FAST_RR=3Dy
> CONFIG_IRDA_DEBUG=3Dy
>=20
> #
> # Infrared-port device drivers
> #
>=20
> #
> # SIR device drivers
> #
> CONFIG_IRTTY_SIR=3Dm
>=20
> #
> # Dongle support
> #
> CONFIG_DONGLE=3Dy
> # CONFIG_ESI_DONGLE is not set
> CONFIG_ACTISYS_DONGLE=3Dm
> # CONFIG_TEKRAM_DONGLE is not set
> # CONFIG_LITELINK_DONGLE is not set
> # CONFIG_MA600_DONGLE is not set
> # CONFIG_GIRBIL_DONGLE is not set
> # CONFIG_MCP2120_DONGLE is not set
> # CONFIG_OLD_BELKIN_DONGLE is not set
> CONFIG_ACT200L_DONGLE=3Dm
>=20
> #
> # Old SIR device drivers
> #
> CONFIG_IRPORT_SIR=3Dm
>=20
> #
> # Old Serial dongle support
> #
> # CONFIG_DONGLE_OLD is not set
>=20
> #
> # FIR device drivers
> #
> # CONFIG_USB_IRDA is not set
> # CONFIG_SIGMATEL_FIR is not set
> # CONFIG_TOSHIBA_FIR is not set
> # CONFIG_VLSI_FIR is not set
> CONFIG_BT=3Dm
> CONFIG_BT_L2CAP=3Dm
> CONFIG_BT_SCO=3Dm
> CONFIG_BT_RFCOMM=3Dm
> CONFIG_BT_RFCOMM_TTY=3Dy
> CONFIG_BT_BNEP=3Dm
> CONFIG_BT_BNEP_MC_FILTER=3Dy
> CONFIG_BT_BNEP_PROTO_FILTER=3Dy
>=20
> #
> # Bluetooth device drivers
> #
> CONFIG_BT_HCIUSB=3Dm
> CONFIG_BT_HCIUSB_SCO=3Dy
> CONFIG_BT_HCIUART=3Dm
> CONFIG_BT_HCIUART_H4=3Dy
> CONFIG_BT_HCIUART_BCSP=3Dy
> CONFIG_BT_HCIUART_BCSP_TXCRC=3Dy
> CONFIG_BT_HCIBCM203X=3Dm
> CONFIG_BT_HCIBFUSB=3Dm
> CONFIG_BT_HCIDTL1=3Dm
> CONFIG_BT_HCIBT3C=3Dm
> CONFIG_BT_HCIBLUECARD=3Dm
> CONFIG_BT_HCIBTUART=3Dm
> CONFIG_BT_HCIVHCI=3Dm
> CONFIG_NETDEVICES=3Dy
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> CONFIG_EQUALIZER=3Dm
> CONFIG_TUN=3Dm
>=20
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
>=20
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=3Dy
> CONFIG_MII=3Dy
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_NET_VENDOR_3COM is not set
>=20
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> CONFIG_NET_PCI=3Dy
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_E100 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> CONFIG_8139TOO=3Dy
> # CONFIG_8139TOO_PIO is not set
> CONFIG_8139TOO_TUNE_TWISTER=3Dy
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
>=20
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
>=20
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
>=20
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
>=20
> #
> # Wireless LAN (non-hamradio)
> #
> CONFIG_NET_RADIO=3Dy
>=20
> #
> # Obsolete Wireless cards support (pre-802.11)
> #
> CONFIG_STRIP=3Dm
> CONFIG_PCMCIA_WAVELAN=3Dm
> CONFIG_PCMCIA_NETWAVE=3Dm
>=20
> #
> # Wireless 802.11 Frequency Hopping cards support
> #
> CONFIG_PCMCIA_RAYCS=3Dm
>=20
> #
> # Wireless 802.11b ISA/PCI cards support
> #
> CONFIG_AIRO=3Dm
> CONFIG_HERMES=3Dm
> CONFIG_PLX_HERMES=3Dm
> CONFIG_TMD_HERMES=3Dm
> CONFIG_PCI_HERMES=3Dm
> CONFIG_ATMEL=3Dm
> CONFIG_PCI_ATMEL=3Dm
>=20
> #
> # Wireless 802.11b Pcmcia/Cardbus cards support
> #
> CONFIG_PCMCIA_HERMES=3Dm
> CONFIG_AIRO_CS=3Dm
> CONFIG_PCMCIA_ATMEL=3Dm
> CONFIG_PCMCIA_WL3501=3Dm
>=20
> #
> # Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
> #
> CONFIG_PRISM54=3Dm
> CONFIG_NET_WIRELESS=3Dy
>=20
> #
> # PCMCIA network device support
> #
> CONFIG_NET_PCMCIA=3Dy
> # CONFIG_PCMCIA_3C589 is not set
> # CONFIG_PCMCIA_3C574 is not set
> # CONFIG_PCMCIA_FMVJ18X is not set
> CONFIG_PCMCIA_PCNET=3Dm
> # CONFIG_PCMCIA_NMCLAN is not set
> # CONFIG_PCMCIA_SMC91C92 is not set
> # CONFIG_PCMCIA_XIRC2PS is not set
> # CONFIG_PCMCIA_AXNET is not set
>=20
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> CONFIG_PPP=3Dm
> CONFIG_PPP_MULTILINK=3Dy
> CONFIG_PPP_FILTER=3Dy
> CONFIG_PPP_ASYNC=3Dm
> CONFIG_PPP_SYNC_TTY=3Dm
> CONFIG_PPP_DEFLATE=3Dm
> CONFIG_PPP_BSDCOMP=3Dm
> CONFIG_PPPOE=3Dm
> # CONFIG_SLIP is not set
> CONFIG_NET_FC=3Dy
> # CONFIG_IPHASE5526 is not set
> # CONFIG_RCPCI is not set
> CONFIG_SHAPER=3Dm
> CONFIG_NETCONSOLE=3Dm
>=20
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
>=20
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
>=20
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=3Dy
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=3Dy
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_SERIO_SERPORT=3Dm
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> CONFIG_MOUSE_SERIAL=3Dm
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=3Dy
> CONFIG_INPUT_PCSPKR=3Dy
> CONFIG_INPUT_UINPUT=3Dm
>=20
> #
> # Character devices
> #
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> # CONFIG_SERIAL_NONSTANDARD is not set
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=3Dm
> CONFIG_SERIAL_8250_CS=3Dm
> CONFIG_SERIAL_8250_ACPI=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D4
> # CONFIG_SERIAL_8250_EXTENDED is not set
>=20
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=3Dm
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_LEGACY_PTYS=3Dy
> CONFIG_LEGACY_PTY_COUNT=3D256
> CONFIG_PRINTER=3Dm
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=3Dm
> # CONFIG_TIPAR is not set
> # CONFIG_QIC02_TAPE is not set
>=20
> #
> # IPMI
> #
> CONFIG_IPMI_HANDLER=3Dm
> CONFIG_IPMI_PANIC_EVENT=3Dy
> CONFIG_IPMI_PANIC_STRING=3Dy
> CONFIG_IPMI_DEVICE_INTERFACE=3Dm
> CONFIG_IPMI_SI=3Dm
> CONFIG_IPMI_WATCHDOG=3Dm
>=20
> #
> # Watchdog Cards
> #
> CONFIG_WATCHDOG=3Dy
> # CONFIG_WATCHDOG_NOWAYOUT is not set
>=20
> #
> # Watchdog Device Drivers
> #
> # CONFIG_SOFT_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> CONFIG_ALIM1535_WDT=3Dm
> CONFIG_ALIM7101_WDT=3Dm
> # CONFIG_SC520_WDT is not set
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> # CONFIG_WAFER_WDT is not set
> # CONFIG_I8XX_TCO is not set
> # CONFIG_SC1200_WDT is not set
> # CONFIG_SCx200_WDT is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> CONFIG_W83627HF_WDT=3Dm
> # CONFIG_W83877F_WDT is not set
> # CONFIG_MACHZ_WDT is not set
>=20
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
>=20
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> CONFIG_NVRAM=3Dm
> CONFIG_RTC=3Dm
> CONFIG_GEN_RTC=3Dm
> CONFIG_GEN_RTC_X=3Dy
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
>=20
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=3Dm
> CONFIG_AGP_ALI=3Dm
> # CONFIG_AGP_ATI is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD64 is not set
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_INTEL_MCH is not set
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_VIA is not set
> # CONFIG_AGP_EFFICEON is not set
> # CONFIG_DRM is not set
>=20
> #
> # PCMCIA character devices
> #
> # CONFIG_SYNCLINK_CS is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> CONFIG_HANGCHECK_TIMER=3Dm
>=20
> #
> # I2C support
> #
> CONFIG_I2C=3Dm
> CONFIG_I2C_CHARDEV=3Dm
>=20
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=3Dm
> CONFIG_I2C_ALGOPCF=3Dm
>=20
> #
> # I2C Hardware Bus support
> #
> CONFIG_I2C_ALI1535=3Dm
> CONFIG_I2C_ALI1563=3Dm
> CONFIG_I2C_ALI15X3=3Dm
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> CONFIG_I2C_ISA=3Dm
> # CONFIG_I2C_NFORCE2 is not set
> CONFIG_I2C_PARPORT=3Dm
> CONFIG_I2C_PARPORT_LIGHT=3Dm
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> CONFIG_SCx200_ACB=3Dm
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> # CONFIG_I2C_VOODOO3 is not set
>=20
> #
> # Hardware Sensors Chip support
> #
> CONFIG_I2C_SENSOR=3Dm
> CONFIG_SENSORS_ADM1021=3Dm
> # CONFIG_SENSORS_ASB100 is not set
> CONFIG_SENSORS_DS1621=3Dm
> # CONFIG_SENSORS_FSCHER is not set
> CONFIG_SENSORS_GL518SM=3Dm
> CONFIG_SENSORS_IT87=3Dm
> CONFIG_SENSORS_LM75=3Dm
> CONFIG_SENSORS_LM78=3Dm
> CONFIG_SENSORS_LM80=3Dm
> CONFIG_SENSORS_LM83=3Dm
> CONFIG_SENSORS_LM85=3Dm
> CONFIG_SENSORS_LM90=3Dm
> CONFIG_SENSORS_VIA686A=3Dm
> CONFIG_SENSORS_W83781D=3Dm
> CONFIG_SENSORS_W83L785TS=3Dm
> CONFIG_SENSORS_W83627HF=3Dm
>=20
> #
> # Other I2C Chip support
> #
> CONFIG_SENSORS_EEPROM=3Dm
> CONFIG_SENSORS_PCF8574=3Dm
> CONFIG_SENSORS_PCF8591=3Dm
> CONFIG_I2C_DEBUG_CORE=3Dy
> CONFIG_I2C_DEBUG_ALGO=3Dy
> CONFIG_I2C_DEBUG_BUS=3Dy
> CONFIG_I2C_DEBUG_CHIP=3Dy
>=20
> #
> # Misc devices
> #
> # CONFIG_IBM_ASM is not set
>=20
> #
> # Multimedia devices
> #
> CONFIG_VIDEO_DEV=3Dm
>=20
> #
> # Video For Linux
> #
>=20
> #
> # Video Adapters
> #
> # CONFIG_VIDEO_BT848 is not set
> # CONFIG_VIDEO_BWQCAM is not set
> # CONFIG_VIDEO_CQCAM is not set
> # CONFIG_VIDEO_W9966 is not set
> # CONFIG_VIDEO_CPIA is not set
> # CONFIG_VIDEO_SAA5246A is not set
> # CONFIG_VIDEO_SAA5249 is not set
> # CONFIG_TUNER_3036 is not set
> # CONFIG_VIDEO_STRADIS is not set
> # CONFIG_VIDEO_ZORAN is not set
> # CONFIG_VIDEO_ZR36120 is not set
> # CONFIG_VIDEO_SAA7134 is not set
> # CONFIG_VIDEO_MXB is not set
> # CONFIG_VIDEO_DPC is not set
> # CONFIG_VIDEO_HEXIUM_ORION is not set
> # CONFIG_VIDEO_HEXIUM_GEMINI is not set
> # CONFIG_VIDEO_CX88 is not set
>=20
> #
> # Radio Adapters
> #
> # CONFIG_RADIO_GEMTEK_PCI is not set
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_MAESTRO is not set
>=20
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
>=20
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> CONFIG_VIDEO_SELECT=3Dy
>=20
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=3Dy
>=20
> #
> # Sound
> #
> CONFIG_SOUND=3Dy
>=20
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=3Dy
> CONFIG_SND_TIMER=3Dy
> CONFIG_SND_PCM=3Dy
> CONFIG_SND_RAWMIDI=3Dm
> CONFIG_SND_SEQUENCER=3Dy
> CONFIG_SND_SEQ_DUMMY=3Dm
> CONFIG_SND_OSSEMUL=3Dy
> CONFIG_SND_MIXER_OSS=3Dy
> CONFIG_SND_PCM_OSS=3Dy
> CONFIG_SND_SEQUENCER_OSS=3Dy
> CONFIG_SND_RTCTIMER=3Dm
> CONFIG_SND_VERBOSE_PRINTK=3Dy
> CONFIG_SND_DEBUG=3Dy
> CONFIG_SND_DEBUG_MEMORY=3Dy
> CONFIG_SND_DEBUG_DETECT=3Dy
>=20
> #
> # Generic devices
> #
> CONFIG_SND_MPU401_UART=3Dm
> # CONFIG_SND_DUMMY is not set
> CONFIG_SND_VIRMIDI=3Dm
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
>=20
> #
> # PCI devices
> #
> CONFIG_SND_AC97_CODEC=3Dm
> CONFIG_SND_ALI5451=3Dm
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_MIXART is not set
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
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> CONFIG_SND_INTEL8X0=3Dm
> CONFIG_SND_INTEL8X0M=3Dm
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VX222 is not set
>=20
> #
> # ALSA USB devices
> #
> CONFIG_SND_USB_AUDIO=3Dm
>=20
> #
> # PCMCIA devices
> #
>=20
> #
> # Open Sound System
> #
> # CONFIG_SOUND_PRIME is not set
>=20
> #
> # USB support
> #
> CONFIG_USB=3Dm
> CONFIG_USB_DEBUG=3Dy
>=20
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=3Dy
> CONFIG_USB_BANDWIDTH=3Dy
> # CONFIG_USB_DYNAMIC_MINORS is not set
>=20
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=3Dm
> CONFIG_USB_EHCI_SPLIT_ISO=3Dy
> CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> CONFIG_USB_OHCI_HCD=3Dm
> # CONFIG_USB_UHCI_HCD is not set
>=20
> #
> # USB Device Class drivers
> #
> CONFIG_USB_AUDIO=3Dm
>=20
> #
> # USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
> #
> CONFIG_USB_MIDI=3Dm
> # CONFIG_USB_ACM is not set
> CONFIG_USB_PRINTER=3Dm
> CONFIG_USB_STORAGE=3Dm
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_DATAFAB=3Dy
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> CONFIG_USB_STORAGE_DPCM=3Dy
> # CONFIG_USB_STORAGE_HP8200e is not set
> CONFIG_USB_STORAGE_SDDR09=3Dy
> CONFIG_USB_STORAGE_SDDR55=3Dy
> CONFIG_USB_STORAGE_JUMPSHOT=3Dy
>=20
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=3Dm
> CONFIG_USB_HIDINPUT=3Dy
> # CONFIG_HID_FF is not set
> CONFIG_USB_HIDDEV=3Dy
>=20
> #
> # USB HID Boot Protocol drivers
> #
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_MTOUCH is not set
> # CONFIG_USB_XPAD is not set
> # CONFIG_USB_ATI_REMOTE is not set
>=20
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_HPUSBSCSI is not set
>=20
> #
> # USB Multimedia devices
> #
> # CONFIG_USB_DABUSB is not set
> # CONFIG_USB_VICAM is not set
> # CONFIG_USB_DSBR is not set
> # CONFIG_USB_IBMCAM is not set
> # CONFIG_USB_KONICAWC is not set
> CONFIG_USB_OV511=3Dm
> CONFIG_USB_PWC=3Dm
> CONFIG_USB_PWCX=3Dm
> # CONFIG_USB_SE401 is not set
> # CONFIG_USB_STV680 is not set
> # CONFIG_USB_W9968CF is not set
>=20
> #
> # USB Network adaptors
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
>=20
> #
> # USB port drivers
> #
> # CONFIG_USB_USS720 is not set
>=20
> #
> # USB Serial Converter support
> #
> # CONFIG_USB_SERIAL is not set
>=20
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_TIGL is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> CONFIG_USB_CYTHERM=3Dm
> # CONFIG_USB_TEST is not set
>=20
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
>=20
> #
> # File systems
> #
> CONFIG_EXT2_FS=3Dy
> CONFIG_EXT2_FS_XATTR=3Dy
> CONFIG_EXT2_FS_POSIX_ACL=3Dy
> CONFIG_EXT2_FS_SECURITY=3Dy
> CONFIG_EXT3_FS=3Dy
> CONFIG_EXT3_FS_XATTR=3Dy
> CONFIG_EXT3_FS_POSIX_ACL=3Dy
> CONFIG_EXT3_FS_SECURITY=3Dy
> CONFIG_JBD=3Dy
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dy
> CONFIG_REISERFS_FS=3Dy
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=3Dy
> # CONFIG_XFS_FS is not set
> CONFIG_MINIX_FS=3Dy
> # CONFIG_ROMFS_FS is not set
> CONFIG_QUOTA=3Dy
> CONFIG_QFMT_V1=3Dm
> CONFIG_QFMT_V2=3Dm
> CONFIG_QUOTACTL=3Dy
> # CONFIG_AUTOFS_FS is not set
> CONFIG_AUTOFS4_FS=3Dy
>=20
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=3Dy
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_ZISOFS_FS=3Dy
> CONFIG_UDF_FS=3Dy
>=20
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dy
> CONFIG_MSDOS_FS=3Dy
> CONFIG_VFAT_FS=3Dy
> CONFIG_NTFS_FS=3Dm
> CONFIG_NTFS_DEBUG=3Dy
> CONFIG_NTFS_RW=3Dy
>=20
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_DEVFS_FS=3Dy
> # CONFIG_DEVFS_MOUNT is not set
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS_XATTR=3Dy
> CONFIG_DEVPTS_FS_SECURITY=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_HUGETLBFS=3Dy
> CONFIG_HUGETLB_PAGE=3Dy
> CONFIG_RAMFS=3Dy
>=20
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> CONFIG_HFSPLUS_FS=3Dm
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_CRAMFS=3Dm
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
>=20
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=3Dy
> CONFIG_NFS_V3=3Dy
> CONFIG_NFS_V4=3Dy
> CONFIG_NFS_DIRECTIO=3Dy
> CONFIG_NFSD=3Dy
> CONFIG_NFSD_V3=3Dy
> CONFIG_NFSD_V4=3Dy
> CONFIG_NFSD_TCP=3Dy
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_EXPORTFS=3Dy
> CONFIG_SUNRPC=3Dy
> CONFIG_SUNRPC_GSS=3Dy
> CONFIG_RPCSEC_GSS_KRB5=3Dy
> CONFIG_SMB_FS=3Dm
> CONFIG_SMB_NLS_DEFAULT=3Dy
> CONFIG_SMB_NLS_REMOTE=3D"iso8859-15"
> CONFIG_CIFS=3Dm
> CONFIG_NCP_FS=3Dm
> CONFIG_NCPFS_PACKET_SIGNING=3Dy
> CONFIG_NCPFS_IOCTL_LOCKING=3Dy
> CONFIG_NCPFS_STRONG=3Dy
> CONFIG_NCPFS_NFS_NS=3Dy
> CONFIG_NCPFS_OS2_NS=3Dy
> CONFIG_NCPFS_SMALLDOS=3Dy
> CONFIG_NCPFS_NLS=3Dy
> CONFIG_NCPFS_EXTRAS=3Dy
> # CONFIG_CODA_FS is not set
> # CONFIG_INTERMEZZO_FS is not set
> # CONFIG_AFS_FS is not set
>=20
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=3Dy
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> CONFIG_MSDOS_PARTITION=3Dy
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> CONFIG_LDM_PARTITION=3Dy
> CONFIG_LDM_DEBUG=3Dy
> # CONFIG_NEC98_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_EFI_PARTITION is not set
>=20
> #
> # Native Language Support
> #
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"iso8859-15"
> CONFIG_NLS_CODEPAGE_437=3Dy
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=3Dy
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
> CONFIG_NLS_ISO8859_1=3Dy
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=3Dy
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=3Dy
>=20
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
>=20
> #
> # NeTraverse Win4Lin Support
> #
> # CONFIG_MKI is not set
>=20
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_EARLY_PRINTK=3Dy
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_MAGIC_SYSRQ=3Dy
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy
> CONFIG_FRAME_POINTER=3Dy
> # CONFIG_4KSTACKS is not set
> # CONFIG_KDB is not set
>=20
> #
> # Security options
> #
> CONFIG_SECURITY=3Dy
> CONFIG_SECURITY_NETWORK=3Dy
> CONFIG_SECURITY_CAPABILITIES=3Dm
> CONFIG_SECURITY_ROOTPLUG=3Dm
> CONFIG_SECURITY_SELINUX=3Dy
> CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
> # CONFIG_SECURITY_SELINUX_DISABLE is not set
> CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
> CONFIG_SECURITY_SELINUX_MLS=3Dy
>=20
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=3Dy
> CONFIG_CRYPTO_HMAC=3Dy
> CONFIG_CRYPTO_NULL=3Dm
> CONFIG_CRYPTO_MD4=3Dm
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_SHA1=3Dy
> CONFIG_CRYPTO_SHA256=3Dm
> CONFIG_CRYPTO_SHA512=3Dm
> CONFIG_CRYPTO_DES=3Dy
> CONFIG_CRYPTO_BLOWFISH=3Dm
> CONFIG_CRYPTO_TWOFISH=3Dm
> CONFIG_CRYPTO_SERPENT=3Dm
> CONFIG_CRYPTO_AES=3Dm
> CONFIG_CRYPTO_CAST5=3Dm
> CONFIG_CRYPTO_CAST6=3Dm
> CONFIG_CRYPTO_ARC4=3Dm
> CONFIG_CRYPTO_DEFLATE=3Dm
> CONFIG_CRYPTO_MICHAEL_MIC=3Dm
> CONFIG_CRYPTO_CRC32C=3Dm
> CONFIG_CRYPTO_TEST=3Dm
>=20
> #
> # Library routines
> #
> CONFIG_CRC32=3Dy
> CONFIG_LIBCRC32C=3Dm
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dm
> CONFIG_X86_BIOS_REBOOT=3Dy
> CONFIG_X86_STD_RESOURCES=3Dy
> CONFIG_PC=3Dy


--=20
              mizu
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
[-> E-mail:michal_AT_zimen_DOT_sk   =20
[-> ICQ:97165392
[-> WWW: http://michal.zimen.sk
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAu1pl9kFXwDL4DRkRAlAXAJ9Ng9migLZVYVtP0uft3IYUweSTHQCgsVSu
iF9eVzcCxoy81/0nmIyebCA=
=ZnE8
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
